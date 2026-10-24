# Shared by the start, first-run, backup and restore scripts: starts OUR MySQL (the one in <root>\mysql, port from config\my.ini,
# 3307 by default) and waits until it accepts connections. A MySQL that belongs to something else on the PC (other port) does not count.
function Get-OurMySqlPort([string]$Root) {
    $ini = Join-Path $Root 'config\my.ini'
    if (Test-Path $ini) {
        $m = Select-String -Path $ini -Pattern '^\s*port\s*=\s*(\d+)' | Select-Object -First 1
        if ($m) { return [int]$m.Matches[0].Groups[1].Value }
    }
    3307
}
function Test-MySqlPort([int]$Port) {
    try {
        $c = New-Object Net.Sockets.TcpClient
        $iar = $c.BeginConnect('127.0.0.1', $Port, $null, $null)
        $ok = $iar.AsyncWaitHandle.WaitOne(700) -and $c.Connected
        $c.Close()
        return [bool]$ok
    } catch { return $false }
}
# The program file of the process listening on the port, or $null when it cannot be told (nothing listening, no access).
function Get-PortOwnerPath([int]$Port) {
    try {
        $c = Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction Stop | Select-Object -First 1
        return (Get-Process -Id $c.OwningProcess -ErrorAction Stop).Path
    } catch { return $null }
}
# Makes the 'trinity' user, its password and the databases match secrets\mysql.txt. The password file used to be written before
# the user was created and the result was never checked, so an install whose first database step failed (or ran against another
# MySQL on the port) kept a password the database never got, and every start ended with "DatabasePool Login NOT opened".
# Safe to run on every start: it only sets what is already meant to be there.
function Sync-TrinityUser([string]$Root) {
    $pwFile = Join-Path $Root 'secrets\mysql.txt'
    $m = Select-String -Path $pwFile -Pattern '^mysql trinity: (.+)$' -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $m) { throw "No database password in $pwFile. Run Install.cmd again." }
    $pw = $m.Matches[0].Groups[1].Value
    $sql = ''
    foreach ($h in 'localhost', '127.0.0.1') {
        $sql += "CREATE USER IF NOT EXISTS 'trinity'@'$h' IDENTIFIED BY '$pw'; ALTER USER 'trinity'@'$h' IDENTIFIED BY '$pw'; "
    }
    foreach ($db in 'auth', 'characters', 'world', 'hotfixes', 'playerbot') {
        $sql += "CREATE DATABASE IF NOT EXISTS $db DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci; "
        foreach ($h in 'localhost', '127.0.0.1') { $sql += "GRANT ALL ON $db.* TO 'trinity'@'$h'; " }
    }
    $sql += 'FLUSH PRIVILEGES;'
    $out = & (Join-Path $Root 'mysql\bin\mysql.exe') "--defaults-file=$Root\config\my.ini" -u root -e $sql 2>&1
    if ($LASTEXITCODE) { throw "Could not set up the database user: $(($out | Out-String).Trim())" }
}
function Start-OurMySql([string]$Root, [int]$WaitSeconds = 90) {
    $port = Get-OurMySqlPort $Root
    if (Test-MySqlPort $port) {
        # Something already answers on our port. Only our own mysqld has this install's databases and password (secrets\mysql.txt);
        # another one, usually the MySQL of an older WoW Forever Bots folder that is still running, refuses the login and the
        # worldserver closes at once ("DatabasePool Login NOT opened").
        $owner = Get-PortOwnerPath $port
        $ours = [IO.Path]::GetFullPath((Join-Path $Root 'mysql\bin\mysqld.exe'))
        if ($owner -and ([IO.Path]::GetFullPath($owner) -ne $ours)) {
            throw "Port $port is already used by another program: $owner. This is usually the MySQL of an older WoW Forever Bots folder that is still running. Stop that one (option 2 in its WoW Forever Bots menu, or restart the PC), then start again."
        }
        return
    }
    'Starting MySQL...'
    $p = Start-Process (Join-Path $Root 'mysql\bin\mysqld.exe') -ArgumentList "`"--defaults-file=$Root\config\my.ini`"" -WindowStyle Hidden -PassThru
    $deadline = (Get-Date).AddSeconds($WaitSeconds)
    while ((Get-Date) -lt $deadline) {
        if (Test-MySqlPort $port) { return }
        if ($p.HasExited) { break }
        Start-Sleep 1
    }
    throw "MySQL did not start on port $port within $WaitSeconds seconds. Look at the newest *.err file in the mysql-data folder for the reason (a program already using port $port is the usual one), then run this again."
}
