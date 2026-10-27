# Stops bnetserver and worldserver cleanly (saves characters), then MySQL. Also ends a running auto-restart.
New-Item -ItemType File -Force (Join-Path $PSScriptRoot 'stop.flag') | Out-Null
foreach ($exe in 'bnetserver', 'worldserver') {
    $p = Get-Process $exe -ErrorAction SilentlyContinue
    if (-not $p) { "$exe not running"; continue }
    $null = $p.CloseMainWindow()
    if ($p.WaitForExit(60000)) { "$exe stopped cleanly" } else { Stop-Process -Id $p.Id -Force; "$exe force-stopped" }
}
$root = Split-Path $PSScriptRoot -Parent
& "$root\mysql\bin\mysqladmin.exe" "--defaults-file=$root\config\my.ini" -u root shutdown 2>$null
. "$PSScriptRoot\BotChat.ps1"
Stop-BotChat $root   # Ollama, when the launcher installed it for bot chat
"Stopped."
