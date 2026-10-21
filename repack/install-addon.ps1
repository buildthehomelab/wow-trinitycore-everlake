# Copies the ForeverBots addon into the client's AddOns folder and leaves it enabled. Required: the client (70450) has no
# working native /w, so whispering a bot (/w, /whisper, /t, /tell, /cw) only works through this addon.
#   .\install-addon.ps1 -Client "C:\WoW Forever Client"
param([string]$Client)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
# the game folder is remembered, so updates can refresh the add-on without asking
$saved = Join-Path $root 'config\client.txt'
if (-not $Client -and (Test-Path $saved)) { $Client = (Get-Content $saved -TotalCount 1).Trim() }
if (-not $Client) { throw 'Usage: install-addon.ps1 -Client "<your WoW folder>"' }
$src = Join-Path $root 'addons\ForeverBots'
if (-not (Test-Path $src)) { throw "addon not found at $src" }
$dest = $null
foreach ($sub in '_classic_beta_\Interface\AddOns', '_classic_\Interface\AddOns', 'Interface\AddOns') {
    $p = Join-Path $Client $sub
    if (Test-Path (Split-Path $p -Parent)) { $dest = $p; break }
}
if (-not $dest) { $dest = Join-Path $Client '_classic_beta_\Interface\AddOns' }   # verify folder name against a real client
New-Item -ItemType Directory -Force $dest | Out-Null
robocopy $src (Join-Path $dest 'ForeverBots') /E /NFL /NDL /NJH /NJS | Out-Null
# The Classic Forever dungeon-bot add-on (another server's) sends ".dungeonbots ..." chat commands at login, which this server does
# not have ("Command 'dungeonbots presets' does not exist"). It is not ours and is left untouched; the player is only told.
if (Test-Path (Join-Path $dest 'ClassicForever_Bots')) {
    Write-Host "Note: the add-on ClassicForever_Bots is installed. It is made for another server and prints 'Command dungeonbots presets does not exist' here. Untick it in the AddOns list on the character screen."
}
New-Item -ItemType Directory -Force (Split-Path $saved -Parent) | Out-Null
Set-Content $saved $Client -Encoding ascii
"ForeverBots installed to $dest. In the character select screen click AddOns and make sure ForeverBots is ticked (and 'Load out of date AddOns' if shown)."
