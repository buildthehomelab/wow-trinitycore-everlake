# Makes sure the game data (maps and the bot pathfinding data, "mmaps") is finished. Runs on every first start and after every update.
# Complete = server\data\.extract-complete exists. If it is missing, the data is built (or finished) from your own client with
# extract-data.ps1 -Resume, which only builds what is missing, so an almost complete set only needs a short pass.
# You can close the window to stop; start again (menu 1, or Install.cmd) and it continues where it stopped.
# Returns $true when the data is complete.
param([string]$Client)
$root = Split-Path $PSScriptRoot -Parent
$marker = Join-Path $root 'server\data\.extract-complete'
if (Test-Path $marker) {
    # the client may have been patched since the data was built: bring the server's DB2 tables to its build (maps stay)
    $null = & (Join-Path $PSScriptRoot 'refresh-db2.ps1') -Client $Client
    return $true
}
Write-Host ''
Write-Host 'Installing bot pathing: the pathfinding data the bots need to walk is not finished yet.' -ForegroundColor Yellow
if (-not $Client) {
    $saved = Join-Path $root 'config\client.txt'
    if (Test-Path $saved) { $Client = (Get-Content $saved -TotalCount 1).Trim() }
}
if (-not $Client -or -not (Test-Path (Join-Path $Client '.build.info'))) {
    Write-Host 'The game folder is not known. Run Install.cmd: it asks for your WoW Forever game folder and builds the data.' -ForegroundColor Red
    return $false
}
$mm = @(Get-ChildItem (Join-Path $root 'server\data\mmaps') -Filter '*.mmap' -ErrorAction SilentlyContinue).Count
if ($mm -gt 0) { Write-Host "$mm maps already have pathing data; only the missing ones are built now, so this is shorter than a full install." -ForegroundColor Yellow }
# An install whose data was finished by an older version has the folders in server\data but no marker (the work files are gone).
# Then nothing is rebuilt from scratch: check each map in server\data and build only the ones that have game files but no navigation mesh.
$data = Join-Path $root 'server\data'
$gen = Join-Path $root 'server\mmaps_generator.exe'
if ((Test-Path (Join-Path $data 'maps')) -and (Test-Path (Join-Path $data 'vmaps')) -and (Test-Path (Join-Path $data 'dbc')) -and $mm -gt 0 -and (Test-Path $gen)) {
    $ids = @()
    foreach ($f in Get-ChildItem (Join-Path $data 'maps') -Filter '*.tilelist' -ErrorAction SilentlyContinue) { if ($f.Name -match '^(\d{4})') { $ids += [int]$Matches[1] } }
    foreach ($d in Get-ChildItem (Join-Path $data 'vmaps') -Directory -ErrorAction SilentlyContinue) { if ($d.Name -match '^\d+$') { $ids += [int]$d.Name } }
    $ids = @($ids | Sort-Object -Unique)
    $missing = @($ids | Where-Object { -not (Test-Path (Join-Path $data ('mmaps\{0:D4}.mmap' -f $_))) })
    Write-Host "Checked $($ids.Count) maps in server\data: $($missing.Count) have no pathing data yet."
    $n = 0
    foreach ($id in $missing) {
        $n++
        Write-Host "Pathfinding data: building map $id ($n of $($missing.Count))..."
        & $gen --input $data --output $data --silent $id | Out-Null
    }
    $still = @($missing | Where-Object { -not (Test-Path (Join-Path $data ('mmaps\{0:D4}.mmap' -f $_))) })
    if ($still.Count) { Write-Host ("No pathing data could be built for map(s): " + ($still -join ', ') + ". Usually these maps have no ground to walk on.") -ForegroundColor Yellow }
    Set-Content $marker (Get-Date -Format s)
    Write-Host 'Bot pathing is complete.' -ForegroundColor Green
    return $true
}
$freeGb = [math]::Round((Get-PSDrive ($root.Substring(0, 1))).Free / 1GB)
if ($mm -eq 0 -and -not (Test-Path (Join-Path $root 'server\data\maps')) -and $freeGb -lt 50) {
    Write-Host "Not enough free space: about 50 GB are needed while the data is built (most of it is removed again at the end) and this drive has $freeGb GB free. Free some space, then start again." -ForegroundColor Red
    return $false
}
Write-Host 'This takes about 10 to 20 minutes on a modern PC (longer on an older one). Leave the computer running. To stop, close this window; starting again continues where it stopped.' -ForegroundColor Yellow
try { & (Join-Path $PSScriptRoot 'extract-data.ps1') -Client $Client | Out-Host } catch { Write-Host "The game data step stopped: $($_.Exception.Message)" -ForegroundColor Red }
if (Test-Path $marker) { Write-Host 'Bot pathing is installed.' -ForegroundColor Green; return $true }
Write-Host 'The game data is not finished yet. Start again to continue.' -ForegroundColor Red
return $false
