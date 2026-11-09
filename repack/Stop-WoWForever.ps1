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
# mysqladmin runs as a plain child process with its own redirected input and output. Started from the launcher (no console
# window), the old "& mysqladmin.exe" call failed with "The handle is invalid ... while getting the console mode" and MySQL
# kept running.
$admin = Join-Path $root 'mysql\bin\mysqladmin.exe'
function Get-OurMysqld { Get-Process mysqld -ErrorAction SilentlyContinue | Where-Object { -not $_.Path -or $_.Path -like "$root\*" } }
if (Get-OurMysqld) {
    try {
        $psi = New-Object System.Diagnostics.ProcessStartInfo $admin
        $psi.Arguments = "`"--defaults-file=$root\config\my.ini`" -u root shutdown"
        $psi.UseShellExecute = $false; $psi.CreateNoWindow = $true
        $psi.RedirectStandardInput = $true; $psi.RedirectStandardOutput = $true; $psi.RedirectStandardError = $true
        $m = [System.Diagnostics.Process]::Start($psi)
        $m.StandardInput.Close()
        $null = $m.StandardOutput.ReadToEndAsync(); $null = $m.StandardError.ReadToEndAsync()
        if (-not $m.WaitForExit(120000)) { try { $m.Kill() } catch { } }
    } catch { Write-Warning "mysqladmin: $($_.Exception.Message)" }
    $d = Get-OurMysqld
    if ($d) { $null = $d | Wait-Process -Timeout 120 -ErrorAction SilentlyContinue }
    if (Get-OurMysqld) { Write-Warning 'MySQL is still running; close it with the Stop button again or restart Windows.' }
    else { 'MySQL stopped' }
} else { 'MySQL not running' }
. "$PSScriptRoot\BotChat.ps1"
Stop-BotChat $root   # Ollama, when the launcher installed it for bot chat
"Stopped."
