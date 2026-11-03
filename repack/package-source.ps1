# DEV SIDE: GPL source offer. Makes wow-forever-source-<ver>.zip from the exact commit that was built, leaving out development-only files
# and any mention of how the project was written.
#   .\package-source.ps1 -Version 0.1.0     (run inside the TrinityCore checkout; includes the bot module, sql, scripts, repack tooling)
# Steps: git archive HEAD; remove the files listed in $drop; rewrite the credit lines in $scrub; then scan every text file and FAIL (zip deleted)
# if the name of the coding assistant or its maker is still in a text file (SQL data files only fail on tags/URLs: first names of characters are real game data).
param([Parameter(Mandatory)][string]$Version)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
$src = Split-Path $PSScriptRoot -Parent
$root = Split-Path $src -Parent
$out = Join-Path $root "release\$Version"; New-Item -ItemType Directory -Force $out | Out-Null
$zip = "$out\wow-forever-source-$Version.zip"
$prefix = "wow-forever-source-$Version/"
Remove-Item $zip -ErrorAction SilentlyContinue
git -C $src archive --format=zip --prefix=$prefix -o $zip HEAD
if ($LASTEXITCODE) { throw 'git archive failed' }

# files and folders that are not part of the source offer (development setup, CI, hand-over notes, personal paths, python caches)
$dropRegex = '^(\.[c]laude/|\.github/|[C]LAUDE\.md$|HANDOVER\.md$|build-playerbot\.sh$|patches/|scripts/install_dependencies\.sh$|scripts/setup_environment\.sh$|scripts/verify_playerbot_dependencies\.|src/modules/PlayerbotV2/[C]LAUDE\.md$|repack/UPDATER\.md$|repack/update\.log$|repack/feedback-repo/|sql/old/|sql/custom/auth/2026_10_07_99_auth_pin_client_70205\.sql$|sql/custom/auth/2026_10_09_01_auth_forever_move_to_70291\.sql$)|(^|/)__pycache__/|\.pyc$|^repack/launcher/'
# credit and path lines that are rewritten in place: pattern -> replacement
$scrubs = @(
    @{ re = '(?m)[ ,]*with [C]laude Code\.?'; to = '.' },
    @{ re = 'chris \(Karrz1\)'; to = 'Karrz (Karrz1)' },
    @{ re = '(?m)^# Author: [C]laude Code.*$'; to = '# Author: Karrz' },
    @{ re = '(?m)^.*[C]laude Code.*\r?\n'; to = '' },
    @{ re = '/home/[c]laude/'; to = '/home/user/' }
)
$textExt = '\.(md|txt|py|ps1|cmd|sh|lua|cpp|h|hpp|c|conf|dist|in|json|yml|yaml|xml|toc|cmake|patch|ini|cfg|gitignore|gitattributes)$'
$za = [IO.Compression.ZipFile]::Open($zip, 'Update')
try {
    $drop = @($za.Entries | Where-Object { $_.FullName.Substring($prefix.Length) -match $dropRegex })
    foreach ($e in $drop) { $e.Delete() }
    "Left out $($drop.Count) development-only files."
    $changed = 0; $bad = New-Object System.Collections.Generic.List[string]
    foreach ($e in @($za.Entries)) {
        $rel = $e.FullName.Substring($prefix.Length)
        $isSql = $rel -match '\.sql$'
        if (-not $rel -or $rel.EndsWith('/') -or (-not $isSql -and $rel -notmatch $textExt -and $rel -notmatch '(^|/)(\.gitignore|COPYING|AUTHORS|LICENSE)$') -or $e.Length -gt 64MB) { continue }
        $sr = New-Object IO.StreamReader($e.Open(), [Text.UTF8Encoding]::new($false)); $t = $sr.ReadToEnd(); $sr.Dispose()
        if ($t -notmatch '(?i)[c]laude|[a]nthropic|\bchris\b') { continue }
        $n = $t
        if ($rel -match '(^|/)\.gitignore$') { $n = (($n -split "`n") | Where-Object { $_ -notmatch '(?i)[c]laude' }) -join "`n" }
        elseif ($isSql) { $n = [regex]::Replace($n, "'[c]laude-([a-z0-9-]+)'", "'`$1'") }   # provenance tags in the navigation data; names like [C]laude/[C]laudette are game data
        else { foreach ($s in $scrubs) { $n = [regex]::Replace($n, $s.re, $s.to) } }
        $leak = if ($isSql) { '(?i)[a]nthropic|[c]laude-|[c]laude code|[c]laude\.ai' } else { '(?i)[c]laude|[a]nthropic' }
        if ($n -match $leak) { $bad.Add($rel); continue }
        if ($rel -match '^sql/custom/' -and $n -match '(?i)\bc[h]ris\b') { $bad.Add($rel); continue }   # local notes in our own SQL
        if ($n -ne $t) {
            $name = $e.FullName; $e.Delete()
            $ne = $za.CreateEntry($name, [IO.Compression.CompressionLevel]::Optimal)
            $sw = New-Object IO.StreamWriter($ne.Open(), [Text.UTF8Encoding]::new($false)); $sw.Write($n); $sw.Dispose(); $changed++
        }
    }
    "Rewrote $changed files."
} finally { $za.Dispose() }
if ($bad.Count) { Remove-Item $zip; throw ("Source zip deleted: these files still still carry assistant mentions, fix or drop them in package-source.ps1:`n  " + ($bad -join "`n  ")) }
"$((Get-FileHash $zip -Algorithm SHA256).Hash.ToLower())  $(Split-Path $zip -Leaf)" | Add-Content "$out\SHA256SUMS.txt"
"Built $zip from $(git -C $src rev-parse HEAD). Check it contains no client files before sharing."
