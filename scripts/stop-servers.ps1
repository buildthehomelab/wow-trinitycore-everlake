# Stops bnetserver and worldserver, then MySQL.
# Tries a clean close first (closes the console window, which TrinityCore treats as a shutdown signal and saves
# players); force-stops only if a server is still running after 60 s. Typing `server shutdown 10` in the
# worldserver window is the cleanest way when someone is online.
foreach ($exe in 'bnetserver', 'worldserver') {
    $p = Get-Process $exe -ErrorAction SilentlyContinue
    if (-not $p) { "$exe not running"; continue }
    $null = $p.CloseMainWindow()
    if ($p.WaitForExit(60000)) { "$exe stopped cleanly" }
    else { Stop-Process -Id $p.Id -Force; "$exe force-stopped" }
}
& "$PSScriptRoot\stop-mysql.ps1"
Start-Sleep 5
if (Get-Process mysqld -ErrorAction SilentlyContinue) { "MySQL still running" } else { "MySQL stopped" }
