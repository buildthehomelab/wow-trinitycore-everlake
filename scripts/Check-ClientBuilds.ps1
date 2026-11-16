# Release check: every client build the server worked with before still works (backwards compatible), and every place that
# lists the accepted builds agrees.
#
#   scripts\Check-ClientBuilds.ps1 [-Root <checkout>] [-Previous <git ref of the last release, e.g. origin/release-0136>]
#
# Rules (any failure throws, so build-package.ps1 stops):
#  1. No build is dropped: every build in repack\released-client-builds.txt (every build a published release accepted, a pinned
#     list) is still in repack\client-builds.txt. With -Previous, also every build of that git ref's client-builds.txt.
#  2. Every listed build except the realm build has its own sql\custom\auth\*_auth_classic_<build>.sql with a build_info row.
#  3. The lists agree: launcher Setup.cs AcceptedBuilds = client-builds.txt; make-configs.ps1 $defaultAlso and both
#     Realm.AlsoAcceptBuilds lines of install-expected.psd1 = client-builds.txt without the realm build.
#  4. No auth SQL file deletes the build_info row of another accepted build.
# The realm build is the gamebuild the newest auth file sets for realm 70 (UPDATE `realmlist` SET `gamebuild`=...).
param([string]$Root, [string]$Previous)
$ErrorActionPreference = 'Stop'
if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }

function Get-BuildList([string]$text) {
    @($text -split "`r?`n" | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ })
}
function Split-Builds([string]$csv) {
    @($csv -split '[,\s]+' | Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ })
}
function Compare-Set([string]$name, [int[]]$want, [int[]]$have) {
    $missing = @($want | Where-Object { $have -notcontains $_ })
    $extra = @($have | Where-Object { $want -notcontains $_ })
    $out = @()
    if ($missing.Count) { $out += "$name lacks: $($missing -join ',')" }
    if ($extra.Count) { $out += "$name has builds client-builds.txt does not: $($extra -join ',')" }
    $out
}

$problems = @()
$listFile = Join-Path $Root 'repack\client-builds.txt'
$builds = Get-BuildList (Get-Content -Raw $listFile)
if (-not $builds.Count) { throw "No builds in $listFile" }

# realm build and the auth files
$authDir = Join-Path $Root 'sql\custom\auth'
$authFiles = @(Get-ChildItem -Path $authDir -Filter '*.sql' | Sort-Object Name)
$realmBuild = 0
foreach ($f in $authFiles) {
    $m = [regex]::Matches((Get-Content -Raw $f.FullName), 'UPDATE `realmlist` SET `gamebuild`=(\d+) WHERE `id`=70')
    if ($m.Count) { $realmBuild = [int]$m[$m.Count - 1].Groups[1].Value }
}
if (-not $realmBuild) { $problems += 'No auth file sets the gamebuild of realm 70' }
elseif ($builds -notcontains $realmBuild) { $problems += "The realm build $realmBuild is not in client-builds.txt" }

# rule 2 and rule 4
foreach ($b in $builds) {
    if ($b -eq $realmBuild) { continue }
    $own = @($authFiles | Where-Object { $_.Name -match "_auth_classic_$b\.sql$" })
    if (-not $own.Count) { $problems += "Build $b has no sql\custom\auth\*_auth_classic_$b.sql"; continue }
    $text = Get-Content -Raw $own[-1].FullName
    if ($text -notmatch "(?s)INSERT INTO ``build_info``.*?\($b,") { $problems += "$($own[-1].Name) has no build_info row for $b" }
}
foreach ($f in $authFiles) {
    # the file's own build is the 5-digit number at the end of its name (old beta files: *_auth_classic_beta_70009.sql)
    $own = if ($f.Name -match '_(\d{5})\.sql$') { [int]$Matches[1] } else { 0 }
    foreach ($m in [regex]::Matches((Get-Content -Raw $f.FullName), 'DELETE FROM `build_info` WHERE `build`\s*(=|IN|<|>)\s*\(?([\d,\s]*)')) {
        $deleted = @(Split-Builds $m.Groups[2].Value | Where-Object { $_ -ne $own -and $builds -contains $_ })
        if ($m.Groups[1].Value -ne '=' -and $m.Groups[1].Value -ne 'IN') { $problems += "$($f.Name) deletes build_info rows by range" }
        elseif ($deleted.Count) { $problems += "$($f.Name) deletes the build_info row of accepted build $($deleted -join ',')" }
    }
}

# rule 3
$setup = Get-Content -Raw (Join-Path $Root 'repack\launcher\Setup.cs')
$m = [regex]::Match($setup, 'AcceptedBuilds = new string\[\] \{([^}]*)\}')
if (-not $m.Success) { $problems += 'Setup.cs: AcceptedBuilds not found' }
else { $problems += Compare-Set 'launcher Setup.cs AcceptedBuilds' $builds (Split-Builds ($m.Groups[1].Value -replace '"', '')) }

$also = @($builds | Where-Object { $_ -ne $realmBuild })
$mc = [regex]::Match((Get-Content -Raw (Join-Path $Root 'scripts\make-configs.ps1')), "\`$defaultAlso = '([\d,]*)'")
if (-not $mc.Success) { $problems += 'make-configs.ps1: $defaultAlso not found' }
else { $problems += Compare-Set 'make-configs.ps1 $defaultAlso' $also (Split-Builds $mc.Groups[1].Value) }

$ie = [regex]::Matches((Get-Content -Raw (Join-Path $Root 'scripts\install-expected.psd1')), "'Realm\.AlsoAcceptBuilds'\s*=\s*'([\d,]*)'")
if ($ie.Count -lt 2) { $problems += "install-expected.psd1: expected 2 Realm.AlsoAcceptBuilds lines, found $($ie.Count)" }
foreach ($x in $ie) { $problems += Compare-Set 'install-expected.psd1 Realm.AlsoAcceptBuilds' $also (Split-Builds $x.Groups[1].Value) }

# rule 1: the pinned list of every build a published release accepted (repack\released-client-builds.txt; never remove a line)
$releasedFile = Join-Path $Root 'repack\released-client-builds.txt'
if (-not (Test-Path $releasedFile)) { $problems += 'repack\released-client-builds.txt is missing' }
else {
    $released = Get-BuildList (Get-Content -Raw $releasedFile)
    $dropped = @($released | Where-Object { $builds -notcontains $_ })
    if ($dropped.Count) { $problems += "Builds a published release accepted and this tree dropped: $($dropped -join ',')" }
    $notYet = @($builds | Where-Object { $released -notcontains $_ })
    if ($notYet.Count) { Write-Warning "Not in released-client-builds.txt yet (add them on release day): $($notYet -join ',')" }
}
# optional extra: -Previous <git ref> also compares with that ref's client-builds.txt (git writes to stderr when a ref or path is
# missing; Windows PowerShell 5.1 turns that into an error under Stop)
$ErrorActionPreference = 'Continue'
if ($Previous) {
    $prevText = (& git -C $Root show "${Previous}:repack/client-builds.txt" 2>$null) -join "`n"
    if ($LASTEXITCODE -ne 0 -or -not $prevText) { $problems += "Cannot read repack/client-builds.txt of $Previous" }
    else {
        $dropped = @(Get-BuildList $prevText | Where-Object { $builds -notcontains $_ })
        if ($dropped.Count) { $problems += "Builds $Previous accepted and this tree dropped: $($dropped -join ',')" }
    }
}
$ErrorActionPreference = 'Stop'

if ($problems.Count) { throw ("Client build check failed:`n  " + ($problems -join "`n  ")) }
$since = 'nothing dropped since the published releases' + $(if ($Previous) { " and $Previous" } else { '' })
Write-Host ("Client builds OK: " + ($builds -join ',') + " (realm build $realmBuild, $since)")
