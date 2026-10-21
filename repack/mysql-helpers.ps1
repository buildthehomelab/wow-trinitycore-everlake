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
function Start-OurMySql([string]$Root, [int]$WaitSeconds = 90) {
    $port = Get-OurMySqlPort $Root
    if (Test-MySqlPort $port) { return }
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
