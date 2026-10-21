# Starts the server and keeps it running: if worldserver crashes it is started again after a short wait, until you shut the server
# down (menu 2 / Stop-WoWForever.ps1) or close this window. A normal shutdown (exit code 0) is respected and ends the loop.
# Gives up when it crashes 5 times within 10 minutes (a crash loop needs a fix, not another restart); crash dumps are in server\Crashes.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$flag = Join-Path $PSScriptRoot 'stop.flag'
$log = Join-Path $PSScriptRoot 'autorestart.log'
$server = Join-Path $root 'server'
. "$PSScriptRoot\mysql-helpers.ps1"
function Log($m) { $l = "$(Get-Date -Format 's')  $m"; Write-Host $l; Add-Content $log $l }
Remove-Item $flag -ErrorAction SilentlyContinue
$crashes = New-Object System.Collections.Generic.List[datetime]
Log 'Auto-restart started. Menu option 2 (Shut down server) stops it.'
while (-not (Test-Path $flag)) {
    if (-not (Test-MySqlPort (Get-OurMySqlPort $root))) {
        Log 'Starting MySQL...'
        try { Start-OurMySql $root | Out-Null } catch { Log "$_"; Start-Sleep 30; continue }
    }
    $w = Get-Process worldserver -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $w) {
        Log 'Starting worldserver...'
        $w = Start-Process (Join-Path $server 'worldserver.exe') -WorkingDirectory $server -WindowStyle Minimized -PassThru
        $null = $w.Handle   # Windows PowerShell 5.1 leaves ExitCode empty unless the process handle is read right after the start
        $serverLog = Join-Path $server 'logs\Server.log'
        $deadline = (Get-Date).AddMinutes(30)
        do { Start-Sleep 5 } until (((Test-Path $serverLog) -and (Select-String -Path $serverLog -Pattern 'World initialized' -Quiet)) -or $w.HasExited -or (Get-Date) -gt $deadline -or (Test-Path $flag))
    }
    if (-not $w.HasExited -and -not (Get-Process bnetserver -ErrorAction SilentlyContinue) -and -not (Test-Path $flag)) {
        Log 'Starting bnetserver...'
        Start-Process (Join-Path $server 'bnetserver.exe') -WorkingDirectory $server -WindowStyle Minimized
    }
    while (-not $w.HasExited -and -not (Test-Path $flag)) { Start-Sleep 5 }
    if (Test-Path $flag) { break }
    $w.WaitForExit()
    $code = $w.ExitCode
    # a process that was already running when this started has no readable exit code: a normal shutdown ends the log with "Halting process"
    if ($null -eq $code -or "$code" -eq '') {
        $tail = if (Test-Path (Join-Path $server 'logs\Server.log')) { Get-Content (Join-Path $server 'logs\Server.log') -Tail 5 -ErrorAction SilentlyContinue } else { @() }
        if (@($tail) -match 'Halting process') { $code = 0 }
    }
    if ($code -eq 0) { Log 'worldserver shut down normally. Auto-restart ends.'; break }
    Log ("worldserver stopped unexpectedly (exit code {0}). A crash dump may be in server\Crashes." -f $code)
    $now = Get-Date; $crashes.Add($now)
    $recent = @($crashes | Where-Object { ($now - $_).TotalMinutes -le 10 })
    if ($recent.Count -ge 5) { Log 'Crashed 5 times within 10 minutes: not restarting again. Use bug-bundle.ps1 and report it.'; break }
    Log 'Restarting in 15 seconds...'
    Start-Sleep 15
}
Remove-Item $flag -ErrorAction SilentlyContinue
Log 'Auto-restart ended.'
