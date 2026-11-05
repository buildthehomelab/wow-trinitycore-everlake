# Builds the game data from YOUR OWN WoW Forever client (build 70707): maps, vmaps and the pathfinding data (mmaps) for EVERY map.
# The bots need the mmaps to walk; the server must not be started before this has finished.
#   .\extract-data.ps1 -Client "C:\WoW Forever Client"
# Safe to run again after an interruption: finished stages are skipped and the long stage (mmaps) continues where it stopped.
# Needs about 45 GB free while it runs (the intermediate Buildings folder is about 40 GB and is removed at the end); the finished data is about 2 GB.
param([Parameter(Mandatory)][string]$Client)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$server = Join-Path $root 'server'
$data = Join-Path $server 'data'
if (-not (Test-Path -LiteralPath (Join-Path $Client '.build.info'))) { throw "$Client does not look like a WoW folder (.build.info missing)" }
$tool = Join-Path $PSScriptRoot 'extract_client_data.ps1'
if (-not (Test-Path $tool)) { $tool = Join-Path $root 'tools\extract_client_data.ps1' }
if (-not (Test-Path $tool)) { throw 'extract_client_data.ps1 is missing from the package.' }
. (Join-Path $PSScriptRoot 'ClientBuild.ps1')
if (Test-Path (Join-Path $data '.extract-complete')) {
    # a marker left by an extraction that did not really finish (start-zone tiles missing) is removed, and the data is built again
    $gone = @(Get-MissingStartZoneData $data)
    if (-not $gone.Count) { 'The game data is already complete. Nothing to do.'; return }
    Write-Warning ("The game data was marked complete, but the server can't start without these files: " + ($gone -join ', ') + '. Building the game data again.')
    Remove-Item (Join-Path $data '.extract-complete') -Force
}

$freeGb = [math]::Round((Get-PSDrive ($server.Substring(0, 1))).Free / 1GB)
Write-Host ''
Write-Host 'GAME DATA: this takes about 10 to 20 minutes on a modern PC, longer on an older one (maps, then the pathfinding data for every map).' -ForegroundColor Yellow
Write-Host "It needs about 45 GB free while it runs and leaves about 2 GB. Free on this drive now: $freeGb GB." -ForegroundColor Yellow
Write-Host 'You can leave the computer running and do something else. If it is interrupted, run Install.cmd again: it continues where it stopped.' -ForegroundColor Yellow
Write-Host 'The server is started only after the data is finished.' -ForegroundColor Yellow
if ($freeGb -lt 45) { Write-Warning "Only $freeGb GB free; the intermediate files need about 45 GB. Free some space or this may fail part way (it can then be resumed)." }
Write-Host ''

# extractors and generator live in server\; the tool writes dbc, maps, vmaps, mmaps ... next to them
# only from a client build the server accepts (Battle.net can have the beta and the Forever release side by side)
$wrong = Test-ClientFolder $root $Client
if ($wrong) { throw $wrong }
# the language the game shows its texts in (a French client has no enUS data; a Russian one needs ruRU tables for Russian names)
$use = Select-ClientProduct $root $Client
$locale = 'enUS'; $lang = $null
if ($use -and $use.Dir) { $lang = Get-ClientLocale $use.Dir $use.Product; $locale = $lang.Locale }
$langLine = "Client language: $locale" + $(if ($lang) { " (from $($lang.Source); installed: $(if ($lang.Installed.Count) { $lang.Installed -join ', ' } else { 'not readable' }))" } else { '' })
Write-Host $langLine
& $tool -ClientPath $Client -OutputPath $server -Resume -Locale $locale -Builds (Get-AcceptedBuilds $root)
if ($LASTEXITCODE -ne 0) { throw "The game data step failed (exit code $LASTEXITCODE). Run Install.cmd again to continue; finished stages are kept." }
foreach ($f in '.extract-maps.done', '.extract-vmaps.done', '.extract-mmaps.done') {
    if (-not (Test-Path (Join-Path $server $f))) { throw "The game data step did not finish ($f missing). Run Install.cmd again to continue." }
}
New-Item -ItemType Directory -Force $data | Out-Null
foreach ($d in 'dbc', 'gt', 'maps', 'vmaps', 'mmaps', 'Cameras') {
    $from = Join-Path $server $d
    if (Test-Path $from) {
        robocopy $from (Join-Path $data $d) /E /MOVE /NFL /NDL /NJH /NJS | Out-Null
        if ($LASTEXITCODE -ge 8) { throw "Moving $d into server\data failed." }
    }
}
foreach ($m in '.extract-maps.done', '.extract-vmaps.done', '.extract-mmaps.done') { Remove-Item (Join-Path $server $m) -ErrorAction SilentlyContinue }
# the client build the DB2 tables came from; refresh-db2.ps1 extracts them again when Battle.net patches the client
if ($use) { Set-Content (Join-Path $data 'dbc\.client-build') @("$($use.Build)", $TableKeysRevision) -Encoding ascii }
# which language really landed (server\data\dbc\<language>), kept for the bug report next to the one asked for
$landed = @(Get-ChildItem (Join-Path $data 'dbc') -Directory -ErrorAction SilentlyContinue | ForEach-Object Name)
Set-Content (Join-Path $data 'dbc\.client-locale') @($langLine, "Extracted: $(if ($landed.Count) { $landed -join ', ' } else { 'none' })") -Encoding ascii
Write-Host "Game tables extracted in: $(if ($landed.Count) { $landed -join ', ' } else { 'none' })"
if ($locale -notin 'enUS', 'enGB' -and $landed -notcontains $locale) {
    Write-Warning "Your game is in $locale, but the server's game tables came out in $($landed -join ', '). NPC and quest names will be in English. In Battle.net, check that the game's text language is $locale (Settings, Game Settings), let it download, then run Install.cmd again."
}
# the marker is written only when the files worldserver checks first are really there; without it the next Install.cmd or start
# builds the data again (the stage markers are already removed, so every stage runs)
$gone = @(Get-MissingStartZoneData $data)
if ($gone.Count) {
    throw ("The game data is not complete: " + ($gone -join ', ') + ' missing in ' + $data + '. The map tools did not finish (see the lines above; an antivirus or a full disk are the usual causes). Run Install.cmd again to build the data again.')
}
Set-Content (Join-Path $data '.extract-complete') (Get-Date -Format s)
$global:LASTEXITCODE = 0
"Done. The game data is in $data."
