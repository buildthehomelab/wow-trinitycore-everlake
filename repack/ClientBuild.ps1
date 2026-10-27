# Dot-sourced by the start scripts. Compares the build of the game client with the build the realm accepts (a realm only lists for a
# client whose build equals realmlist.gamebuild; a Battle.net-patched client logs in but sees "no realms online"). Warns only, never stops a start.
function Get-RealmBuild([string]$Root) {
    # the newest "SET gamebuild=N" in the shipped auth updates is what the realm was set to
    $build = $null
    foreach ($f in @(Get-ChildItem (Join-Path $Root 'sql\custom\auth') -Filter '*.sql' -File -ErrorAction SilentlyContinue | Sort-Object Name)) {
        $m = [regex]::Matches((Get-Content $f.FullName -Raw -ErrorAction SilentlyContinue), '(?i)SET\s+`?gamebuild`?\s*=\s*(\d+)')
        if ($m.Count) { $build = [int]$m[$m.Count - 1].Groups[1].Value }
    }
    $build
}
# Battle.net products a WoW Forever client folder can hold, with their game folder and program. Two of them are installed side by side
# now and have different builds: the beta (wow_classic_beta) and the Forever release (wowf). The build decides which one is used.
$ClientLayouts = [ordered]@{ 'wow_classic_beta' = @('_classic_beta_', 'WowB.exe'); 'wowf' = @('_forever_', 'Wow.exe') }
# Shown when no installed client has an accepted build.
$ClientInstallHint = 'Install the WoW Forever beta with Battle.net: open a command prompt and run "C:\Program Files (x86)\Battle.net\Battle.net.exe" --game=wow_classic_beta --install , then choose its World of Warcraft folder (the one with _classic_beta_).'

# One row per product in the client folder's .build.info: Product, Build (the last number of Version), Dir (its game folder, or $null
# when that folder is not there). $ClientDir can be the folder with .build.info or a game folder in it (_forever_ / _classic_beta_);
# a game folder only yields its own product.
function Get-ClientProducts([string]$ClientDir) {
    if (-not $ClientDir) { return @() }
    $base = $ClientDir; $only = $null
    if (-not (Test-Path (Join-Path $base '.build.info'))) {
        $only = Split-Path $ClientDir -Leaf
        $base = Split-Path $ClientDir -Parent
    }
    $info = Join-Path $base '.build.info'
    if (-not (Test-Path $info)) { return @() }
    $lines = @(Get-Content $info -ErrorAction SilentlyContinue)
    if ($lines.Count -lt 2) { return @() }
    $col = @(@($lines[0] -split '\|') | ForEach-Object { ($_ -split '!')[0] })
    $iv = [array]::IndexOf($col, 'Version'); $ip = [array]::IndexOf($col, 'Product')
    if ($iv -lt 0) { return @() }
    foreach ($l in @($lines | Select-Object -Skip 1 | Where-Object { $_.Trim() })) {
        $f = $l -split '\|'
        $product = if ($ip -ge 0) { $f[$ip].Trim() } else { '' }
        $build = if ($f[$iv].Trim() -match '(\d+)$') { [int]$Matches[1] } else { $null }
        $dir = $null
        if ($ClientLayouts.Contains($product)) {
            $d = Join-Path $base $ClientLayouts[$product][0]
            if (Test-Path (Join-Path $d $ClientLayouts[$product][1])) { $dir = $d }
        }
        if ($only -and $dir -and (Split-Path $dir -Leaf) -ne $only) { continue }
        [pscustomobject]@{ Product = $product; Build = $build; Dir = $dir }
    }
}
# The client builds this package works with, preferred first: repack\client-builds.txt (one list for the scripts and the launcher),
# else the realm's build.
function Get-AcceptedBuilds([string]$Root) {
    $f = Join-Path $Root 'repack\client-builds.txt'
    $list = @(Get-Content $f -ErrorAction SilentlyContinue | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ })
    if ($list.Count) { return $list }
    $r = Get-RealmBuild $Root
    if ($r) { return @($r) }
    @()
}
# The realm is on the first build of client-builds.txt (the newest auth update sets it); bnetserver also lets in the other listed
# builds (Realm.AlsoAcceptBuilds), so a player whose client Battle.net has not patched yet can still log in. Run before bnetserver
# starts; writes bnetserver.conf only when the line differs.
function Sync-AlsoAcceptBuilds([string]$Root) {
    try {
        $conf = Join-Path $Root 'server\bnetserver.conf'
        if (-not (Test-Path $conf)) { return }
        $realm = Get-RealmBuild $Root
        if (-not $realm) { return }
        $also = @(Get-AcceptedBuilds $Root | Where-Object { $_ -ne $realm })
        $want = 'Realm.AlsoAcceptBuilds = "' + ($also -join ',') + '"'
        $lines = @(Get-Content $conf)
        $hit = $false
        $out = @(foreach ($l in $lines) { if ($l -match '^\s*Realm\.AlsoAcceptBuilds\s*=') { $hit = $true; $want } else { $l } })
        if (-not $hit) { $out += $want }
        if (($out -join "`n") -ne ($lines -join "`n")) { Set-Content $conf $out -Encoding ascii }
    } catch { Write-Warning "Could not set Realm.AlsoAcceptBuilds in bnetserver.conf: $($_.Exception.Message)" }
}
# The installed product of $ClientDir to use: the one with the first accepted build that has its game folder, or $null.
function Select-ClientProduct([string]$Root, [string]$ClientDir) {
    $rows = @(Get-ClientProducts $ClientDir | Where-Object { $_.Dir })
    foreach ($b in Get-AcceptedBuilds $Root) {
        $hit = @($rows | Where-Object { $_.Build -eq $b })
        if ($hit.Count) { return $hit[0] }
    }
    $null
}
# The place of $ClientDir's best client build in the accepted list (0 = preferred), or 99 when none is accepted.
function Get-ClientRank([string]$Root, [string]$ClientDir) {
    $use = Select-ClientProduct $Root $ClientDir
    if (-not $use) { return 99 }
    [array]::IndexOf([int[]]@(Get-AcceptedBuilds $Root), [int]$use.Build)
}
# A folder whose name says it is a copy (F:\wow-70532-backup, "World of Warcraft - Copy", ...). Such a folder is only used when
# nothing else fits or the player chose it.
function Test-BackupPath([string]$Dir) { [bool]($Dir -match '(?i)(^|[^a-z])(backups?|bak|old|copy|kopie|sicherung)([^a-z]|$)') }
# The client folders (with .build.info) Battle.net has installed: its install list (%ProgramData%\Battle.net\Agent\product.db, a
# protobuf file whose install paths are length-prefixed strings) and the World of Warcraft uninstall entries in the registry.
function Get-BattleNetClients {
    $paths = New-Object System.Collections.Generic.List[string]
    try {
        $b = [IO.File]::ReadAllBytes((Join-Path $env:ProgramData 'Battle.net\Agent\product.db'))
        for ($i = 1; $i -lt $b.Length - 2; $i++) {
            $c = $b[$i]
            if (-not ((($c -ge 65 -and $c -le 90) -or ($c -ge 97 -and $c -le 122)) -and $b[$i + 1] -eq 58 -and ($b[$i + 2] -eq 47 -or $b[$i + 2] -eq 92))) { continue }
            $len = [int]$b[$i - 1]
            if ($len -ge 128) { continue }
            if ($i -ge 2 -and $b[$i - 2] -ge 128) { $len = ($b[$i - 2] -band 127) + ($len -shl 7) }   # two-byte length
            if ($len -lt 3 -or $i + $len -gt $b.Length) { continue }
            $paths.Add([Text.Encoding]::UTF8.GetString($b, $i, $len))
            $i += $len - 1
        }
    } catch { }
    foreach ($k in 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*', 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*', 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*') {
        try {
            foreach ($e in @(Get-ItemProperty $k -ErrorAction SilentlyContinue)) {
                if ("$($e.DisplayName)" -match 'World of Warcraft' -and $e.InstallLocation) { $paths.Add([string]$e.InstallLocation) }
            }
        } catch { }
    }
    $out = New-Object System.Collections.Generic.List[string]
    foreach ($p in $paths) {
        $d = ($p -replace '/', '\').TrimEnd('\')
        if ($d -match '^[A-Za-z]:$') { continue }
        try {   # .NET file checks: a path on a drive that is not there (an unplugged disk) is simply not used
            if (-not [IO.File]::Exists([IO.Path]::Combine($d, '.build.info'))) {
                $up = [IO.Path]::GetDirectoryName($d)   # a game folder (_forever_ / _classic_beta_): its client folder is the parent
                if (-not ($up -and [IO.File]::Exists([IO.Path]::Combine($up, '.build.info')))) { continue }
                $d = $up
            }
        } catch { continue }
        if (-not @($out | Where-Object { $_ -eq $d }).Count) { $out.Add($d) }
    }
    @($out)
}
# $Dirs ordered for use: an accepted build first (the preferred build first), then a client Battle.net installed, then a folder not
# named like a backup, then the order they were found in.
function Sort-ClientFolders([string]$Root, [string[]]$Dirs, [string[]]$Registered) {
    $i = 0
    $rows = foreach ($d in $Dirs) {
        [pscustomobject]@{ Dir = $d; Rank = (Get-ClientRank $Root $d); Bnet = [int](-not @($Registered | Where-Object { $_ -eq $d }).Count); Backup = [int](Test-BackupPath $d); Order = ($i++) }
    }
    @($rows | Sort-Object Rank, Bnet, Backup, Order)
}
# The folders of a sorted list (Sort-ClientFolders) that are as good as the first one: more than one means the player chooses.
function Get-ClientTies($Sorted) {
    $s = @($Sorted)
    if (-not $s.Count -or $s[0].Rank -eq 99) { return @() }
    @($s | Where-Object { $_.Rank -eq $s[0].Rank -and $_.Bnet -eq $s[0].Bnet -and $_.Backup -eq $s[0].Backup } | ForEach-Object { $_.Dir })
}
# config\client.txt: the client folder on the first line; a second line "picked" when the player chose it (then it is never replaced).
function Get-SavedClient([string]$Root) {
    $f = Join-Path $Root 'config\client.txt'
    $l = @(Get-Content $f -TotalCount 2 -ErrorAction SilentlyContinue)
    if (-not $l.Count -or -not $l[0].Trim()) { return $null }
    [pscustomobject]@{ Dir = $l[0].Trim(); Picked = ($l.Count -gt 1 -and $l[1].Trim() -eq 'picked') }
}
function Save-Client([string]$Root, [string]$Dir, [switch]$Picked) {
    $old = Get-SavedClient $Root
    if ($old -and $old.Picked -and $old.Dir -eq $Dir) { $Picked = $true }   # the player's own choice stays marked
    $f = Join-Path $Root 'config\client.txt'
    New-Item -ItemType Directory -Force (Split-Path $f -Parent) | Out-Null
    $text = @($Dir); if ($Picked) { $text += 'picked' }
    Set-Content $f $text -Encoding ascii
}
# A remembered folder that was found automatically, is named like a backup and is not a Battle.net install gives way to a
# Battle.net-installed client of an accepted build that is not a backup. Returns that client folder, or $null to keep the saved one.
function Get-BetterThanSaved([string]$Root) {
    $s = Get-SavedClient $Root
    if (-not $s -or $s.Picked -or -not (Test-BackupPath $s.Dir)) { return $null }
    $bnet = @(Get-BattleNetClients)
    $base = if ([IO.File]::Exists([IO.Path]::Combine($s.Dir, '.build.info'))) { $s.Dir } else { [IO.Path]::GetDirectoryName($s.Dir) }
    if ($bnet -contains $base) { return $null }
    $best = @(Sort-ClientFolders $Root $bnet $bnet | Where-Object { $_.Rank -ne 99 -and -not $_.Backup })
    if ($best.Count) { return $best[0].Dir }
    $null
}
# $null when $ClientDir has a client this package can use, else a message saying what is there and what is needed.
function Test-ClientFolder([string]$Root, [string]$ClientDir) {
    $want = @(Get-AcceptedBuilds $Root)
    if (-not $want.Count -or (Select-ClientProduct $Root $ClientDir)) { return $null }
    $have = (@(Get-ClientProducts $ClientDir) | ForEach-Object { "$($_.Product) build $($_.Build)" }) -join ', '
    if (-not $have) { $have = 'no WoW client' }
    "The game in $ClientDir is $have, but this server needs build $($want -join ' or '). $ClientInstallHint"
}
function Test-ClientBuild([string]$Root) {
    try {
        $saved = Join-Path $Root 'config\client.txt'
        if (-not (Test-Path $saved)) { return }
        $dir = (Get-Content $saved -TotalCount 1).Trim()
        $msg = Test-ClientFolder $Root $dir
        if ($msg) { Write-Warning "$msg With another build you can log in to Battle.net but the realm list stays empty (no realms online)." }
        else { $p = Select-ClientProduct $Root $dir; if ($p) { "Using the game in $($p.Dir) (build $($p.Build)), which this server accepts." } }
    } catch { }
}
