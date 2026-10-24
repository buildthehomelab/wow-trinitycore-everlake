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
# Shown when no installed client has an accepted build. 70532 is the WoW Forever beta.
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
# The installed product of $ClientDir to use: the one with the first accepted build that has its game folder, or $null.
function Select-ClientProduct([string]$Root, [string]$ClientDir) {
    $rows = @(Get-ClientProducts $ClientDir | Where-Object { $_.Dir })
    foreach ($b in Get-AcceptedBuilds $Root) {
        $hit = @($rows | Where-Object { $_.Build -eq $b })
        if ($hit.Count) { return $hit[0] }
    }
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
