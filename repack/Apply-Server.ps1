# Run elevated by the launcher (one Windows permission prompt): points the game's portal name at the chosen server.
#   Apply-Server.ps1 -Portal trinity.actual.battle.net -Address 203.0.113.5
# Only the hosts line for exactly this portal name is replaced; a backup of the hosts file is kept once.
# This script does not touch certificates or trust settings.
param(
    [Parameter(Mandatory)][string]$Portal,
    [Parameter(Mandatory)][string]$Address,
    [string]$Marker = 'wow-forever-join'
)
$ErrorActionPreference = 'Stop'
if ($Portal -notmatch '^[A-Za-z0-9.-]+\.actual\.battle\.net$') { throw "Portal '$Portal' must end in .actual.battle.net" }
$ip = $null
if (-not [Net.IPAddress]::TryParse($Address, [ref]$ip)) { throw "Address '$Address' is not an IP address." }

$hosts = Join-Path $env:SystemRoot 'System32\drivers\etc\hosts'
$bak = $hosts + '.wowforever.bak'
# some PCs have no hosts file at all (removed by a cleaner tool): then it is simply made
$exists = Test-Path -LiteralPath $hosts -PathType Leaf
if ($exists -and -not (Test-Path $bak)) { Copy-Item $hosts $bak }
if (-not $exists) { New-Item -ItemType Directory -Force (Split-Path $hosts -Parent) | Out-Null }
$old = @(); if ($exists) { $old = @(Get-Content $hosts) }
$keep = @($old | Where-Object {
    $t = ($_ -replace '#.*$', '').Trim() -split '\s+'
    -not ($t.Count -ge 2 -and ($t[1..($t.Count - 1)] -contains $Portal))
})
$keep += ('{0} {1} # {2}' -f $ip.ToString(), $Portal, $Marker)
Set-Content $hosts $keep -Encoding ASCII
"hosts: $Portal -> $($ip.ToString())"
