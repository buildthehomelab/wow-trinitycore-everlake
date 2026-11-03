# Checks the server's settings files and shows, with the file and the line number, anything the server would stop on or ignore,
# and which file's value is used for a setting that is in more than one file. Changes nothing. Double-click Check-Config.cmd in
# the main folder. The start scripts run the same check before every start.
param([switch]$NoPause, [switch]$All)   # -All: also list settings that a conf.d file sets again over worldserver.conf
$root = Split-Path $PSScriptRoot -Parent
. "$PSScriptRoot\ConfigCheck.ps1"
$cfg = Test-ServerConfig (Join-Path $root 'server') -All:$All
foreach ($l in $cfg.Lines) {
    $c = if ($l -like 'PROBLEM*') { 'Red' } elseif ($l -like 'WARNING*') { 'Yellow' } else { 'Gray' }
    Write-Host $l -ForegroundColor $c
    Write-Host ''
}
if ($cfg.Ok) { Write-Host 'No problem the server would stop on.' -ForegroundColor Green }
else { Write-Host 'Fix the PROBLEM lines above (file and line number are given), save the file, then start the server again.' -ForegroundColor Red }
if (-not $NoPause) { Read-Host 'Press Enter to close' | Out-Null }
if (-not $cfg.Ok) { exit 1 }
