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
function Get-ClientBuild([string]$ClientDir) {
    $info = Join-Path $ClientDir '.build.info'
    # the saved folder can be the game folder itself (_forever_ / _classic_beta_); .build.info is one level up then
    if (-not (Test-Path $info)) { $info = Join-Path (Split-Path $ClientDir -Parent) '.build.info' }
    if (-not (Test-Path $info)) { return $null }
    $lines = @(Get-Content $info -ErrorAction SilentlyContinue)
    if ($lines.Count -lt 2) { return $null }
    $col = @($lines[0] -split '\|') | ForEach-Object { ($_ -split '!')[0] }
    $i = [array]::IndexOf($col, 'Version')
    if ($i -lt 0) { return $null }
    $v = (($lines[1] -split '\|')[$i]).Trim()          # e.g. 1.60.1.70450
    if ($v -match '(\d+)$') { [int]$Matches[1] } else { $null }
}
function Test-ClientBuild([string]$Root) {
    try {
        $saved = Join-Path $Root 'config\client.txt'
        if (-not (Test-Path $saved)) { return }
        $dir = (Get-Content $saved -TotalCount 1).Trim()
        $client = Get-ClientBuild $dir
        $realm = Get-RealmBuild $Root
        if (-not $client -or -not $realm) { return }
        if ($client -ne $realm) {
            Write-Warning "Your game client is build $client ($dir) but this realm needs build $realm. With another build you can log in to Battle.net but the realm list stays empty (no realms online). Use an unpatched copy of the client at build $realm, started with the ForeverLauncher, and do not let the Battle.net app patch it."
        } else { "Game client build $client matches the realm." }
    } catch { }
}
