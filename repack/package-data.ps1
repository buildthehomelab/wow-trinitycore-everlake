# DEV SIDE: zips the already extracted game data (maps, vmaps, mmaps, dbc, gt) from server\data into
# wow-forever-data-<ver>.zip so testers can skip extract-data.ps1. Only for the private tester group (see REPACK-PLAN section 11).
#   .\package-data.ps1 -Version 0.1.0
param([Parameter(Mandatory)][string]$Version)
$ErrorActionPreference = 'Stop'
$root = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$out = Join-Path $root "release\$Version"; New-Item -ItemType Directory -Force $out | Out-Null
$data = Join-Path $root 'server\data'
foreach ($d in 'maps', 'vmaps', 'mmaps', 'dbc', 'gt') { if (-not (Test-Path "$data\$d")) { throw "$data\$d missing" } }
$zip = "$out\wow-forever-data-$Version.zip"
Remove-Item $zip -ErrorAction SilentlyContinue
# zip layout: server\data\{maps,vmaps,mmaps,dbc,gt}; mmaps is large, compression level is fastest on purpose
Add-Type -AssemblyName System.IO.Compression.FileSystem
$tmp = Join-Path $out '_dstage'; Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force "$tmp\server" | Out-Null
cmd /c mklink /J "$tmp\server\data" "$data" | Out-Null
[IO.Compression.ZipFile]::CreateFromDirectory($tmp, $zip, [IO.Compression.CompressionLevel]::Fastest, $false)
cmd /c rmdir "$tmp\server\data"; Remove-Item $tmp -Recurse -Force
"$((Get-FileHash $zip -Algorithm SHA256).Hash.ToLower())  $(Split-Path $zip -Leaf)" | Add-Content "$out\SHA256SUMS.txt"
"Built $zip (size $([Math]::Round((Get-Item $zip).Length/1GB,2)) GB). If over 2 GB split it per folder before uploading to GitHub; Drive/Mega are fine."
