# Plays Warsong Gulch, Arathi Basin and Alterac Valley with bots only, each to the end of the match (or for -MaxMinutes), on the running
# worldserver over SOAP, and reports what the server did meanwhile: any Map::Update SEH exception (a fault the guard caught), whether the
# worldserver process is still up and answering, and how each match ended.
#   .\run-bg-soak.ps1                        -> wsg, ab, av one after another
#   .\run-bg-soak.ps1 -Types wsg,av -MaxMinutes 20
# Exit code: 0 every soak ended or reached its time limit with no SEH line and the server up, and the bots played it (see below); 1 a SEH
# line, a crash, a match that never started or bots that did not play it; 2 could not run (SOAP down).
# Played = evidence from `playerbot bg` (polled every 30 s) and Playerbot.log for the soak window:
#   wsg  at least one flag capture (the best score seen is A + H >= 1)
#   ab   at least one [bg_capture] success, and successes >= 10% of starts (the 11 Oct loop made 9 in 840)
#   av   fewer than 30 [bg_stall] lines (the 11 Oct start-room stall made 195)
# Each type also prints the best score seen and the last [BgTopUp] line. Playerbot.log is read from the same folder as Server.log;
# without it the log checks are skipped and only the score check runs. Same SOAP set-up as run-scenario.ps1 (secrets\soap.txt, SOAP on 127.0.0.1); changes no config and no
# account. Needs the bots online and the world bots as they are: it only queues one bot battleground through `.bot bgsoak`.
param(
    [string[]]$Types = @('wsg', 'ab', 'av'),
    [int]$MaxMinutes = 30,
    [string]$Server = '',
    [int]$Port = 7878
)
. "$PSScriptRoot\common.ps1"
if (-not $Server) { $Server = $installFolder }
$ErrorActionPreference = 'Stop'

$line = Select-String "$root\secrets\soap.txt" -Pattern '^soap: (.+?)\s*$' | Select-Object -First 1
if ($null -eq $line) { throw "no 'soap: <account>:<password>' line in $root\secrets\soap.txt" }
$auth = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($line.Matches[0].Groups[1].Value))

function Send-Command([string]$command) {
    $body = '<?xml version="1.0" encoding="utf-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
        'xmlns:ns1="urn:TC"><SOAP-ENV:Body><ns1:executeCommand><command>' + [Security.SecurityElement]::Escape($command) +
        '</command></ns1:executeCommand></SOAP-ENV:Body></SOAP-ENV:Envelope>'
    try {
        $r = Invoke-WebRequest -Uri "http://127.0.0.1:$Port/" -Method Post -Body $body -ContentType 'text/xml' `
            -Headers @{ Authorization = $auth } -UseBasicParsing -TimeoutSec 60
    } catch {
        $resp = $_.Exception.Response
        if ($null -eq $resp) { return $null }      # not answering
        $text = (New-Object IO.StreamReader($resp.GetResponseStream())).ReadToEnd()
        throw "SOAP refused '$command': $text"
    }
    return [string]([xml]$r.Content).Envelope.Body.executeCommandResponse.result
}

$ids = @{ 'av' = 1; 'wsg' = 2; 'ab' = 3 }
$serverLog = Join-Path $root "$Server\logs\Server.log"
$botLog = Join-Path $root "$Server\logs\Playerbot.log"

function Read-LogFrom([string]$path, [long]$offset) {
    if (-not (Test-Path $path)) { return '' }
    $len = (Get-Item $path).Length
    $fh = [IO.File]::Open($path, 'Open', 'Read', 'ReadWrite')
    try {
        if ($len -lt $offset) { $offset = 0 }
        $fh.Seek($offset, 'Begin') | Out-Null
        return (New-Object IO.StreamReader($fh)).ReadToEnd()
    } finally { $fh.Dispose() }
}
if (-not (Test-Path $serverLog)) { throw "no $serverLog (the worldserver has not run from $Server yet)" }
if ($null -eq (Send-Command 'server info')) { Write-Host 'SOAP on 127.0.0.1 is not answering: worldserver down, or SOAP.Enabled=0'; exit 2 }

$failed = 0
foreach ($t in $Types) {
    if (-not $ids.ContainsKey($t)) { throw "unknown type '$t' (wsg, ab, av)" }
    $offset = (Get-Item $serverLog).Length
    $botOffset = if (Test-Path $botLog) { (Get-Item $botLog).Length } else { 0 }
    $bestA = 0; $bestH = 0
    $started = Send-Command ("bot bgsoak " + $ids[$t] + " " + $MaxMinutes)
    Write-Host "[$t] $started"
    if ($started -notmatch 'started') { Write-Host "[$t] FAIL: could not start"; $failed++; continue }

    $deadline = (Get-Date).AddMinutes($MaxMinutes + 15)
    $final = ''
    $down = $false
    while ((Get-Date) -lt $deadline) {
        Start-Sleep 30
        $report = Send-Command 'bot bgsoak'
        if ($null -eq $report) {
            $down = $true
            if (-not (Get-Process worldserver -ErrorAction SilentlyContinue)) { break }   # gone: crashed
            continue                                                                       # busy: ask again
        }
        $down = $false
        # Best score seen so far for this type (`playerbot bg` lists "bg=<id> (<name>) ... score=A:<n>/H:<n>").
        $bg = Send-Command 'playerbot bg'
        if ($bg) {
            foreach ($m in [regex]::Matches($bg, 'bg=\s*' + $ids[$t] + '\b[^\n]*?score=A:(\d+)/H:(\d+)')) {
                $bestA = [Math]::Max($bestA, [int]$m.Groups[1].Value)
                $bestH = [Math]::Max($bestH, [int]$m.Groups[2].Value)
            }
        }
        if ($report -match '\[bgsoak\] done') { $final = $report.Trim(); break }
    }

    # What the server logged during the soak (the log may have rotated: then read it from the start).
    $text = Read-LogFrom $serverLog $offset
    $botText = Read-LogFrom $botLog $botOffset
    $seh = @($text -split "`n" | Where-Object { $_ -match 'SEH exception' })
    $alive = [bool](Get-Process worldserver -ErrorAction SilentlyContinue)

    $verdict = 'PASS'
    if (-not $alive) { $verdict = 'FAIL (worldserver process gone: crash)' }
    elseif ($seh.Count -gt 0) { $verdict = "FAIL ($($seh.Count) SEH exception line(s))" }
    elseif (-not $final) { $verdict = 'FAIL (no final [bgsoak] line before the time limit)' }
    elseif ($final -match 'result=never_started') { $verdict = 'FAIL (no bot ever entered the battleground)' }

    # Did the bots play it? Counts from Playerbot.log for the soak window, plus the best score seen.
    $botLines = @($botText -split "`n")
    $capStart = @($botLines | Where-Object { $_ -match '\[bg_capture\] .* start entry=' }).Count
    $capOk    = @($botLines | Where-Object { $_ -match '\[bg_capture\] .* success' }).Count
    $stalls   = @($botLines | Where-Object { $_ -match '\[bg_stall\] bot=' }).Count
    $topUp    = @($botLines | Where-Object { $_ -match '\[BgTopUp\]' } | Select-Object -Last 1)
    Write-Host "[$t] best score A:$bestA H:$bestH; bg_capture start=$capStart success=$capOk; bg_stall=$stalls"
    if ($topUp) { Write-Host "[$t] last top-up: $($topUp[0].Trim())" }
    if ($verdict -eq 'PASS') {
        $haveBotLog = Test-Path $botLog
        if ($t -eq 'wsg' -and ($bestA + $bestH) -lt 1) { $verdict = 'FAIL (no flag was captured)' }
        elseif ($t -eq 'ab' -and $haveBotLog -and ($capOk -lt 1 -or $capOk * 10 -lt $capStart)) { $verdict = "FAIL (banner captures: $capOk of $capStart starts)" }
        elseif ($t -eq 'ab' -and -not $haveBotLog -and ($bestA + $bestH) -lt 1) { $verdict = 'FAIL (no resources scored)' }
        elseif ($t -eq 'av' -and $haveBotLog -and $stalls -ge 30) { $verdict = "FAIL ($stalls bots stalled)" }
    }
    Write-Host "[$t] $verdict"
    if ($final) { Write-Host "[$t] $final" }
    foreach ($s in ($seh | Select-Object -First 5)) { Write-Host "[$t]   $($s.Trim())" }
    if ($verdict -ne 'PASS') { $failed++ }
    if (-not $alive) { break }
    Start-Sleep 60      # let the bots leave and the instance close before the next type
}
Write-Host ("{0} soak(s) failed" -f $failed)
if ($failed -gt 0) { exit 1 } else { exit 0 }
