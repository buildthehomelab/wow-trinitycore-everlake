# Collects what we need to diagnose a bug into one zip on your Desktop. Usernames and IP addresses are masked.
# Double-click Bug-Report.cmd in the main folder (or right-click this file, Run with PowerShell). The window stays open at the end
# and says where the zip is, or what went wrong; press Enter to close it.
param([switch]$NoPause)   # tests and scripts: do not wait for Enter
$root = Split-Path $PSScriptRoot -Parent
$zip = $null
try {
    $ErrorActionPreference = 'Stop'
    $stage = Join-Path $env:TEMP 'wf-bundle'; Remove-Item $stage -Recurse -Force -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Force $stage | Out-Null
    $found = New-Object System.Collections.Generic.List[string]
    function Scrub($path, $out) {
        if (-not (Test-Path -LiteralPath $path)) { return }   # literal: a game folder name may hold [ or ]
        # shared read: works while the server still has the log open
        $fs = [IO.File]::Open($path, 'Open', 'Read', 'ReadWrite')
        try { $lines = (New-Object IO.StreamReader($fs)).ReadToEnd() -split "`r?`n" } finally { $fs.Dispose() }
        $lines | Select-Object -Last 20000 | ForEach-Object {
            $_ -replace '\b\d{1,3}(\.\d{1,3}){3}\b', 'x.x.x.x' -replace '(?i)(password|pass|secret|key)\s*=\s*"?[^"\r\n]+"?', '$1 = <removed>' -replace [regex]::Escape($env:USERNAME), '<user>'
        } | Set-Content -LiteralPath $out
        $found.Add((Split-Path $out -Leaf))
    }
    foreach ($l in 'Server.log', 'DBErrors.log', 'Bnet.log', 'Playerbot.log', 'Errors.log', 'config-check.txt') { Scrub "$root\server\logs\$l" "$stage\$l" }
    foreach ($l in 'install.log', 'update.log', 'autorestart.log') { Scrub "$PSScriptRoot\$l" "$stage\repack-$l" }
    Scrub "$root\mysql-data\mysql-error.log" "$stage\mysql-error.log"   # why the database did not start or an import failed
    foreach ($c in 'worldserver.conf', 'bnetserver.conf', 'playerbot.conf') { Scrub "$root\server\$c" "$stage\$c" }
    foreach ($c in Get-ChildItem "$root\server\worldserver.conf.d" -Filter '*.conf' -File -ErrorAction SilentlyContinue) { Scrub $c.FullName "$stage\conf.d-$($c.Name)" }
    foreach ($c in Get-ChildItem $stage -Filter '*.conf' -File) { (Get-Content $c.FullName) | Where-Object { $_ -notmatch 'DatabaseInfo' } | Set-Content $c.FullName }
    Copy-Item "$root\version.json" $stage -ErrorAction SilentlyContinue
    $crash = Get-ChildItem -Path (Join-Path $root 'client-errors') -ErrorAction SilentlyContinue   # optional: tester copies WoW\Errors here
    if ($crash) { Copy-Item $crash.FullName $stage -ErrorAction SilentlyContinue }
    # the launcher's key scan (next to the launcher, or in %TEMP% when that folder is read-only): why the game key table was not found
    foreach ($k in "$root\keyscan.txt", "$PSScriptRoot\keyscan.txt", (Join-Path $env:TEMP 'keyscan.txt')) {
        if (Test-Path -LiteralPath $k) { Scrub $k "$stage\keyscan-$((Split-Path (Split-Path $k -Parent) -Leaf) -replace '[^\w.-]', '_').txt" }
    }
    # the game's own newest Logs and Errors text files: a game that hangs or closes before its login screen leaves nothing on the server
    # side. The game folder is the one config\client.txt names; each product folder under it (_forever_, _classic_beta_) is read.
    $gameRoot = if (Test-Path "$root\config\client.txt") { (Get-Content "$root\config\client.txt" -TotalCount 1).Trim() } else { '' }
    if ($gameRoot -and (Test-Path -LiteralPath $gameRoot)) {
        foreach ($prod in Get-ChildItem -LiteralPath $gameRoot -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like '_*_' }) {
            foreach ($sub in 'Logs', 'Errors') {
                Get-ChildItem -LiteralPath (Join-Path $prod.FullName $sub) -File -ErrorAction SilentlyContinue |
                    Where-Object { ($_.Extension -eq '.log' -or $_.Extension -eq '.txt') -and $_.LastWriteTime -gt (Get-Date).AddDays(-3) } |
                    Sort-Object LastWriteTime -Descending | Select-Object -First 8 |
                    ForEach-Object { Scrub $_.FullName "$stage\client-$($prod.Name.Trim('_'))-$sub-$($_.Name)" }
            }
        }
    }
    # the newest server crash report, if there is one (the .txt only; dumps are too big)
    $cr = Get-ChildItem "$root\server\Crashes" -Filter '*.txt' -File -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ($cr) { Scrub $cr.FullName "$stage\crash-$($cr.Name)" }
    # MySQL's own error log says why it did not start or refused a login
    $me = Get-ChildItem "$root\mysql-data" -Filter '*.err' -File -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ($me) { Scrub $me.FullName "$stage\mysql-$($me.Name)" }
    $data = Join-Path $root 'server\data'
    # -Recurse: the db2 files are in a locale folder (dbc\ruRU\...), so a flat count said dbc=0 for a complete extraction
    $count = { param($d, $f) @(Get-ChildItem (Join-Path $data $d) -Filter $f -File -Recurse -ErrorAction SilentlyContinue).Count }
    $client = if (Test-Path "$root\config\client.txt") { (Get-Content "$root\config\client.txt" -TotalCount 1) -replace [regex]::Escape($env:USERNAME), '<user>' } else { '(not set)' }
    $port = 3307; $pm = Select-String -Path "$root\config\my.ini" -Pattern '^\s*port\s*=\s*(\d+)' -ErrorAction SilentlyContinue | Select-Object -First 1; if ($pm) { $port = [int]$pm.Matches[0].Groups[1].Value }
    # another install's MySQL on our port refuses this install's password, and the worldserver closes at once
    $owner = try { $c = Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction Stop | Select-Object -First 1; $p = Get-Process -Id $c.OwningProcess; "$($p.Path)" -replace [regex]::Escape($env:USERNAME), '<user>' } catch { '(nothing listening)' }
    @"
Windows: $([Environment]::OSVersion.VersionString)
CPUs: $([Environment]::ProcessorCount)
Free GB on install drive: $([math]::Round((Get-PSDrive ($root.Substring(0, 1))).Free / 1GB))
Install folder has spaces: $($root -match ' ')
Game folder (config\client.txt): $client
server\data: dbc=$(& $count 'dbc' '*.db2') maps=$(& $count 'maps' '*.map') mmaps=$(& $count 'mmaps' '*.mmap') extract-complete=$(Test-Path (Join-Path $data '.extract-complete'))
MySQL port $port is used by: $owner
Running: $((Get-Process worldserver, bnetserver, mysqld -ErrorAction SilentlyContinue | ForEach-Object ProcessName) -join ', ')
VC++ 2015-2022 x64 runtime: $([bool](Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64' -ErrorAction SilentlyContinue))
Files found: $($found -join ', ')
"@ | Set-Content "$stage\system.txt"
    $desk = [Environment]::GetFolderPath('Desktop')
    if (-not $desk -or -not (Test-Path $desk)) { $desk = $root }
    $zip = Join-Path $desk ("wf-bugbundle-{0:yyyyMMdd-HHmm}.zip" -f (Get-Date))
    Compress-Archive "$stage\*" $zip -Force
    Remove-Item $stage -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host ''
    Write-Host "Created $zip" -ForegroundColor Green
    Write-Host 'Post that zip in our Discord. Names and IPs are masked, but you can open it and check first.'
    if (-not $found.Contains('Server.log')) { Write-Host "No server\logs\Server.log was found: the server never got far enough to write one. Say so when you post the zip." -ForegroundColor Yellow }
    try { Start-Process explorer.exe "/select,`"$zip`"" } catch { }
} catch {
    Write-Host ''
    Write-Host "The bug report could not be made: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Please post a screenshot of this window and send these files by hand: server\logs\Server.log, server\logs\DBErrors.log, repack\install.log (in $root)."
}
if (-not $NoPause) { Write-Host ''; Read-Host 'Press Enter to close this window' | Out-Null }
