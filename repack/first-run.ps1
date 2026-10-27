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
# The mysql program reads a file in the character set of the Windows language unless told otherwise (gbk on Chinese Windows, for
# example). The dumps are utf8mb4, and read as gbk the Korean and Chinese texts swallow quotes: the import stops halfway, the world
# misses tables and the worldserver closes ("database structure is not up to date"). An install made before this line gets it here.
$ini = Get-Content "$root\config\my.ini"
if (-not ($ini -match '^\s*default-character-set\s*=')) {
    $ini = $ini -replace '^\[client\]\s*$', "[client]`r`ndefault-character-set=utf8mb4"
    Set-Content "$root\config\my.ini" $ini -Encoding ascii
}
. "$PSScriptRoot\mysql-helpers.ps1"
Repair-MovedFolder $root   # says so plainly when the folder path has letters MySQL cannot read, instead of "mysql initialize failed"
if (-not (Test-VcRuntime $root)) { try { Install-VcRuntime $root } catch { Write-Warning $_.Exception.Message } }   # if mysqld still cannot run, the code below says so
if (-not (Test-Path "$root\mysql-data\mysql")) {
    # A data folder without the mysql system folder is what an earlier try that stopped halfway leaves (closed window, antivirus).
    # mysqld refuses to set up a folder with files in it, so every new try failed the same way. No database can be in it yet
    # (those are made after this step), so it is set aside, never deleted.
    $data = Join-Path $root 'mysql-data'
    $dbDirs = @('auth', 'characters', 'world', 'hotfixes', 'playerbot' | Where-Object { Test-Path (Join-Path $data $_) })
    if ((Test-Path $data) -and @(Get-ChildItem $data -Force -ErrorAction SilentlyContinue).Count -and -not $dbDirs) {
        $aside = "$data-unfinished-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        Rename-Item $data (Split-Path $aside -Leaf)
        Write-Host "Set aside the mysql-data folder of an earlier try that did not finish ($aside)."
    }
    # Its text goes into install.log too: printed straight to the console it is missing there, and the window closes with it.
    $eap = $ErrorActionPreference; $ErrorActionPreference = 'Continue'   # Windows PowerShell 5.1 stops on a native program's error text under 'Stop'
    $initOut = @(& "$mysqlBin\mysqld.exe" "--defaults-file=$root\config\my.ini" --initialize-insecure --console 2>&1 | ForEach-Object { "$_" })
    $code = $LASTEXITCODE
    $ErrorActionPreference = $eap
    $initOut | ForEach-Object { Write-Host $_ }
    if ($code) {
        if ($code -in $script:VcRuntimeExitCodes) {
            throw "mysql\bin\mysqld.exe could not run (code $('0x{0:X8}' -f $code)): a part of the Microsoft Visual C++ runtime (x64) is missing or damaged. Install it from https://aka.ms/vs/17/release/vc_redist.x64.exe (run the file, choose Repair or Install), restart the PC, then run Install.cmd again."
        }
        $why = Get-MySqlReason $initOut
        if (-not $initOut) { $why.Text = 'MySQL printed nothing: an antivirus program may have blocked mysql\bin\mysqld.exe. Allow the WoW Forever Bots folder in it and run Install.cmd again.' }
        $msg = "MySQL could not set up its data folder (code $code). $($why.Text)"
        if ($why.Line) { $msg += " MySQL said: $($why.Line)" }
        if ($why.Kind -eq 'leftover') { $msg += ' Close every WoW Forever Bots window, restart the PC and run Install.cmd again.' }
        throw $msg
    }
}
Start-OurMySql $root
$pwFile = "$root\secrets\mysql.txt"
if (-not (Test-Path $pwFile)) {
    $pw = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 24 | ForEach-Object { [char]$_ })
    "mysql trinity: $pw" | Set-Content $pwFile -Encoding ascii
}
Sync-TrinityUser $root
# optional prebuilt world data (wow-forever-db-*.zip unpacks sql\world.sql and sql\hotfixes.sql)
foreach ($db in 'world', 'hotfixes') {
    $dump = "$root\sql\$db.sql"
    if (Test-Path $dump) {
        "Importing $db (a few minutes)..."
        cmd /c "`"$mysqlBin\mysql.exe`" --defaults-file=`"$root\config\my.ini`" --default-character-set=utf8mb4 -u root $db < `"$dump`""
        if ($LASTEXITCODE) { throw "Importing $db failed (the error is shown above). Run Install.cmd again; if it stops here again, post repack\install.log in our Discord." }
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
            cmd /c "`"$mysqlBin\mysql.exe`" --defaults-file=`"$root\config\my.ini`" --default-character-set=utf8mb4 -u root playerbot < `"$p`""
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
