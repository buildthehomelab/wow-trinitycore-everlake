# One-click updater for the repack. Checks the latest GitHub Release, downloads and verifies it, stops the server cleanly,
# backs up the databases and the old program files, swaps in the new files and add-on, and starts the server again so the
# database updates apply. Your characters, accounts, bots (databases), certificates, secrets and your own settings are kept.
#   .\update.ps1                 -> check, update, restart
#   .\update.ps1 -CheckOnly      -> only say whether a newer version exists
#   .\update.ps1 -NoStart        -> update but do not start the server afterwards
#   .\update.ps1 -Quiet          -> check only, no text; exit code 0 = up to date, 10 = update available, 1 = could not check
# Windows PowerShell 5.1, no administrator rights needed.
[CmdletBinding()]
param(
    [switch]$CheckOnly,
    [switch]$Quiet,
    [switch]$NoStart,
    [switch]$AcceptDbReset,      # only when the release notes say [DB-RESET] and you accept losing characters
    [string]$Repo,               # default: repack\release-source.txt
    [string]$ApiUrl,             # tests only: replaces https://api.github.com/repos/<repo>/releases/latest
    [string]$Root,               # tests only: default is the folder above repack\
    [switch]$SkipDatabase        # tests only: skip the MySQL dump (never use on a real install)
)
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'   # the progress bar makes downloads in Windows PowerShell 5.1 very slow
try { [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 } catch { }
if (-not $Root) { $Root = Split-Path $PSScriptRoot -Parent }
$onWindows = ($env:OS -eq 'Windows_NT')
$exe = if ($onWindows) { '.exe' } else { '' }

function Say($m) { if (-not $Quiet) { Write-Host $m } }
function Join($a, $b) { Join-Path $a $b }

function Get-Latest {
    $url = $ApiUrl
    if (-not $url) {
        $r = $Repo
        if (-not $r) { $r = (Get-Content (Join $PSScriptRoot 'release-source.txt') -TotalCount 1).Trim() }
        $url = "https://api.github.com/repos/$r/releases/latest"
    }
    for ($i = 1; $i -le 3; $i++) {
        try { return Invoke-RestMethod $url -Headers @{ 'User-Agent' = 'wow-forever-updater'; 'Accept' = 'application/vnd.github+json' } -UseBasicParsing }
        catch {
            if ($i -eq 3) { throw "Could not reach the release page ($url): $($_.Exception.Message)" }
            Start-Sleep (3 * $i)
        }
    }
}

function ConvertTo-Ver($s) {
    if ($s -match '(\d+(?:\.\d+){1,3})') { try { return [version]$Matches[1] } catch { } }
    return $null
}

# --- version check ------------------------------------------------------------------------------------------------
$verFile = Join $Root 'version.json'
if (-not (Test-Path $verFile)) { throw "version.json not found in $Root (is this the repack folder?)" }
$localInfo = Get-Content $verFile -Raw | ConvertFrom-Json
$local = [string]$localInfo.version
try { $rel = Get-Latest } catch {
    if ($Quiet) { exit 1 }
    throw
}
$remote = ([string]$rel.tag_name).TrimStart('v', 'V')
$lv = ConvertTo-Ver $local; $rv = ConvertTo-Ver $remote
if ($lv -and $rv) { $newer = ($rv -gt $lv) } else { $newer = ($remote -ne $local) }
Say "Installed: $local   Latest: $remote"
if ($Quiet) { try { Set-Content (Join $PSScriptRoot 'latest-version.txt') $remote -Encoding ascii } catch { } }   # read by the launcher window for its update notice
if (-not $newer) { Say 'You are up to date.'; if ($Quiet) { exit 0 } else { return } }
if ($Quiet) { exit 10 }
Say "`nWhat is new:`n$($rel.body)`n"
if ($CheckOnly) { Say 'An update is available. Run repack\update.ps1 (or Update-WoWForever.cmd) to install it.'; return }
if (([string]$rel.body) -match '\[DB-RESET\]' -and -not $AcceptDbReset) {
    throw 'This update resets the database (characters and bots are lost). Your data is not touched. If you accept that, run again with -AcceptDbReset. A backup is made first.'
}

# the small update zip first; the full one-zip package and the old core zip work too
$core = $null
foreach ($pat in 'wow-forever-update-*.zip', 'WoW-Forever-Bots-*.zip', 'wow-forever-core-*.zip') {
    $core = @($rel.assets | Where-Object { $_.name -like $pat })[0]
    if ($core) { break }
}
$sums = @($rel.assets | Where-Object { $_.name -eq 'SHA256SUMS.txt' })[0]
if (-not $core -or -not $sums) { throw 'The release has no update zip or no SHA256SUMS.txt, nothing was changed.' }

# --- single instance + log ----------------------------------------------------------------------------------------
$tmp = Join $Root 'update-tmp'
$dl = Join $Root 'update-download'   # keeps a broken-off download for the next run (Get-Download)
$lock = Join $Root 'update.lock'
if (Test-Path $lock) {
    $age = (Get-Date) - (Get-Item $lock).LastWriteTime
    if ($age.TotalHours -lt 6) { throw "Another update seems to be running ($lock). If not, delete that file and try again." }
}
Set-Content $lock (Get-Date -Format s)
try { Start-Transcript -Path (Join $PSScriptRoot 'update.log') -Force | Out-Null } catch { }

function Stop-Servers {
    New-Item -ItemType File -Force (Join $PSScriptRoot 'stop.flag') | Out-Null   # ends a running auto-restart so it does not start the server again mid-update
    foreach ($name in 'worldserver', 'bnetserver') {
        $p = Get-Process $name -ErrorAction SilentlyContinue
        if (-not $p) { continue }
        Say "Stopping $name (saves characters; can take a minute)..."
        # worldserver: the "server exit" console command, which saves every character. Closing its window let Windows end it
        # before anything was saved (see Stop-WorldserverSaved in console-send.ps1).
        $sent = $false
        if ($name -eq 'worldserver') {
            try { . (Join $PSScriptRoot 'console-send.ps1'); Send-WorldserverCommand 'server exit'; $sent = $true }
            catch { Say "Could not reach the worldserver console ($($_.Exception.Message)); closing its window instead." }
        }
        if (-not $sent) { $null = $p | ForEach-Object { $_.CloseMainWindow() } }
        # never kill it: a hard kill can lose the last minutes of characters. Give it 10 minutes, then give up and change nothing.
        $deadline = (Get-Date).AddMinutes(10)
        while ((Get-Process $name -ErrorAction SilentlyContinue) -and (Get-Date) -lt $deadline) { Start-Sleep 2 }
        if (Get-Process $name -ErrorAction SilentlyContinue) { throw "$name did not stop. Close its window yourself, wait until it is gone, then run the update again. Nothing was changed." }
    }
}

# Copies a folder tree; skips files matching $skipFiles (wildcards) and any folder whose name is in $skipDirs.
function Copy-Tree($src, $dst, $skipFiles, $skipDirs) {
    $src = (Resolve-Path $src).Path.TrimEnd('\', '/')
    New-Item -ItemType Directory -Force $dst | Out-Null
    $n = 0
    foreach ($f in Get-ChildItem $src -Recurse -File -Force) {
        $rel = $f.FullName.Substring($src.Length).TrimStart('\', '/')
        $parts = $rel -split '[\\/]'
        if ($parts.Count -gt 1 -and (@($parts[0..($parts.Count - 2)] | Where-Object { $skipDirs -contains $_ }).Count)) { continue }
        $skip = $false
        foreach ($w in $skipFiles) { if ($f.Name -like $w) { $skip = $true; break } }
        if ($skip) { continue }
        $target = Join $dst $rel
        New-Item -ItemType Directory -Force (Split-Path $target -Parent) | Out-Null
        # A program that is open (the launcher window that started this update) cannot be overwritten, but it can be renamed.
        # The first try must not throw: the transcript (update.log) records every thrown error, even one caught here, and a
        # "used by another process" line before the success line reads as a failed update.
        $cpErr = $null
        Copy-Item $f.FullName $target -Force -ErrorAction SilentlyContinue -ErrorVariable cpErr
        if ($cpErr) {
            if (-not (Test-Path $target)) { throw $cpErr[0] }
            Remove-Item "$target.old" -Force -ErrorAction SilentlyContinue
            $aside = if (Test-Path "$target.old") { "$target.old-$(Get-Date -Format yyyyMMddHHmmss)" } else { "$target.old" }   # an older one still open
            Move-Item $target $aside -Force
            Copy-Item $f.FullName $target -Force
        }
        $n++
    }
    return $n
}

# Downloads $url to $dest through $dest.part. GitHub's file servers drop long downloads when they are busy (players 11-08:
# "(504) Gateway Timeout" from DownloadFile), so a drop is tried again a few times, and every try, also the next press of
# Update, carries on from the bytes already in the .part instead of starting over. The server's ETag is kept next to it and
# sent as If-Range, so a file that changed on the server is fetched from the start. The checksum check after it catches the rest.
function Get-Download($url, $dest, [long]$size) {
    $part = "$dest.part"; $tagFile = "$dest.etag"
    $waits = 3, 8, 15, 30, 60
    for ($try = 1; ; $try++) {
        try {
            $have = 0L
            if (Test-Path $part) { $have = (Get-Item $part).Length }
            $tag = ''
            if ($have -gt 0 -and (Test-Path $tagFile)) { $tag = ([string](Get-Content $tagFile -Raw)).Trim() }
            if ($have -gt 0 -and (-not $tag -or ($size -gt 0 -and $have -gt $size))) { Remove-Item $part -Force; $have = 0L }
            if ($size -gt 0 -and $have -eq $size) { Move-Item $part $dest -Force; Remove-Item $tagFile -Force -ErrorAction SilentlyContinue; return }
            $rq = [Net.HttpWebRequest]::Create($url)
            $rq.UserAgent = 'wow-forever-updater'; $rq.Timeout = 30000; $rq.ReadWriteTimeout = 120000
            if ($have -gt 0) { $rq.AddRange($have); $rq.Headers['If-Range'] = $tag; Say ("Carrying on from {0} MB..." -f [math]::Round($have / 1MB)) }
            try { $rsp = $rq.GetResponse() }
            catch {
                $wex = $_.Exception; if ($wex.InnerException) { $wex = $wex.InnerException }   # PowerShell wraps the WebException
                $er = if ($wex -is [Net.WebException]) { $wex.Response } else { $null }
                if ($er -and [int]$er.StatusCode -eq 416) { $er.Close(); Remove-Item $part -Force -ErrorAction SilentlyContinue }
                throw
            }
            try {
                $resumed = $have -gt 0 -and $rsp.StatusCode -eq [Net.HttpStatusCode]::PartialContent
                if (-not $resumed) { $have = 0L }
                Set-Content $tagFile ([string]$rsp.Headers['ETag']) -Encoding ascii
                $mode = if ($resumed) { [IO.FileMode]::Append } else { [IO.FileMode]::Create }
                $in = $rsp.GetResponseStream()
                $out = New-Object IO.FileStream($part, $mode, [IO.FileAccess]::Write)
                try {
                    $buf = New-Object byte[] 262144
                    $got = $have; $next = $got + 100MB
                    while (($n = $in.Read($buf, 0, $buf.Length)) -gt 0) {
                        $out.Write($buf, 0, $n); $got += $n
                        if ($got -ge $next) { $next = $got + 100MB; if ($size -gt 0) { Say ("  {0} of {1} MB" -f [math]::Round($got / 1MB), [math]::Round($size / 1MB)) } }
                    }
                }
                finally { $out.Close(); $in.Close() }
            }
            finally { $rsp.Close() }
            if ($size -gt 0 -and $got -ne $size) { throw ("the download stopped at {0} of {1} MB" -f [math]::Round($got / 1MB), [math]::Round($size / 1MB)) }
            Move-Item $part $dest -Force
            Remove-Item $tagFile -Force -ErrorAction SilentlyContinue
            return
        }
        catch {
            $why = $_.Exception.Message
            if ($try -gt $waits.Count) { throw "Download failed after $try tries: $why Press Update again later; it carries on where it stopped." }
            $w = $waits[$try - 1]
            Say ("Download broke off ({0}). Trying again in {1} s (try {2} of {3})..." -f $why, $w, ($try + 1), ($waits.Count + 1))
            Start-Sleep -Seconds $w
        }
    }
}

function Set-ConfLine($file, $key, $value) {
    if (-not (Test-Path $file)) { return }
    $lines = @(Get-Content $file)
    $hit = $false
    $out = foreach ($l in $lines) { if ($l -match ('^\s*' + [regex]::Escape($key) + '\s*=')) { $hit = $true; "$key = $value" } else { $l } }
    if (-not $hit) { $out = @($lines) + "$key = $value" }
    Set-Content $file $out -Encoding ascii
}

$ok = $false
$swapped = $false
$wasRunning = [bool](Get-Process worldserver, bnetserver -ErrorAction SilentlyContinue)
$bk = $null
try {
    # --- download + verify (nothing is stopped or changed until the file is checked) -------------------------------
    $needGb = [math]::Round(($core.size * 4) / 1GB, 1)
    $drive = (Get-Item $Root).PSDrive
    if ($drive -and $drive.Free -and $drive.Free -lt ($core.size * 4)) { throw "Not enough free disk space: about $needGb GB needed on $($drive.Name):." }
    if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
    New-Item -ItemType Directory -Force $tmp | Out-Null
    # the download itself lives in its own folder that survives a failed run, so the next run carries on; a part left by an
    # older release (another file name) is cleared out first
    New-Item -ItemType Directory -Force $dl | Out-Null
    Get-ChildItem $dl -File | Where-Object { -not $_.Name.StartsWith($core.name) } | Remove-Item -Force -ErrorAction SilentlyContinue
    $zip = Join $dl $core.name
    if (Test-Path $zip) { Remove-Item $zip -Force }
    Say ("Downloading {0} ({1} MB)..." -f $core.name, [math]::Round($core.size / 1MB))
    Get-Download $core.browser_download_url $zip $core.size
    Move-Item $zip (Join $tmp 'core.zip')
    Get-Download $sums.browser_download_url (Join $tmp 'SHA256SUMS.txt') 0
    $want = $null
    foreach ($l in Get-Content (Join $tmp 'SHA256SUMS.txt')) { $t = $l.Trim() -split '\s+', 2; if ($t.Count -eq 2 -and $t[1].TrimStart('*') -eq $core.name) { $want = $t[0] } }
    if (-not $want) { throw "SHA256SUMS.txt has no entry for $($core.name)" }
    $have = (Get-FileHash (Join $tmp 'core.zip') -Algorithm SHA256).Hash
    if ($have -ne $want.ToUpper()) { throw 'The download is damaged (checksum does not match). Nothing was changed; try again.' }
    Say 'Checksum OK. Unpacking...'
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [IO.Compression.ZipFile]::ExtractToDirectory((Join $tmp 'core.zip'), (Join $tmp 'core'))
    $new = Join $tmp 'core'
    if (-not (Test-Path (Join $new 'version.json'))) { throw 'The package has no version.json, nothing was changed.' }
    if (-not (Test-Path (Join (Join $new 'server') ('worldserver' + $exe)))) { throw 'The package has no server\worldserver, nothing was changed.' }
    $newInfo = Get-Content (Join $new 'version.json') -Raw | ConvertFrom-Json

    # --- stop, back up ---------------------------------------------------------------------------------------------
    Stop-Servers
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $bk = Join (Join $Root 'backups') "pre-$remote-$stamp"
    New-Item -ItemType Directory -Force $bk | Out-Null
    if (-not $SkipDatabase) {
        $mysqlBin = Join (Join $Root 'mysql') 'bin'
        $ini = Join (Join $Root 'config') 'my.ini'
        # The same start as the server start: repairs a moved folder or a port Windows now keeps for itself, waits for a MySQL that is
        # still repairing its files instead of starting a second one, and says the reason from MySQL's own log when it fails.
        # (It used to start a new mysqld every few seconds; each one found the files locked by the first and the reason got lost.)
        . (Join $PSScriptRoot 'mysql-helpers.ps1')
        try { Start-OurMySql $Root | ForEach-Object { Say $_ } }
        catch { throw "Your data could not be backed up, so nothing was changed. $($_.Exception.Message) If you cannot fix that, double-click Bug-Report.cmd in the main folder and send us the zip." }
        $eapSaved = $ErrorActionPreference; $ErrorActionPreference = 'Continue'   # Windows PowerShell 5.1 turns a native program's error text into a stop under 'Stop'
        $ready = $false
        for ($i = 0; $i -lt 30 -and -not $ready; $i++) {
            $ping = & (Join $mysqlBin 'mysqladmin.exe') "--defaults-file=$ini" -u root ping 2>&1
            if ($LASTEXITCODE -eq 0) { $ready = $true } else { Start-Sleep 2 }
        }
        $ErrorActionPreference = $eapSaved
        if (-not $ready) { throw "MySQL is running but does not answer, so your data could not be backed up and nothing was changed. MySQL said: $(($ping | Out-String).Trim()). Restart the PC and run the update again." }
        foreach ($db in 'auth', 'characters', 'playerbot') {
            Say "Backing up database $db..."
            $sql = Join $bk "$db.sql"
            $ErrorActionPreference = 'Continue'
            $dumpOut = & (Join $mysqlBin 'mysqldump.exe') "--defaults-file=$ini" -u root --single-transaction --routines --result-file="$sql" $db 2>&1
            $ErrorActionPreference = $eapSaved
            if ($LASTEXITCODE -ne 0 -or -not (Test-Path $sql) -or (Get-Item $sql).Length -lt 100) { throw "Backup of database $db failed, nothing was changed. MySQL said: $(($dumpOut | Out-String).Trim()). Start the server with option 1 in the WoW Forever Bots menu, wait until it is up, close it with option 2 and run the update again." }
            $gz = [IO.File]::Create("$sql.gz")
            $gzs = New-Object IO.Compression.GZipStream($gz, [IO.Compression.CompressionMode]::Compress)
            $in = [IO.File]::OpenRead($sql); $in.CopyTo($gzs); $in.Dispose(); $gzs.Dispose(); $gz.Dispose()
            Remove-Item $sql
        }
    }
    # old program files and settings, so a restore (restore-backup.ps1) matches the database backup
    $null = Copy-Tree (Join $Root 'server') (Join $bk 'server') @('*.pdb', '*.log') @('logs', 'data', 'Crashes')
    Copy-Item $verFile (Join $bk 'version.json') -Force
    Say "Backup saved in $bk"
    Get-ChildItem (Join $Root 'backups') -Directory -Filter 'pre-*' | Where-Object { $_.FullName -ne (Resolve-Path $bk).Path } | Sort-Object CreationTime -Descending | Select-Object -Skip 2 | Remove-Item -Recurse -Force   # newest by date (a name sort puts pre-0.1.10 below pre-0.1.5 and deleted the backup just made); the new one always stays, so 3 are kept

    # --- swap files -------------------------------------------------------------------------------------------------
    # Kept: your settings (*.conf), certificates, secrets, MySQL and its data, maps (server\data), logs, backups.
    # The release's own realm settings file is replaced; put your own changes in server\worldserver.conf.d\zz-9-local.conf.
    Say 'Installing the new files...'
    $swapped = $true
    $skipFiles = @('*.conf', 'my.ini', 'version.json')
    $skipDirs = @('data', 'logs', 'Crashes', 'mysql', 'mysql-data', 'config', 'secrets', 'certs', 'backups', 'update-tmp')
    $count = Copy-Tree $new $Root $skipFiles $skipDirs
    # The setting templates (repack\templates\*.conf) are ours, not the player's: the *.conf skip above left the old ones, and the
    # start then had no new settings to add to zz-9-local.conf. Replace them with the new release's.
    $newTpl = Join (Join $new 'repack') 'templates'
    if (Test-Path $newTpl) {
        $tplDir = Join (Join $Root 'repack') 'templates'
        New-Item -ItemType Directory -Force $tplDir | Out-Null
        foreach ($t in @(Get-ChildItem $newTpl -Filter '*.conf' -File)) { Copy-Item $t.FullName (Join $tplDir $t.Name) -Force }
    }
    # The two managed settings files (ours, replaced by every release); zz-9-local.conf is the player's own and stays.
    foreach ($mf in 'zz-0-playerbot-defaults.conf', 'zz-1-wow-forever-realm.conf') {
        $managed = Join (Join (Join $new 'server') 'worldserver.conf.d') $mf
        if (Test-Path $managed) {
            $cd = Join (Join $Root 'server') 'worldserver.conf.d'
            New-Item -ItemType Directory -Force $cd | Out-Null
            Copy-Item $managed (Join $cd $mf) -Force
        }
    }
    $localConf = Join (Join (Join $Root 'server') 'worldserver.conf.d') 'zz-9-local.conf'
    # The server only reads a settings file that starts a section: without a [worldserver] line every setting in it is ignored.
    # The file is not created here: one with only the section line and comments counts as an "empty file" for the 0.1.15 server,
    # which then does not start. Menu S creates it when you want your own settings; the start sets aside one without settings.
    if ((Test-Path $localConf) -and -not (Select-String -Path $localConf -Pattern '^\s*\[' -Quiet)) {
        $old = Get-Content $localConf -Raw
        Set-Content $localConf ("[worldserver]`r`n" + $old) -Encoding ascii
    }
    # the database updater reads the SQL files from the package and needs the MySQL client; keep both paths current
    # a settings file left empty (no [bnetserver] line) is written again from its .dist first, so the two lines below do not
    # turn it into a file of a few lines the server cannot read (noobiru 0.1.33)
    try { . (Join (Join $Root 'repack') 'WorldUp.ps1'); Repair-ServerConf (Join $Root 'server') | ForEach-Object { Say $_ } } catch { Write-Warning "Could not check the server settings files: $($_.Exception.Message)" }
    $fwd = { param($p) '"' + ($p -replace '\\', '/') + '"' }
    foreach ($c in 'worldserver.conf', 'bnetserver.conf') {
        $cf = Join (Join $Root 'server') $c
        Set-ConfLine $cf 'SourceDirectory' (& $fwd $Root)
        Set-ConfLine $cf 'MySQLExecutable' (& $fwd (Join (Join (Join $Root 'mysql') 'bin') ('mysql' + $exe)))
    }
    Copy-Item (Join $new 'version.json') $verFile -Force   # last: an interrupted update is simply repeated
    Say "Installed version $remote ($count files)."

    # --- add-on -----------------------------------------------------------------------------------------------------
    $clientFile = Join (Join $Root 'config') 'client.txt'
    if (Test-Path $clientFile) {
        $client = (Get-Content $clientFile -TotalCount 1).Trim()
        try { & (Join $PSScriptRoot 'install-addon.ps1') -Client $client } catch { Write-Warning "Could not update the add-on: $($_.Exception.Message)" }
    } else {
        Write-Warning 'The game folder is not known yet: run repack\install-addon.ps1 -Client "<your WoW folder>" once. After that updates install the add-on themselves.'
    }
    # bot pathing: if the game data is not finished, build it in its own window (it takes about 10 to 20 minutes; the update itself is done)
    if (-not (Test-Path (Join (Join (Join $Root 'server') 'data') '.extract-complete'))) {
        try { Start-Process powershell.exe -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$(Join $PSScriptRoot 'ensure-data.ps1')`""; Say 'Installing bot pathing in a new window (the game data was not finished). Start the server after it says it is installed.' } catch { Write-Warning "Could not start the pathing install: $($_.Exception.Message)" }
    }
    # one shortcut only: removes the older separate ones this repack made and makes sure "WoW Forever Bots" exists
    try { & (Join $PSScriptRoot 'make-shortcuts.ps1') | Out-Null } catch { Write-Warning "Could not tidy the shortcuts: $($_.Exception.Message)" }
    if ($newInfo.dataVersion -and $localInfo.dataVersion -and ([string]$newInfo.dataVersion -ne [string]$localInfo.dataVersion)) {
        Write-Warning "This release needs new map data (version $($newInfo.dataVersion)). Download wow-forever-data-*.zip from the release page and unpack it into server\data."
    }
    ($rel.body | Out-String) | Set-Content (Join $Root 'last-update-notes.txt') -Encoding utf8
    $ok = $true
    if (Test-Path $dl) { Remove-Item $dl -Recurse -Force -ErrorAction SilentlyContinue }
}
catch {
    Write-Host "`nUpdate stopped: $($_.Exception.Message)" -ForegroundColor Red
    if ($swapped) {
        Write-Host "The update was only partly installed. Run it again (it starts over safely). Your database backup is in $bk." -ForegroundColor Yellow
    } else {
        Write-Host 'Nothing was changed. Details: repack\update.log'
        if ($wasRunning -and -not (Get-Process worldserver -ErrorAction SilentlyContinue)) {
            Write-Host 'Starting the server again as it was...'
            try { & (Join $PSScriptRoot 'Start-WoWForever.ps1') } catch { Write-Host 'Start it with repack\Start-WoWForever.ps1.' }
        }
    }
}
finally {
    if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue }
    Remove-Item $lock -Force -ErrorAction SilentlyContinue
}

if ($ok -and -not $NoStart) {
    Say 'Starting the server. The first start after an update applies the database changes and can take several minutes...'
    & (Join $PSScriptRoot 'Start-WoWForever.ps1')
}
elseif ($ok) { Say 'Updated. Start the server with repack\Start-WoWForever.ps1.' }
try { Stop-Transcript | Out-Null } catch { }
if (-not $ok) { exit 1 }
