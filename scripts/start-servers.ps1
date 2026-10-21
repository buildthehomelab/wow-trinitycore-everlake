# Starts MySQL, worldserver and bnetserver. The servers open minimized console windows: type commands there
# (e.g. `server shutdown 10` in worldserver to stop it cleanly).
#   .\start-servers.ps1                    -> the folder install.ps1 installs into ($installFolder in common.ps1, server-bot\)
#   .\start-servers.ps1 -Server server     -> the plain Forever server (server\), no installed-revision check
# Run only one of them at a time (same ports, same databases).
param([string]$Server = '', [switch]$SkipBackupCheck)
. "$PSScriptRoot\common.ps1"
if (-not $Server) { $Server = $installFolder }
& "$PSScriptRoot\start-mysql.ps1"
Start-Sleep 5
$dir = Join-Path $root $Server

# worldserver applies database migrations on start. Refuse to start a build whose install did not make a restore-checked
# backup (scripts\install.ps1 writes <server>\.verified-backup for the installed revision). -SkipBackupCheck for the plain
# server\ build or a deliberate override.
if (-not $SkipBackupCheck -and $Server -ne 'server') {
    $marker = Join-Path $dir '.verified-backup'
    if (-not (Test-Path "$dir\worldserver.exe")) { throw "No worldserver.exe in ${dir}: run scripts\install.ps1 (it installs into $installFolder)" }
    if (-not (Test-Path $marker)) { throw "No verified backup for ${Server}: run scripts\install.ps1 (or pass -SkipBackupCheck)" }
    $rev = ((& "$dir\worldserver.exe" --version 2>&1) | Out-String)
    $commit = (Get-Content $marker -Raw | ConvertFrom-Json).commit
    if (-not $commit) { throw "$marker has no commit: run scripts\install.ps1 again" }
    if ($rev -notmatch [regex]::Escape($commit)) { throw "The worldserver in ${Server} ($($rev.Trim())) is not the revision whose backup was verified ($commit): run scripts\install.ps1 for the build you want to start, or start the folder it installed into" }
}

# worldserver overwrites Server.log and Playerbot.log on start, so keep copies of the last runs first.
# Only the newest 3 of each are kept (disk rule).
function Save-OldLogs([string]$logDir, [int]$keep = 3) {
    $archive = Join-Path $logDir 'archive'
    $stamp = Get-Date -Format 'yyyy-MM-dd-HHmm'
    foreach ($name in 'Server', 'Playerbot') {
        $log = Join-Path $logDir "$name.log"
        if (-not (Test-Path $log) -or (Get-Item $log).Length -eq 0) { continue }
        New-Item -ItemType Directory -Force $archive | Out-Null
        Copy-Item $log (Join-Path $archive "$name-$stamp.log") -Force
        Get-ChildItem $archive -Filter "$name-*.log" | Sort-Object LastWriteTime -Descending |
            Select-Object -Skip $keep | Remove-Item -Force
    }
    "Archived previous logs to $archive (keeping the last $keep of each)"
}

foreach ($exe in 'worldserver', 'bnetserver') {
    if (Get-Process $exe -ErrorAction SilentlyContinue) { "$exe already running"; continue }
    if ($exe -eq 'worldserver') { Save-OldLogs (Join-Path $dir 'logs') }
    Start-Process "$dir\$exe.exe" -WorkingDirectory $dir -WindowStyle Minimized
    "$exe started from $Server"
    if ($exe -eq 'worldserver') {
        # worldserver applies the auth SQL updates; bnetserver exits if it starts before new auth columns exist
        # ("Could not prepare statements of the Login database"), so wait until the world is up (max 30 min).
        $log = Join-Path $dir 'logs\Server.log'
        $deadline = (Get-Date).AddMinutes(30)
        do { Start-Sleep 5 } until (((Test-Path $log) -and (Select-String -Path $log -Pattern 'World initialized' -Quiet)) -or
                                    -not (Get-Process worldserver -ErrorAction SilentlyContinue) -or (Get-Date) -gt $deadline)
        # The [startup] bots line in Server.log shows World.Enable as read from the config files; "(default)" means the key was not
        # found, i.e. worldserver.conf.d\playerbot.conf was not loaded (for example it has no [section] header).
        if (Test-Path $log) {
            $line = Select-String -Path $log -Pattern '\[startup\] bots:' | Select-Object -Last 1
            if (-not $line) { Write-Warning 'no [startup] bots line in Server.log (bot module not loaded?)' }
            elseif ($line.Line -notmatch 'World\.Enable=1') { Write-Warning ("world bots are not enabled by the config: " + $line.Line.Trim()) }
            else { "playerbot.conf loaded: " + $line.Line.Trim() }
        }
    }
}
