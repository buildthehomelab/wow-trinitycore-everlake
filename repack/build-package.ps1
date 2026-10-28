# DEV SIDE (chris's PC): assembles the release zips from server-bot\ plus the packaging files.
# Produces in <root>\release\<ver>\ (+ SHA256SUMS.txt):
#   WoW-Forever-Bots-<ver>.zip   the ONE zip players download: everything, including the game database dumps; they run Install.cmd
#   wow-forever-update-<ver>.zip the same without MySQL and the database dumps (small); the Update button downloads this one
# Also run package-source.ps1 (GPL source, separate asset). Nothing is uploaded; publishing is manual. Target client build: 70658 (70634, 70630 and 70532 still accepted).
#   .\build-package.ps1 -Version 0.1.1 [-DbZip <path to wow-forever-db-*.zip>]
# The database dumps (sql\world.sql, sql\hotfixes.sql, from a FRESH install) come from the db zip: the one given, else the newest
# wow-forever-db-*.zip under <root>\release\. Without one the full zip is built without dumps (worldserver then imports on first start).
# Expects <root>\TrinityCore\repack\ (this folder), <root>\server-bot\ (installed build) and <root>\mysql-portable\ (a copy
# of the MySQL 8.4 folder that has bin\mysqld.exe; its data dir is NOT included), optional <root>\openssl-portable\.
# Refuses to pack when this checkout's sql\, add-on or repack scripts lack what the programs' commit has (see Assert-KitMatchesPrograms);
# -BinCommit names that commit when worldserver.exe carries none.
param([Parameter(Mandatory)][string]$Version, [string]$DbZip, [string]$LegacyDll, [string]$BinCommit)
$ErrorActionPreference = 'Stop'
# Windows PowerShell 5.1 reads a script without a BOM as ANSI, so a non-ASCII character in a string can break parsing. Installer scripts must be plain ASCII.
$bad = Get-ChildItem (Join-Path $PSScriptRoot '*') -Include *.ps1,*.cmd,*.bat -File | Where-Object { [IO.File]::ReadAllBytes($_.FullName) | Where-Object { $_ -gt 127 } | Select-Object -First 1 }
$bad += Get-Item (Join-Path $PSScriptRoot '..\tools\extract_client_data.ps1') | Where-Object { [IO.File]::ReadAllBytes($_.FullName) | Where-Object { $_ -gt 127 } | Select-Object -First 1 }
if ($bad) { throw ('Non-ASCII characters in installer scripts: ' + (($bad | ForEach-Object Name) -join ', ')) }
$root = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$src  = Split-Path $PSScriptRoot -Parent
# The kit takes sql\, the ForeverBots add-on and the repack scripts from this checkout and only the programs from server-bot\.
# 0.1.17 shipped 245 programs with SQL that stopped at 2026_10_23_03, so an update never got the 2026_10_24 files. Before anything is
# staged: the programs' commit (from the rev. line in worldserver.exe) must be in this checkout, sql\ and the add-on must be that
# commit's exactly, and every line that commit's branch added to the repack scripts must be in this checkout's copy.
function Invoke-SrcGit {
    $eap = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
    try { $o = & git -C $src @args 2>$null; $script:gitExit = $LASTEXITCODE; $o } finally { $ErrorActionPreference = $eap }
}
function Assert-KitMatchesPrograms {
    $exe = Join-Path $root 'server-bot\worldserver.exe'
    if (-not (Test-Path $exe)) { throw "No worldserver.exe in $root\server-bot" }
    $rev = [regex]::Match([Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes($exe)), 'TrinityCore rev\. ([0-9a-f]{7,40})(\+?) [^()]*\(([^()]*) branch\)')
    $bin = $script:BinCommit
    if (-not $bin) {
        if (-not $rev.Success) { throw 'worldserver.exe carries no "TrinityCore rev." line: pass -BinCommit <the commit the programs were built from>' }
        if ($rev.Groups[2].Value) { throw "worldserver.exe was built from $($rev.Groups[1].Value) with uncommitted changes (+): build from a clean commit, or pass -BinCommit" }
        $bin = $rev.Groups[1].Value
    }
    $binFull = Invoke-SrcGit rev-parse --verify --quiet "$bin^{commit}"
    if ($gitExit -ne 0 -or -not $binFull) { throw "The programs' commit $bin is not in $src : fetch it there first (git -C `"$src`" fetch origin <its branch>)" }
    $kitHead = Invoke-SrcGit rev-parse HEAD
    $kitBranch = Invoke-SrcGit rev-parse --abbrev-ref HEAD
    if ($rev.Success) { "Programs:   worldserver.exe built from $binFull ($($rev.Groups[3].Value) branch)" } else { "Programs:   $binFull (given with -BinCommit)" }
    "Kit source: $src at $kitHead ($kitBranch)"
    $taken = 'sql', 'src/modules/PlayerbotV2/Addon', 'src/modules/PlayerbotV2/conf', 'repack', 'tools/addon-installer', 'tools/extract_client_data.ps1'
    $dirty = @(Invoke-SrcGit status --porcelain --untracked-files=all -- @taken)
    if ($dirty.Count) { throw ("The kit source has uncommitted or untracked files the package would take; commit or remove them:`n  " + ($dirty -join "`n  ")) }
    # sql\ and the add-on: exactly the programs' commit (D = missing from the kit, A = only in the kit, M = changed)
    $diff = @(Invoke-SrcGit diff --name-status --no-renames $binFull HEAD -- sql src/modules/PlayerbotV2/Addon)
    if ($gitExit -ne 0) { throw 'git diff of sql\ and the add-on failed' }
    if ($diff.Count) {
        throw ("The kit source's sql\ / add-on differ from the programs' commit $binFull (D = missing from the kit, A = only in the kit, M = changed):`n  " + ($diff -join "`n  ") +
            "`nBring them to that commit (git checkout $binFull -- sql src/modules/PlayerbotV2/Addon), commit, and pack again.")
    }
    # repack scripts: the kit branch has its own newer scripts, so it only has to carry what the programs' branch added since the two split
    $base = Invoke-SrcGit merge-base $binFull HEAD
    if ($gitExit -ne 0 -or -not $base) { throw "The kit source and $binFull share no history: the repack scripts cannot be checked" }
    $missing = New-Object System.Collections.Generic.List[string]
    foreach ($row in @(Invoke-SrcGit diff --name-status --no-renames $base $binFull -- repack tools/addon-installer tools/extract_client_data.ps1)) {
        $st, $path = $row -split "`t", 2
        $kitFile = Join-Path $src $path
        if ($st -eq 'D') { if (Test-Path $kitFile) { Write-Warning "$path was removed on the programs' branch but is still in the kit" }; continue }
        if (-not (Test-Path $kitFile)) { $missing.Add("$path (the whole file)"); continue }
        $have = New-Object 'System.Collections.Generic.HashSet[string]'
        foreach ($l in [IO.File]::ReadAllLines($kitFile)) { [void]$have.Add($l.Trim()) }
        foreach ($l in @(Invoke-SrcGit diff --unified=0 --no-renames $base $binFull -- $path)) {
            if ($l.StartsWith('+') -and -not $l.StartsWith('+++')) {
                $t = $l.Substring(1).Trim()
                if ($t -and -not $have.Contains($t)) { $missing.Add("$path : $t"); break }
            }
        }
    }
    if ($missing.Count) { throw ("The kit source lacks repack changes from the programs' commit $binFull (since $base):`n  " + ($missing -join "`n  ") + "`nApply them to the kit branch, commit, and pack again.") }
    $script:BinFull = $binFull; $script:KitHead = $kitHead
}
Assert-KitMatchesPrograms
$out = Join-Path $root "release\$Version"; New-Item -ItemType Directory -Force $out | Out-Null
$stage = Join-Path $out '_stage'; Remove-Item $stage -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force "$stage\server", "$stage\repack", "$stage\config", "$stage\addons", "$stage\tools" | Out-Null
# binaries + dlls + .conf.dist only; never the live .conf (DB passwords, local paths), logs, pdb, data or characters
robocopy "$root\server-bot" "$stage\server" /E /XF *.conf *.pdb *.log *.pem *.bak* *.orig *~ .verified-backup /XD logs data Crashes symbols /NFL /NDL /NJH /NJS | Out-Null
# The OpenSSL legacy provider (legacy.dll) must sit next to the programs: the servers look for it in their own folder, and without it
# they print "OpenSSL failed to load legacy.dll". It has to be the build that matches the libcrypto the programs ship with.
if (-not (Test-Path "$stage\server\legacy.dll")) {
    $crypto = Get-ChildItem "$stage\server" -Filter 'libcrypto-3*.dll' -ErrorAction SilentlyContinue | Select-Object -First 1
    $want = if ($crypto) { ($crypto.VersionInfo.FileVersion -split '[.,]' | Select-Object -First 3) -join '.' } else { $null }
    $cands = @()
    foreach ($r in @($LegacyDll, $env:OPENSSL_MODULES, "$root\openssl-portable", $env:OPENSSL_ROOT_DIR, "$env:ProgramFiles\OpenSSL-Win64", "$env:ProgramFiles\OpenSSL", "$root\server-bot")) {
        if ($r -and (Test-Path $r)) { $cands += Get-ChildItem $r -Recurse -Filter legacy.dll -File -ErrorAction SilentlyContinue }
    }
    $pick = $cands | Where-Object { -not $want -or ((($_.VersionInfo.FileVersion -split '[.,]' | Select-Object -First 3) -join '.') -eq $want) } | Select-Object -First 1
    if (-not $pick) { throw ("legacy.dll (OpenSSL legacy provider" + $(if ($want) { " $want" }) + ") not found. Pass -LegacyDll <path to legacy.dll from the OpenSSL install the build used>.") }
    Copy-Item $pick.FullName "$stage\server\legacy.dll" -Force
    "Added legacy.dll from $($pick.FullName)"
}
robocopy "$src\repack" "$stage\repack" /E /XF Install.cmd WoW-Forever-Bots.cmd Play-WoWForever.cmd Bug-Report.cmd build-package.ps1 package-data.ps1 package-source.ps1 README-TESTER.md SOURCE.txt NOTICE.txt UPDATER.md update.log clean-release.ps1 *.log *.bak* *.orig *~ /XD feedback-repo /NFL /NDL /NJH /NJS | Out-Null
# the ForeverBots addon is REQUIRED (whispering bots only works through it); always ship the copy from this commit
robocopy "$src\src\modules\PlayerbotV2\Addon\ForeverBots" "$stage\addons\ForeverBots" /E /NFL /NDL /NJH /NJS | Out-Null
if (-not (Test-Path "$stage\addons\ForeverBots\ForeverBots.toc")) { throw 'ForeverBots addon missing from the package' }
# ForeverDots (countdown bars for your own damage-over-time spells) goes in beside it and is installed the same way
robocopy "$src\src\modules\PlayerbotV2\Addon\ForeverDots" "$stage\addons\ForeverDots" /E /NFL /NDL /NJH /NJS | Out-Null
if (-not (Test-Path "$stage\addons\ForeverDots\ForeverDots.toc")) { throw 'ForeverDots addon missing from the package' }
if (Test-Path "$root\mysql-portable\bin\mysqld.exe") {
    robocopy "$root\mysql-portable" "$stage\mysql" /E /XD data mysql-data /XF *.log /NFL /NDL /NJH /NJS | Out-Null
} else { Write-Warning 'mysql-portable missing: testers would have to supply MySQL' }
if (Test-Path "$root\openssl-portable") { robocopy "$root\openssl-portable" "$stage\tools\openssl" /E /NFL /NDL /NJH /NJS | Out-Null }
# SQL tree: the server applies database changes from it (SourceDirectory), so every update must carry it
# Two applied auth files carry local notes and are left out; 2026_10_15_00_auth_build_info_70205_70291.sql carries their build_info rows
robocopy "$src\sql" "$stage\sql" /E /XD old /XF *.ps1 *.cnf 2026_10_07_99_auth_pin_client_70205.sql 2026_10_09_01_auth_forever_move_to_70291.sql /NFL /NDL /NJH /NJS | Out-Null
if ($LASTEXITCODE -ge 8) { throw 'copying the sql folder failed' }
# managed realm settings (replaced by every update) + the one-click update launcher in the package root
New-Item -ItemType Directory -Force "$stage\server\worldserver.conf.d" | Out-Null
Copy-Item "$src\repack\templates\realm.conf" "$stage\server\worldserver.conf.d\zz-1-wow-forever-realm.conf" -Force
Copy-Item "$src\src\modules\PlayerbotV2\conf\zz-0-playerbot-defaults.conf" "$stage\server\worldserver.conf.d\zz-0-playerbot-defaults.conf" -Force   # managed bot defaults (auction bot on); the robocopy of server-bot leaves out every *.conf
# only the two managed overrides ship: a local one (a packet log, a debug log level) never reaches players
$extra = Get-ChildItem "$stage\server\worldserver.conf.d" -File | Where-Object { $_.Name -notin 'zz-0-playerbot-defaults.conf', 'zz-1-wow-forever-realm.conf' }
if ($extra) { throw ('Unexpected files in worldserver.conf.d: ' + (($extra | ForEach-Object Name) -join ', ')) }
Copy-Item "$src\repack\Update-WoWForever.cmd" "$stage\Update-WoWForever.cmd" -Force
Copy-Item "$src\tools\extract_client_data.ps1" "$stage\repack\extract_client_data.ps1" -Force   # maps + vmaps + mmaps for every map, resumable (used by extract-data.ps1)
Copy-Item "$src\repack\Install.cmd" "$stage\Install.cmd" -Force
Copy-Item "$src\repack\WoW-Forever-Bots.cmd" "$stage\WoW-Forever-Bots.cmd" -Force
Copy-Item "$src\repack\Play-WoWForever.cmd" "$stage\Play-WoWForever.cmd" -Force
Copy-Item "$src\repack\Bug-Report.cmd" "$stage\Bug-Report.cmd" -Force
& "$src\repack\build-launcher.ps1" -Out "$stage\WoWForeverLauncher.exe"   # the launcher window, compiled with the .NET Framework compiler that ships with Windows
foreach ($f in 'README-TESTER.md:README.md', 'SOURCE.txt:SOURCE.txt', 'NOTICE.txt:NOTICE.txt') {
    $a, $b = $f -split ':'; Copy-Item "$src\repack\$a" "$stage\$b" -Force
}
if (Test-Path "$src\COPYING") { Copy-Item "$src\COPYING" "$stage\COPYING" -Force }
if (Test-Path "$root\BOT_COMMANDS.pdf") { Copy-Item "$root\BOT_COMMANDS.pdf" "$stage\BOT_COMMANDS.pdf" }
@{ version = $Version; client = [string](. { . "$PSScriptRoot\ClientBuild.ps1"; Get-RealmBuild $src }); dataVersion = '1'; built = (Get-Date -Format s); commit = $BinFull; kitCommit = $KitHead } | ConvertTo-Json | Set-Content "$stage\version.json"
# debug symbols stay with the dev (crash dumps), never in the tester zip
New-Item -ItemType Directory -Force "$out\symbols" | Out-Null
Get-ChildItem "$root\server-bot" -Filter *.pdb | Copy-Item -Destination "$out\symbols" -Force
# ZipFile (not Compress-Archive: that one fails on archives over 2 GB in Windows PowerShell 5.1)
Add-Type -AssemblyName System.IO.Compression.FileSystem
function New-Zip($dir, $zip) {
    Remove-Item $zip -ErrorAction SilentlyContinue
    [IO.Compression.ZipFile]::CreateFromDirectory($dir, $zip, [IO.Compression.CompressionLevel]::Optimal, $false)
    if ((Get-Item $zip).Length -gt 1.95GB) { Write-Warning "$zip is over 2 GB: GitHub will not take it as a release file." }
}
# 1. the database dumps go into the full zip only
if (-not $DbZip) { $DbZip = (Get-ChildItem "$root\release" -Recurse -Filter 'wow-forever-db-*.zip' -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName }
if ($DbZip -and (Test-Path $DbZip)) {
    "Adding the database dumps from $DbZip"
    $dbTmp = Join-Path $out '_dbstage'; Remove-Item $dbTmp -Recurse -Force -ErrorAction SilentlyContinue
    [IO.Compression.ZipFile]::ExtractToDirectory($DbZip, $dbTmp)
    foreach ($f in 'world.sql', 'hotfixes.sql') {
        $p = Get-ChildItem $dbTmp -Recurse -Filter $f | Select-Object -First 1
        if ($p) { Copy-Item $p.FullName "$stage\sql\$f" -Force } else { Write-Warning "$f not in $DbZip" }
    }
    Remove-Item $dbTmp -Recurse -Force
} else { Write-Warning 'No database dumps found: the full zip is built without them (first start imports the world database itself, slower).' }
# local backups and editor leftovers never ship
Get-ChildItem $stage -Recurse -File -Force | Where-Object { $_.Name -like '*.bak*' -or $_.Name -like '*.orig' -or $_.Name -like '*~' } | Remove-Item -Force
# The programs carry the build banner (the branch name) as ASCII and as UTF-16. It is replaced by text of the same length, so offsets stay valid.
# The words are written with a bracket so this script does not hold them itself.
$lat = [Text.Encoding]::GetEncoding(28591)
$reA  = '(?i)[c]laude';              $toA  = 'karrz1'
$reW  = '(?i)c\x00l\x00a\x00u\x00d\x00e\x00'; $toW = 'k' + [char]0 + 'a' + [char]0 + 'r' + [char]0 + 'r' + [char]0 + 'z' + [char]0 + '1' + [char]0
foreach ($f in Get-ChildItem $stage -Recurse -File -Include *.exe, *.dll | Where-Object { $_.FullName -notmatch '\\(mysql|tools)\\' }) {
    $txt = $lat.GetString([IO.File]::ReadAllBytes($f.FullName))
    $new = [regex]::Replace([regex]::Replace($txt, $reA, $toA), $reW, $toW)
    if ($new -ne $txt) { [IO.File]::WriteAllBytes($f.FullName, $lat.GetBytes($new)); "Rewrote build banner in $($f.FullName.Substring($stage.Length + 1))" }
}
# Final check: nothing packed may carry the words (or the dev's user folder / full name), ASCII or UTF-16, except known game data (NPC names in the world data, a word list in MySQL).
$allowed = @('sql\world.sql', 'sql\hotfixes.sql', 'sql\custom\world\2026_09_27_00_world_forever_baseline_01.sql', 'mysql\share\dictionary.txt')
$reAny = '(?i)[c]laude|[a]nthropic|c\x00l\x00a\x00u\x00d\x00e\x00|a\x00n\x00t\x00h\x00r\x00o\x00p\x00i\x00c\x00|Users[\\/]c[h]ris|c[h]ris leisk|c[h]risleisk|U\x00s\x00e\x00r\x00s\x00[\\/]\x00c\x00h\x00r\x00i\x00s\x00'
$hits = New-Object System.Collections.Generic.List[string]
foreach ($f in Get-ChildItem $stage -Recurse -File) {
    $rel = $f.FullName.Substring($stage.Length + 1)
    if ($allowed -contains $rel -or $f.Length -gt 1GB) { continue }
    if ($lat.GetString([IO.File]::ReadAllBytes($f.FullName)) -match $reAny) { $hits.Add($rel) }
    elseif ($rel -like 'sql\custom\*' -and $lat.GetString([IO.File]::ReadAllBytes($f.FullName)) -match '(?i)\bc[h]ris\b') { $hits.Add($rel) }   # local notes in our own SQL
}
if ($hits.Count) { throw ("Packed files still carry the build-tool words:`n  " + ($hits -join "`n  ")) }
# Files the package must hold
foreach ($need in 'server\worldserver.exe', 'server\bnetserver.exe', 'server\legacy.dll', 'server\worldserver.conf.d\zz-0-playerbot-defaults.conf', 'server\worldserver.conf.d\zz-1-wow-forever-realm.conf', 'Install.cmd', 'addons\ForeverBots\ForeverBots.toc', 'addons\ForeverDots\ForeverDots.toc') {
    if (-not (Test-Path (Join-Path $stage $need))) { throw "Package file missing: $need" }
}
New-Zip $stage "$out\WoW-Forever-Bots-$Version.zip"
# the add-on alone, for players who only need the client part (friends of a host, or a build without the repack): the zip holds the folder ForeverBots
$addonTmp = Join-Path $out '_addon'; Remove-Item $addonTmp -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force "$addonTmp\ForeverBots" | Out-Null
Copy-Item "$stage\addons\ForeverBots\*" "$addonTmp\ForeverBots" -Recurse -Force
New-Item -ItemType Directory -Force "$addonTmp\ForeverDots" | Out-Null
Copy-Item "$stage\addons\ForeverDots\*" "$addonTmp\ForeverDots" -Recurse -Force
Copy-Item "$src\tools\addon-installer\*" $addonTmp -Force   # Install-Addon.cmd/.ps1 + README.txt: double-click installer next to the folder
New-Zip $addonTmp "$out\ForeverBots-addon-$Version.zip"
Remove-Item $addonTmp -Recurse -Force
# 2. the update zip: no MySQL, no dumps (players already have them), no installer
foreach ($x in "$stage\mysql", "$stage\sql\world.sql", "$stage\sql\hotfixes.sql", "$stage\Install.cmd") { Remove-Item $x -Recurse -Force -ErrorAction SilentlyContinue }
# The launcher goes in as repack\WoWForeverLauncher.exe.new: the Update button runs while the launcher is open, and Windows does not
# let the updater overwrite a running WoWForeverLauncher.exe (0.1.21 stopped half-way there). make-shortcuts.ps1, which every updater
# runs after copying, puts it in place with update-launcher.ps1.
Move-Item "$stage\WoWForeverLauncher.exe" "$stage\repack\WoWForeverLauncher.exe.new" -Force
New-Zip $stage "$out\wow-forever-update-$Version.zip"
Get-ChildItem $out -File | Where-Object { $_.Name -like 'WoW-Forever-Bots-*.zip' -or $_.Name -like 'wow-forever-update-*.zip' -or $_.Name -like 'ForeverBots-addon-*.zip' } | ForEach-Object { "$((Get-FileHash $_.FullName -Algorithm SHA256).Hash.ToLower())  $($_.Name)" } | Set-Content "$out\SHA256SUMS.txt"
Remove-Item $stage -Recurse -Force
# a release file of its own: launchers read it with the release list to learn which client builds the newest repack takes (and when
# Battle.net patches, an edited copy can be uploaded to the release on its own, without a new kit)
Copy-Item "$src\repack\client-builds.txt" "$out\client-builds.txt" -Force
"Built $out. Now package-source.ps1, then test Install.cmd in a clean Windows user or VM before publishing."
