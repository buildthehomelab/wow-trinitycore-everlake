# Makes a backup of the databases that hold your accounts, characters and bots (auth, characters, playerbot) into backups\pre-manual-<time>.
# restore-backup.ps1 can put it back. Needs MySQL running (it is started if not). Windows PowerShell 5.1.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$mysqlBin = Join-Path $root 'mysql\bin'; $ini = Join-Path $root 'config\my.ini'
. "$PSScriptRoot\mysql-helpers.ps1"
Start-OurMySql $root
$bk = Join-Path $root ('backups\pre-manual-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Force $bk | Out-Null
foreach ($db in 'auth', 'characters', 'playerbot') {
    "Backing up $db..."
    $sql = Join-Path $bk "$db.sql"
    & (Join-Path $mysqlBin 'mysqldump.exe') "--defaults-file=$ini" -u root --single-transaction --routines --result-file="$sql" $db
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $sql) -or (Get-Item $sql).Length -lt 100) { throw "Backup of $db failed. Is MySQL running?" }
    $gz = [IO.File]::Create("$sql.gz"); $z = New-Object IO.Compression.GZipStream($gz, [IO.Compression.CompressionMode]::Compress)
    $in = [IO.File]::OpenRead($sql); $in.CopyTo($z); $in.Dispose(); $z.Dispose(); $gz.Dispose()
    Remove-Item $sql
}
Copy-Item (Join-Path $root 'version.json') (Join-Path $bk 'version.json') -Force -ErrorAction SilentlyContinue
"Backup saved in $bk"
# keep the 5 newest manual backups
Get-ChildItem (Join-Path $root 'backups') -Directory -Filter 'pre-manual-*' | Sort-Object CreationTime -Descending | Select-Object -Skip 5 | Remove-Item -Recurse -Force
