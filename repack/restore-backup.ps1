# Puts back a backup made by update.ps1 (databases auth, characters, playerbot + the old program files and settings).
# Use it only if an update went wrong. It overwrites your current characters and bots with the backed-up ones.
#   .\restore-backup.ps1                       -> lists the backups
#   .\restore-backup.ps1 -Backup pre-0.2.0-20261012-135222
param([string]$Backup, [switch]$Yes)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$all = @(Get-ChildItem "$root\backups" -Directory -Filter 'pre-*' -ErrorAction SilentlyContinue | Sort-Object CreationTime -Descending)
if (-not $Backup) {
    if (-not $all) { 'No backups found.'; return }
    'Backups (newest first):'; $all | ForEach-Object { "  $($_.Name)" }
    'Run: .\restore-backup.ps1 -Backup <name>'; return
}
$dir = Join-Path "$root\backups" $Backup
if (-not (Test-Path $dir)) { throw "No such backup: $dir" }
if (-not $Yes) {
    $a = Read-Host "This replaces your current characters, accounts and bots with the state of $Backup. Type YES to continue"
    if ($a -ne 'YES') { 'Cancelled.'; return }
}
& "$PSScriptRoot\Stop-WoWForever.ps1" | Out-Null
$mysqlBin = "$root\mysql\bin"; $ini = "$root\config\my.ini"
. "$PSScriptRoot\mysql-helpers.ps1"
Start-OurMySql $root
foreach ($db in 'auth', 'characters', 'playerbot') {
    $gz = "$dir\$db.sql.gz"
    if (-not (Test-Path $gz)) { continue }
    "Restoring $db..."
    $tmp = "$env:TEMP\wf-restore-$db.sql"
    $in = [IO.File]::OpenRead($gz); $z = New-Object IO.Compression.GZipStream($in, [IO.Compression.CompressionMode]::Decompress)
    $out = [IO.File]::Create($tmp); $z.CopyTo($out); $out.Dispose(); $z.Dispose(); $in.Dispose()
    & "$mysqlBin\mysql.exe" "--defaults-file=$ini" -u root -e "DROP DATABASE IF EXISTS ``$db``; CREATE DATABASE ``$db`` DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    cmd /c "`"$mysqlBin\mysql.exe`" --defaults-file=`"$ini`" --default-character-set=utf8mb4 -u root $db < `"$tmp`""
    if ($LASTEXITCODE) { throw "Restoring $db failed (the backup file is still in $dir)." }
    Remove-Item $tmp
}
"Restoring program files and settings..."
if (Test-Path "$dir\server") { Copy-Item "$dir\server\*" "$root\server" -Recurse -Force }
if (Test-Path "$dir\version.json") { Copy-Item "$dir\version.json" "$root\version.json" -Force }
"Restored. Start the server with repack\Start-WoWForever.ps1."
