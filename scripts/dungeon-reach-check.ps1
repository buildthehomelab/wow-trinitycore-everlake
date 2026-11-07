# Offline dungeon reach check: can the bots walk every dungeon and raid they run, entrance to boss and boss to boss, on the navmesh?
# READ ONLY: one SELECT on the world database (the boss spawns), then dungeon_reach_check.exe reads the server's mmaps. It does not
# stop, start or touch the realm, and it is safe while someone plays.
# Run after a build (the tool comes from the server folder, else from build\bin\RelWithDebInfo):
#   powershell -ExecutionPolicy Bypass -File <path>\dungeon-reach-check.ps1 [-Out <folder>] [-Map 2999]
# Writes into -Out: spawns.tsv (the boss spawns), reach-list.txt (what is walked), reach-report.txt (the result, islands included).
# Exit code: 0 every boss reached, 1 at least one cannot be reached, 2 something missing (tool, python, mmaps).
param([string]$Out = '',
      [string]$Server = '',
      [int[]]$Map = @())
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\common.ps1"
if (-not $Server) { $Server = Join-Path $root $installFolder }
if (-not $Out) { $Out = Join-Path $root ('reports\dungeon-reach-' + (Get-Date -Format 'yyyyMMdd-HHmm')) }
New-Item -ItemType Directory -Force -Path $Out | Out-Null
$mysqlBin = 'C:\local\mysql-8.4.11\bin'

# The tool: next to worldserver.exe when installed, else straight from the build (a tree configured with TOOLS on).
$tool = @((Join-Path $Server 'dungeon_reach_check.exe'),
          (Join-Path $root 'build\bin\RelWithDebInfo\dungeon_reach_check.exe')) | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $tool) { Write-Host 'dungeon_reach_check.exe not found (build with TOOLS on: cmake build -DTOOLS=1, then build-server.ps1)'; exit 2 }
$py = Get-Command python -ErrorAction SilentlyContinue
if (-not $py) { $py = Get-Command py -ErrorAction SilentlyContinue }
if (-not $py) { Write-Host 'Python not found.'; exit 2 }

# The world database and the data folder the server itself uses.
$conf = Join-Path $Server 'worldserver.conf'
$dbLine = (Select-String $conf -Pattern '^\s*WorldDatabaseInfo\s*=\s*"([^"]+)"' | Select-Object -First 1).Matches[0].Groups[1].Value
$db = $dbLine.Split(';')   # host;port;user;password;database
$dataDir = (Select-String $conf -Pattern '^\s*DataDir\s*=\s*"([^"]+)"' | Select-Object -First 1).Matches[0].Groups[1].Value
$mmaps = Join-Path $dataDir 'mmaps'
if (-not (Test-Path $mmaps)) { Write-Host "missing $mmaps"; exit 2 }
Write-Host "world database $($db[4]) on $($db[0]):$($db[1]); mmaps $mmaps"

# Every creature spawn on the dungeon and raid maps, oldest row first (the list maker takes a boss's first spawn).
$maps = '33,34,36,43,47,48,70,90,109,129,189,209,229,230,249,289,309,329,349,389,409,429,469,509,531,533,2999,3065'
$spawns = Join-Path $Out 'spawns.tsv'
$env:MYSQL_PWD = $db[3]
try {
    $rows = & "$mysqlBin\mysql.exe" "--host=$($db[0])" "--port=$($db[1])" "--user=$($db[2])" --batch --skip-column-names $db[4] `
        -e "SELECT id, map, position_x, position_y, position_z FROM creature WHERE map IN ($maps) ORDER BY guid"
    if ($LASTEXITCODE -ne 0) { throw "mysql failed (exit $LASTEXITCODE)" }
} finally { Remove-Item Env:\MYSQL_PWD -ErrorAction SilentlyContinue }
[IO.File]::WriteAllLines($spawns, [string[]]$rows)
Write-Host "$(@($rows).Count) spawns -> $spawns"

$list = Join-Path $Out 'reach-list.txt'
$maker = Join-Path $repoRoot 'src\tools\dungeon_reach_check\make_reach_list.py'
$makerArgs = @('-I', $maker, '--spawns', $spawns)
foreach ($m in $Map) { $makerArgs += @('--map', "$m") }
$text = & $py.Source @makerArgs
if ($LASTEXITCODE -ne 0) { Write-Host 'make_reach_list.py failed'; exit 2 }
[IO.File]::WriteAllLines($list, [string[]]$text)

$report = Join-Path $Out 'reach-report.txt'
$toolArgs = @($mmaps, $list, '--islands')
foreach ($m in $Map) { $toolArgs += @('--map', "$m") }
$ErrorActionPreference = 'Continue'   # the tool's error lines go to stderr; Windows PowerShell would stop on them
& $tool @toolArgs 2>&1 | ForEach-Object { "$_" } | Out-File -Encoding utf8 $report
$code = $LASTEXITCODE
Select-String $report -Pattern '^(FAIL|WARN)|^SUMMARY' | ForEach-Object { $_.Line }
Write-Host "report: $report"
exit $code
