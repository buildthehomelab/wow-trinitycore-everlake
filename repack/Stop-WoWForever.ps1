# Stops worldserver (saves every character first), then bnetserver, then MySQL. Also ends a running auto-restart.
New-Item -ItemType File -Force (Join-Path $PSScriptRoot 'stop.flag') | Out-Null
try { . "$PSScriptRoot\console-send.ps1" } catch { Write-Warning "console-send.ps1: $($_.Exception.Message)" }
# worldserver first, so a player cannot log in again while it saves; with many bots saving can take a few minutes
if (Get-Process worldserver -ErrorAction SilentlyContinue) { 'Saving characters and stopping worldserver (can take a few minutes with many bots)...' }
$how = 'not running'
if (Get-Command Stop-WorldserverSaved -ErrorAction SilentlyContinue) { $how = Stop-WorldserverSaved 600 }
elseif ($w = Get-Process worldserver -ErrorAction SilentlyContinue | Select-Object -First 1) {
    # the console helper could not load: close the window as before (characters may not be saved)
    $null = $w.CloseMainWindow()
    $how = if ($w.WaitForExit(60000)) { 'stopped' } else { 'timeout' }
}
switch ($how) {
    'not running' { 'worldserver not running' }
    'stopped'     { 'worldserver saved and stopped' }
    default       {
        $w = Get-Process worldserver -ErrorAction SilentlyContinue
        if ($w) { $w | Stop-Process -Force }
        'worldserver did not stop in time and was force-stopped; the last minutes of play may be lost'
    }
}
$p = Get-Process bnetserver -ErrorAction SilentlyContinue
if (-not $p) { 'bnetserver not running' }
else {
    $null = $p.CloseMainWindow()
    if ($p.WaitForExit(60000)) { 'bnetserver stopped' } else { Stop-Process -Id $p.Id -Force; 'bnetserver force-stopped' }
}
$root = Split-Path $PSScriptRoot -Parent
& "$root\mysql\bin\mysqladmin.exe" "--defaults-file=$root\config\my.ini" -u root shutdown 2>$null
. "$PSScriptRoot\BotChat.ps1"
Stop-BotChat $root   # Ollama, when the launcher installed it for bot chat
"Stopped."
