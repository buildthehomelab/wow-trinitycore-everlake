# Raid sweep for Zul'Gurub: by default all nine ZG bosses in raid order (Arlokk is summoned at the gong's spot, Gahz'ranka by the
# Mudskunk Lure's event) and two Molten Core regression checks of the shared fight-script code. -Runs overrides the list.
# Run from the TrinityCore checkout's scripts\ folder with the realm up, SOAP on, and NOBODY logged in:
#   powershell -ExecutionPolicy Bypass -File <path>\sweep-zg.ps1 [-Out <folder>] [-Runs name1,name2,...]
# Each run's new Playerbot.log and Scenario.log lines are saved as <n>-<scenario>-Playerbot.log / -Scenario.log, plus summary.txt.
# Read-only for the server: it only sends `playerbot scenario run/status/result/abort` over SOAP (run-scenario.ps1).
param([string]$Out = 'C:\Users\chris\wow forever\sweep-zg',
      [string[]]$Runs = @('zg_jeklik', 'zg_venoxis', 'zg_marli', 'zg_mandokir', 'zg_thekal', 'zg_arlokk', 'zg_jindo', 'zg_gahzranka',
                          'zg_hakkar', 'mc_lucifron', 'mc_geddon'))
. "$PSScriptRoot\common.ps1"
$logs = Join-Path $root "$installFolder\logs"
New-Item -ItemType Directory -Force -Path $Out | Out-Null

$runs = $Runs

function Size([string]$f) { if (Test-Path $f) { (Get-Item $f).Length } else { 0 } }
function Tail-Since([string]$f, [long]$from, [string]$dest) {
    if (-not (Test-Path $f)) { return }
    $len = (Get-Item $f).Length
    if ($from -gt $len) { $from = 0 }   # rotated: take the whole file
    $s = [IO.File]::Open($f, 'Open', 'Read', 'ReadWrite')
    try { $s.Seek($from, 'Begin') | Out-Null; $o = [IO.File]::Create($dest); try { $s.CopyTo($o) } finally { $o.Close() } } finally { $s.Close() }
}

$i = 0
foreach ($name in $runs) {
    $i++
    $tag = '{0:D2}-{1}' -f $i, $name
    $pb = Join-Path $logs 'Playerbot.log'; $sc = Join-Path $logs 'Scenario.log'
    $pb0 = Size $pb; $sc0 = Size $sc
    $t0 = Get-Date
    & "$PSScriptRoot\run-scenario.ps1" -Name $name -WaitMinutes 40 | Tee-Object -FilePath (Join-Path $Out "$tag-console.txt")
    $code = $LASTEXITCODE
    Tail-Since $pb $pb0 (Join-Path $Out "$tag-Playerbot.log")
    Tail-Since $sc $sc0 (Join-Path $Out "$tag-Scenario.log")
    $verdict = switch ($code) { 0 { 'PASS' } 1 { 'FAIL' } 2 { 'NOT STARTED' } default { 'ABORTED' } }
    $line = '{0} {1} {2} {3:N0} min' -f (Get-Date -Format 'HH:mm'), $tag, $verdict, ((Get-Date) - $t0).TotalMinutes
    Add-Content (Join-Path $Out 'summary.txt') $line
    Write-Host $line
    Start-Sleep 30   # let the squad leave and the instance settle before the next run
}
