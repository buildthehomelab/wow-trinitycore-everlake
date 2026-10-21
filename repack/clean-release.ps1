# DEV SIDE (Karrz's PC, gh logged in as Karrz1): takes the assistant-tool mentions out of already published release zips and uploads the
# cleaned files over the old ones (same file names). Release titles and notes are not touched; drafts are skipped; nothing is deleted.
#   .\clean-release.ps1                       -> downloads, cleans, checks; writes to release\clean-<tag>\  (nothing is uploaded)
#   .\clean-release.ps1 -Upload               -> the same, then replaces the assets (gh release upload --clobber) and SHA256SUMS.txt
#   .\clean-release.ps1 -Tags v0.1.5 -Upload
# Rules: source zips lose the development-only files (CI, hand-over notes, setup scripts, python caches); credit lines are rewritten;
# every text file is then checked and the run STOPS (nothing uploaded) if one still carries a mention. Windows PowerShell 5.1.
param([string[]]$Tags = @('v0.1.5', 'v0.1.4', 'v0.1.0'), [switch]$Upload, [string]$Repo = 'Karrz1/Karrz-playerbots-wow-forever')
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
$root = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$dropRegex = '^[^/\\]+[/\\](\.[c]laude[/\\]|\.github[/\\]|[C]LAUDE\.md$|HANDOVER\.md$|build-playerbot\.sh$|patches[/\\]|scripts[/\\]install_dependencies\.sh$|scripts[/\\]setup_environment\.sh$|scripts[/\\]verify_playerbot_dependencies\.|src[/\\]modules[/\\]PlayerbotV2[/\\][C]LAUDE\.md$|repack[/\\]UPDATER\.md$|repack[/\\]update\.log$|repack[/\\]feedback-repo[/\\])|(^|[/\\])__pycache__[/\\]|\.pyc$'
$scrubs = @(
    @{ re = '(?m)[ ,]*with [C]laude Code\.?'; to = '.' },
    @{ re = 'chris \(Karrz1\)'; to = 'Karrz (Karrz1)' },
    @{ re = '(?m)^# Author: [C]laude Code.*$'; to = '# Author: Karrz' },
    @{ re = '(?m)^.*[C]laude Code.*\r?\n'; to = '' },
    @{ re = '/home/[c]laude/'; to = '/home/user/' }
)
$textExt = '\.(md|txt|py|ps1|cmd|sh|lua|cpp|h|hpp|c|conf|dist|in|json|yml|yaml|xml|toc|cmake|patch|ini|cfg|sql)$|(^|[/\\])(\.gitignore|COPYING|AUTHORS|LICENSE)$'
$leak = '(?i)[c]laude|[a]nthropic'
$leakSql = '(?i)[a]nthropic|[c]laude-|[c]laude code|[c]laude\.ai'

function Clean-Zip($zip, $kind) {
    $za = [IO.Compression.ZipFile]::Open($zip, 'Update'); $bad = New-Object System.Collections.Generic.List[string]; $changed = 0
    try {
        if ($kind -eq 'source') {
            $drop = @($za.Entries | Where-Object { $_.FullName -match $dropRegex }); foreach ($e in $drop) { $e.Delete() }
            "  left out $($drop.Count) development-only files"
        } else {
            foreach ($e in @($za.Entries | Where-Object { $_.FullName -match '(^|[/\\])update\.log$' })) { $e.Delete() }
        }
        foreach ($e in @($za.Entries)) {
            $n = $e.FullName; $sql = $n -match '\.sql$'
            if ($n -match '\.exe$' -and $e.Length -lt 400MB) {
                # the build banner inside the programs carries the branch name; replaced by a text of the same length
                $lat = [Text.Encoding]::GetEncoding(28591)
                $ms = New-Object IO.MemoryStream; $st = $e.Open(); $st.CopyTo($ms); $st.Dispose(); $bytes = $ms.ToArray()
                $txt = $lat.GetString($bytes)
                if ($txt -match $leak) {
                    $txt = [regex]::Replace($txt, '(?i)[c]laude', 'karrz1')
                    $e.Delete(); $ne = $za.CreateEntry($n, [IO.Compression.CompressionLevel]::Optimal)
                    $os = $ne.Open(); $nb = $lat.GetBytes($txt); $os.Write($nb, 0, $nb.Length); $os.Dispose(); $changed++
                }
                continue
            }
            if ($n.EndsWith('/') -or $n.EndsWith('\') -or $n -notmatch $textExt -or $n -match '^(mysql|tools)[/\\]' -or $e.Length -gt 400MB) { continue }
            $sr = New-Object IO.StreamReader($e.Open(), (New-Object Text.UTF8Encoding($false))); $t = $sr.ReadToEnd(); $sr.Dispose()
            $hit = ($t -match $leak) -or ($kind -ne 'plain' -and $t -match 'chris \(Karrz1\)')
            if (-not $hit) { continue }
            $new = $t
            if ($n -match '(^|[/\\])\.gitignore$') { $new = (($new -split "`n") | Where-Object { $_ -notmatch '(?i)[c]laude' }) -join "`n" }
            elseif ($sql) { $new = [regex]::Replace($new, "'[c]laude-([a-z0-9-]+)'", "'`$1'") }
            else { foreach ($s in $scrubs) { $new = [regex]::Replace($new, $s.re, $s.to) } }
            if ($new -match $(if ($sql) { $leakSql } else { $leak })) { $bad.Add($n); continue }
            if ($new -ne $t) {
                $e.Delete(); $ne = $za.CreateEntry($n, [IO.Compression.CompressionLevel]::Optimal)
                $sw = New-Object IO.StreamWriter($ne.Open(), (New-Object Text.UTF8Encoding($false))); $sw.Write($new); $sw.Dispose(); $changed++
            }
        }
    } finally { $za.Dispose() }
    "  rewrote $changed files"
    if ($bad.Count) { throw ("still carries a mention, nothing uploaded:`n  " + ($bad -join "`n  ")) }
}

foreach ($tag in $Tags) {
    $rel = gh release view $tag -R $Repo --json isDraft,assets | ConvertFrom-Json
    if ($rel.isDraft) { "== $tag is a draft: skipped"; continue }
    "== $tag"
    $dir = Join-Path $root "release\clean-$tag"; Remove-Item $dir -Recurse -Force -ErrorAction SilentlyContinue; New-Item -ItemType Directory -Force $dir | Out-Null
    gh release download $tag -R $Repo -D $dir
    if ($LASTEXITCODE) { throw "download of $tag failed" }
    $sums = @{}; $sumFile = Join-Path $dir 'SHA256SUMS.txt'
    if (Test-Path $sumFile) { foreach ($l in Get-Content $sumFile) { if ($l -match '^([0-9a-fA-F]{64})\s+(.+)$') { $sums[$Matches[2].Trim()] = $Matches[1].ToLower() } } }
    $done = @()
    foreach ($z in Get-ChildItem $dir -Filter *.zip) {
        $kind = if ($z.Name -like '*source*') { 'source' } elseif ($z.Name -like 'wow-forever-core*' -or $z.Name -like 'wow-forever-db*') { 'plain' } else { 'repack' }
        "- $($z.Name) ($kind)"
        $before = (Get-FileHash $z.FullName -Algorithm SHA256).Hash.ToLower()
        Clean-Zip $z.FullName $kind
        $after = (Get-FileHash $z.FullName -Algorithm SHA256).Hash.ToLower()
        if ($after -ne $before) { $sums[$z.Name] = $after; $done += $z.FullName } else { "  unchanged" }
    }
    ($sums.GetEnumerator() | Sort-Object Name | ForEach-Object { "$($_.Value)  $($_.Name)" }) | Set-Content $sumFile -Encoding ascii
    if ($Upload -and $done.Count) {
        gh release upload $tag @($done + $sumFile) -R $Repo --clobber
        if ($LASTEXITCODE) { throw "upload to $tag failed" }
        "  uploaded $($done.Count) files and SHA256SUMS.txt"
    } else { "  cleaned files are in $dir (not uploaded)" }
}
