# Starts MySQL, bnetserver and worldserver from the repack folder and waits until the world is up.
# Package layout: <root>\{server\, mysql\, config\my.ini, repack\ (this script), certs\, data\}
$root = Split-Path $PSScriptRoot -Parent
Remove-Item (Join-Path $PSScriptRoot 'stop.flag') -ErrorAction SilentlyContinue
# the bots need the pathfinding data (mmaps); without it they walk in straight lines and fall through the ground.
# If it is not finished, build it now (shows progress), then start the server.
if (-not (& "$PSScriptRoot\ensure-data.ps1")) { throw 'The game data is not finished, so the server was not started. Start again (menu 1) to continue, or run Install.cmd.' }
. "$PSScriptRoot\mysql-helpers.ps1"
Start-OurMySql $root
$dir = Join-Path $root 'server'
$log = Join-Path $dir 'logs\Server.log'
foreach ($exe in 'worldserver', 'bnetserver') {
    if (Get-Process $exe -ErrorAction SilentlyContinue) { "$exe already running"; continue }
    Start-Process "$dir\$exe.exe" -WorkingDirectory $dir -WindowStyle Minimized
    "$exe started"
    if ($exe -eq 'worldserver') {
        # bnetserver must start after worldserver has applied the DB updates
        $deadline = (Get-Date).AddMinutes(30)
        do { Start-Sleep 5 } until (((Test-Path $log) -and (Select-String -Path $log -Pattern 'World initialized' -Quiet)) -or
                                    -not (Get-Process worldserver -ErrorAction SilentlyContinue) -or (Get-Date) -gt $deadline)
        if (-not (Get-Process worldserver -ErrorAction SilentlyContinue)) { throw "worldserver exited; run bug-bundle.ps1 and report it" }
    }
}
"Server is up. Now start the game with Play-WoWForever.cmd (or P in the control panel) and keep its window open."
# friendly hint only; never blocks or fails the start
try {
    $code = (Start-Process powershell -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$PSScriptRoot\update.ps1`"", '-Quiet' -Wait -PassThru -WindowStyle Hidden).ExitCode
    if ($code -eq 10) { "A new version is available. Double-click Update-WoWForever.cmd (in the main folder) to install it." }
} catch { }
