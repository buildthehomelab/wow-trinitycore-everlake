# Shared by the start, first-run, backup and restore scripts: starts OUR MySQL (the one in <root>\mysql, port from config\my.ini,
# 3307 by default) and waits until it accepts connections. A MySQL that belongs to something else on the PC (other port) does not count.
# It also repairs what stops MySQL from starting after the install: a moved folder, a port Windows now keeps for itself, a start
# while the previous MySQL is still running; when it still fails it says the reason from MySQL's own log.
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
# True when the MySQL that answers on our port is the one of THIS folder: it lets root in without a password (as ours does) and
# its data folder is this folder's mysql-data. Used when Windows does not say which program listens (a Windows service or a
# program run as administrator hides its path from a normal user), which used to count as ours.
function Test-OurMySqlAnswers([string]$Root) {
    $mysql = Join-Path $Root 'mysql\bin\mysql.exe'
    if (-not (Test-Path $mysql)) { return $true }   # cannot ask: keep the old behaviour
    $out = @(& $mysql "--defaults-file=$Root\config\my.ini" -u root --connect-timeout=5 -N -B -e 'SELECT @@datadir' 2>&1)
    if ($LASTEXITCODE) { return $false }
    $dir = ([string]($out | Select-Object -Last 1)).Trim().TrimEnd('\', '/')
    try { return ([IO.Path]::GetFullPath($dir) -ieq [IO.Path]::GetFullPath((Join-Path $Root 'mysql-data'))) } catch { return $false }
}
# A short name for whatever listens on the port, for the player: the Windows service (MySQL80, MariaDB...) when it is one,
# else the program path, else ''.
function Get-PortOwnerText([int]$Port) {
    try {
        $c = Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction Stop | Select-Object -First 1
        $svc = @(Get-CimInstance Win32_Service -Filter "ProcessId = $($c.OwningProcess)" -ErrorAction SilentlyContinue) | Select-Object -First 1
        if ($svc) { return "the Windows service `"$($svc.Name)`"" }
        $p = Get-Process -Id $c.OwningProcess -ErrorAction Stop
        if ($p.Path) { return $p.Path }
        return "$($p.ProcessName).exe (process $($c.OwningProcess))"
    } catch { return '' }
}
# Logs in to the database the way the worldserver does (its LoginDatabaseInfo; a later conf.d file wins) and returns MySQL's
# error text, or '' when the login works. The worldserver itself only logs fatal SQL errors (Logger.sql.sql = 6), so when it
# closes with "DatabasePool Login NOT opened" this is the only place the real reason shows.
function Test-WorldDbLogin([string]$Root) {
    $files = @(Join-Path $Root 'server\worldserver.conf') + @(Get-ChildItem (Join-Path $Root 'server\worldserver.conf.d') -Filter '*.conf' -File -ErrorAction SilentlyContinue | Sort-Object Name | ForEach-Object FullName)
    $info = $null
    foreach ($f in $files) {
        $m = Select-String -Path $f -Pattern '^\s*LoginDatabaseInfo\s*=\s*"([^"]*)"' -ErrorAction SilentlyContinue | Select-Object -Last 1
        if ($m) { $info = $m.Matches[0].Groups[1].Value }
    }
    if (-not $info) { return 'No LoginDatabaseInfo line in worldserver.conf.' }
    $v = $info -split ';'
    if ($v.Count -lt 5) { return "The LoginDatabaseInfo line has $($v.Count) parts instead of 5 (host;port;user;password;database)." }
    $out = @(& (Join-Path $Root 'mysql\bin\mysql.exe') --no-defaults "--host=$($v[0])" "--port=$($v[1])" "--user=$($v[2])" "--password=$($v[3])" --connect-timeout=5 -N -B -e 'SELECT 1' $v[4] 2>&1 |
             ForEach-Object { "$_" } | Where-Object { $_ -notmatch 'Using a password on the command line' })
    if ($LASTEXITCODE) { return (($out | Where-Object { $_ }) -join ' ').Trim() }
    ''
}
# The servers log in with the password written in their *DatabaseInfo lines; Sync-TrinityUser gives the database the one in
# secrets\mysql.txt. When the two differ (settings files from an older install or another folder, a secrets file copied over),
# every start ended with "Access denied for user 'trinity'" and "DatabasePool Login NOT opened". Puts the secrets password and
# our port into every trinity line of the server settings. Only those two parts of those lines change.
function Sync-ConfDbPassword([string]$Root) {
    $m = Select-String -Path (Join-Path $Root 'secrets\mysql.txt') -Pattern '^mysql trinity: (.+)$' -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $m) { return }
    $pw = $m.Matches[0].Groups[1].Value; $port = Get-OurMySqlPort $Root
    $confs = @(Get-ChildItem (Join-Path $Root 'server') -Filter '*.conf' -File -ErrorAction SilentlyContinue) +
             @(Get-ChildItem (Join-Path $Root 'server\worldserver.conf.d') -Filter '*.conf' -File -ErrorAction SilentlyContinue)
    foreach ($f in $confs) {
        $t = @(Get-Content $f.FullName)
        $n = $t | ForEach-Object {
            if ($_ -match '^(\s*\w*DatabaseInfo\s*=\s*")(127\.0\.0\.1|localhost);(\d+);trinity;([^;"]*);([^;"]+)"(.*)$' -and ($Matches[4] -ne $pw -or $Matches[3] -ne "$port")) {
                "$($Matches[1])$($Matches[2]);$port;trinity;$pw;$($Matches[5])`"$($Matches[6])"
            } else { $_ }
        }
        if (($n -join "`n") -ne ($t -join "`n")) { Set-Content $f.FullName $n -Encoding ascii; Write-Host "Database login in $($f.Name) set to match secrets\mysql.txt." }
    }
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
# The mysqld.exe of THIS folder that is running now (it can be alive without listening yet: repairing its files after the PC was
# switched off, or still shutting down), or $null.
function Get-OurMySqlProcess([string]$Root) {
    $ours = [IO.Path]::GetFullPath((Join-Path $Root 'mysql\bin\mysqld.exe'))
    foreach ($p in @(Get-Process mysqld -ErrorAction SilentlyContinue)) {
        try { if ($p.Path -and ([IO.Path]::GetFullPath($p.Path) -eq $ours)) { return $p } } catch { }
    }
    $null
}
function Get-SamePath([string]$A, [string]$B) {
    $a = ($A -replace '\\', '/').TrimEnd('/'); $b = ($B -replace '\\', '/').TrimEnd('/')
    [string]::Equals($a, $b, [StringComparison]::OrdinalIgnoreCase)
}
# true when $Path is $Folder or lies inside it
function Test-PathUnder([string]$Path, [string]$Folder) {
    $p = ($Path -replace '\\', '/').TrimEnd('/'); $f = ($Folder -replace '\\', '/').TrimEnd('/')
    [string]::Equals($p, $f, [StringComparison]::OrdinalIgnoreCase) -or $p.StartsWith("$f/", [StringComparison]::OrdinalIgnoreCase)
}
# The folder this install was made in when that is not this folder (the folder was moved or copied after the install), else $null.
# config\moved-from.txt is written by Repair-MovedFolder when it put this folder's paths back, and removed by Install.cmd: the
# server's own paths can be repaired here, but the shortcuts, the certificate trust and the hosts entry (another PC) only by the
# install, so a moved folder is reported until Install.cmd ran once in it.
function Get-MovedFrom([string]$Root) {
    # the server settings get the install folder's full path (make-tester-configs.ps1); the part in front of these endings is that folder
    $endings = @{
        'CertificatesFile' = '/certs/chain.pem'; 'PrivateKeyFile' = '/certs/server.key'; 'DataDir' = '/server/data'
        'MySQLExecutable' = '/mysql/bin/mysql.exe'; 'SourceDirectory' = ''
    }
    $mark = Join-Path $Root 'config\moved-from.txt'
    if (Test-Path -LiteralPath $mark) {
        $m = @(Get-Content -LiteralPath $mark -ErrorAction SilentlyContinue | Where-Object { $_.Trim() }) | Select-Object -First 1
        if ($m) { return $m.Trim() }
    }
    foreach ($c in 'bnetserver.conf', 'worldserver.conf') {
        $cf = Join-Path (Join-Path $Root 'server') $c
        if (-not (Test-Path -LiteralPath $cf)) { continue }
        foreach ($l in @(Get-Content -LiteralPath $cf)) {
            if ($l -notmatch '^\s*(\w+)\s*=\s*"?(.*?)"?\s*$' -or -not $endings.ContainsKey($Matches[1])) { continue }
            $v = $Matches[2] -replace '\\', '/'
            $end = $endings[$Matches[1]]
            if (-not $v -or $v -notmatch '^[A-Za-z]:/' -or -not $v.EndsWith($end, [StringComparison]::OrdinalIgnoreCase)) { continue }
            $was = $v.Substring(0, $v.Length - $end.Length)
            if ($was -and -not (Get-SamePath $was $Root)) { return ($was -replace '/', '\') }
        }
    }
    $null
}
# Plain words for a moved folder, with what to do.
function Get-MovedMessage([string]$Root, [string]$From) {
    "This folder was moved: it was installed in $From and is now in $Root. Please run Install.cmd once in this folder. It keeps your characters and bots, and puts the new place into the server settings, the shortcuts and the certificate the game checks. Then start the server again."
}
# The paths in config\my.ini and the server settings are written once, at install. A folder that was moved or renamed afterwards
# keeps the old paths: mysqld then exits at once (no data folder there, or its log cannot be opened) and nothing listens on the port.
# Puts this folder's paths back: a value under the folder the install was made in (Get-MovedFrom), or one that points nowhere,
# when this folder has the file. Other values are the player's own and stay. The old folder is kept in config\moved-from.txt.
function Repair-MovedFolder([string]$Root) {
    $ini = Join-Path $Root 'config\my.ini'
    if (-not (Test-Path $ini)) { return }
    $from = Get-MovedFrom $Root
    $moved = $false
    $fwd = ($Root -replace '\\', '/').TrimEnd('/')
    if ($fwd -match '[^\x20-\x7E]') {
        throw "MySQL cannot use this folder because its path has letters other than English ones: $Root. Move the whole WoW Forever Bots folder to a simple path such as C:\WoWForeverBots and start again. Your characters and bots move with it."
    }
    $want = @{ 'basedir' = "$fwd/mysql"; 'datadir' = "$fwd/mysql-data"; 'log_error' = "$fwd/mysql-data/mysql-error.log" }
    $lines = @(Get-Content $ini); $changed = $false
    $out = foreach ($l in $lines) {
        if ($l -match '^\s*(basedir|datadir|log[-_]error)\s*=\s*(.*?)\s*$') {
            $v = $want[$Matches[1] -replace '-', '_']
            if ($Matches[2].Trim('"') -ne $v) { $changed = $true; "$($Matches[1])=$v" } else { $l }
        } else { $l }
    }
    if ($changed) { Set-Content $ini $out -Encoding ascii; Write-Host "The folder was moved: MySQL now uses $Root."; $moved = $true }
    $server = Join-Path $Root 'server'
    $paths = [ordered]@{
        'DataDir' = "$fwd/server/data"; 'SourceDirectory' = $fwd; 'MySQLExecutable' = "$fwd/mysql/bin/mysql.exe"
        'CertificatesFile' = "$fwd/certs/chain.pem"; 'PrivateKeyFile' = "$fwd/certs/server.key"
    }
    foreach ($c in 'worldserver.conf', 'bnetserver.conf') {
        $cf = Join-Path $server $c
        if (-not (Test-Path $cf)) { continue }
        $lines = @(Get-Content $cf); $changed = $false
        $out = foreach ($l in $lines) {
            if ($l -match '^\s*(DataDir|SourceDirectory|MySQLExecutable|CertificatesFile|PrivateKeyFile)\s*=\s*"?(.*?)"?\s*$' -and $Matches[2] -and
                -not (Get-SamePath $Matches[2] $paths[$Matches[1]]) -and (Test-Path $paths[$Matches[1]]) -and
                (-not (Test-Path $Matches[2]) -or ($from -and (Test-PathUnder $Matches[2] $from)))) {
                $changed = $true; "$($Matches[1]) = `"$($paths[$Matches[1]])`""
            } else { $l }
        }
        if ($changed) { Set-Content $cf $out -Encoding ascii; $moved = $true }
    }
    if ($moved -and $from) {
        $mark = Join-Path $Root 'config\moved-from.txt'
        if (-not (Test-Path -LiteralPath $mark)) { Set-Content -LiteralPath $mark $from -Encoding utf8 }
    }
}
# Windows can reserve port ranges for Hyper-V, WSL or Docker (netsh interface ipv4 show excludedportrange). The reserved ranges can
# change after a restart or a Windows update, so a port that worked yesterday can be refused today: mysqld then cannot listen and
# exits. Returns the reserved ranges as @(start, end) pairs, empty when they cannot be read.
function Get-ExcludedPortRanges {
    $r = @()
    try {
        foreach ($l in @(& netsh.exe interface ipv4 show excludedportrange protocol=tcp 2>$null)) {
            if ($l -match '^\s*(\d+)\s+(\d+)') { $r += , @([int]$Matches[1], [int]$Matches[2]) }
        }
    } catch { }
    , $r
}
function Test-PortUsable([int]$Port, $Ranges) {
    foreach ($x in $Ranges) { if ($Port -ge $x[0] -and $Port -le $x[1]) { return $false } }
    -not (Test-MySqlPort $Port)
}
# Moves our MySQL to another port: my.ini (server and client part) and the database lines of the server settings.
function Set-OurMySqlPort([string]$Root, [int]$Old, [int]$New) {
    $ini = Join-Path $Root 'config\my.ini'
    (Get-Content $ini) -replace '^\s*port\s*=\s*\d+\s*$', "port=$New" | Set-Content $ini -Encoding ascii
    $confs = @(Get-ChildItem (Join-Path $Root 'server') -Filter '*.conf' -File -ErrorAction SilentlyContinue) +
             @(Get-ChildItem (Join-Path $Root 'server\worldserver.conf.d') -Filter '*.conf' -File -ErrorAction SilentlyContinue)
    foreach ($f in $confs) {
        $t = @(Get-Content $f.FullName)
        $n = $t -replace "^(\s*\w*DatabaseInfo\s*=\s*`"?[^;]*);$Old;", "`${1};$New;"
        if (($n -join "`n") -ne ($t -join "`n")) { Set-Content $f.FullName $n -Encoding ascii }
    }
    Write-Host "Port $Old cannot be used on this PC (Windows keeps it for something else), so the database now uses port $New."
}
# The login server (1119, 8081) and the world server (8085) cannot move to other ports like MySQL can: the game asks for them.
# Before a server starts, its ports are checked: one Windows keeps for itself (same ranges as above) or one another program
# listens on stops the start with the reason, instead of a server window that closes or a login that never answers.
function Test-GamePorts([string]$Root) {
    $ranges = Get-ExcludedPortRanges
    $want = @()
    if (-not (Get-Process bnetserver -ErrorAction SilentlyContinue)) { $want += 1119, 8081 }
    if (-not (Get-Process worldserver -ErrorAction SilentlyContinue)) { $want += 8085 }
    foreach ($p in $want) {
        foreach ($x in $ranges) {
            if ($p -ge $x[0] -and $p -le $x[1]) {
                throw "Windows keeps port $p for itself right now (Hyper-V, WSL or Docker reserve ports, and that can change after a restart or a Windows update), so the server cannot use it. Fix: right-click Start, open Terminal (Admin) and run: net stop winnat   then   net start winnat. Then start again."
            }
        }
        $owner = Get-PortOwnerPath $p
        if ($owner) {
            $name = [IO.Path]::GetFileName($owner)
            if ($name -ieq 'WoWForeverLauncher.exe') { throw "Port $p is used by the WoW Forever launcher: it is still connected to a friend's server. Pick your own server in the launcher (or close and open the launcher again), then start again." }
            throw "Port $p is already used by another program: $name ($owner). The server needs that port. Close that program (Task Manager, Details tab) or stop it from starting with Windows, then start again."
        }
    }
}
function Move-OurMySqlPort([string]$Root, [int]$Port) {
    $ranges = Get-ExcludedPortRanges
    foreach ($p in (3308..3399) + (13307..13399) + (23307..23399)) {
        if (Test-PortUsable $p $ranges) { Set-OurMySqlPort $Root $Port $p; return $p }
    }
    throw "No free port found for the database between 3308 and 23399."
}
# mysqld.exe and the servers need the Microsoft Visual C++ 2015-2022 runtime (x64). A PC without it cannot even load mysqld: it ends
# at once with exit code 0xC0000135 and prints nothing, so the install only said "mysql initialize failed".
$script:VcRuntimeExitCodes = @(-1073741515, -1073741701)   # 0xC0000135 a DLL is missing, 0xC000007B a DLL of the wrong kind
function Test-VcRuntime([string]$Root) {
    $dirs = @((Join-Path $env:SystemRoot 'System32'), (Join-Path $Root 'mysql\bin'))   # installed for all programs, or shipped next to mysqld
    foreach ($d in 'vcruntime140.dll', 'vcruntime140_1.dll', 'msvcp140.dll') {
        if (-not @($dirs | Where-Object { Test-Path (Join-Path $_ $d) }).Count) { return $false }
    }
    $true
}
# Downloads Microsoft's own installer and runs it without questions. Needs administrator rights (Install.cmd has them).
function Install-VcRuntime([string]$Root) {
    $url = 'https://aka.ms/vs/17/release/vc_redist.x64.exe'
    Write-Host 'This PC lacks the Microsoft Visual C++ runtime that MySQL and the server need. Installing it from Microsoft (about 25 MB)...'
    $exe = Join-Path $env:TEMP 'vc_redist.x64.exe'
    try {
        try { [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 } catch { }
        (New-Object Net.WebClient).DownloadFile($url, $exe)
        $sig = Get-AuthenticodeSignature $exe
        if ($sig.Status -ne 'Valid' -or $sig.SignerCertificate.Subject -notmatch 'O=Microsoft Corporation') { throw 'the downloaded file is not signed by Microsoft' }
        $code = (Start-Process $exe -ArgumentList '/install', '/quiet', '/norestart' -Wait -PassThru).ExitCode
        if ($code -notin 0, 1638, 3010) { throw "its installer ended with code $code" }   # 1638: a newer one is already there, 3010: restart wanted
    } catch {
        throw "The Microsoft Visual C++ runtime is missing and could not be installed ($($_.Exception.Message)). Install it yourself from $url (run the file, press Install), then run Install.cmd again."
    } finally { Remove-Item $exe -ErrorAction SilentlyContinue }
    if (-not (Test-VcRuntime $Root)) { throw "The Microsoft Visual C++ runtime still seems to be missing. Restart the PC; if it still fails, install it yourself from $url, then run Install.cmd again." }
    Write-Host 'Visual C++ runtime installed.'
}
# The reason in lines MySQL wrote (its log, or what it printed), as one short text for the player.
# Kind is 'port', 'lock', 'damaged', 'disk', 'access', 'leftover', 'files' or '' when the text says nothing we know.
function Get-MySqlReason([string[]]$Lines) {
    $res = @{ Kind = ''; Line = ''; Log = '' }
    $errors = @($Lines | Where-Object { $_ -match '\[ERROR\]|Assertion failure' })
    $all = $errors -join "`n"
    if ($errors) { $res.Line = ($errors[-1] -replace '^.*?\[ERROR\]\s*(\[[^\]]*\]\s*)*', '').Trim() }
    if ($all -match 'Bind on TCP/IP port|already have another mysqld server running on port|10013|10048') {
        $res.Kind = 'port'; $res.Text = 'Windows did not let MySQL use its port.'
    } elseif ($all -match 'data directory has files in it|--initialize specified but the data directory') {
        $res.Kind = 'leftover'; $res.Text = 'The mysql-data folder has files from an earlier try that did not finish.'
    } elseif ($all -match 'Unable to lock .*ibdata1|lock.*\./ibdata1|another mysqld .*same data directory') {
        $res.Kind = 'lock'; $res.Text = 'Another MySQL from this folder is still running and holds the database files. Restart the PC and start again.'
    } elseif ($all -match 'Errcode: 28|No space left|OS error code 112|disk is full') {
        $res.Kind = 'disk'; $res.Text = 'The disk is full. Free a few GB and start again.'
    } elseif ($all -match 'OS error code 5|Errcode: 13|Permission denied|Access is denied|Operating system error number 5') {
        $res.Kind = 'access'; $res.Text = 'Windows or an antivirus program did not let MySQL open its files. Do not keep the folder in Program Files, OneDrive or another synced folder, allow the folder in your antivirus, and start again.'
    } elseif ($all -match 'corrupt|Assertion failure|Database page corruption|redo log|ib_logfile|Data Dictionary initialization failed|Upgrade after a crash is not supported|Plugin initialization aborted|Table .* is marked as crashed') {
        $res.Kind = 'damaged'; $res.Text = 'The database files are damaged, usually after the PC lost power or was switched off while the server ran. Do not delete anything: double-click Bug-Report.cmd in the main folder and send us the zip so we can help you get your characters back.'
    } elseif ($res.Line) {
        $res.Text = 'MySQL could not start.'
    } else {
        $res.Text = 'MySQL stopped without saying why.'
    }
    $res
}
# The reason in MySQL's own log (mysql-data\mysql-error.log, or a *.err file an older my.ini wrote).
function Get-MySqlFailure([string]$Root, [datetime]$Since) {
    $logs = @(Get-ChildItem (Join-Path $Root 'mysql-data') -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq 'mysql-error.log' -or $_.Extension -eq '.err' } |
              Sort-Object LastWriteTime -Descending)
    if (-not $logs) { $res = @{ Kind = ''; Line = ''; Log = '' }; $res.Text = "MySQL wrote no log in the mysql-data folder (the folder may be missing, or an antivirus program may have blocked or removed mysql\bin\mysqld.exe)."; $res.Kind = 'files'; return $res }
    $log = $logs[0]
    $tail = @()
    try { $tail = @(Get-Content $log.FullName -Tail 80 -ErrorAction Stop) } catch { }
    if ($log.LastWriteTime -lt $Since.AddSeconds(-5)) { $tail = @() }   # an old log says nothing about this start
    $res = Get-MySqlReason $tail
    $res.Log = $log.FullName
    $res
}
function Start-OurMySql([string]$Root, [int]$WaitSeconds = 90) {
    Repair-MovedFolder $Root
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
        # Windows did not say which program it is (a service, or one run as administrator): ask the database itself.
        if (-not $owner -and -not (Test-OurMySqlAnswers $Root)) {
            $who = Get-PortOwnerText $port
            if ($who -match '^the Windows service "(.+)"$') {
                throw "Port $port is used by another MySQL on this PC ($who), not the one in this folder. Stop it: press Win+R, type services.msc, press Enter, find $($Matches[1]), right-click it and choose Stop, then open it and set Startup type to Manual so it does not start with Windows again. Then start again."
            }
            if (-not $who) { $who = 'a program Windows does not name' }
            throw "Port $port is used by another MySQL on this PC ($who), not the one in this folder. It is usually another server pack, XAMPP, a MySQL install or an older WoW Forever Bots folder. Close it (Task Manager, Details tab: right-click mysqld.exe, Open file location shows which one), then start again."
        }
        return
    }
    $mysqld = Join-Path $Root 'mysql\bin\mysqld.exe'
    if (-not (Test-Path $mysqld)) { throw "mysql\bin\mysqld.exe is missing. An antivirus program may have removed it: allow the WoW Forever Bots folder in it, then run Install.cmd again (your characters are kept)." }
    if (-not (Get-OurMySqlProcess $Root) -and -not (Test-PortUsable $port (Get-ExcludedPortRanges))) { $port = Move-OurMySqlPort $Root $port }
    $since = Get-Date
    $moved = $false; $waitedForOld = $false
    while ($true) {
        # A mysqld of this folder that is already running (repairing its files after the PC was switched off, or still shutting
        # down) is waited for: a second one cannot open the same files, exits at once, and fills the log with lock errors.
        $p = Get-OurMySqlProcess $Root
        $mine = -not $p
        if ($mine) {
            'Starting MySQL...'
            $p = Start-Process $mysqld -ArgumentList "`"--defaults-file=$Root\config\my.ini`"" -WindowStyle Hidden -PassThru
            $null = $p.Handle   # keeps the exit code readable after it ends
        } else { 'MySQL is already starting, waiting for it...' }
        # Repairing the files can take much longer than a normal start on a slow disk, so keep waiting while the process is alive.
        $deadline = (Get-Date).AddSeconds($WaitSeconds); $hard = (Get-Date).AddMinutes(15); $said = Get-Date
        while ((Get-Date) -lt $hard) {
            if (Test-MySqlPort $port) { return }
            if ($p.HasExited) { break }
            if ((Get-Date) -gt $deadline -and ((Get-Date) - $said).TotalSeconds -ge 30) { 'MySQL is still starting (after the PC was switched off it first repairs its files, this can take some minutes)...'; $said = Get-Date }
            Start-Sleep 1
        }
        # The one we waited for was shutting down: now start our own.
        if ($p.HasExited -and -not $mine -and -not $waitedForOld) { $waitedForOld = $true; $since = Get-Date; continue }
        $f = Get-MySqlFailure $Root $since
        if ($mine -and $p.HasExited -and ($p.ExitCode -in $script:VcRuntimeExitCodes)) {
            $f = @{ Kind = 'runtime'; Line = ''; Log = ''; Text = 'mysqld.exe could not run: a part of the Microsoft Visual C++ runtime (x64) is missing or damaged. Install it from https://aka.ms/vs/17/release/vc_redist.x64.exe (run the file, choose Repair or Install), restart the PC and start again.' }
        }
        # A port Windows refused: move to a free one once and try again.
        if ($p.HasExited -and $f.Kind -eq 'port' -and -not $moved) { $port = Move-OurMySqlPort $Root $port; $moved = $true; $since = Get-Date; continue }
        break
    }
    $msg = "MySQL did not start on port $port. $($f.Text)"
    if ($f.Line) { $msg += " MySQL said: $($f.Line)" }
    if ($f.Log) { $msg += " (full text in $($f.Log))" }
    throw $msg
}
