# Last step of install.ps1: the first account, then the "next steps" note in the main folder (the launcher reads that note to know
# the install finished). install.ps1 has already stopped its log, so what is typed here is not written to install.log.
#   finish-install.ps1 -Root C:\WoWForever [-Gui]
param([Parameter(Mandatory = $true)][string]$Root, [switch]$Gui)
Write-Host ''
Write-Host 'HOW TO LOG IN' -ForegroundColor Green
Write-Host 'You need an account. It is created through the running server (the server finishes starting in the other window).'
if ($Gui) { Write-Host 'The launcher window asks for the account name and password next.' }
else {
    $make = Read-Host 'Create your account now? [Y/n]'
    if ($make -notmatch '^(n|no|nein)$') {
        try { & "$PSScriptRoot\Create-Account.ps1" } catch { Write-Warning $_.Exception.Message; Write-Host 'You can do it later: menu option A (Create account).' }
    } else { Write-Host 'Later: menu option A (Create account).' }
}
$help = @"
Next steps
1. Start the game with Play-WoWForever.cmd (or P in the control panel; it applies the server key, keep its window open) and log in with
   your account name (for example yourname; yourname@local works too) and your password. Realm: Trinity. In game, type /fb for the bots window.
2. Next time: Start Menu > WoW Forever Bots (or the Desktop shortcut) opens the control panel: 1 Start, 2 Stop, 3 Restart,
   T Restarter mode, A Create account, S Settings, B Backup, U Update.
Help and news: https://discord.gg/QJBM6tR3E4
"@
Set-Content (Join-Path $Root 'secrets\first-login.txt') $help -Encoding ascii
if (-not $Gui) { Write-Host "`n$help" -ForegroundColor Green }
