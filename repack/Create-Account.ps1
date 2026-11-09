# Creates a game account through the running server (the server's own "bnetaccount create" command, nothing is written to the
# database directly), so a player can log in. Asks for a name, a password (typed twice, hidden) and whether it is a GM account.
#   .\Create-Account.ps1                          -> asks everything
#   .\Create-Account.ps1 -Name x -GM              -> asks only for the password
[CmdletBinding()]
param([string]$Name, [switch]$GM, [switch]$NoGmQuestion)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
. "$PSScriptRoot\console-send.ps1"

function Test-AccountName($n) { $n -match '^[A-Za-z0-9._@+-]{3,60}$' }
function Test-Password($p) { $p.Length -ge 6 -and $p.Length -le 16 -and $p -match '^[\x21-\x7E]+$' -and $p -notmatch '[''"`;]' }
# The query's output, trimmed (empty when it found no row). A failed call throws with MySQL's own message: it used to come back as
# empty output, which the name check below read as "an account with this name exists". Runs with ErrorActionPreference Continue,
# since under Stop a line on stderr would end the script before the exit code is read.
function Invoke-Query($sql) {
    $mysql = Join-Path $root 'mysql\bin\mysql.exe'
    if (-not (Test-Path $mysql)) { throw "mysql\bin\mysql.exe is missing. An antivirus program may have removed it: allow the WoW Forever Bots folder in it and run Install.cmd again." }
    $eap = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
    try { $out = @(& $mysql "--defaults-file=$root\config\my.ini" -u root -N -B -e $sql 2>&1 | ForEach-Object { "$_" }); $code = $LASTEXITCODE }
    finally { $ErrorActionPreference = $eap }
    $rows = @($out | Where-Object { $_ -notmatch '^mysql(\.exe)?: \[Warning\]' })
    if ($code) { throw "The database could not be read (MySQL exit code $code): $(($rows -join ' ').Trim())" }
    ($rows -join "`n").Trim()
}
function Read-Plain($prompt) {
    $s = Read-Host $prompt -AsSecureString
    $b = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($s)
    try { [Runtime.InteropServices.Marshal]::PtrToStringBSTR($b) } finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($b) }
}

# 1. the server must be running and finished starting. Right after the install starts it in another window the process can take a
# few seconds to appear ("Create your account now? y" then said "not running" while step 8 was still starting it), so give
# it up to a minute first.
for ($i = 0; $i -lt 60 -and -not (Get-Process worldserver -ErrorAction SilentlyContinue); $i++) {
    if ($i -eq 0) { Write-Host 'Waiting for the server window to start...' }
    Start-Sleep -Seconds 1
}
if (-not (Get-Process worldserver -ErrorAction SilentlyContinue)) {
    Write-Host 'The server is not running. Start it first (menu 1 or 3), then create the account.' -ForegroundColor Yellow
    return
}
$log = Join-Path $root 'server\logs\Server.log'
if (-not ((Test-Path $log) -and (Select-String -Path $log -Pattern 'World initialized' -Quiet))) {
    Write-Host 'Waiting for the server to finish starting (the first start can take several minutes)...'
    $deadline = (Get-Date).AddMinutes(30)
    do { Start-Sleep 5 } until (((Test-Path $log) -and (Select-String -Path $log -Pattern 'World initialized' -Quiet)) -or -not (Get-Process worldserver -ErrorAction SilentlyContinue) -or (Get-Date) -gt $deadline)
    if (-not (Get-Process worldserver -ErrorAction SilentlyContinue)) { throw 'The server stopped while starting. See server\logs\Server.log.' }
}

# 2. ask
while (-not $Name -or -not (Test-AccountName $Name)) {
    if ($Name) { Write-Host 'Use 3 to 60 letters, digits or . _ - + @ (no spaces).' -ForegroundColor Yellow }
    $Name = (Read-Host 'Account name (this is what you type to log in)').Trim()
}
if ($Name -notmatch '@') { $Name = "$Name@local" }
$taken = Invoke-Query "SELECT COUNT(*) FROM auth.battlenet_accounts WHERE UPPER(email)=UPPER('$Name')"
if ($taken -notmatch '^\d+$') { throw "The database gave no answer to the account check (got '$taken'). Is MySQL running? Start the server first." }
if ($taken -ne '0') {
    Write-Host "An account called $Name already exists. Use another name." -ForegroundColor Yellow
    return
}
# the launcher window passes the password in an environment variable of this process only (never on the command line)
$envPw = $env:WFB_ACCOUNT_PW
$env:WFB_ACCOUNT_PW = $null
if ($envPw) {
    if (-not (Test-Password $envPw)) { Write-Host 'The password needs 6 to 16 characters, no spaces and none of  " '' ` ;' -ForegroundColor Yellow; return }
    $pw = $envPw
} else {
while ($true) {
    $pw = Read-Plain 'Password (6 to 16 characters, no spaces)'
    if (-not (Test-Password $pw)) { Write-Host 'Use 6 to 16 characters, no spaces and none of  " '' ` ;' -ForegroundColor Yellow; continue }
    if ($pw -ne (Read-Plain 'Password again')) { Write-Host 'The two passwords differ. Try again.' -ForegroundColor Yellow; continue }
    break
}
}
if (-not $GM -and -not $NoGmQuestion) {
    $a = Read-Host 'Make this a GM (admin) account? The bots work on every account; GM only adds the game master commands. [y/N]'
    $GM = ($a -match '^(y|yes|j|ja)$')
}

# 3. let the server do it
# A command typed while the server is still loading its bots can be lost, so it is sent again (up to 3 times, ~12 s apart)
# until the account shows up in the database.
$id = ''
for ($try = 1; $try -le 3 -and -not $id; $try++) {
    Send-WorldserverCommand "bnetaccount create $Name $pw"
    for ($i = 0; $i -lt 12 -and -not $id; $i++) {
        Start-Sleep 1
        $r = Invoke-Query "SELECT id FROM auth.battlenet_accounts WHERE UPPER(email)=UPPER('$Name')"
        if ($r -and $r -ne '0') { $id = $r }
    }
}
if (-not $id) {
    Write-Host "`nThe server did not confirm the account. Open the worldserver window (taskbar) and type:" -ForegroundColor Yellow
    Write-Host "   bnetaccount create $Name <your password>"
    if ($GM) { Write-Host "   account set gmlevel <number shown by: bnetaccount listgameaccounts $Name>  3 -1" }
    return
}
if ($GM) {
    $lvl = ''
    for ($try = 1; $try -le 3 -and -not $lvl; $try++) {
        Send-WorldserverCommand "account set gmlevel ${id}#1 3 -1"
        for ($i = 0; $i -lt 10 -and -not $lvl; $i++) {
            Start-Sleep 1
            $lvl = Invoke-Query "SELECT MAX(aa.SecurityLevel) FROM auth.account a JOIN auth.account_access aa ON aa.AccountID=a.id JOIN auth.battlenet_accounts b ON a.battlenet_account=b.id WHERE UPPER(b.email)=UPPER('$Name')"
            if ($lvl -eq 'NULL') { $lvl = '' }
        }
    }
    if (-not $lvl) { Write-Host "The account exists but the GM level was not confirmed. In the worldserver window type:  account set gmlevel ${id}#1 3 -1" -ForegroundColor Yellow }
}
Write-Host "`nDone. Account created: $Name" -ForegroundColor Green
# the login server adds @local to a name typed without an @, so a @local account logs in with the plain name too
$typed = if ($Name -match '^(.+)@local$') { $Matches[1] } else { $Name }
Write-Host "Start the game with Play-WoWForever.cmd (keep its window open), log in with $typed and your password, realm Trinity."
