<#
.SYNOPSIS
    Test-night digest of the bot server's logs: pulls, deaths, rules that fired, TickPerf spikes, errors.

.DESCRIPTION
    Reads server-bot's Playerbot.log, Server.log and DBErrors.log (plus the newest crash dump) after a test
    session and writes one short text file that can be pushed to the captures branch.

    Needs nothing beyond the PowerShell that ships with Windows (5.1 or later). Streams the logs, so a large
    Playerbot.log is fine.

    Log lines it reads (emitted by playerbot-v2-raid and later builds):
      [raid_encounter] ... pull start / pull end: result=kill|wipe|reset   (raid maps with rules)
      [bot_death] ...  killer, spell, damage, position, the bot's last rule  (any bot; players in raids/dungeons/BGs)
      [raid_fight] / [raid_death]                                            (PvE coordinator, every group)
      [PlayerbotV2] TickPerf ...                                             (once a minute)
      any line starting with a [tag]                                         (rule counts)

.EXAMPLE
    .\bot-log-digest.ps1
    .\bot-log-digest.ps1 -LogDir "D:\server\logs" -SpikeMs 100
#>
param(
    [string]$LogDir = '',
    [string]$Out = '',
    [int]$SpikeMs = 150,
    [int]$MaxDeaths = 40
)

$ErrorActionPreference = 'Stop'
if (-not $LogDir) { . "$PSScriptRoot\common.ps1"; $LogDir = Join-Path $root 'server-bot\logs' }

$mapNames = @{
    '30' = 'Alterac Valley'; '489' = 'Warsong Gulch'; '529' = 'Arathi Basin'
    '409' = 'Molten Core'; '469' = 'Blackwing Lair'; '249' = "Onyxia's Lair"; '309' = "Zul'Gurub"
    '509' = 'Ruins of AQ'; '531' = 'Temple of AQ'; '533' = 'Naxxramas'
}
function MapName([string]$id) { if ($mapNames.ContainsKey($id)) { return $mapNames[$id] } return "map $id" }
# The running worldserver keeps its logs open for writing: open them shared so the digest also works mid-session.
function OpenShared([string]$path) {
    $fs = New-Object System.IO.FileStream($path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
    return New-Object System.IO.StreamReader($fs)
}
function TsText([string]$ts) {
    if (-not $ts) { return '--:--:--' }
    return [DateTimeOffset]::FromUnixTimeSeconds([int64]$ts).LocalDateTime.ToString('HH:mm:ss')
}

# The logs sit in server-bot\logs on the PC; also accept the server folder itself or its logs subfolder.
if (-not (Test-Path (Join-Path $LogDir 'Playerbot.log'))) {
    foreach ($alt in @((Join-Path $LogDir 'logs'), (Split-Path -Parent $LogDir))) {
        if ($alt -and (Test-Path (Join-Path $alt 'Playerbot.log'))) { $LogDir = $alt; break }
    }
}
$playerbotLog = Join-Path $LogDir 'Playerbot.log'
$serverLog = Join-Path $LogDir 'Server.log'
$dbLog = Join-Path $LogDir 'DBErrors.log'
if (-not (Test-Path $playerbotLog)) { throw "No Playerbot.log in $LogDir (use -LogDir)" }
if (-not $Out) { $Out = Join-Path $LogDir ('digest-' + (Get-Date -Format 'yyyy-MM-dd-HHmm') + '.txt') }

# ---- one pass over Playerbot.log -------------------------------------------------------------------------------
$pulls = New-Object System.Collections.ArrayList
$openPulls = @{}
$deaths = New-Object System.Collections.ArrayList
$worldLines = New-Object System.Collections.ArrayList   # [world] lines (world bot spawner cost, once a minute)
$ruleCensus = New-Object System.Collections.ArrayList   # [rule_census] lines (last rule each non-raid bot fired, once a minute)
$tagCount = @{}
$tagSample = @{}
$perf = New-Object System.Collections.ArrayList
$fightStarts = 0; $fightEnds = 0; $raidDeaths = 0
$minTs = $null; $maxTs = $null
$lines = 0
$lastPerf = $null

$reTag = [regex]'\[([A-Za-z_]+)\]'
$reTs = [regex]'\bts=(\d+)'
$rePullStart = [regex]'\[raid_encounter\] ts=(\d+) map=(\d+) group=(\d+) pull start: (.*) \| alive=(\d+)/(\d+)'
$rePullEnd = [regex]'\[raid_encounter\] ts=(\d+) map=(\d+) group=(\d+) pull end: result=(\w+) dur=(\d+)s killed=(\d+)/(\d+) alive=(\d+)/(\d+) \| (.*)$'
$reDeath = [regex]'\[bot_death\] ts=(\d+) (.+?) \((bot|player)\) map=(\d+) pos=(\S+) killer=(.*?) spell=(.*?) dmg=(-?\d+) overkill=(-?\d+) rule=(\S+)(?: killer_at=(.*?) spell_data=(.*))?$'
$rePerf = [regex]'TickPerf \(avg ms over (\d+) ticks\):.* total=([\d.]+) max=(\d+)ms'
$reSlow = [regex]'TickPerf slowest: (.*)$'
$reWorst = [regex]'TickPerf max \(ms\): (.*)$'
$watchTags = @('world', 'raid_pull', 'raid_threat', 'raid_school', 'raid_interrupt', 'raid_tranq', 'raid_escape', 'raid_hazard', 'raid_los',
    'raid_cone', 'raid_consume', 'raid_cd', 'pet_taunt', 'bgcoord',
    'raid', 'raid_spacing', 'raid_support', 'raid_tank', 'taunt', 'rejoin', 'raid_rejoin', 'strand', 'move_blocked', 'wedge',
    'bg_use_diag')

$reader = OpenShared $playerbotLog
while ($null -ne ($line = $reader.ReadLine())) {
    $lines++
    $m = $reTs.Match($line)
    if ($m.Success) {
        $t = [int64]$m.Groups[1].Value
        if ($null -eq $minTs -or $t -lt $minTs) { $minTs = $t }
        if ($null -eq $maxTs -or $t -gt $maxTs) { $maxTs = $t }
    }

    if ($line.Contains('[raid_encounter]')) {
        $m = $rePullStart.Match($line)
        if ($m.Success) {
            $openPulls[$m.Groups[2].Value + '/' + $m.Groups[3].Value] = $m.Groups[1].Value
            continue
        }
        $m = $rePullEnd.Match($line)
        if ($m.Success) {
            $k = $m.Groups[2].Value + '/' + $m.Groups[3].Value
            $start = $openPulls[$k]; $openPulls.Remove($k)
            [void]$pulls.Add([pscustomobject]@{
                Start = $start; Map = $m.Groups[2].Value; Result = $m.Groups[4].Value; Dur = [int]$m.Groups[5].Value
                Killed = $m.Groups[6].Value + '/' + $m.Groups[7].Value; Alive = $m.Groups[8].Value + '/' + $m.Groups[9].Value
                What = $m.Groups[10].Value })
        }
        continue
    }
    if ($line.Contains('[rule_census]')) { [void]$ruleCensus.Add($line.Substring($line.IndexOf('[rule_census]'))) }
    if ($line.Contains('[world] enable=')) { [void]$worldLines.Add($line.Substring($line.IndexOf('[world]'))); continue }
    if ($line.Contains('[bot_death]')) {
        $m = $reDeath.Match($line)
        if ($m.Success) {
            [void]$deaths.Add([pscustomobject]@{
                Ts = $m.Groups[1].Value; Name = $m.Groups[2].Value; Kind = $m.Groups[3].Value; Map = $m.Groups[4].Value
                Pos = $m.Groups[5].Value; Killer = $m.Groups[6].Value; Spell = $m.Groups[7].Value
                Dmg = [int]$m.Groups[8].Value; Rule = $m.Groups[10].Value
                KillerAt = $m.Groups[11].Value; SpellData = $m.Groups[12].Value })
        }
        continue
    }
    if ($line.Contains('TickPerf')) {
        $m = $rePerf.Match($line)
        if ($m.Success) {
            $lastPerf = [pscustomobject]@{ Line = $lines; Avg = [double]$m.Groups[2].Value; Max = [int]$m.Groups[3].Value; Worst = ''; Slow = '' }
            [void]$perf.Add($lastPerf)
            continue
        }
        if ($lastPerf) {
            $m = $reWorst.Match($line); if ($m.Success) { $lastPerf.Worst = $m.Groups[1].Value; continue }
            $m = $reSlow.Match($line); if ($m.Success) { $lastPerf.Slow = $m.Groups[1].Value; continue }
        }
        continue
    }
    if ($line.Contains('[raid_fight]')) {
        if ($line.Contains('pull started')) { $fightStarts++ } elseif ($line.Contains('pull ended')) { $fightEnds++ }
    }
    elseif ($line.Contains('[raid_death]')) { $raidDeaths++ }

    $m = $reTag.Match($line)
    if ($m.Success) {
        $tag = $m.Groups[1].Value
        if ($tagCount.ContainsKey($tag)) { $tagCount[$tag]++ } else { $tagCount[$tag] = 1; $tagSample[$tag] = New-Object System.Collections.ArrayList }
        if ($tagSample[$tag].Count -lt 2) { [void]$tagSample[$tag].Add($line.Trim()) }
    }
}
$reader.Close()

# ---- errors from every log ---------------------------------------------------------------------------------------
$reErr = [regex]'(?i)\b(error|assert(ion)?|exception|fatal|crash(ed)?|segfault|access violation)\b'
$errCount = @{}; $errFirst = @{}
foreach ($f in @($serverLog, $dbLog, $playerbotLog)) {
    if (-not (Test-Path $f)) { continue }
    $short = Split-Path -Leaf $f
    $reader = OpenShared $f
    while ($null -ne ($line = $reader.ReadLine())) {
        if (-not $reErr.IsMatch($line)) { continue }
        # Same message with different numbers / guids counts once.
        $key = $short + ': ' + ([regex]::Replace($line.Trim(), '\d+', '#'))
        if ($key.Length -gt 220) { $key = $key.Substring(0, 220) }
        if ($errCount.ContainsKey($key)) { $errCount[$key]++ } else { $errCount[$key] = 1; $errFirst[$key] = $short + ': ' + $line.Trim() }
    }
    $reader.Close()
}
$crash = $null
$crashDir = Join-Path $LogDir 'Crashes'
if (-not (Test-Path $crashDir)) { $crashDir = Join-Path (Split-Path -Parent $LogDir) 'Crashes' }
if (Test-Path $crashDir) {
    $logStart = (Get-Item $playerbotLog).CreationTime
    $crash = Get-ChildItem $crashDir -File | Where-Object { $_.LastWriteTime -ge $logStart } | Sort-Object LastWriteTime -Descending | Select-Object -First 1
}

# ---- write the digest --------------------------------------------------------------------------------------------
$o = New-Object System.Collections.Generic.List[string]
$o.Add('Bot server test-night digest  (' + (Get-Date -Format 'yyyy-MM-dd HH:mm') + ')')
$o.Add('Logs: ' + $LogDir + '  |  Playerbot.log ' + $lines + ' lines, ' + [math]::Round((Get-Item $playerbotLog).Length / 1MB, 1) + ' MB')
if ($minTs) { $o.Add('Session: ' + (TsText $minTs) + ' - ' + (TsText $maxTs) + ' (from ts= stamps)') }
$o.Add('')

$o.Add('== PULLS (raid maps) ==')
if ($pulls.Count -eq 0) { $o.Add('none logged ([raid_encounter] lines appear on builds from playerbot-v2-raid 2026-10-06)') }
else {
    $kills = @($pulls | Where-Object Result -eq 'kill').Count
    $wipes = @($pulls | Where-Object Result -eq 'wipe').Count
    $resets = @($pulls | Where-Object Result -eq 'reset').Count
    $o.Add("$($pulls.Count) pulls: $kills kills, $wipes wipes, $resets resets")
    foreach ($p in $pulls) {
        $o.Add(('{0}  {1,-15} {2,-5} {3,4}s  killed {4,-6} alive {5,-6} {6}' -f (TsText $p.Start), (MapName $p.Map), $p.Result.ToUpper(), $p.Dur, $p.Killed, $p.Alive, $p.What))
    }
}
foreach ($k in $openPulls.Keys) { $o.Add('still open at log end: ' + (MapName ($k.Split('/')[0])) + ' since ' + (TsText $openPulls[$k])) }
$o.Add("PvE coordinator: $fightStarts pulls started, $fightEnds ended, $raidDeaths [raid_death] lines (all groups, all maps)")
$o.Add('')

$o.Add('== DEATHS ==')
if ($deaths.Count -eq 0) { $o.Add('none logged') }
else {
    $bots = @($deaths | Where-Object Kind -eq 'bot').Count
    $o.Add("$($deaths.Count) deaths ($bots bots, $($deaths.Count - $bots) players). Top causes:")
    $deaths | Group-Object { $_.Killer + ' / ' + $_.Spell } | Sort-Object Count -Descending | Select-Object -First 10 | ForEach-Object {
        $o.Add(('  {0,3} x  {1}' -f $_.Count, $_.Name))
    }
    $o.Add('Rules the bots were running when they died:')
    $deaths | Where-Object Kind -eq 'bot' | Group-Object Rule | Sort-Object Count -Descending | Select-Object -First 8 | ForEach-Object {
        $o.Add(('  {0,3} x  {1}' -f $_.Count, $_.Name))
    }
    $o.Add("Each death (first $MaxDeaths):")
    $deaths | Select-Object -First $MaxDeaths | ForEach-Object {
        $o.Add(('  {0} {1,-12} {2,-6} {3,-14} by {4} with {5} ({6} dmg) at {7}  rule {8}{9}' -f (TsText $_.Ts), $_.Name, $_.Kind, (MapName $_.Map), $_.Killer, $_.Spell, $_.Dmg, $_.Pos, $_.Rule, $(if ($_.KillerAt) { '  killer at ' + $_.KillerAt + '  [' + $_.SpellData + ']' } else { '' })))
    }
}
$o.Add('')

$o.Add('== RULES FIRED (log lines per tag) ==')
$tagCount.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 30 | ForEach-Object {
    $o.Add(('  {0,7}  [{1}]' -f $_.Value, $_.Key))
}
# Every raid_* tag gets samples too, so tags added later ([raid_hazard], [raid_los], [raid_cone], [raid_consume],
# [raid_cd], [raid_curse], [raid_fear] ...) show up without a script change.
$sampleTags = New-Object System.Collections.ArrayList
foreach ($t in $watchTags) { [void]$sampleTags.Add($t) }
foreach ($t in ($tagSample.Keys | Sort-Object)) {
    if ($t.StartsWith('raid_') -and -not $sampleTags.Contains($t) -and $t -ne 'raid_encounter' -and $t -ne 'raid_fight' -and $t -ne 'raid_death') {
        [void]$sampleTags.Add($t)
    }
}
foreach ($t in $sampleTags) {
    if (-not $tagSample.ContainsKey($t)) { continue }
    $o.Add("  e.g. [$t]:")
    foreach ($s in $tagSample[$t]) { if ($s.Length -gt 200) { $s = $s.Substring(0, 200) + '...' }; $o.Add('     ' + $s) }
}
$o.Add('')

$o.Add('== BOT RULES (last rule fired per non-raid bot, [rule_census] once a minute) ==')
if ($ruleCensus.Count -eq 0) { $o.Add('no [rule_census] lines') }
else {
    # Sum each rule over all windows (bot-minutes), so AH, mail, hub and quest rules show how much of the fleet's time they took.
    $sums = @{}
    $botMinutes = 0
    foreach ($c in $ruleCensus) {
        if ($c -match 'bots=(\d+) rules=\d+ \| (.*)$') {
            $botMinutes += [int]$Matches[1]
            foreach ($pair in ($Matches[2] -split ', ')) {
                $kv = $pair -split '=', 2
                if ($kv.Count -eq 2) { $sums[$kv[0]] = [int]$sums[$kv[0]] + [int]$kv[1] }
            }
        }
    }
    $o.Add(('{0} windows, {1} bot-minutes of non-raid rules (top 40 per window); AH/mail/hub rules marked *' -f $ruleCensus.Count, $botMinutes))
    $sums.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 30 | ForEach-Object {
        $mark = if ($_.Key -match 'ah|auction|mail|hub') { '*' } else { ' ' }
        $o.Add(('  {0,7} {1} {2}' -f $_.Value, $mark, $_.Key))
    }
    $o.Add('  last: ' + $ruleCensus[$ruleCensus.Count - 1])
}
$o.Add('')

$o.Add("== TICKPERF (60 s windows; spike = worst tick >= $SpikeMs ms) ==")
if ($perf.Count -eq 0) { $o.Add('no TickPerf lines') }
else {
    $avg = ($perf | Measure-Object Avg -Average).Average
    $worst = ($perf | Measure-Object Max -Maximum).Maximum
    $spikes = @($perf | Where-Object { $_.Max -ge $SpikeMs })
    $o.Add(('{0} windows, average tick {1:N1} ms, worst tick {2} ms, {3} windows with a spike' -f $perf.Count, $avg, $worst, $spikes.Count))
    $spikes | Sort-Object Max -Descending | Select-Object -First 8 | ForEach-Object {
        $o.Add(('  {0} ms (avg {1:N1}) at log line {2}' -f $_.Max, $_.Avg, $_.Line))
        if ($_.Worst) { $o.Add('     worst tick: ' + ($_.Worst -split ' phase_max')[0]) }
        if ($_.Slow) { $o.Add('     slowest: ' + $_.Slow) }
    }
}
$o.Add('')

$o.Add('== WORLD BOTS (Playerbot.World.*, one [world] line a minute) ==')
if ($worldLines.Count -eq 0) { $o.Add('no [world] lines (spawner off)') }
else {
    $peak = 0; $peakLine = ''; $perBot = 0.0
    foreach ($w in $worldLines) {
        $mb = [regex]::Match($w, ' bots=(\d+)/')
        if ($mb.Success -and [int]$mb.Groups[1].Value -ge $peak) { $peak = [int]$mb.Groups[1].Value; $peakLine = $w }
        $mp = [regex]::Match($w, 'per_bot_mb=([\d.]+)')
        if ($mp.Success -and [double]$mp.Groups[1].Value -gt $perBot) { $perBot = [double]$mp.Groups[1].Value }
    }
    $o.Add(('{0} lines, peak {1} bots, largest per_bot_mb {2:N2}' -f $worldLines.Count, $peak, $perBot))
    $o.Add('  first: ' + $worldLines[0])
    $o.Add('  peak:  ' + $peakLine)
    $o.Add('  last:  ' + $worldLines[$worldLines.Count - 1])
}
$o.Add('')

$o.Add('== ERRORS / ASSERTS (same text with other numbers counted once) ==')
if ($crash) { $o.Add('CRASH DUMP: ' + $crash.FullName + ' (' + $crash.LastWriteTime + ')') }
if ($errCount.Count -eq 0) { $o.Add('none') }
else {
    $errCount.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 25 | ForEach-Object {
        $s = $errFirst[$_.Key]; if ($s.Length -gt 220) { $s = $s.Substring(0, 220) + '...' }
        $o.Add(('  {0,5} x  {1}' -f $_.Value, $s))
    }
    if ($errCount.Count -gt 25) { $o.Add("  ... $($errCount.Count - 25) more distinct messages") }
}

[System.IO.File]::WriteAllLines($Out, $o)
Write-Host "Digest written to $Out ($($o.Count) lines)"
