# Lets other people join this server over the internet (or a LAN / VPN): the login and world servers listen on every network
# card instead of only this PC, the realm list hands out this PC's address, and Windows Firewall lets the three game ports in
# (TCP 1119 login, 8081 login web page, 8085 world). MySQL stays on this PC only. Started by Host-For-Others.cmd.
#   .\HostForOthers.ps1        -> asks: turns hosting on (asks for the address, restarts the server), or off when it is on
#   .\HostForOthers.ps1 -On [-Address auto|<ip or name>] [-Vpn <ip>] [-NoFirewall] [-NoRestart]   -> no questions (the launcher)
#   -Vpn: this PC's address in a shared network (Radmin VPN, ZeroTier) as well: players in that network get it, the others get -Address.
#   .\HostForOthers.ps1 -Off [-NoFirewall] [-NoRestart]                               -> undo everything it changed, no questions
# -On and -Off end with HOST_STATE= / HOST_PUBLIC= / HOST_LAN= / HOST_MASK= / HOST_CAFP= lines (fingerprint: SHA-256 of
# certs\ca.pem, hex). -NoFirewall: the caller adds or removes the rule itself. -NoRestart: the caller restarts the server.
# Start-WoWForever.ps1 dot-sources this file and calls Sync-HostForOthers on every start while hosting is on: an update or a new
# RAM preset rewrites the server settings, and a home internet address can change from day to day.
# Windows PowerShell 5.1. Saved as UTF-8 with BOM (the Russian text needs it). Administrator rights only for the firewall rule
# (one Windows prompt): the server itself must keep running as the normal user, or the launcher could not stop it.
param([switch]$On, [switch]$Off, [string]$Address, [string]$Vpn, [switch]$NoFirewall, [switch]$NoRestart, [string]$AllowBuild, [string]$DisallowBuild)

$script:HostRule = 'WoW Forever Bots (friends)'   # the launcher's Host switch uses the same name, so either side can undo it
$script:HostPorts = @(1119, 8081, 8085)

function Get-HostLang([string]$Root) {
    $f = Join-Path $Root 'config\launcher-settings.txt'
    $m = if (Test-Path $f) { Select-String -Path $f -Pattern '^lang=(\w+)' | Select-Object -First 1 }
    if ($m) { return $m.Matches[0].Groups[1].Value }
    if ((Get-Culture).Name -like 'ru*') { 'ru' } else { 'en' }
}
function T([string]$En, [string]$Ru) { if ($script:HostLangRu) { $Ru } else { $En } }

function Get-HostStateFile([string]$Root) { Join-Path $Root 'config\friends.txt' }
# 'auto' (the internet address is looked up at every start) or the address the host typed; $null when hosting is off.
function Get-HostAddressSetting([string]$Root) {
    # Select-String on a missing file stops a script running with ErrorActionPreference Stop, -ErrorAction SilentlyContinue or not
    $f = Get-HostStateFile $Root
    $m = if (Test-Path $f) { Select-String -Path $f -Pattern '^address=(.+)$' | Select-Object -First 1 }
    if ($m) { $m.Matches[0].Groups[1].Value.Trim() } else { $null }
}
# this PC's address in a shared network (Radmin VPN, ZeroTier) handed out besides the main address, or $null
function Get-HostVpnSetting([string]$Root) {
    $f = Get-HostStateFile $Root
    $m = if (Test-Path $f) { Select-String -Path $f -Pattern '^vpn=(.+)$' | Select-Object -First 1 }
    if ($m -and (Test-Ipv4 $m.Matches[0].Groups[1].Value.Trim())) { $m.Matches[0].Groups[1].Value.Trim() } else { $null }
}
function Test-HostAddress([string]$A) { $A -match '^[A-Za-z0-9]([A-Za-z0-9.-]{0,251}[A-Za-z0-9])?$' }
function Test-Ipv4([string]$A) {
    $ip = $null
    ($A -match '^\d{1,3}(\.\d{1,3}){3}$') -and [Net.IPAddress]::TryParse($A, [ref]$ip)
}

# This PC's address in the home network: the network card that has a router (default gateway), with its subnet mask.
# A VPN (or another virtual card) that is on also has a default gateway and often comes first; the realm then handed out the
# VPN's address and logins broke as soon as the VPN was turned off. Real network cards (Ethernet, Wi-Fi) win; a virtual one is
# used only when it is the only card with a router (Radmin VPN / ZeroTier setups type their own address anyway).
function Get-HostLan {
    # Among the cards that qualify, the one Windows itself sends internet traffic through wins (lowest route + interface metric),
    # not just the first one listed: a PC with two network cards handed out the wrong home address (assistof, 2026-11-07, whose
    # own fix this follows). Addresses 127.x, 169.254.x and 0.x are skipped.
    try {
        $cards = @(Get-NetIPConfiguration -ErrorAction Stop | Where-Object { $_.IPv4DefaultGateway -and $_.NetAdapter.Status -eq 'Up' })
        $real = @($cards | Where-Object { $_.NetAdapter.HardwareInterface -and -not $_.NetAdapter.Virtual })
        $pool = if ($real.Count) { $real } else { $cards }
        $routes = @(Get-NetRoute -AddressFamily IPv4 -DestinationPrefix '0.0.0.0/0' -ErrorAction SilentlyContinue)
        $ifs = @(Get-NetIPInterface -AddressFamily IPv4 -ErrorAction SilentlyContinue)
        $best = $null; $bestMetric = [long]::MaxValue
        foreach ($c in $pool) {
            $a = @($c.IPv4Address | Where-Object { $_.IPAddress -and $_.IPAddress -notmatch '^(127\.|169\.254\.|0\.)' }) | Select-Object -First 1
            if (-not $a) { continue }
            $idx = $c.InterfaceIndex
            $r = @($routes | Where-Object { $_.InterfaceIndex -eq $idx } | Sort-Object RouteMetric) | Select-Object -First 1
            $i = @($ifs | Where-Object { $_.InterfaceIndex -eq $idx }) | Select-Object -First 1
            $m = [long]$(if ($r) { $r.RouteMetric } else { 100000 }) + [long]$(if ($i) { $i.InterfaceMetric } else { 100000 })
            if ($m -lt $bestMetric) { $best = $a; $bestMetric = $m }
        }
        if (-not $best) { return $null }
        $bits = ('1' * $best.PrefixLength).PadRight(32, '0')
        $mask = (0..3 | ForEach-Object { [Convert]::ToInt32($bits.Substring($_ * 8, 8), 2) }) -join '.'
        @{ Ip = $best.IPAddress; Mask = $mask }
    } catch { $null }
}
# The internet address the router has, as seen from outside; $null when no service answers.
function Get-HostPublicIp {
    try { [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 } catch { }
    foreach ($u in 'https://api.ipify.org', 'https://checkip.amazonaws.com') {
        try {
            $r = ([string](Invoke-RestMethod $u -TimeoutSec 8 -UseBasicParsing)).Trim()
            if (Test-Ipv4 $r) { return $r }
        } catch { }
    }
    $null
}

function Set-HostConfLine([string]$File, [string]$Key, [string]$Value) {
    if (-not (Test-Path $File)) { return }
    $lines = @(Get-Content $File)
    $hit = $false
    $out = foreach ($l in $lines) { if ($l -match ('^\s*' + [regex]::Escape($Key) + '\s*=')) { $hit = $true; "$Key = $Value" } else { $l } }
    if (-not $hit) { $out = @($lines) + "$Key = $Value" }
    if (($out -join "`n") -ne ($lines -join "`n")) { Set-Content $File $out -Encoding ascii }
}
# BindIP of the login and the world server. zz-9-local.conf (the player's own settings, read last) is changed only when it already
# has a BindIP line, since that line would win over worldserver.conf.
function Set-HostBindIp([string]$Root, [string]$Ip) {
    $server = Join-Path $Root 'server'
    foreach ($c in 'bnetserver.conf', 'worldserver.conf') { Set-HostConfLine (Join-Path $server $c) 'BindIP' "`"$Ip`"" }
    $local = Join-Path $server 'worldserver.conf.d\zz-9-local.conf'
    if ((Test-Path $local) -and (Select-String -Path $local -Pattern '^\s*BindIP\s*=' -Quiet)) { Set-HostConfLine $local 'BindIP' "`"$Ip`"" }
    # The login page address bnetserver hands to each player (LoginRESTService::GetHostnameForClient). It must be the portal name:
    # a friend's launcher points trinity.actual.battle.net at this PC, and the certificate is only valid for that name. A
    # bnetserver.conf made from the plain .dist (127.0.0.1) would send every friend to their own PC and their login would fail.
    $bnet = Join-Path $server 'bnetserver.conf'
    foreach ($k in 'LoginREST.ExternalAddress', 'LoginREST.LocalAddress') { Set-HostConfLine $bnet $k 'trinity.actual.battle.net' }
}
# $true while the login server listens for other PCs: also after an On that stopped before it wrote the state file
function Test-HostBound([string]$Root) {
    $f = Join-Path $Root 'server\bnetserver.conf'
    (Test-Path $f) -and [bool](Select-String -Path $f -Pattern '^\s*BindIP\s*=\s*"?0\.0\.0\.0' -Quiet)
}
# The address the realm list gives the game: players in this PC's home network (and this PC itself) get localAddress, players in
# a shared network (Radmin VPN, ZeroTier) get address3 when it is set, everyone else gets address. MySQL must be running.
function Set-HostRealm([string]$Root, [string]$Address, [string]$Local, [string]$Mask, [string]$Vpn) {
    $third = if ($Vpn -and (Test-Ipv4 $Vpn)) { "'$Vpn'" } else { 'NULL' }
    $sql = "UPDATE realmlist SET address='$Address', localAddress='$Local', localSubnetMask='$Mask', address3=$third WHERE id=70; SELECT COUNT(*) FROM realmlist WHERE id=70"
    $r = Invoke-HostNative (Join-Path $Root 'mysql\bin\mysql.exe') @("--defaults-file=$Root\config\my.ini", '-u', 'root', '-N', '-B', 'auth', '-e', $sql)
    if ($r.Code) { throw "MySQL (realmlist): $($r.Text)" }
    if (-not @($r.Lines | Where-Object { $_.Trim() -eq '1' })) { throw 'realmlist has no realm 70 (Trinity).' }
}
# A program's exit code and everything it printed. Under ErrorActionPreference Stop, Windows PowerShell turns a program's first
# line on stderr (even a MySQL warning) into a terminating error before the exit code can be read, so the call runs with Continue.
function Invoke-HostNative([string]$Exe, [string[]]$Arguments) {
    $eap = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
    try {
        $lines = @(& $Exe @Arguments 2>&1 | ForEach-Object { "$_" })
        @{ Code = $LASTEXITCODE; Lines = $lines; Text = (($lines | Where-Object { $_ -notmatch '\[Warning\]' }) -join ' ').Trim() }
    } catch { @{ Code = -1; Lines = @(); Text = $_.Exception.Message } }
    finally { $ErrorActionPreference = $eap }
}
# Start-WoWForever.ps1 and Stop-WoWForever.ps1 are written for the default Continue (they call mysqladmin and the servers).
function Invoke-HostScript([string]$Name) {
    $eap = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
    try { & (Join-Path $PSScriptRoot $Name) } finally { $ErrorActionPreference = $eap }
}

# The firewall rule, made in a separate administrator PowerShell (one Windows prompt). Also removes the inbound BLOCK rules Windows
# adds for worldserver.exe / bnetserver.exe when someone pressed Cancel on its "allow access" question once: a block rule wins
# over any allow rule. Returns $true when the rule is there (or gone, for -Remove) afterwards.
function Set-HostFirewall([string]$Root, [switch]$Remove) {
    $exes = @('worldserver.exe', 'bnetserver.exe' | ForEach-Object { Join-Path (Join-Path $Root 'server') $_ })
    $cmd = "Get-NetFirewallRule -DisplayName '$script:HostRule' -ErrorAction SilentlyContinue | Remove-NetFirewallRule`n"
    if (-not $Remove) {
        $cmd += "New-NetFirewallRule -DisplayName '$script:HostRule' -Direction Inbound -Action Allow -Protocol TCP -LocalPort $($script:HostPorts -join ',') -Profile Any | Out-Null`n"
        foreach ($e in $exes) {
            $e = $e.Replace("'", "''")
            $cmd += "Get-NetFirewallApplicationFilter -Program '$e' -ErrorAction SilentlyContinue | Get-NetFirewallRule | Where-Object { `$_.Direction -eq 'Inbound' -and `$_.Action -eq 'Block' } | Remove-NetFirewallRule`n"
        }
    }
    $enc = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($cmd))
    try { Start-Process powershell.exe -Verb RunAs -Wait -WindowStyle Hidden -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-EncodedCommand', $enc }
    catch { return $false }   # the Windows prompt was answered No
    $there = [bool](Get-NetFirewallRule -DisplayName $script:HostRule -ErrorAction SilentlyContinue)
    if ($Remove) { -not $there } else { $there }
}

# Puts the hosting settings back after an update or a RAM preset rewrote the server settings, and refreshes the internet address
# when it is looked up automatically. Called by Start-WoWForever.ps1 while MySQL runs and before the servers start; does nothing
# while hosting is off. Never stops a start.
function Sync-HostForOthers([string]$Root) {
    $setting = Get-HostAddressSetting $Root
    if (-not $setting) { return }
    try {
        Set-HostBindIp $Root '0.0.0.0'
        $lan = Get-HostLan
        if (-not $lan) { Write-Warning 'Hosting for others: no network card with a router found, the realm address was not changed.'; return }
        $address = $setting
        if ($setting -eq 'auto') {
            $address = Get-HostPublicIp
            if (-not $address) { Write-Warning 'Hosting for others: could not look up your internet address, the realm keeps the last one.'; return }
        }
        $vpn = Get-HostVpnSetting $Root
        Set-HostRealm $Root $address $lan.Ip $lan.Mask $vpn
        "Hosting for others is on: players join at $address (in your home network: $($lan.Ip)). Host-For-Others.cmd turns it off."
    } catch { Write-Warning "Hosting for others: $($_.Exception.Message)" }
}

function Get-HostCaFingerprint([string]$Root) {
    try {
        $c = New-Object Security.Cryptography.X509Certificates.X509Certificate2 (Join-Path $Root 'certs\ca.pem')
        $h = [Security.Cryptography.SHA256]::Create().ComputeHash($c.RawData)
        ($h | ForEach-Object { $_.ToString('X2') }) -join ':'
    } catch { $null }
}
function Test-HostPort([string]$Ip, [int]$Port) {
    try {
        $c = New-Object Net.Sockets.TcpClient
        $ok = $c.BeginConnect($Ip, $Port, $null, $null).AsyncWaitHandle.WaitOne(1500) -and $c.Connected
        $c.Close(); [bool]$ok
    } catch { $false }
}

if ($MyInvocation.InvocationName -eq '.') { return }   # dot-sourced by Start-WoWForever.ps1: functions only

# --- on / off ----------------------------------------------------------------------------------------------------------------------
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$script:HostLangRu = (Get-HostLang $root) -eq 'ru'
try { [Console]::OutputEncoding = [Text.Encoding]::UTF8 } catch { }
. "$PSScriptRoot\mysql-helpers.ps1"
function Say([string]$En, [string]$Ru, [string]$Color = 'White') { Write-Host ('  ' + (T $En $Ru)) -ForegroundColor $Color }
function Ask([string]$En, [string]$Ru) { Write-Host ('  ' + (T $En $Ru) + ' ') -NoNewline -ForegroundColor Yellow; Read-Host }
function Test-Yes([string]$A) { $A.Trim() -match '^(y|yes|д|да)$' }
function ServerUp { [bool](Get-Process worldserver, bnetserver -ErrorAction SilentlyContinue) }
$interactive = -not ($On -or $Off)
$state = Get-HostStateFile $root
$wasUp = ServerUp
$restart = $wasUp -and -not $NoRestart
# -AllowBuild N (or 1.60.1.N): friends whose Battle.net already patched the game to a build this release does not know yet may join,
# at their own risk (the launcher's Host for friends, New game build, does the same). -DisallowBuild N takes it back.
if ($AllowBuild -or $DisallowBuild) {
    . "$PSScriptRoot\ClientBuild.ps1"
    if ($DisallowBuild) {
        Remove-UntestedBuild $root ([int]($DisallowBuild -replace '^.*\.', ''))
        Say "Build $DisallowBuild is no longer let in after the server restarts." "Версия $DisallowBuild больше не будет пускаться после перезапуска сервера." 'Green'
    } else {
        $full = if ($AllowBuild -match '^\d+$') { "$(Get-RealmVersion $root).$AllowBuild" } else { $AllowBuild }
        Say "Build $full is untested with this repack: players on it play AT THEIR OWN RISK (crashes, disconnects, visual bugs, odd game data). Ask them to report problems in #bug-report on our Discord." "Версия $full не проверена с этой сборкой: игроки на ней играют НА СВОЙ СТРАХ И РИСК (вылеты, отключения, графические ошибки, странные игровые данные). Попросите их сообщать о проблемах в #bug-report в нашем Discord." 'Yellow'
        $why = Add-UntestedBuild $root $full
        if ($why) { throw $why }
        Say "Build $full is let in after the server restarts." "Версия $full будет пускаться после перезапуска сервера." 'Green'
    }
    if ($restart) {
        Say 'Restarting the server...' 'Перезапускаю сервер...'
        Invoke-HostScript 'Stop-WoWForever.ps1' | Out-Null
        Invoke-HostScript 'Start-WoWForever.ps1'
    }
    return
}
$lan = Get-HostLan
$fp = Get-HostCaFingerprint $root
# for the launcher (and anyone reading the output): one line each, last
function Write-HostResult([string]$Now, [string]$Public) {
    "HOST_STATE=$Now"
    "HOST_PUBLIC=$Public"
    "HOST_LAN=$(if ($lan) { $lan.Ip })"
    "HOST_MASK=$(if ($lan) { $lan.Mask })"
    "HOST_CAFP=$(if ($fp) { $fp -replace ':', '' })"
}

if ($interactive) {
    Write-Host ''
    Say 'WoW Forever Bots - host for others' 'WoW Forever Bots - сервер для других игроков' 'Yellow'
    Write-Host ''
}
if ($Off -or ($interactive -and ((Get-HostAddressSetting $root) -or (Test-HostBound $root)))) {
    if ($interactive) {
        $setting = Get-HostAddressSetting $root
        if ($setting) { Say "Hosting for others is ON (address: $setting)." "Сервер открыт для других игроков (адрес: $setting)." 'Green' }
        else { Say 'Hosting for others is partly on (an earlier try stopped half way).' 'Доступ для других игроков включён частично (прошлая попытка остановилась на полпути).' 'Yellow' }
        if (-not (Test-Yes (Ask 'Turn it off, so only this PC can play again? (Y/N)' 'Закрыть его, чтобы играть снова мог только этот ПК? (Д/Н)'))) { return }
    }
    # Every step runs even when an earlier one failed (Off also cleans up after an On that stopped half way); the failures are
    # listed at the end.
    $problems = @()
    function Step([string]$What, [scriptblock]$Do) { try { & $Do } catch { $script:problems += "${What}: $($_.Exception.Message)" } }
    if ($restart) { Say 'Stopping the server...' 'Останавливаю сервер...'; Step 'stop' { Invoke-HostScript 'Stop-WoWForever.ps1' | Out-Null } }
    Step 'state' { if (Test-Path $state) { Remove-Item $state } }
    Step 'BindIP' { Set-HostBindIp $root '127.0.0.1' }
    $dbWasUp = Test-MySqlPort (Get-OurMySqlPort $root)
    Step 'realmlist' { Start-OurMySql $root | Out-Null; Set-HostRealm $root '127.0.0.1' '127.0.0.1' '255.255.255.0' }
    if (-not $NoFirewall) {
        Say 'Removing the firewall rule (Windows asks for permission)...' 'Удаляю правило брандмауэра (Windows попросит разрешение)...'
        if (-not (Set-HostFirewall $root -Remove)) {
            $problems += 'firewall'
            Say "The firewall rule '$script:HostRule' could not be removed. Remove it yourself: Start > Windows Defender Firewall with Advanced Security > Inbound Rules." "Правило брандмауэра '$script:HostRule' удалить не удалось. Удалите его сами: Пуск > Монитор брандмауэра Защитника Windows > Правила для входящих подключений." 'Yellow'
        }
    }
    if ($restart) { Step 'start' { Invoke-HostScript 'Start-WoWForever.ps1' } }
    elseif (-not $dbWasUp -and (Test-MySqlPort (Get-OurMySqlPort $root))) {   # leave MySQL as it was
        Step 'MySQL stop' { $null = Invoke-HostNative "$root\mysql\bin\mysqladmin.exe" @("--defaults-file=$root\config\my.ini", '-u', 'root', 'shutdown') }
    }
    Write-Host ''
    if ($problems) {
        foreach ($p in $problems) { Write-Host "  $p" -ForegroundColor Red }
        Say 'Hosting is off, but the steps above failed. Run this again to retry them.' 'Доступ закрыт, но шаги выше не удались. Запустите снова, чтобы повторить их.' 'Yellow'
    } else {
        Say 'Done: only this PC can play on the server again. You can also switch off the port forwarding in your router.' 'Готово: на сервере снова может играть только этот ПК. Перенаправление портов в роутере тоже можно отключить.' 'Green'
    }
    if (-not $interactive) { "HOST_PROBLEMS=$($problems -join '; ')"; Write-HostResult 'off' '' }
    return
}

# --- turn on ---------------------------------------------------------------------------------------------------------------------
if (-not $lan) { throw (T 'No network card with a router was found. Connect this PC to your network and try again.' 'Не найдена сетевая карта с роутером. Подключите ПК к сети и попробуйте снова.') }
if ($Address -and $Address -ne 'auto' -and -not (Test-HostAddress $Address)) { throw "Not an address: $Address" }
if ($Vpn -and -not (Test-Ipv4 $Vpn)) { throw "Not an address: $Vpn" }
$public = $null
if ($interactive -or -not $Address -or $Address -eq 'auto') {
    Say 'Looking up your internet address...' 'Определяю ваш интернет-адрес...'
    $public = Get-HostPublicIp
}
if ($interactive) {
    Say 'This lets other people play on your server: their game connects to this PC.' 'Так другие игроки смогут играть на вашем сервере: их игра подключается к этому ПК.'
    Say 'Only do this for people you trust. Your database stays closed to the outside.' 'Делайте это только для тех, кому доверяете. База данных остаётся закрытой снаружи.'
    Write-Host ''
    Say "Address in your home network: $($lan.Ip)" "Адрес в домашней сети: $($lan.Ip)" 'Cyan'
    if ($public) { Say "Address on the internet:      $public" "Адрес в интернете:      $public" 'Cyan' }
    else { Say 'Address on the internet: could not be looked up (no internet, or a blocker).' 'Адрес в интернете: определить не удалось (нет интернета или блокировка).' 'Yellow' }
    Write-Host ''
    Say 'Which address should players use?' 'Какой адрес будут использовать игроки?'
    if ($public) { Say "  Enter            = $public (looked up again at every server start, so it follows a changing address)" "  Enter            = $public (проверяется при каждом запуске сервера, так что меняющийся адрес не страшен)" }
    Say "  L                = $($lan.Ip) (only players in your home network)" "  L                = $($lan.Ip) (только игроки в вашей домашней сети)"
    Say '  or type another  = a name from a dynamic DNS service (No-IP, DuckDNS), or this PC''s IP in Radmin VPN / ZeroTier / Hamachi' '  или введите свой = имя от сервиса динамического DNS (No-IP, DuckDNS) или IP этого ПК в Radmin VPN / ZeroTier / Hamachi'
    while (-not $Address) {
        $a = (Ask 'Address:' 'Адрес:').Trim()
        if (-not $a -and $public) { $Address = 'auto' }
        elseif ($a -match '^[lLлЛ]$') { $Address = $lan.Ip }
        elseif ($a -and (Test-HostAddress $a)) { $Address = $a }
        else { Say 'Type an IP address (like 203.0.113.7) or a name (like myserver.duckdns.org).' 'Введите IP-адрес (например 203.0.113.7) или имя (например myserver.duckdns.org).' 'Yellow' }
    }
    if ($restart -and -not (Test-Yes (Ask 'The server restarts now (characters are saved). Continue? (Y/N)' 'Сейчас сервер перезапустится (персонажи сохраняются). Продолжить? (Д/Н)'))) { return }
}
if (-not $Address) { $Address = 'auto' }
if ($Address -eq 'auto' -and -not $public) { throw (T 'Could not look up your internet address. Check the internet connection, or give the address yourself.' 'Не удалось определить интернет-адрес. Проверьте подключение к интернету или укажите адрес сами.') }
$shown = if ($Address -eq 'auto') { $public } else { $Address }

if (-not $NoFirewall) {
    Say 'Adding the firewall rule for TCP 1119, 8081 and 8085 (Windows asks for permission)...' 'Добавляю правило брандмауэра для TCP 1119, 8081 и 8085 (Windows попросит разрешение)...'
    if (-not (Set-HostFirewall $root)) {
        # nothing else is changed yet, so a refused prompt leaves hosting fully off
        if (-not $interactive) { throw (T 'The firewall rule was not added (Windows permission refused?). Nothing was changed.' 'Правило брандмауэра не добавлено (Windows не дал разрешение?). Ничего не изменено.') }
        Say 'The firewall rule was not added (permission refused?). Players will not get in until TCP 1119, 8081 and 8085 are allowed. Run this again to retry.' 'Правило брандмауэра не добавлено (отказано в разрешении?). Игроки не подключатся, пока TCP 1119, 8081 и 8085 не разрешены. Запустите снова, чтобы повторить.' 'Yellow'
    }
}
if ($restart) { Say 'Stopping the server...' 'Останавливаю сервер...'; Invoke-HostScript 'Stop-WoWForever.ps1' | Out-Null }
# BindIP first and the state file last: the state file is what says "on" (here, to the launcher and at every start), so it is
# only written once the settings are in place. The realm address is set by Sync-HostForOthers at the start.
Set-HostBindIp $root '0.0.0.0'
Set-Content $state (@("address=$Address") + @(if ($Vpn) { "vpn=$Vpn" })) -Encoding ascii
if ($restart -or ($interactive -and -not $wasUp)) {
    Say 'Starting the server (it sets the address and opens the ports)...' 'Запускаю сервер (он сам выставит адрес и откроет порты)...'
    Invoke-HostScript 'Start-WoWForever.ps1'
    $deadline = (Get-Date).AddSeconds(30)   # bnetserver starts last and needs a moment before it listens
    do { $bad = @($script:HostPorts | Where-Object { -not (Test-HostPort $lan.Ip $_) }); if ($bad) { Start-Sleep 2 } } while ($bad -and (Get-Date) -lt $deadline)
    Write-Host ''
    if ($bad) { Say "Ports not answering on $($lan.Ip): $($bad -join ', '). Look at the server windows for an error." "Порты не отвечают на $($lan.Ip): $($bad -join ', '). Посмотрите ошибки в окнах сервера." 'Red' }
    else { Say "The server answers on $($lan.Ip), ports 1119, 8081 and 8085." "Сервер отвечает на $($lan.Ip), порты 1119, 8081 и 8085." 'Green' }
}
if (-not $interactive) { Write-HostResult 'on' $shown; return }

$ca = Join-Path $root 'certs\ca.pem'
Write-Host ''
Say 'What to do now:' 'Что сделать дальше:' 'Yellow'
if ($Address -ne $lan.Ip) {
    Say "1. In your router, forward TCP ports 1119, 8081 and 8085 to $($lan.Ip) (look for 'Port forwarding' or 'Virtual server'). Not needed for a VPN address." "1. В роутере перенаправьте TCP-порты 1119, 8081 и 8085 на $($lan.Ip) (раздел 'Port forwarding' или 'Виртуальный сервер'). Для адреса VPN не нужно."
    Say '   If your provider shares one internet address between many homes (CGNAT), forwarding cannot work: use Radmin VPN or ZeroTier instead.' '   Если провайдер даёт один адрес на много квартир (CGNAT), перенаправление не сработает: используйте Radmin VPN или ZeroTier.'
}
Say "2. Give each player your address: $shown" "2. Дайте каждому игроку ваш адрес: $shown"
Say "3. And this file: $ca" "3. И этот файл: $ca"
Say '   Never send ca.key (same folder): it must stay private.' '   Никогда не отправляйте ca.key (та же папка): он должен оставаться только у вас.' 'Yellow'
if ($fp) { Say "   Its fingerprint (they can compare it): $fp" "   Его отпечаток (игроки могут сверить): $fp" }
Say '4. Create an account for each player: WoW-Forever-Bots.cmd, option A.' '4. Создайте каждому игроку учётную запись: WoW-Forever-Bots.cmd, пункт A.'
Say '5. Players follow repack\JOIN-A-FRIEND.md: install ca.pem once, then Add... in their launcher with your address.' '5. Игроки делают как в repack\JOIN-A-FRIEND.md: один раз устанавливают ca.pem, потом Add... в своём лаунчере с вашим адресом.'
Write-Host ''
Say 'To undo all of this, run Host-For-Others.cmd again.' 'Чтобы всё отменить, запустите Host-For-Others.cmd ещё раз.' 'Cyan'
if (Test-Path $ca) { Start-Process explorer.exe "/select,`"$ca`"" }
