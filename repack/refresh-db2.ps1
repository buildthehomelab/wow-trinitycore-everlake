# Keeps the server's game tables (server\data\dbc, the DB2 files) on the same build as the player's game client.
# Battle.net patches the client (70532 -> 70630 changed spells and items); the server then has to read the new tables too, or it runs
# the old spells while the game shows the new ones. Maps and pathfinding are not touched: only the DB2 files are extracted again,
# which takes about a minute. The build they came from is kept in server\data\dbc\.client-build.
# Run with the server stopped (ensure-data.ps1 calls it before every start and after every update). Returns $true when the tables
# match the client (or nothing could be checked), $false when a refresh was needed and failed.
param([string]$Client)
$root = Split-Path $PSScriptRoot -Parent
. (Join-Path $PSScriptRoot 'ClientBuild.ps1')
$dbc = Join-Path $root 'server\data\dbc'
if (-not (Test-Path $dbc)) { return $true }   # no data yet: the full extraction (extract-data.ps1) writes the tables and the stamp
if (-not $Client) {
    $saved = Join-Path $root 'config\client.txt'
    if (Test-Path $saved) { $Client = (Get-Content $saved -TotalCount 1).Trim() }
}
if (-not $Client) { return $true }
$use = Select-ClientProduct $root $Client
if (-not $use) { return $true }               # not an accepted build: Test-ClientBuild warns at start
# an untested build (config\untested-builds.txt) may have changed a table layout, and the server does not start with tables it cannot
# read: keep the tables of the newest build this release knows until a release knows this one
if (@(Get-KnownBuilds $root) -notcontains $use.Build) { return $true }
$stamp = Join-Path $dbc '.client-build'
$have = if (Test-Path $stamp) { (Get-Content $stamp -TotalCount 1).Trim() } else { '' }
if ($have -eq "$($use.Build)") { return $true }
if (Get-Process worldserver, bnetserver -ErrorAction SilentlyContinue) {
    Write-Warning "The game client is build $($use.Build) but the server's game tables are $(if ($have) { "build $have" } else { 'from an older build' }). Shut the server down and start it again to update them."
    return $true
}
$tool = Join-Path $root 'server\mapextractor.exe'
if (-not (Test-Path $tool)) { Write-Warning 'server\mapextractor.exe is missing; the game tables were not updated.'; return $true }
$base = Split-Path $use.Dir -Parent
$locale = 'enUS'
$bi = Get-Content (Join-Path $base '.build.info') -Raw -ErrorAction SilentlyContinue
if ($bi -match '\b(enUS|enGB|deDE|esES|esMX|frFR|itIT|koKR|ptBR|ruRU|zhCN|zhTW)\b') { $locale = $Matches[1]; if ($locale -eq 'enGB') { $locale = 'enUS' } }
Write-Host "Updating the server's game tables to your client's build $($use.Build) (about a minute)..." -ForegroundColor Yellow
$work = Join-Path $root 'server\db2-refresh'
Remove-Item $work -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force $work | Out-Null
Push-Location (Join-Path $root 'server')
try { & $tool -i "$base" -o "$work" -e 2 -l $locale -p $use.Product | Out-Null } finally { Pop-Location }
$new = Join-Path $work 'dbc'
if (-not @(Get-ChildItem $new -Recurse -Filter '*.db2' -ErrorAction SilentlyContinue).Count) {
    Remove-Item $work -Recurse -Force -ErrorAction SilentlyContinue
    Write-Warning "The game tables could not be read from $base (product $($use.Product)); the server keeps the ones it has."
    return $false
}
# keep the previous tables next to the new ones until the copy is done, so an interrupted refresh leaves a working set
$old = Join-Path $root 'server\data\dbc-previous'
Remove-Item $old -Recurse -Force -ErrorAction SilentlyContinue
robocopy $dbc $old /E /NFL /NDL /NJH /NJS | Out-Null
robocopy $new $dbc /E /NFL /NDL /NJH /NJS | Out-Null
if ($LASTEXITCODE -ge 8) {
    robocopy $old $dbc /E /NFL /NDL /NJH /NJS | Out-Null
    Remove-Item $work -Recurse -Force -ErrorAction SilentlyContinue
    Write-Warning 'Copying the new game tables failed; the previous ones were put back.'
    return $false
}
Set-Content $stamp "$($use.Build)" -Encoding ascii
Remove-Item $work, $old -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "The server's game tables are now build $($use.Build)." -ForegroundColor Green
$true
