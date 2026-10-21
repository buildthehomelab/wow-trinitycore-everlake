# One-step PC install of a built commit: pre-flight, DB backup, cmake install + configs, config assertions,
# optional vmaps/mmaps swap, addon sync, pass/fail summary. Windows PowerShell 5.1 only, no Python.
#
#   .\install.ps1 -Commit 11f76234 -DryRun        -> run the read-only checks and print every action; changes nothing
#   .\install.ps1 -Commit 11f76234                 -> do it (PlayerbotV2 build in server-bot\)
#   .\install.ps1 -Commit 11f76234 -VmapsFrom D:\new\vmaps -MmapsFrom D:\new\mmaps   -> also swap the data folders
#
# Rules it enforces (PC rules):
#   * never stops or touches a running worldserver/bnetserver: if one is running it refuses before changing anything
#   * no changes to game data: only mysqldump backups, each verified by restoring it into a scratch schema that is dropped
#     again (run as the MySQL root login from secrets\mysql.txt, so no grant is needed; MySQL is started if it is not running and never stopped)
#   * writes <Server>\.verified-backup, the marker start-servers.ps1 requires before it lets this build migrate the databases
#   * the commit you name must be the checked-out HEAD of TrinityCore\ and must be what the installed worldserver reports
#   * backups\: keeps the newest 3 backups plus the baselines (8b43fd30, d72da764)
# Exit code 0 = all checks passed, 1 = at least one FAIL (the summary lists them).
param(
    [Parameter(Mandatory)][string]$Commit,
    [string]$Server = '',                  # default: $installFolder from common.ps1
    [string]$Client = 'C:\wow wowowo',
    [string[]]$Addons = @('ForeverBots'),
    [string]$VmapsFrom,
    [string]$MmapsFrom,
    [switch]$SkipWorldBackup,
    [string]$ScratchDb = 'zz_backup_verify',
    [int]$KeepSymbols = 3,
    [switch]$DryRun,
    [string]$ExpectedFile = '',
    [string]$BuildDir = ''                 # default: build\ ; pass build-ninja if build-fast.ps1 produced the build
)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\common.ps1"
if (-not $Server) { $Server = $installFolder }
if (-not $ExpectedFile) { $ExpectedFile = Join-Path $PSScriptRoot 'install-expected.psd1' }   # a $PSScriptRoot default in the param block is empty in PS 5.1
$repo    = $repoRoot
$dir     = Join-Path $root $Server
$mysqlBin = 'C:\local\mysql-8.4.11\bin'
$baselines = @('8b43fd30', 'd72da764')
$keep    = 3
$short   = $Commit.Substring(0, [Math]::Min(8, $Commit.Length)).ToLower()
$stamp   = Get-Date -Format 'yyyyMMdd-HHmm'
$results = New-Object System.Collections.ArrayList

function Add-Result([string]$name, [string]$status, [string]$detail) {
    [void]$results.Add([pscustomobject]@{ Name = $name; Status = $status; Detail = $detail })
    $color = 'Green'; if ($status -eq 'FAIL') { $color = 'Red' } elseif ($status -eq 'SKIP' -or $status -eq 'PLAN') { $color = 'Yellow' }
    Write-Host ("[{0}] {1}: {2}" -f $status, $name, $detail) -ForegroundColor $color
}
function Test-Failed { return @($results | Where-Object { $_.Status -eq 'FAIL' }).Count -gt 0 }
# Runs $action unless -DryRun; a throw becomes a FAIL and the script stops changing things.
function Invoke-Step([string]$name, [string]$plan, [scriptblock]$action) {
    if (Test-Failed) { Add-Result $name 'SKIP' 'an earlier step failed'; return }
    if ($DryRun)     { Add-Result $name 'PLAN' $plan; return }
    try { $detail = & $action; Add-Result $name 'PASS' ([string]$detail) }
    catch { Add-Result $name 'FAIL' "$($_.Exception.Message) (script line $($_.InvocationInfo.ScriptLineNumber))" }
}

if ($PSVersionTable.PSVersion.Major -ne 5) { Write-Warning "Built for Windows PowerShell 5.1; running on $($PSVersionTable.PSVersion)" }
if ($DryRun) { Write-Host '== DRY RUN: read-only checks only, nothing is changed ==' -ForegroundColor Yellow }

# ---------------------------------------------------------------- 1. pre-flight (read-only)
$running = @(Get-Process worldserver, bnetserver -ErrorAction SilentlyContinue)
if ($running.Count) { Add-Result 'no server running' 'FAIL' ("close it first: " + (($running | ForEach-Object { $_.ProcessName }) -join ', ') + ' (this script never stops a server)') }
else                { Add-Result 'no server running' 'PASS' 'worldserver and bnetserver are not running' }

$head = (& git -C $repo rev-parse HEAD 2>&1) | Out-String
$head = $head.Trim()
if ($head -like "$($Commit.ToLower())*") { Add-Result 'commit checked out' 'PASS' "HEAD = $head" }
else { Add-Result 'commit checked out' 'FAIL' "TrinityCore HEAD is $head, not $Commit (check out and build that commit first)" }
$dirty = (& git -C $repo status --porcelain --untracked-files=no 2>&1) | Out-String
if ($dirty.Trim()) { Add-Result 'clean work tree' 'FAIL' 'tracked files are modified; build from a clean checkout so the commit means something' }
else { Add-Result 'clean work tree' 'PASS' 'no tracked changes' }

$cache = Join-Path $root 'build\CMakeCache.txt'
if (-not (Test-Path $cache)) { Add-Result 'build tree' 'FAIL' "$cache missing: run scripts\build-server.ps1 first" }
else {
    $prefix = ((Select-String $cache -Pattern '^CMAKE_INSTALL_PREFIX:PATH=(.+)$').Matches[0].Groups[1].Value) -replace '/', '\'
    if ((Split-Path $prefix -Leaf) -ne $Server) { Add-Result 'build tree' 'FAIL' "build\ installs to $prefix but -Server is $Server" }
    else { Add-Result 'build tree' 'PASS' "install prefix $prefix" }
}
foreach ($p in @("$root\secrets\mysql.txt", "$mysqlBin\mysqldump.exe")) {
    if (Test-Path $p) { Add-Result 'needs' 'PASS' $p } else { Add-Result 'needs' 'FAIL' "$p missing" }
}
foreach ($pair in @(@('VmapsFrom', $VmapsFrom), @('MmapsFrom', $MmapsFrom))) {
    if ($pair[1]) {
        if (Test-Path $pair[1] -PathType Container) { Add-Result "-$($pair[0])" 'PASS' $pair[1] } else { Add-Result "-$($pair[0])" 'FAIL' "$($pair[1]) is not a folder" }
    }
}
if (-not $Addons) { } else {
    foreach ($a in $Addons) {
        $s = Join-Path $repo "src\modules\PlayerbotV2\Addon\$a"
        if (Test-Path $s) { Add-Result "addon source $a" 'PASS' $s } else { Add-Result "addon source $a" 'FAIL' "$s missing" }
    }
    if (-not (Test-Path (Join-Path $Client '_classic_beta_'))) { Add-Result 'client folder' 'FAIL' "$Client\_classic_beta_ not found" }
    else { Add-Result 'client folder' 'PASS' $Client }
}

# ---------------------------------------------------------------- 2. DB backup (dump only)
$backupRoot = Join-Path $root 'backups'
$backupDir  = Join-Path $backupRoot $short
if (Test-Path $backupDir) { $backupDir = Join-Path $backupRoot "$short-$stamp" }
$dbs = @('auth', 'characters', 'playerbot', 'hotfixes', 'world')
if ($SkipWorldBackup) { $dbs = @('auth', 'characters', 'playerbot') }

function Get-Scalar([string]$db, [string]$query) {
    # one value from mysql.exe ('' when the query returns nothing); the password is in $env:MYSQL_PWD, which the backup step sets for
    # its whole run (every mysql/mysqldump call below needs it) and clears at its end. $db '' = no default schema (CREATE/DROP)
    $mysqlArgs = @('--host=127.0.0.1', '--port=3306', '--user=root', '--batch', '--skip-column-names', '-e', $query)
    if ($db) { $mysqlArgs += $db }
    $o = @(& "$mysqlBin\mysql.exe" @mysqlArgs 2>&1)
    if ($LASTEXITCODE -ne 0) { throw "mysql failed (exit $LASTEXITCODE) for: $query -> $($o -join ' ')" }
    if ($o.Count -eq 0 -or $null -eq $o[0]) { return '' }
    return ([string]$o[0]).Trim()
}

Invoke-Step 'database backup + restore check' "mysqldump $($dbs -join ', '); restore each into scratch schema '$ScratchDb' and compare table counts, then drop it; write schema.txt + verified.txt into $backupDir" {
    if (-not (Get-Process mysqld -ErrorAction SilentlyContinue)) { & "$PSScriptRoot\start-mysql.ps1" | Out-Null; Start-Sleep 8 }
    $pwLine = Select-String "$root\secrets\mysql.txt" -Pattern '^mysql root: (.+?)\s*$' | Select-Object -First 1
    if ($null -eq $pwLine) { throw "no 'mysql root: <password>' line in $root\secrets\mysql.txt" }
    New-Item -ItemType Directory -Force $backupDir | Out-Null
    $schema = New-Object System.Collections.ArrayList
    $verified = New-Object System.Collections.ArrayList
    $env:MYSQL_PWD = $pwLine.Matches[0].Groups[1].Value
    try {
        foreach ($db in $dbs) {
            $raw = Join-Path $backupDir "$db.sql"
            # --result-file keeps the dump byte-exact (no PowerShell pipe re-encoding)
            & "$mysqlBin\mysqldump.exe" --host=127.0.0.1 --port=3306 --user=root --single-transaction --routines --default-character-set=utf8mb4 "--result-file=$raw" $db
            if ($LASTEXITCODE -ne 0) { throw "mysqldump $db failed (exit $LASTEXITCODE); is the schema '$db' there?" }

            # schema version: how many updates are applied and the newest one (TrinityCore's `updates` table; absent in some schemas)
            $srcTables = [int](Get-Scalar $db "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$db'")
            $ver = 'n/a'
            if ((Get-Scalar $db "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$db' AND table_name='updates'") -eq '1') {
                $ver = (Get-Scalar $db "SELECT CONCAT(COUNT(*),' applied, newest ',IFNULL(MAX(name),'none')) FROM updates")
            }
            [void]$schema.Add("$db`: tables=$srcTables; updates: $ver")

            # restore check: load the dump into a scratch schema, compare table counts, drop it again
            [void](Get-Scalar '' "DROP DATABASE IF EXISTS ``$ScratchDb``")
            [void](Get-Scalar '' "CREATE DATABASE ``$ScratchDb`` DEFAULT CHARSET utf8mb4")
            try {
                cmd /c "`"$mysqlBin\mysql.exe`" --host=127.0.0.1 --port=3306 --user=root --default-character-set=utf8mb4 $ScratchDb < `"$raw`""
                if ($LASTEXITCODE -ne 0) { throw "restore of $db into $ScratchDb failed (exit $LASTEXITCODE)" }
                $dstTables = [int](Get-Scalar '' "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$ScratchDb'")
                if ($dstTables -ne $srcTables) { throw "$db restore has $dstTables tables, source has $srcTables" }
            } finally { try { [void](Get-Scalar '' "DROP DATABASE IF EXISTS ``$ScratchDb``") } catch { } }
            [void]$verified.Add("$db`: $srcTables tables restored OK")

            $in = [IO.File]::OpenRead($raw); $out = [IO.File]::Create("$raw.gz")
            try { $gz = New-Object IO.Compression.GZipStream($out, [IO.Compression.CompressionMode]::Compress); $in.CopyTo($gz); $gz.Dispose() }
            finally { $in.Dispose(); $out.Dispose() }
            Remove-Item $raw -Force
        }
    } finally { Remove-Item Env:\MYSQL_PWD -ErrorAction SilentlyContinue }
    Set-Content (Join-Path $backupDir 'schema.txt') $schema -Encoding ascii
    Set-Content (Join-Path $backupDir 'verified.txt') (@("commit: $head", "time: $(Get-Date -Format s)") + $verified) -Encoding ascii
    $script:backupVerified = $true
    "$($dbs.Count) databases dumped and restore-checked -> $backupDir ($([Math]::Round((Get-ChildItem $backupDir | Measure-Object Length -Sum).Sum / 1MB)) MB)"
}

Invoke-Step 'backup retention' "keep newest $keep backups + baselines ($($baselines -join ', ')); delete older ones" {
    $old = Get-ChildItem $backupRoot -Directory | Where-Object {
        $n = $_.Name; -not ($baselines | Where-Object { $n -like "$_*" })
    } | Sort-Object LastWriteTime -Descending | Select-Object -Skip $keep
    foreach ($o in $old) { Remove-Item $o.FullName -Recurse -Force }
    "removed $(@($old).Count) old backup folder(s)"
}

# ---------------------------------------------------------------- 3. install + configs
Invoke-Step 'install build + configs' "scripts\install-server.ps1 (cmake --install, runtime DLLs, make-configs -Server $Server)" {
    if ($BuildDir) { & "$PSScriptRoot\install-server.ps1" -BuildDir $BuildDir } else { & "$PSScriptRoot\install-server.ps1" }
    "installed into $dir"
}

Invoke-Step 'mysql config' "render config\my.ini.template from the repo into $root\config\my.ini (start-mysql.ps1 reads it) after backing up the current one into the backup folder; never restarts MySQL" {
    $src = Join-Path $repo 'config\my.ini.template'
    $dst = Join-Path $root 'config\my.ini'
    if (-not (Test-Path $src)) { throw "$src missing" }
    # basedir: keep what the installed my.ini already uses, else $env:MYSQL_BASEDIR, else the default of start-mysql.ps1.
    $basedir = if ($env:MYSQL_BASEDIR) { $env:MYSQL_BASEDIR } else { 'C:/local/mysql-8.4.11' }
    if (Test-Path $dst) {
        $m = Select-String -Path $dst -Pattern '^basedir=(.+)$' | Select-Object -First 1
        if ($m) { $basedir = $m.Matches[0].Groups[1].Value.Trim() }
    }
    $datadir = ($root -replace '\\', '/') + '/mysql-data'
    if (Test-Path $dst) {   # never repoint a live data directory
        $d = Select-String -Path $dst -Pattern '^datadir=(.+)$' | Select-Object -First 1
        if ($d) { $datadir = $d.Matches[0].Groups[1].Value.Trim() }
    }
    $text = (Get-Content $src -Raw) -replace '@MYSQL_BASEDIR@', $basedir -replace '@MYSQL_DATADIR@', $datadir
    $tmp = Join-Path $env:TEMP 'my.ini.rendered'
    Set-Content -Path $tmp -Value $text -Encoding ASCII -NoNewline
    if ((Test-Path $dst) -and ((Get-FileHash $tmp).Hash -eq (Get-FileHash $dst).Hash)) { return "my.ini unchanged" }
    New-Item -ItemType Directory -Force (Split-Path $dst) | Out-Null
    $note = ''
    if (Test-Path $dst) {
        Copy-Item $dst (Join-Path $backupDir 'my.ini.before') -Force
        $note = " (previous one saved as $backupDir\my.ini.before)"
    }
    Copy-Item $tmp $dst -Force
    "my.ini updated$note. MySQL has NOT been restarted: the new settings apply only after a MySQL restart, which is done only when chris says go"
}

Invoke-Step 'installed revision'"worldserver.exe --version must report $short" {
    $v = (& "$dir\worldserver.exe" --version 2>&1) | Out-String
    if ($v -notmatch [regex]::Escape($short)) { throw "worldserver reports: $($v.Trim()). Expected revision $short; rebuild that commit and re-run" }
    $v.Trim()
}


Invoke-Step 'verified-backup marker' "write $dir\.verified-backup (start-servers.ps1 refuses to start this build without it)" {
    if (-not $script:backupVerified) { throw 'no verified backup in this run' }
    $json = '{"commit":"' + $short + '","backup":"' + ($backupDir -replace '\\', '/') + '","time":"' + (Get-Date -Format s) + '"}'
    Set-Content (Join-Path $dir '.verified-backup') $json -Encoding ascii
    "marker for $short"
}

Invoke-Step 'debug symbols' "copy worldserver.pdb/bnetserver.pdb next to the exes and keep a set per build in symbols\$short (newest $KeepSymbols kept)" {
    $built = Join-Path $root 'build\bin\RelWithDebInfo'
    $symDir = Join-Path $dir "symbols\$short"
    New-Item -ItemType Directory -Force $symDir | Out-Null
    $n = 0
    foreach ($name in 'worldserver', 'bnetserver') {
        $pdb = Join-Path $built "$name.pdb"
        if (-not (Test-Path $pdb)) { throw "$pdb missing: the RelWithDebInfo build should produce it" }
        Copy-Item $pdb $dir -Force
        Copy-Item $pdb $symDir -Force
        $n++
    }
    $old = Get-ChildItem (Join-Path $dir 'symbols') -Directory | Sort-Object LastWriteTime -Descending | Select-Object -Skip $KeepSymbols
    foreach ($o in $old) { Remove-Item $o.FullName -Recurse -Force }
    "$n pdb files; removed $(@($old).Count) old symbol set(s)"
}

# ---------------------------------------------------------------- 4. config assertions
function Get-ConfValue([string]$file, [string]$key) {
    $last = $null
    foreach ($line in Get-Content $file) {
        if ($line -match '^\s*#') { continue }
        if ($line -match ('^\s*' + [regex]::Escape($key) + '\s*=\s*(.*?)\s*$')) { $last = $Matches[1].Trim('"') }
    }
    return $last
}
Invoke-Step 'config assertions' "check keys from $(Split-Path $ExpectedFile -Leaf) in the generated .conf files" {
    $expected = Import-PowerShellDataFile $ExpectedFile
    $files = @{ world = "$dir\worldserver.conf"; playerbot = "$dir\worldserver.conf.d\playerbot.conf"; bnet = "$dir\bnetserver.conf" }
    $bad = New-Object System.Collections.ArrayList
    $n = 0
    foreach ($section in $expected.Keys) {
        $f = $files[$section]
        if (-not $f) { [void]$bad.Add("unknown section '$section' in $ExpectedFile"); continue }
        if (-not (Test-Path $f)) { [void]$bad.Add("$f missing"); continue }
        foreach ($key in $expected[$section].Keys) {
            $n++
            $want = [string]$expected[$section][$key]
            $got = Get-ConfValue $f $key
            if ($got -ne $want) { [void]$bad.Add("$section/$key = '$got' (expected '$want')") }
        }
    }
    # Every worldserver.conf.d file needs a [section] header as its first non-comment line: without it the loader silently drops every key.
    foreach ($c in Get-ChildItem "$dir\worldserver.conf.d" -Filter '*.conf' -ErrorAction SilentlyContinue) {
        $first = Get-Content $c.FullName | Where-Object { $_ -notmatch '^\s*(#|$)' } | Select-Object -First 1
        if ($first -notmatch '^\s*\[[^\]]+\]') { [void]$bad.Add("$($c.Name) has no [section] header (first line: '$first')") }
    }
    if ($bad.Count) { throw ("$($bad.Count) mismatch: " + ($bad -join '; ')) }
    "$n values match"
}

# ---------------------------------------------------------------- 5. optional data folder swap
function Invoke-Swap([string]$name, [string]$from) {
    if (-not $from) { Add-Result "swap $name" 'SKIP' 'not requested'; return }
    $target = Join-Path $root "server\data\$name"
    Invoke-Step "swap $name" "move existing $target to $name.old-$stamp, move $from into place" {
        if (-not (Test-Path $from -PathType Container)) { throw "$from is not a folder" }
        if ((Get-ChildItem $from -Force | Measure-Object).Count -eq 0) { throw "$from is empty" }
        if (Test-Path $target) { Rename-Item $target "$name.old-$stamp" }
        Move-Item $from $target
        "$name replaced; previous copy kept as $name.old-$stamp (delete it when the new one is verified, disk is tight)"
    }
}
Invoke-Swap 'vmaps' $VmapsFrom
Invoke-Swap 'mmaps' $MmapsFrom

# ---------------------------------------------------------------- 6. addon sync
foreach ($a in $Addons) {
    $src = Join-Path $repo "src\modules\PlayerbotV2\Addon\$a"
    $dst = Join-Path $Client "_classic_beta_\Interface\AddOns\$a"
    Invoke-Step "addon $a" "robocopy /MIR $src -> $dst" {
        & robocopy $src $dst /MIR /NFL /NDL /NJH /NJS /NP | Out-Null
        if ($LASTEXITCODE -ge 8) { throw "robocopy failed (exit $LASTEXITCODE)" }
        $LASTEXITCODE = 0
        $diff = Compare-Object (Get-ChildItem $src -Recurse -File | ForEach-Object { (Get-FileHash $_.FullName).Hash }) `
                               (Get-ChildItem $dst -Recurse -File | ForEach-Object { (Get-FileHash $_.FullName).Hash })
        if ($diff) { throw 'addon files differ after sync' }
        "synced and verified"
    }
}

# ---------------------------------------------------------------- summary
Write-Host ''
Write-Host '================ install summary ================'
$results | Format-Table -AutoSize -Wrap | Out-String | Write-Host
$fails = @($results | Where-Object { $_.Status -eq 'FAIL' }).Count
if ($DryRun) { Write-Host "DRY RUN finished: $fails check(s) would block a real run. Nothing was changed." }
elseif ($fails -eq 0) { Write-Host "PASS: $short installed. Start with scripts\start-servers.ps1 -Server $Server" -ForegroundColor Green }
else { Write-Host "FAIL: $fails step(s) failed; steps after the first failure were skipped." -ForegroundColor Red }
if ($fails) { exit 1 } else { exit 0 }
