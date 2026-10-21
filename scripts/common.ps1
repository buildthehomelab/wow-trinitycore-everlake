# Dot-sourced by the other scripts: `. "$PSScriptRoot\common.ps1"`. Sets
#   $repoRoot  the git checkout (scripts\ lives in it)
#   $root      the deployment folder that holds build\, server\, server-bot\, backups\ and secrets\: the checkout's parent when the
#              checkout folder is named 'TrinityCore' (the layout on the PC), otherwise the checkout itself
#   $installFolder  the folder (under $root) that install.ps1 installs into and start-servers.ps1 starts by default: the one place both agree
$installFolder = 'server-bot'
$repoRoot = Split-Path $PSScriptRoot -Parent
$root = if ((Split-Path $repoRoot -Leaf) -eq 'TrinityCore') { Split-Path $repoRoot -Parent } else { $repoRoot }
