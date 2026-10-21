# Runs one bot scenario test on the running worldserver over SOAP and prints the verdict (see doc\ops\2026_10_09_bot_scenario_tests.md).
#   .\run-scenario.ps1 -Name deadmines_rhahkzor            -> starts it, waits for it to end, prints the [scenario] lines, exit code 0 = PASS
#   .\run-scenario.ps1 -List                               -> the scenario names
#   .\run-scenario.ps1 -All [-Match rfk]                   -> every scenario (or those whose name contains -Match), one after another;
#                                                              prints one PASS/FAIL line per dungeon, exit code 0 only if all passed
# Needs, once (done by hand, never by this script): SOAP.Enabled=1 with SOAP.IP=127.0.0.1 in worldserver.conf, a GM account, and
# secrets\soap.txt holding one line "soap: <account>:<password>". Nothing here changes a config or an account.
param(
    [string]$Name = '',
    [switch]$List,
    [switch]$All,
    [string]$Match = '',
    [string]$Server = '',
    [int]$Port = 7878,
    [int]$WaitMinutes = 40
)
. "$PSScriptRoot\common.ps1"
if (-not $Server) { $Server = $installFolder }
$ErrorActionPreference = 'Stop'

$line = Select-String "$root\secrets\soap.txt" -Pattern '^soap: (.+?)\s*$' | Select-Object -First 1
if ($null -eq $line) { throw "no 'soap: <account>:<password>' line in $root\secrets\soap.txt" }
$cred = $line.Matches[0].Groups[1].Value
$auth = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($cred))

function Send-Command([string]$command) {
    $body = '<?xml version="1.0" encoding="utf-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
        'xmlns:ns1="urn:TC"><SOAP-ENV:Body><ns1:executeCommand><command>' + [Security.SecurityElement]::Escape($command) +
        '</command></ns1:executeCommand></SOAP-ENV:Body></SOAP-ENV:Envelope>'
    try {
        $r = Invoke-WebRequest -Uri "http://127.0.0.1:$Port/" -Method Post -Body $body -ContentType 'text/xml' `
            -Headers @{ Authorization = $auth } -UseBasicParsing -TimeoutSec 60
    } catch {
        $resp = $_.Exception.Response
        if ($null -eq $resp) { throw "SOAP on 127.0.0.1:$Port is not answering (worldserver down, or SOAP.Enabled=0): $($_.Exception.Message)" }
        $text = (New-Object IO.StreamReader($resp.GetResponseStream())).ReadToEnd()
        throw "SOAP refused '$command': $text"
    }
    $xml = [xml]$r.Content
    return [string]$xml.Envelope.Body.executeCommandResponse.result
}

if ($List) { Send-Command 'playerbot scenario list'; return }

if ($All) {
    $started = Send-Command ('playerbot scenario runall ' + $Match)
    Write-Host $started
    if ($started -notmatch 'started') { exit 2 }
    $deadline = (Get-Date).AddMinutes($WaitMinutes * 13)
    $shown = 0
    while ((Get-Date) -lt $deadline) {
        Start-Sleep 30
        $summary = (Send-Command 'playerbot scenario summary') -split "`n"
        $lines = @($summary | Where-Object { $_ -match '^\s+\S+ (PASS|FAIL)' })
        for ($i = $shown; $i -lt $lines.Count; $i++) { Write-Host $lines[$i].Trim() }
        $shown = $lines.Count
        if ((Send-Command 'playerbot scenario status') -match 'No scenario is running' -and $summary[0] -notmatch 'in progress') {
            $failed = @($lines | Where-Object { $_ -match ' FAIL' }).Count
            Write-Host ("{0} scenario(s), {1} failed" -f $lines.Count, $failed)
            if ($failed -gt 0) { exit 1 } else { exit 0 }
        }
    }
    Send-Command 'playerbot scenario abort' | Out-Null
    Write-Host 'runall still going after the time limit: aborted'
    exit 3
}
if (-not $Name) { throw 'give -Name <scenario> (or -List)' }

$started = Send-Command "playerbot scenario run $Name"
Write-Host $started
if ($started -notmatch 'started') { exit 2 }

$deadline = (Get-Date).AddMinutes($WaitMinutes)
$last = ''
while ((Get-Date) -lt $deadline) {
    Start-Sleep 20
    $status = Send-Command 'playerbot scenario status'
    if ($status -ne $last) { Write-Host $status; $last = $status }
    if ($status -match 'No scenario is running') {
        $result = Send-Command 'playerbot scenario result'
        Write-Host $result
        $log = Join-Path $root "$Server\logs\Scenario.log"
        Write-Host "(appended to $log)"
        if ($result -match 'result=PASS') { exit 0 } else { exit 1 }
    }
}
Send-Command 'playerbot scenario abort' | Out-Null
Write-Host "scenario still running after $WaitMinutes minutes: aborted"
exit 3
