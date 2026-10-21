# Collects what we need to diagnose a bug into one zip on your Desktop. Usernames and IP addresses are masked.
$root = Split-Path $PSScriptRoot -Parent
$stage = Join-Path $env:TEMP 'wf-bundle'; Remove-Item $stage -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force $stage | Out-Null
function Scrub($path, $out) {
    if (-not (Test-Path $path)) { return }
    Get-Content $path -Tail 20000 | ForEach-Object {
        $_ -replace '\b\d{1,3}(\.\d{1,3}){3}\b', 'x.x.x.x' -replace '(?i)(password|pass|secret|key)\s*=\s*"?[^"\r\n]+"?', '$1 = <removed>'
    } | Set-Content $out
}
Scrub "$root\server\logs\Server.log" "$stage\Server.log"
Scrub "$root\server\logs\Playerbot.log" "$stage\Playerbot.log"
Scrub "$root\server\logs\Errors.log" "$stage\Errors.log"
Copy-Item "$root\version.json" $stage -ErrorAction SilentlyContinue
foreach ($c in 'worldserver.conf', 'playerbot.conf') { Scrub "$root\server\$c" "$stage\$c" }
(Get-Content "$stage\worldserver.conf" -ErrorAction SilentlyContinue) | Where-Object { $_ -notmatch 'DatabaseInfo' } | Set-Content "$stage\worldserver.conf"
$crash = Get-ChildItem -Path (Join-Path $root 'client-errors') -ErrorAction SilentlyContinue   # optional: tester copies WoW\Errors here
if ($crash) { Copy-Item $crash.FullName $stage -ErrorAction SilentlyContinue }
@"
Windows: $([Environment]::OSVersion.VersionString)
CPUs: $([Environment]::ProcessorCount)
"@ | Set-Content "$stage\system.txt"
$zip = Join-Path ([Environment]::GetFolderPath('Desktop')) ("wf-bugbundle-{0:yyyyMMdd-HHmm}.zip" -f (Get-Date))
Compress-Archive "$stage\*" $zip -Force
"Created $zip : attach it to your GitHub issue. Read it first if you like; names and IPs are masked but check it."
