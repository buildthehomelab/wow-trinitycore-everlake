# WoW Forever Bots - control panel. One window that stays open: start/stop/restart the server, auto-restart, accounts, settings,
# backups, updates. Windows PowerShell 5.1. Started by WoW-Forever-Bots.cmd (optionally with a key to run first, e.g. "1").
param([string]$Run)
$ErrorActionPreference = 'Continue'
$root = Split-Path $PSScriptRoot -Parent
$here = $PSScriptRoot
$Host.UI.RawUI.WindowTitle = 'WoW Forever Bots'
try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(100, 38) } catch { }

$banner = @'
__      __ __      __  ___                          ___      _
\ \    / /_\ \    / / | __|__ _ _ _____ _____ _ _  | _ ) ___| |_ ___
 \ \/\/ / _ \ \/\/ /  | _/ _ \ '_/ -_) V / -_) '_| | _ \/ _ \  _(_-<
  \_/\_/\___/\_/\_/   |_|\___/_| \___|\_/\___|_|   |___/\___/\__/__/
'@

# once per install: make the two shortcuts ("WoW Forever" launcher + "WoW Forever Bots" control panel) on the Desktop and in the Start Menu; an update run by an older update.ps1 does not do it, and the new marker name makes installs that already ran the old one redo it
$marker = Join-Path $here 'shortcuts-launcher.done'
if (-not (Test-Path $marker)) {
    try { & (Join-Path $here 'make-shortcuts.ps1') | Out-Null; Set-Content $marker (Get-Date -Format s) } catch { }
}

function Info { try { Get-Content (Join-Path $root 'version.json') -Raw | ConvertFrom-Json } catch { $null } }
function ServerUp { [bool](Get-Process worldserver -ErrorAction SilentlyContinue) }
function RestarterProc {
    Get-CimInstance Win32_Process -Filter "Name='powershell.exe'" -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -like '*AutoRestart-WoWForever.ps1*' }
}
function PlayersOnline {
    $m = Join-Path $root 'mysql\bin\mysql.exe'
    if (-not (Test-Path $m)) { return $null }
    try {
        $n = & $m "--defaults-file=$root\config\my.ini" -u root -N -s -e 'SELECT COUNT(*) FROM characters.characters WHERE online=1' 2>$null
        if ($LASTEXITCODE -eq 0 -and $n -match '^\d+$') { return [int]$n }
    } catch { }
    $null
}
function Pause-Menu { Write-Host ''; Write-Host '  Press any key to go back to the menu...' -ForegroundColor DarkGray; $null = [Console]::ReadKey($true) }
function Ask([string]$q) { Write-Host "  $q " -NoNewline -ForegroundColor Yellow; $k = [Console]::ReadKey($true); Write-Host $k.KeyChar; $k.KeyChar.ToString().ToUpper() }
function Opt([string]$key, [string]$text, [string]$color = 'White') {
    Write-Host ('    {0} - ' -f $key) -NoNewline -ForegroundColor Gray
    Write-Host $text -ForegroundColor $color
}
function Script-Run([string]$name, [string[]]$more = @()) { & (Join-Path $here $name) @more }

function Draw {
    Clear-Host
    Write-Host ''
    Write-Host $banner -ForegroundColor Yellow
    $i = Info
    $ver = if ($i) { $i.version } else { '?' }
    $core = if ($i -and $i.commit) { ([string]$i.commit).Substring(0, 8) } else { '?' }
    Write-Host ('  Version: {0}    Core: {1}    Client build: {2}' -f $ver, $core, $(if ($i) { $i.client } else { '?' })) -ForegroundColor Cyan
    $up = ServerUp
    Write-Host '  Server:  ' -NoNewline -ForegroundColor Cyan
    if ($up) {
        Write-Host 'RUNNING' -NoNewline -ForegroundColor Green
        $p = PlayersOnline
        if ($null -ne $p) { Write-Host ("    players online: {0}" -f $p) -NoNewline -ForegroundColor Cyan }
    } else { Write-Host 'STOPPED' -NoNewline -ForegroundColor Red }
    $r = RestarterProc
    Write-Host '    Game data: ' -NoNewline -ForegroundColor Cyan
    if (Test-Path (Join-Path $root 'server\data\.extract-complete')) { Write-Host 'complete' -NoNewline -ForegroundColor Green } else { Write-Host 'NOT FINISHED (menu 1 builds it)' -NoNewline -ForegroundColor Red }
    Write-Host '    Restarter: ' -NoNewline -ForegroundColor Cyan
    if ($r) { Write-Host 'ON' -ForegroundColor Green } else { Write-Host 'off' -ForegroundColor DarkGray }
    Write-Host ''
    Opt '1' 'Start server' $(if ($up) { 'DarkGray' } else { 'Green' })
    Opt '2' 'Stop server' $(if ($up) { 'Red' } else { 'DarkGray' })
    Opt '3' 'Restart server'
    Opt 'T' 'Restarter mode (restarts the server by itself if it crashes)'
    Write-Host ''
    Opt 'P' 'Play (opens the launcher window)'
    Opt 'A' 'Create account'
    Opt 'S' 'Server settings (your own changes, opens in Notepad)'
    Opt 'B' 'Backup now / restore a backup'
    Opt 'I' 'Install / refresh the game add-on (ForeverBots)'
    Opt 'U' 'Update to the newest release'
    Write-Host ''
    Opt 'D' 'Join our Discord'
    Opt 'H' 'Help'
    Opt '0' 'Exit (the server keeps running)'
    Write-Host ''
}

function Do-Start {
    if (ServerUp) { Write-Host '  The server is already running.' -ForegroundColor Yellow; return }
    Write-Host '  Starting. The first start after an install or update can take several minutes while the database is prepared...' -ForegroundColor Cyan
    try { Script-Run 'Start-WoWForever.ps1' } catch { Write-Host "  $($_.Exception.Message)" -ForegroundColor Red }
}
function Do-Stop {
    if (-not (ServerUp) -and -not (Get-Process bnetserver, mysqld -ErrorAction SilentlyContinue)) { Write-Host '  The server is not running.' -ForegroundColor Yellow; return }
    Write-Host '  Saving characters and stopping (up to a minute)...' -ForegroundColor Cyan
    Script-Run 'Stop-WoWForever.ps1'
}
function Do-Restart {
    $wasOn = [bool](RestarterProc)
    Do-Stop
    Start-Sleep 3
    Do-Start
    if ($wasOn) { Do-Restarter-On }
}
function Do-Restarter-On {
    Start-Process powershell.exe -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$here\AutoRestart-WoWForever.ps1`"" -WindowStyle Minimized
    Write-Host '  Restarter mode is ON (a minimized window watches the server).' -ForegroundColor Green
}
function Do-Restarter {
    $r = @(RestarterProc)
    if ($r.Count) {
        $r | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
        Write-Host '  Restarter mode is OFF. The server keeps running; if it crashes it stays down until you start it.' -ForegroundColor Yellow
    } else {
        Do-Restarter-On
    }
}
function Do-Settings {
    $d = Join-Path $root 'server\worldserver.conf.d'
    New-Item -ItemType Directory -Force $d | Out-Null
    $f = Join-Path $d 'zz-9-local.conf'
    # the server ignores a settings file that does not start with a section line, so the file always begins with [worldserver]
    if (-not (Test-Path $f)) {
        "[worldserver]`r`n# Your own settings. Anything here overrides the realm settings and survives updates.`r`n# Example:  Playerbot.World.MaxBots = 300`r`n# Restart the server after saving (menu 3)." | Set-Content $f
    } elseif (-not (Select-String -Path $f -Pattern '^\s*\[' -Quiet)) {
        ("[worldserver]`r`n" + (Get-Content $f -Raw)) | Set-Content $f
    }
    Start-Process notepad.exe -ArgumentList "`"$f`""
    Write-Host '  Opened in Notepad. Save the file, then restart the server (3) for the change to apply.' -ForegroundColor Cyan
}
function Do-Backup {
    $k = Ask 'B - [1] backup now   [2] restore a backup   [other] back:'
    if ($k -eq '1') {
        try { Script-Run 'Backup-Now.ps1' } catch { Write-Host "  $($_.Exception.Message)" -ForegroundColor Red }
    } elseif ($k -eq '2') {
        $all = @(Get-ChildItem (Join-Path $root 'backups') -Directory -Filter 'pre-*' -ErrorAction SilentlyContinue | Sort-Object CreationTime -Descending)
        if (-not $all) { Write-Host '  No backups yet. Use "1" first (updates also make one).' -ForegroundColor Yellow; return }
        for ($n = 0; $n -lt $all.Count -and $n -lt 9; $n++) { Write-Host ("    {0} - {1}" -f ($n + 1), $all[$n].Name) }
        $c = Ask 'Which one? (number, other = cancel):'
        if ($c -match '^[1-9]$' -and [int]$c -le $all.Count) { & (Join-Path $here 'restore-backup.ps1') -Backup $all[[int]$c - 1].Name }
    }
}
function Do-Addon {
    try { & (Join-Path $here 'install-addon.ps1') } catch {
        Write-Host "  $($_.Exception.Message)" -ForegroundColor Yellow
        $f = Read-Host '  Type or paste the full path of your WoW Forever game folder (the one that contains .build.info), or press Enter to cancel'
        if ($f) { try { & (Join-Path $here 'install-addon.ps1') -Client $f.Trim('"') } catch { Write-Host "  $($_.Exception.Message)" -ForegroundColor Red } }
    }
}
function Do-Play {
    Start-Process (Join-Path $root 'Play-WoWForever.cmd')
    Write-Host '  Opening the launcher window.' -ForegroundColor Cyan
}
function Do-Update { & (Join-Path $here 'Update-Window.ps1') }
function Do-Discord { Start-Process (Get-Content (Join-Path $here 'discord-link.txt') -TotalCount 1); Write-Host '  Opening Discord in your browser.' -ForegroundColor Cyan }
function Do-Help {
    Write-Host @'

  Start / Stop / Restart  Run the server. Restart saves everything first. Stop saves characters and shuts down MySQL too.
  Restarter mode (T)      A small minimized window watches the server and starts it again if it crashes. Turn it off with T,
                          or Stop the server. It gives up after 5 crashes in 10 minutes (that needs a fix; see Help below).
  Create account          Name, password, optional GM. The server must be running.
  Server settings         Opens server\worldserver.conf.d\zz-9-local.conf. Your changes there survive updates.
  Backup / restore        Backs up accounts, characters and bots. Updates also make one automatically.
  Add-on (I)              Copies the ForeverBots add-on into your game folder again (after reinstalling the game or moving the folder).
  Update                  Installs the newest release from GitHub and keeps your characters.
  Play (P)                Starts the game for this server and applies the server login key (keep that window open while you play); realm "Trinity".
  Problems                Run repack\bug-bundle.ps1 and send the zip it makes in our Discord (button D).
  Closing this window     The server keeps running. Use 2 to stop it.
'@ -ForegroundColor Gray
}

function Dispatch([string]$k) {
    switch ($k) {
        '1' { Do-Start } '2' { Do-Stop } '3' { Do-Restart } 'T' { Do-Restarter } 'P' { Do-Play } 'A' { try { Script-Run 'Create-Account.ps1' } catch { Write-Host "  $($_.Exception.Message)" -ForegroundColor Red } }
        'S' { Do-Settings } 'B' { Do-Backup } 'I' { Do-Addon } 'U' { Do-Update } 'D' { Do-Discord } 'H' { Do-Help }
        default { return $false }
    }
    $true
}

if ($Run) { $null = Dispatch $Run.ToUpper(); Pause-Menu }
while ($true) {
    Draw
    $k = Ask 'Enter your choice:'
    if ($k -eq '0') {
        if (ServerUp) { if ((Ask 'The server keeps running. Exit this menu? (Y/N)') -ne 'Y') { continue } }
        break
    }
    if (Dispatch $k) { Pause-Menu }
}
