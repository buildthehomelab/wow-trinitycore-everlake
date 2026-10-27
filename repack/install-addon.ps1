# Copies the ForeverBots addon into the client's AddOns folder and leaves it enabled. Required: the client (70634) has no
# working native /w, so whispering a bot (/w, /whisper, /t, /tell, /cw) only works through this addon.
#   .\install-addon.ps1 -Client "C:\WoW Forever Client"
param([string]$Client)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
# the game folder is remembered, so updates can refresh the add-on without asking
. (Join-Path $PSScriptRoot 'ClientBuild.ps1')
if (-not $Client -and (Get-SavedClient $root)) { $Client = (Get-SavedClient $root).Dir }
if (-not $Client) { throw 'Usage: install-addon.ps1 -Client "<your WoW folder>"' }
# the remembered folder (updates pass it in) may be a backup copy an earlier install found; the Battle.net install is used then
$saved = Get-SavedClient $root
if ($saved -and $saved.Dir -eq $Client) {
    $better = Get-BetterThanSaved $root
    if ($better) { Write-Host "Not using $Client (it looks like a backup copy); using the Battle.net install $better."; $Client = $better }
}
# Leaves exactly one copy of an add-on ($name: ForeverBots, ForeverDots) in an AddOns folder: copies named like it
# (ForeverBots.bak, ForeverBots-old, "ForeverBots (2)") are removed, and the add-on folder itself is deleted and copied fresh, never
# merged into, so no file of an older version stays.
function Install-CleanAddon([string]$src, [string]$addons, [string]$name = 'ForeverBots') {
    New-Item -ItemType Directory -Force $addons | Out-Null
    foreach ($d in @(Get-ChildItem $addons -Directory -ErrorAction SilentlyContinue)) {
        if ($d.Name -ne $name -and $d.Name -match ('^' + $name + '($|[^A-Za-z0-9])')) {
            Write-Host "Removing the old copy $($d.FullName)"
            Remove-Item $d.FullName -Recurse -Force
        }
    }
    $target = Join-Path $addons $name
    if (Test-Path $target) { Remove-Item $target -Recurse -Force }
    Copy-Item $src $target -Recurse -Force
    if (-not (Test-Path (Join-Path $target "$name.toc"))) { throw "the add-on did not copy to $target" }
}
# The other game folders of the same install (beta, Forever release, Classic) that already hold the add-on get the same fresh copy,
# so no game folder keeps an old one.
function Update-OtherAddonCopies([string]$src, [string]$clientRoot, [string]$done, [string]$name = 'ForeverBots') {
    foreach ($sub in '_forever_', '_classic_beta_', '_classic_', '_classic_era_', '') {
        $addons = if ($sub) { Join-Path $clientRoot "$sub\Interface\AddOns" } else { Join-Path $clientRoot 'Interface\AddOns' }
        if (-not (Test-Path (Join-Path $addons $name))) { continue }
        if ((Resolve-Path $addons).Path.TrimEnd('\') -eq (Resolve-Path $done).Path.TrimEnd('\')) { continue }
        Install-CleanAddon $src $addons $name
        Write-Host "Also refreshed $addons\$name"
    }
}
$src = Join-Path $root 'addons\ForeverBots'
if (-not (Test-Path $src)) { throw "addon not found at $src" }
$dest = $null
# into the game folder of the build the server accepts (the beta and the Forever release can be installed side by side)
$use = Select-ClientProduct $root $Client
if ($use) { $dest = Join-Path $use.Dir 'Interface\AddOns' }
foreach ($sub in '_forever_\Interface\AddOns', '_classic_beta_\Interface\AddOns', '_classic_\Interface\AddOns', 'Interface\AddOns') {
    if ($dest) { break }
    $p = Join-Path $Client $sub
    if (Test-Path (Split-Path $p -Parent)) { $dest = $p; break }
}
if (-not $dest) { $dest = Join-Path $Client '_forever_\Interface\AddOns' }   # verify folder name against a real client
Install-CleanAddon $src $dest
Update-OtherAddonCopies $src $Client $dest
# ForeverDots, shipped beside it (addons\ForeverDots), the same way
$dotsSrc = Join-Path $root 'addons\ForeverDots'
if (Test-Path (Join-Path $dotsSrc 'ForeverDots.toc')) {
    Install-CleanAddon $dotsSrc $dest 'ForeverDots'
    Update-OtherAddonCopies $dotsSrc $Client $dest 'ForeverDots'
}
# The Classic Forever dungeon-bot add-on (another server's) sends ".dungeonbots ..." chat commands at login, which this server does
# not have ("Command 'dungeonbots presets' does not exist"). It is not ours and is left untouched; the player is only told.
if (Test-Path (Join-Path $dest 'ClassicForever_Bots')) {
    Write-Host "Note: the add-on ClassicForever_Bots is installed. It is made for another server and prints 'Command dungeonbots presets does not exist' here. Untick it in the AddOns list on the character screen."
}
Save-Client $root $Client
"ForeverBots and ForeverDots installed to $dest. In the character select screen click AddOns and make sure ForeverBots and ForeverDots are ticked (and 'Load out of date AddOns' if shown)."
