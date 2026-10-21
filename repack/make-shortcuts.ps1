# Creates two shortcuts on the Desktop and in the Start Menu: "WoW Forever" (the launcher window, Play-WoWForever.cmd) and "WoW Forever Bots" (the control panel, WoW-Forever-Bots.cmd).
# It also removes the older separate shortcuts this repack made (Start server, Stop server, Update server, Create account, Auto-restart,
# Join our Discord, the "WoW Forever Bots" Start Menu folder and the "WoW Forever - ..." Desktop ones). Only ours are removed:
# a shortcut counts when it points into this install folder (or is our Discord link under our own name). Safe to run again.
#   .\make-shortcuts.ps1                -> Start Menu + Desktop
#   .\make-shortcuts.ps1 -NoDesktop     -> Start Menu only
param([switch]$NoDesktop)
$ErrorActionPreference = 'Stop'
$root = (Split-Path $PSScriptRoot -Parent).TrimEnd('\')
$sh = New-Object -ComObject WScript.Shell
$programs = [Environment]::GetFolderPath('Programs')
$desktop = [Environment]::GetFolderPath('Desktop')
$discord = $null
$linkFile = Join-Path $PSScriptRoot 'discord-link.txt'
if (Test-Path $linkFile) {
    $first = @(Get-Content $linkFile | Where-Object { $_ -match '^\s*https://' })[0]
    if ($first) { $discord = $first.Trim() }
}
function Is-Ours($file) {
    try {
        if ($file.Extension -eq '.lnk') {
            $l = $sh.CreateShortcut($file.FullName)
            return (($l.TargetPath -like "$root\*") -or ($l.Arguments -like "*$root\*") -or ($l.WorkingDirectory.TrimEnd('\') -eq $root))
        }
        if ($file.Extension -eq '.url' -and $discord) {
            return ([bool](Select-String -Path $file.FullName -Pattern ([regex]::Escape($discord)) -Quiet))
        }
    } catch { }
    $false
}
# old Start Menu folder
$oldMenu = Join-Path $programs 'WoW Forever Bots'
if (Test-Path $oldMenu -PathType Container) {
    Get-ChildItem $oldMenu -File | Where-Object { Is-Ours $_ } | Remove-Item -Force -ErrorAction SilentlyContinue
    if (-not (Get-ChildItem $oldMenu -Force)) { Remove-Item $oldMenu -Force -ErrorAction SilentlyContinue }
}
# old Desktop shortcuts
Get-ChildItem $desktop -File -Filter 'WoW Forever - *' -ErrorAction SilentlyContinue | Where-Object { Is-Ours $_ } | Remove-Item -Force -ErrorAction SilentlyContinue
# the one shortcut
$ico = Join-Path $PSScriptRoot 'wow-forever.ico'
function New-Link($dir) {
    $l = $sh.CreateShortcut((Join-Path $dir 'WoW Forever Bots.lnk'))
    $l.TargetPath = "$root\WoW-Forever-Bots.cmd"; $l.WorkingDirectory = $root; $l.Description = 'WoW Forever Bots control panel'
    if (Test-Path $ico) { $l.IconLocation = $ico }
    $l.Save()
    $p = $sh.CreateShortcut((Join-Path $dir 'WoW Forever.lnk'))
    $exe = "$root\WoWForeverLauncher.exe"
    $p.TargetPath = $(if (Test-Path $exe) { $exe } else { "$root\Play-WoWForever.cmd" }); $p.WorkingDirectory = $root; $p.Description = 'Start the game (launcher window)'; if (-not (Test-Path $exe)) { $p.WindowStyle = 7 }
    if (Test-Path $ico) { $p.IconLocation = $ico }
    $p.Save()
}
New-Link $programs
if (-not $NoDesktop) { New-Link $desktop }
"Shortcuts 'WoW Forever' and 'WoW Forever Bots' created in the Start Menu" + $(if ($NoDesktop) { '.' } else { ' and on the Desktop.' })
