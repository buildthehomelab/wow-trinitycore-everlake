# One-time setup (run as Administrator): own name-constrained CA + certificate for trinity.actual.battle.net,
# trusts the CA for this PC, adds the hosts entry. Keys stay on THIS PC; never share certs\ca.key.
# Remove everything again with Uninstall.cmd (repack\uninstall.ps1).
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$certs = Join-Path $root 'certs'
New-Item -ItemType Directory -Force $certs | Out-Null
# Use the openssl that ships with the package (tools\openssl). One found on the PATH (Git, other installs) may look for a
# config file that does not exist on this PC ("Can't open ...\SSL/openssl.cnf"), so every call below gets its own -config.
$openssl = Join-Path $root 'tools\openssl\openssl.exe'
if (-not (Test-Path $openssl)) { $openssl = (Get-Command openssl -ErrorAction SilentlyContinue).Source }
if (-not $openssl -or -not (Test-Path $openssl)) { throw 'openssl not found (the package should include tools\openssl).' }
Set-Location $certs
function Run-OpenSsl {
    param([string]$What, [string[]]$OpenSslArgs)
    $old = $ErrorActionPreference; $ErrorActionPreference = 'Continue'   # openssl writes its progress to stderr; that is not an error
    $out = & $openssl @OpenSslArgs 2>&1
    $ErrorActionPreference = $old
    if ($LASTEXITCODE -ne 0) {
        throw "Could not create the certificate ($What failed). openssl said: $(($out | Out-String).Trim())"
    }
}
# Every install makes its own CA. A friend's PC trusts its own CA and the host's, so each CA gets this PC's name and the date in
# its name (still starting "WoW Forever Local CA", which Uninstall looks for), and the server certificate names its CA by key
# (authorityKeyIdentifier): Windows then never mixes up two CAs with the same name when it checks a friend's server.
$caTag = (($env:COMPUTERNAME -replace '[^A-Za-z0-9-]', '') + ' ' + (Get-Date -Format 'yyyy-MM-dd')).Trim()
@"
[req]
distinguished_name=dn
x509_extensions=ca
prompt=no
[dn]
CN=WoW Forever Local CA $caTag
[ca]
basicConstraints=critical,CA:TRUE
keyUsage=critical,keyCertSign,cRLSign
subjectKeyIdentifier=hash
nameConstraints=critical,permitted;DNS:actual.battle.net
"@ | Set-Content ca.cnf -Encoding ascii
@"
[req]
distinguished_name=dn
prompt=no
[dn]
CN=trinity.actual.battle.net
"@ | Set-Content server.cnf -Encoding ascii
@"
subjectAltName=DNS:trinity.actual.battle.net
extendedKeyUsage=serverAuth
authorityKeyIdentifier=keyid:always
"@ | Set-Content leaf.ext -Encoding ascii
# done only when the finished chain exists; a half-finished earlier try is thrown away and made again
if (-not (Test-Path chain.pem)) {
    Remove-Item ca.key, ca.pem, ca.srl, server.key, server.csr, server.pem, chain.pem -ErrorAction SilentlyContinue
    Run-OpenSsl 'making the CA' @('req', '-x509', '-newkey', 'rsa:3072', '-nodes', '-keyout', 'ca.key', '-out', 'ca.pem', '-days', '825', '-config', 'ca.cnf')
    Run-OpenSsl 'making the server key' @('req', '-new', '-newkey', 'rsa:2048', '-nodes', '-keyout', 'server.key', '-out', 'server.csr', '-config', 'server.cnf')
    if (-not (Test-Path server.csr)) { throw 'Could not create the certificate: openssl did not write server.csr.' }
    Run-OpenSsl 'signing the server certificate' @('x509', '-req', '-in', 'server.csr', '-CA', 'ca.pem', '-CAkey', 'ca.key', '-CAcreateserial', '-out', 'server.pem', '-days', '825', '-extfile', 'leaf.ext')
    if (-not (Test-Path server.pem)) { throw 'Could not create the certificate: openssl did not write server.pem.' }
    Get-Content server.pem, ca.pem | Set-Content chain.pem
}
Import-Certificate -FilePath "$certs\ca.pem" -CertStoreLocation Cert:\LocalMachine\Root | Out-Null
$hosts = "$env:SystemRoot\System32\drivers\etc\hosts"
# An antivirus that guards the hosts file (Kaspersky, some others) refuses the write. That used to stop the whole install at
# this step (krabov0690, 2026-11-07): now it is tried a few times, and if it still fails the install goes on and says how to add
# the line by hand. Without the line the login server cannot start.
# Some PCs have no hosts file at all (a "cleaner" or tweak tool removed it, or a custom Windows build): reading it then stopped
# the install with "Cannot find path ...\hosts" (lev, 2026-11-08). A missing file is simply made, with Windows' own header.
$hasLine = $false
if (Test-Path -LiteralPath $hosts -PathType Leaf) {
    try { $hasLine = [bool](Select-String -LiteralPath $hosts -Pattern 'trinity.actual.battle.net' -SimpleMatch -Quiet -ErrorAction Stop) }
    catch { Write-Warning "Could not read the hosts file ($($_.Exception.Message)); trying to add the line anyway." }
} else {
    Write-Host "There is no hosts file on this PC ($hosts); making a new one."
    try {
        New-Item -ItemType Directory -Force (Split-Path $hosts -Parent) | Out-Null
        Set-Content -LiteralPath $hosts -Encoding ascii -ErrorAction Stop -Value @(
            '# Copyright (c) 1993-2009 Microsoft Corp.', '#',
            '# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.', '#',
            '# localhost name resolution is handled within DNS itself.',
            '#      127.0.0.1       localhost', '#      ::1             localhost')
    } catch { Write-Warning "Could not make the hosts file ($($_.Exception.Message))." }
}
if (-not $hasLine) {
    $hostsLine = "127.0.0.1 trinity.actual.battle.net # wow-forever-local"
    $written = $false; $why = ''
    for ($try = 1; $try -le 3 -and -not $written; $try++) {
        try { Add-Content -LiteralPath $hosts "`r`n$hostsLine" -Encoding ascii -ErrorAction Stop; $written = $true }
        catch { $why = $_.Exception.Message; Start-Sleep -Seconds 2 }
    }
    if (-not $written) {
        Write-Warning "Windows did not let us write the hosts file ($why). Usually an antivirus protects it, or the file is set to Read-only."
        Write-Host "Fix: allow the WoW Forever Bots folder in your antivirus (or turn its hosts file protection off for a minute) and run" -ForegroundColor Yellow
        Write-Host "Install.cmd again, or add this line yourself at the end of $hosts (Notepad, run as administrator):" -ForegroundColor Yellow
        Write-Host "    127.0.0.1 trinity.actual.battle.net" -ForegroundColor Yellow
    }
}
"Done. bnetserver.conf must point CertificatesFile at $certs\chain.pem and PrivateKeyFile at $certs\server.key (the package's bnetserver.conf.dist uses these relative paths)."
