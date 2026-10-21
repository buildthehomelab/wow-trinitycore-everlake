# One-time database setup for the portable MySQL (port 3307, local only, so it never clashes with another MySQL).
# Creates the data dir, a random password for the 'trinity' user (stored in secrets\mysql.txt), the databases,
# and imports the world data from the db zip when it is present (otherwise worldserver imports it on first start, slower).
# Then writes the configs (make-tester-configs.ps1). Safe to re-run: it skips what exists.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$mysqlBin = Join-Path $root 'mysql\bin'
New-Item -ItemType Directory -Force "$root\config", "$root\secrets" | Out-Null
if (-not (Test-Path "$root\config\my.ini")) {
    (Get-Content "$PSScriptRoot\templates\my.ini" -Raw).Replace('@ROOT@', ($root -replace '\\', '/')) | Set-Content "$root\config\my.ini" -Encoding ascii
}
if (-not (Test-Path "$root\mysql-data\mysql")) {
    & "$mysqlBin\mysqld.exe" "--defaults-file=$root\config\my.ini" --initialize-insecure --console
    if ($LASTEXITCODE) { throw 'mysql initialize failed' }
}
. "$PSScriptRoot\mysql-helpers.ps1"
Start-OurMySql $root
$pwFile = "$root\secrets\mysql.txt"
if (-not (Test-Path $pwFile)) {
    $pw = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 24 | ForEach-Object { [char]$_ })
    "mysql trinity: $pw" | Set-Content $pwFile -Encoding ascii
    $sql = "CREATE USER IF NOT EXISTS 'trinity'@'localhost' IDENTIFIED BY '$pw'; " +
           "CREATE USER IF NOT EXISTS 'trinity'@'127.0.0.1' IDENTIFIED BY '$pw'; " +
           "CREATE DATABASE IF NOT EXISTS auth DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci; " +
           "CREATE DATABASE IF NOT EXISTS characters DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci; " +
           "CREATE DATABASE IF NOT EXISTS world DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci; " +
           "CREATE DATABASE IF NOT EXISTS hotfixes DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci; " +
           "CREATE DATABASE IF NOT EXISTS playerbot DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci; " +
           "GRANT ALL ON auth.* TO 'trinity'@'localhost'; GRANT ALL ON auth.* TO 'trinity'@'127.0.0.1'; " +
           "GRANT ALL ON characters.* TO 'trinity'@'localhost'; GRANT ALL ON characters.* TO 'trinity'@'127.0.0.1'; " +
           "GRANT ALL ON world.* TO 'trinity'@'localhost'; GRANT ALL ON world.* TO 'trinity'@'127.0.0.1'; " +
           "GRANT ALL ON hotfixes.* TO 'trinity'@'localhost'; GRANT ALL ON hotfixes.* TO 'trinity'@'127.0.0.1'; " +
           "GRANT ALL ON playerbot.* TO 'trinity'@'localhost'; GRANT ALL ON playerbot.* TO 'trinity'@'127.0.0.1'; FLUSH PRIVILEGES;"
    & "$mysqlBin\mysql.exe" "--defaults-file=$root\config\my.ini" -u root -e $sql
}
# optional prebuilt world data (wow-forever-db-*.zip unpacks sql\world.sql and sql\hotfixes.sql)
foreach ($db in 'world', 'hotfixes') {
    $dump = "$root\sql\$db.sql"
    if (Test-Path $dump) {
        "Importing $db (a few minutes)..."
        cmd /c "`"$mysqlBin\mysql.exe`" --defaults-file=`"$root\config\my.ini`" -u root $db < `"$dump`""
    }
}
# Shared bot database (roads, talent builds, names ...): the worldserver reads it while loading, before any migration runs,
# so it must exist before the first start. Only imported when still empty.
$haveShared = & "$mysqlBin\mysql.exe" "--defaults-file=$root\config\my.ini" -u root -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='playerbot'"
if ([int]$haveShared -eq 0) {
    foreach ($f in 'playerbot_shared_schema.sql', 'playerbot_shared_data.sql') {
        $p = "$root\sql\playerbot_shared\$f"
        if (Test-Path $p) {
            "Importing $f..."
            cmd /c "`"$mysqlBin\mysql.exe`" --defaults-file=`"$root\config\my.ini`" -u root playerbot < `"$p`""
            if ($LASTEXITCODE) { throw "importing $f failed" }
        }
    }
}
# Admin account for the owner of this install: random password, saved only here. Testers get no GM and no default account;
# nothing is created in the database from this script (the account is made in the worldserver console, see README).
$adminFile = "$root\secrets\admin.txt"
if (-not (Test-Path $adminFile)) {
    $apw = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 20 | ForEach-Object { [char]$_ })
    "admin account: admin@local`r`nadmin password: $apw" | Set-Content $adminFile -Encoding ascii
    "Admin login written to $adminFile (keep it private)."
}
& "$PSScriptRoot\make-tester-configs.ps1"
try { & "$PSScriptRoot\make-shortcuts.ps1" -NoDesktop } catch { Write-Warning "Start Menu shortcuts not created: $($_.Exception.Message)" }
"First-run setup done. Next: Start-WoWForever.ps1"
