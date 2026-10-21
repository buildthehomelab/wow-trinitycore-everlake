# Runs bot scenarios on the running worldserver and publishes the results to the scenario-reports branch of the repo, so threads
# can read them directly (no log relaying). Windows PowerShell 5.1, no Python. Never starts, stops or installs anything unless
# -Watch is given, and even then only starts the servers through start-servers.ps1; it never stops them.
#
#   .\scenario-watch.ps1 -Probe                          -> read-only: can this PC reach and push to the repo? changes nothing
#   .\scenario-watch.ps1 -Scenarios deadmines_full,mc_garr [-Commit 53d62c42]
#   .\scenario-watch.ps1 -All [-Match rfk]               -> the dungeon set (or those whose name contains -Match)
#   .\scenario-watch.ps1 -Watch -Scenarios deadmines_full -> waits for install.ps1 to finish a NEW build (its .verified-backup
#                                                           marker changes), starts the servers if none run, runs the scenarios, publishes
#   .\scenario-watch.ps1 ... -NoPush                     -> write the report folder only (reports-git\), do not push
#
# What is published (branch scenario-reports, a separate clone in <root>\reports-git so the working checkout is never touched):
#   latest\summary.md            one PASS/FAIL line per scenario, the build commit, the time
#   latest\<scenario>.txt        for a FAIL: the [scenario] block from Scenario.log plus the tagged Playerbot.log lines of that run
#                                (capped); for a PASS: the verdict line and a few tagged lines
#   runs\<utc-stamp>_<commit>\   the same, kept for history (the newest 20 runs)
# Secrets: nothing is read from secrets\ except SOAP by run-scenario.ps1. Before anything is written, every value found in
# secrets\*.txt and every password-looking token is replaced with ***, and only lines carrying a known [tag] are published.
# A run is not published if the commit cannot be determined; an unpushed commit stays in reports-git and goes out with the next push.
# Exit code: 0 all scenarios passed, 1 at least one failed, 2 could not run.
param(
    [string[]]$Scenarios = @(),
    [switch]$All,
    [string]$Match = '',
    [string]$Commit = '',
    [string]$Server = '',
    [string]$Branch = 'scenario-reports',
    [string]$Remote = '',
    [int]$WaitMinutes = 40,
    [switch]$Watch,
    [int]$WatchHours = 12,
    [switch]$Probe,
    [switch]$NoPush
)
. "$PSScriptRoot\common.ps1"
if (-not $Server) { $Server = $installFolder }
$ErrorActionPreference = 'Stop'
$reportsGit = Join-Path $root 'reports-git'
$logDir     = Join-Path $root "$Server\logs"
$tagRegex   = '\[(scenario|bot_death|spell_dmg|pull_back|pull_gate|raid_[a-z_]+|mark_cc|pvecoord|group_hygiene|healer_drink|tank_chase|idle|release|move_lock|move_abandon|role|world)\]'

function Invoke-Git([string[]]$gitArgs, [string]$dir) {
    # Run git as a plain process: PowerShell 5.1 turns a native command's stderr (git's progress text) into a NativeCommandError
    # even when git exits 0, so the exit code is the only signal and stderr is just captured text.
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = 'git'
    $psi.Arguments = (@('-C', $dir) + $gitArgs | ForEach-Object { if ($_ -match '[\s"]') { '"' + ($_ -replace '"', '\"') + '"' } else { $_ } }) -join ' '
    $psi.RedirectStandardOutput = $true; $psi.RedirectStandardError = $true; $psi.UseShellExecute = $false; $psi.CreateNoWindow = $true
    $proc = [System.Diagnostics.Process]::Start($psi)
    $errTask = $proc.StandardError.ReadToEndAsync()   # drained in parallel so a full pipe cannot stall git
    $stdout = $proc.StandardOutput.ReadToEnd()
    $proc.WaitForExit()
    return [pscustomobject]@{ Code = $proc.ExitCode; Out = ($stdout + $errTask.Result).Trim() }
}

if (-not $Remote) {   # the same remote and credentials the checkout already uses: origin, or ours when the checkout has no origin
    foreach ($name in 'origin', 'ours') {
        $r = Invoke-Git @('remote', 'get-url', $name) $repoRoot
        if ($r.Code -eq 0 -and $r.Out) { $Remote = $r.Out; break }
    }
    if (-not $Remote) { throw 'no remote origin or ours in this checkout: pass -Remote <url>' }
}

# ---- secrets: values to blank out of anything published
$secretValues = New-Object System.Collections.ArrayList
Get-ChildItem (Join-Path $root 'secrets') -File -ErrorAction SilentlyContinue | ForEach-Object {
    Get-Content $_.FullName -ErrorAction SilentlyContinue | ForEach-Object {
        foreach ($piece in ($_ -split '[:=\s]+')) { if ($piece.Length -ge 6) { [void]$secretValues.Add($piece) } }
    }
}
function Remove-Secrets([string]$text) {
    foreach ($s in $secretValues) { $text = $text.Replace($s, '***') }
    $text = [regex]::Replace($text, '(?i)(password|passwd|pwd|token|secret|authorization|api[_-]?key)\s*[:=]\s*\S+', '$1=***')
    return $text
}

# ---- git: the reports clone
function Initialize-ReportsRepo {
    if (-not (Test-Path (Join-Path $reportsGit '.git'))) {
        New-Item -ItemType Directory -Force $reportsGit | Out-Null
        [void](Invoke-Git @('init', '-q') $reportsGit)
        [void](Invoke-Git @('remote', 'add', 'origin', $Remote) $reportsGit)
        [void](Invoke-Git @('config', 'user.name', 'PC scenario watcher') $reportsGit)
        [void](Invoke-Git @('config', 'user.email', 'scenario-watch@users.noreply.github.com') $reportsGit)
    }
    $heads = Invoke-Git @('ls-remote', '--heads', 'origin', $Branch) $reportsGit
    $haveLocal = (Invoke-Git @('rev-parse', '--verify', '-q', "refs/heads/$Branch") $reportsGit).Code -eq 0
    if ($heads.Code -eq 0 -and $heads.Out -and -not $haveLocal) {
        [void](Invoke-Git @('fetch', '-q', '--depth', '1', 'origin', $Branch) $reportsGit)
        [void](Invoke-Git @('checkout', '-q', '-B', $Branch, "origin/$Branch") $reportsGit)
    } elseif ($haveLocal) {
        [void](Invoke-Git @('checkout', '-q', $Branch) $reportsGit)
        if ($heads.Code -eq 0 -and $heads.Out) { [void](Invoke-Git @('pull', '--rebase', '-q', 'origin', $Branch) $reportsGit) }
    } else {
        [void](Invoke-Git @('symbolic-ref', 'HEAD', "refs/heads/$Branch") $reportsGit)   # first run: a new branch that holds only reports
    }
    if ($heads.Code -ne 0) { return "cannot reach the remote: $($heads.Out)" }
    return ''
}

if ($Probe) {
    "remote: $Remote"
    $git = Invoke-Git @('--version') $repoRoot; "git: $($git.Out)"
    $ls = Invoke-Git @('ls-remote', '--heads', $Remote, $Branch) $repoRoot
    "ls-remote exit $($ls.Code): " + $(if ($ls.Out) { $ls.Out } else { "(branch $Branch does not exist yet)" })
    # push test without writing anything: a dry run authenticates against the remote
    $push = Invoke-Git @('push', '--dry-run', $Remote, "HEAD:refs/heads/$Branch-probe") $repoRoot
    "push --dry-run exit $($push.Code): $($push.Out)"
    if ($ls.Code -eq 0 -and $push.Code -eq 0) { 'PROBE OK: this PC can read and push to the repo' } else { 'PROBE FAIL: see above; the report folder can still be built with -NoPush' }
    return
}

# ---- resolve the scenario list
if ($All) {
    $names = (& "$PSScriptRoot\run-scenario.ps1" -List -Server $Server | Out-String) -split "`r?`n" | ForEach-Object { ($_.Trim() -split '\s+')[0] } |
        Where-Object { $_ -match '^[a-z0-9_]+$' -and ($Match -eq '' -or $_ -like "*$Match*") }
    $Scenarios = @($names)
}
if ($Scenarios.Count -eq 0) { Write-Host 'give -Scenarios a,b or -All (or -Probe)'; exit 2 }

function Get-InstalledCommit {
    $marker = Join-Path $root "$Server\.verified-backup"
    if (Test-Path $marker) { return [string]((Get-Content $marker -Raw | ConvertFrom-Json).commit) }
    return ''
}

# ---- wait for a new install (Watch mode)
if ($Watch) {
    $marker = Join-Path $root "$Server\.verified-backup"
    $before = if (Test-Path $marker) { (Get-Item $marker).LastWriteTimeUtc } else { [datetime]::MinValue }
    Write-Host "watching $marker for a new install (up to $WatchHours h)..."
    $until = (Get-Date).AddHours($WatchHours)
    while ((Get-Date) -lt $until) {
        Start-Sleep 30
        if ((Test-Path $marker) -and (Get-Item $marker).LastWriteTimeUtc -gt $before) { Start-Sleep 10; break }
    }
    if ((Get-Date) -ge $until) { Write-Host 'no new install appeared'; exit 2 }
    if (-not (Get-Process worldserver -ErrorAction SilentlyContinue)) { & "$PSScriptRoot\start-servers.ps1" -Server $Server }
    $up = $false
    for ($i = 0; $i -lt 60 -and -not $up; $i++) {   # up to 10 minutes: first start applies SQL
        Start-Sleep 10
        try { & "$PSScriptRoot\run-scenario.ps1" -List -Server $Server *> $null; $up = $true } catch { }
    }
    if (-not $up) { Write-Host 'SOAP never answered after the install'; exit 2 }
    Start-Sleep 60   # the bots need a moment after the world opens
}
if (-not $Commit) { $Commit = Get-InstalledCommit }
if (-not $Commit) { $Commit = (Invoke-Git @('rev-parse', '--short=8', 'HEAD') $repoRoot).Out }
if (-not $Commit) { Write-Host 'cannot determine the build commit: pass -Commit'; exit 2 }
$Commit = $Commit.Substring(0, [Math]::Min(8, $Commit.Length))

# ---- run, capture, sanitize
function Read-NewBytes([string]$path, [long]$from) {
    if (-not (Test-Path $path)) { return '' }
    $fs = New-Object IO.FileStream($path, 'Open', 'Read', ([IO.FileShare]::ReadWrite -bor [IO.FileShare]::Delete))
    try {
        if ($fs.Length -lt $from) { $from = 0 }   # the log was recreated (server restarted)
        [void]$fs.Seek($from, 'Begin')
        $sr = New-Object IO.StreamReader($fs, [Text.Encoding]::UTF8)
        return $sr.ReadToEnd()
    } finally { $fs.Dispose() }
}
function Get-Length([string]$path) { if (Test-Path $path) { (Get-Item $path).Length } else { 0 } }

$stamp  = (Get-Date).ToUniversalTime().ToString('yyyyMMdd-HHmmss')
$report = @{}      # name -> text
$verdict = @{}     # name -> PASS/FAIL/ERROR line
$failed = 0
foreach ($name in $Scenarios) {
    Write-Host "=== $name ==="
    $scLen = Get-Length (Join-Path $logDir 'Scenario.log')
    $pbLen = Get-Length (Join-Path $logDir 'Playerbot.log')
    $outText = ''; $code = 3
    try {
        $outText = (& "$PSScriptRoot\run-scenario.ps1" -Name $name -Server $Server -WaitMinutes $WaitMinutes *>&1 | Out-String)
        $code = $LASTEXITCODE
    } catch { $outText = "run-scenario.ps1 threw: $($_.Exception.Message)"; $code = 2 }
    Write-Host $outText
    $scBlock = Read-NewBytes (Join-Path $logDir 'Scenario.log') $scLen
    $pbLines = (Read-NewBytes (Join-Path $logDir 'Playerbot.log') $pbLen) -split "`r?`n" | Where-Object { $_ -match $tagRegex }
    $result  = ($outText -split "`r?`n" | Where-Object { $_ -match 'result=' } | Select-Object -Last 1)
    $status  = if ($code -eq 0) { 'PASS' } elseif ($code -eq 1) { 'FAIL' } else { "ERROR($code)" }
    if ($code -ne 0) { $failed++ }
    $cap = if ($code -eq 0) { 60 } else { 700 }   # a failure keeps its whole story, a pass only a sample
    if ($pbLines.Count -gt $cap) { $pbLines = @($pbLines | Select-Object -First ($cap / 2)) + @("... $($pbLines.Count - $cap) lines cut ...") + @($pbLines | Select-Object -Last ($cap / 2)) }
    $verdict[$name] = "$status $name $result".Trim()
    $report[$name] = "# $name $status (build $Commit, $stamp UTC)`r`n`r`n## run-scenario output`r`n$outText`r`n`r`n## Scenario.log block`r`n$scBlock`r`n`r`n## Playerbot.log tagged lines`r`n" + ($pbLines -join "`r`n")
}

# ---- write + commit + push
$summary = "# Scenario results`r`nbuild: $Commit`r`nrun: $stamp UTC`r`nscenarios: $($Scenarios.Count), failed: $failed`r`n`r`n" + (($Scenarios | ForEach-Object { '- ' + $verdict[$_] }) -join "`r`n") + "`r`n"
$err = Initialize-ReportsRepo
$utf8 = New-Object Text.UTF8Encoding($false)
if (-not (Test-Path (Join-Path $reportsGit '.git'))) { Write-Host 'reports clone missing'; exit 2 }
$latest = Join-Path $reportsGit 'latest'
$run    = Join-Path $reportsGit "runs\${stamp}_$Commit"
New-Item -ItemType Directory -Force $latest, $run | Out-Null
Get-ChildItem $latest -File | Remove-Item -Force
foreach ($d in @($latest, $run)) {
    [IO.File]::WriteAllText((Join-Path $d 'summary.md'), (Remove-Secrets $summary), $utf8)
    foreach ($name in $Scenarios) { [IO.File]::WriteAllText((Join-Path $d "$name.txt"), (Remove-Secrets $report[$name]), $utf8) }
}
Get-ChildItem (Join-Path $reportsGit 'runs') -Directory | Sort-Object Name -Descending | Select-Object -Skip 20 | Remove-Item -Recurse -Force
[void](Invoke-Git @('add', '-A') $reportsGit)
$c = Invoke-Git @('commit', '-q', '-m', "scenario results for $Commit ($failed failed of $($Scenarios.Count))") $reportsGit
Write-Host "committed locally: $($c.Out)"
if ($NoPush) { Write-Host "-NoPush: report is in $reportsGit"; if ($failed) { exit 1 } else { exit 0 } }
if ($err) { Write-Host "NOT pushed: $err. The commit stays in $reportsGit; re-run later or send latest\ by hand."; if ($failed) { exit 1 } else { exit 0 } }
$p = Invoke-Git @('push', '-q', 'origin', "${Branch}:${Branch}") $reportsGit
if ($p.Code -ne 0) {
    [void](Invoke-Git @('pull', '--rebase', '-q', 'origin', $Branch) $reportsGit)   # someone else pushed to the reports branch
    $p = Invoke-Git @('push', '-q', 'origin', "${Branch}:${Branch}") $reportsGit
}
if ($p.Code -eq 0) { Write-Host "published to branch $Branch (latest/summary.md)" } else { Write-Host "PUSH FAILED: $($p.Out)`nThe commit stays in $reportsGit." }
if ($failed) { exit 1 } else { exit 0 }
