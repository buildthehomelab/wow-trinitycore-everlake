# Starts MySQL, bnetserver and worldserver from the repack folder and waits until the world is up.
# Package layout: <root>\{server\, mysql\, config\my.ini, repack\ (this script), certs\, data\}
$root = Split-Path $PSScriptRoot -Parent
Remove-Item (Join-Path $PSScriptRoot 'stop.flag') -ErrorAction SilentlyContinue
# the bots need the pathfinding data (mmaps); without it they walk in straight lines and fall through the ground.
# If it is not finished, build it now (shows progress), then start the server.
if (-not (& "$PSScriptRoot\ensure-data.ps1")) { throw 'The game data is not finished, so the server was not started. Start again (menu 1) to continue, or run Install.cmd.' }
. "$PSScriptRoot\mysql-helpers.ps1"
Start-OurMySql $root
Sync-TrinityUser $root   # repairs an install whose first database step left the user without its password
. "$PSScriptRoot\HostForOthers.ps1"
Sync-HostForOthers $root   # only while Host-For-Others.cmd has hosting on: settings an update rewrote, a changed internet address
$dir = Join-Path $root 'server'
$logDir = Join-Path $dir 'logs'
. "$PSScriptRoot\ClientLanguage.ps1"
Set-ClientLanguageConf $dir
. "$PSScriptRoot\WorldUp.ps1"
Repair-ConfDir $dir
. "$PSScriptRoot\ClientBuild.ps1"
Sync-AlsoAcceptBuilds $root
Sync-UntestedBuildRows $root
. "$PSScriptRoot\BotChat.ps1"
Start-BotChat $root   # Ollama, only when bot chat is switched on
foreach ($exe in 'worldserver', 'bnetserver') {
    if (Get-Process $exe -ErrorAction SilentlyContinue) { "$exe already running"; continue }
    $since = (Get-Date).AddMinutes(-1)
    Start-Process "$dir\$exe.exe" -WorkingDirectory $dir -WindowStyle Minimized
    "$exe started"
    if ($exe -eq 'worldserver') {
        # bnetserver must start after worldserver has applied the DB updates
        'The worldserver window stays quiet while it loads; progress is in server\logs\Server.log. The first start can take several minutes.'
        $deadline = (Get-Date).AddMinutes(30)
        do { Start-Sleep 5 } until ((Test-WorldInitialized $logDir $since) -or
                                    -not (Get-Process worldserver -ErrorAction SilentlyContinue) -or (Get-Date) -gt $deadline)
        if (-not (Get-Process worldserver -ErrorAction SilentlyContinue)) {
            # the worldserver could not log in to the database: another MySQL on our port (an older install still running) is the usual reason
            if (Select-String -Path (Join-Path $logDir 'Server.log') -Pattern 'DatabasePool .* NOT opened' -Quiet -ErrorAction SilentlyContinue) {
                throw "worldserver could not open its databases and closed. Usually another MySQL is running on port $(Get-OurMySqlPort $root), most often from an older WoW Forever Bots folder: stop it (option 2 in its menu, or restart the PC) and start again. If that does not help, double-click Bug-Report.cmd in the main folder and post the zip in our Discord."
            }
            throw "worldserver exited; double-click Bug-Report.cmd in the main folder and post the zip in our Discord"
        }
        if (-not (Test-WorldInitialized $logDir $since)) { Write-Warning 'No "World initialized" line after 30 minutes. Starting bnetserver anyway so you can try to log in; check server\logs\Server.log.' }
        else { 'World initialized. Starting bnetserver (the login server)...' }
        # The base database adds the PvP, RP and Hardcore realms (71, 72, 73) too, but this package runs one realm (Trinity, id 70).
        # A realmlist flag cannot hide a realm (an offline one is still listed, greyed out), so remove those three rows.
        # Only these ids are touched. Safe to run every start.
        try {
            & "$root\mysql\bin\mysql.exe" "--defaults-file=$root\config\my.ini" -u root auth -e "DELETE FROM realmcharacters WHERE realmid IN (71,72,73); DELETE FROM realmlist WHERE id IN (71,72,73)"
        } catch { Write-Warning "Could not remove the unused realms: $($_.Exception.Message)" }
    }
}
. "$PSScriptRoot\ClientBuild.ps1"
Test-ClientBuild $root
"Server is up. Now start the game with the WoW Forever launcher (WoWForeverLauncher.exe) and keep its window open."
# friendly hint only; never blocks or fails the start
try {
    $code = (Start-Process powershell -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$PSScriptRoot\update.ps1`"", '-Quiet' -Wait -PassThru -WindowStyle Hidden).ExitCode
    if ($code -eq 10) { "A new version is available. Double-click Update-WoWForever.cmd (in the main folder) to install it." }
} catch { }
