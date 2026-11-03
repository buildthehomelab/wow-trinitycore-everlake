# Dot-sourced by the start scripts and by Check-Config.cmd. Reads the server's settings files the way the server does
# (worldserver.conf, then every .conf in worldserver.conf.d by name, the same for bnetserver) and says, with the file and the
# line number, what would stop the server or what it would quietly ignore:
#  - the same setting twice in one file: the server prints "duplicate key name" in its own window, which closes at once, and
#    does not start. Settings files are read with the boost ini reader; this follows its rules line by line.
#  - a line that is not a setting, a comment or a [section] (the server stops there too), a [section] twice in one file
#  - settings above the first [section] line, or below a second [section]: the server reads only the first section of a file
#  - a setting set in more than one file: not an error, the file read last wins; listed so you can see which value is used
# The full list goes to server\logs\config-check.txt (Bug-Report.cmd adds it to the zip).

# the characters the boost reader trims around a line, a key and a value
$script:CfgTrim = [char[]]@(' ', "`t", "`n", "`r", [char]11, [char]12)

# the files in the order the server reads them: the main file, then the folder (and its subfolders) by name
function Get-ServerConfFiles([string]$ServerDir, [string]$Name) {
    $files = New-Object System.Collections.Generic.List[string]
    $main = Join-Path $ServerDir "$Name.conf"
    if (Test-Path $main -PathType Leaf) { $files.Add($main) }
    $walk = {
        param($dir)
        # NTFS lists a folder in upper-case ordinal order, which is the order the server gets them in
        $entries = @(Get-ChildItem -LiteralPath $dir -Force -ErrorAction SilentlyContinue)
        $names = [string[]]@($entries | ForEach-Object Name)
        [Array]::Sort($names, $entries, [StringComparer]::OrdinalIgnoreCase)
        foreach ($e in $entries) {
            if ($e.PSIsContainer) { & $walk $e.FullName }
            elseif ($e.Extension -eq '.conf') { $files.Add($e.FullName) }
        }
    }
    $dir = Join-Path $ServerDir "$Name.conf.d"
    if (Test-Path $dir -PathType Container) { & $walk $dir }
    return ,$files
}

# One file, read like the server reads it. Returns the settings the server takes from it (in the first section only) and
# every problem with its line number. Unlike the server it does not stop at the first problem, so all of them can be fixed at once.
function Read-ServerConfFile([string]$Path) {
    $r = [pscustomobject]@{ Path = $Path; Settings = New-Object System.Collections.Generic.List[object]; Errors = New-Object System.Collections.Generic.List[string]; Warnings = New-Object System.Collections.Generic.List[string] }
    try { $bytes = [IO.File]::ReadAllBytes($Path) } catch { $r.Errors.Add("$Path : could not be read ($($_.Exception.Message))"); return $r }
    $bom = $bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF
    $lines = [Text.Encoding]::UTF8.GetString($bytes) -split "`n"
    # the top level of the file: [section] names and any key above the first section share one list, as in the boost reader
    $top = New-Object 'System.Collections.Generic.Dictionary[string,object]' ([StringComparer]::Ordinal)
    $order = New-Object System.Collections.Generic.List[string]
    $section = $null
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $n = $i + 1
        $t = $lines[$i].Trim($script:CfgTrim)
        $shown = $t.Replace([string][char]0xFEFF, '')
        if ($t.Length -eq 0 -or $t[0] -eq ';' -or $t[0] -eq '#') { continue }
        $where = "$Path line $n"
        $hint = if ($n -eq 1 -and $bom) { ' The file starts with an invisible UTF-8 mark (BOM): save it again as "UTF-8" without BOM, or as ANSI, in Notepad.' } else { '' }
        if ($t[0] -eq '[') {
            if ($section -and $section.Keys.Count -eq 0) { $null = $top.Remove($section.Name); $order.Remove($section.Name) | Out-Null }
            $end = $t.IndexOf(']')
            if ($end -lt 0) { $r.Errors.Add("${where}: '$shown' has a [ without a closing ]. The server stops at this line."); continue }
            $sn = $t.Substring(1, $end - 1).Trim($script:CfgTrim)
            if ($top.ContainsKey($sn)) {
                $r.Errors.Add("${where}: [$sn] is already on line $($top[$sn].Line) of the same file. The server stops at this line. Delete this [$sn] line (keep the settings under it).")
                continue
            }
            $section = [pscustomobject]@{ Name = $sn; Line = $n; Keys = New-Object 'System.Collections.Generic.Dictionary[string,object]' ([StringComparer]::Ordinal) }
            $top[$sn] = $section; $order.Add($sn)
            continue
        }
        $eq = $t.IndexOf('=')
        if ($eq -lt 0) { $r.Errors.Add("${where}: '$shown' is not a setting (Name = value), a comment (# at the start) or a [section]. The server stops at this line.$hint"); continue }
        if ($eq -eq 0) { $r.Errors.Add("${where}: '$shown' has no setting name before the =. The server stops at this line."); continue }
        $key = $t.Substring(0, $eq).Trim($script:CfgTrim)
        $val = $t.Substring($eq + 1).Trim($script:CfgTrim)
        $s = [pscustomobject]@{ Key = $key; Value = $val; Line = $n; Path = $Path; Text = $t }
        if ($section) {
            if ($section.Keys.ContainsKey($key)) {
                $first = $section.Keys[$key]
                $r.Errors.Add("${where}: $key is set twice in this file, first on line $($first.Line) ($($first.Text)) and again here ($t). The server stops with ""duplicate key name"" and does not start. Delete one of the two lines.")
                continue
            }
            $section.Keys[$key] = $s
        } else {
            if ($top.ContainsKey($key)) {
                $r.Errors.Add("${where}: $key is set twice in this file, first on line $($top[$key].Line). The server stops with ""duplicate key name"" and does not start. Delete one of the two lines.")
                continue
            }
            $top[$key] = [pscustomobject]@{ Name = $key; Line = $n; Keys = $null }; $order.Add($key)
            if ($n -eq 1 -and $bom) { $r.Warnings.Add("${where}: the file starts with an invisible UTF-8 mark (BOM), so the server does not see the first line as written. Save it again as ""UTF-8"" without BOM, or as ANSI, in Notepad.") }
        }
    }
    if ($section -and $section.Keys.Count -eq 0) { $null = $top.Remove($section.Name); $order.Remove($section.Name) | Out-Null }
    if ($r.Errors.Count) { return $r }   # the server stops on the first of them; what it would ignore matters once they are fixed
    if ($order.Count -eq 0) {
        $r.Errors.Add("${Path}: has no settings in it. The server stops with ""empty file"".")
        return $r
    }
    # the server keeps only the first entry of the file: normally the [worldserver] (or [bnetserver]) section
    $firstEntry = $top[$order[0]]
    if ($null -eq $firstEntry.Keys) {
        $loose = @($order | Where-Object { $null -eq $top[$_].Keys } | ForEach-Object { $top[$_].Line })
        $r.Warnings.Add("${Path} line $($firstEntry.Line): a setting comes before the first [section] line, so the server ignores EVERY setting in this file. Put [worldserver] (or [bnetserver]) on the first line. Lines affected: $($loose -join ', ').")
        return $r
    }
    foreach ($s in $firstEntry.Keys.Values) { $r.Settings.Add($s) }
    foreach ($other in @($order | Select-Object -Skip 1)) {
        $o = $top[$other]
        if ($null -eq $o.Keys) { $r.Warnings.Add("${Path} line $($o.Line): $other is outside the first section; the server ignores it.") }
        else { $r.Warnings.Add("${Path} line $($o.Line): a second section [$other] with $($o.Keys.Count) setting(s) under it. The server reads only the first section of a file ([$($firstEntry.Name)] on line $($firstEntry.Line)), so the settings under [$other] are ignored. Delete the [$other] line so they belong to the first section.") }
    }
    return $r
}

# Checks worldserver and bnetserver settings. Returns Ok (false when the server would refuse to start), Lines (what to show)
# and Report (the file with the full list). Never throws.
function Test-ServerConfig([string]$ServerDir, [string[]]$Names = @('worldserver', 'bnetserver'), [switch]$All) {
    $show = New-Object System.Collections.Generic.List[string]
    $full = New-Object System.Collections.Generic.List[string]
    $ok = $true
    $full.Add("Settings check, $(Get-Date -Format 's'). Files are read in this order; for a setting in more than one file the last one wins.")
    foreach ($name in $Names) {
        $files = Get-ServerConfFiles $ServerDir $name
        if ($files.Count -eq 0) { continue }
        $full.Add(''); $full.Add("== $name"); foreach ($f in $files) { $full.Add("   read: $f") }
        # setting -> every place it is set, in reading order. Exact spelling, as the server compares names
        $where = New-Object System.Collections.Hashtable ([StringComparer]::Ordinal)
        $spell = @{}          # setting in lower case -> the spellings used
        foreach ($f in $files) {
            $r = Read-ServerConfFile $f
            foreach ($e in $r.Errors) { $ok = $false; $show.Add("PROBLEM: $e"); $full.Add("PROBLEM: $e") }
            foreach ($w in $r.Warnings) { $show.Add("WARNING: $w"); $full.Add("WARNING: $w") }
            foreach ($s in $r.Settings) {
                if (-not $where.ContainsKey($s.Key)) { $where[$s.Key] = New-Object System.Collections.Generic.List[object] }
                $where[$s.Key].Add($s)
                $lk = $s.Key.ToLowerInvariant()
                if (-not $spell.ContainsKey($lk)) { $spell[$lk] = New-Object System.Collections.Generic.List[string] }
                if (-not $spell[$lk].Contains($s.Key)) { $spell[$lk].Add($s.Key) }
            }
        }
        foreach ($lk in @($spell.Keys | Sort-Object)) {
            if ($spell[$lk].Count -lt 2) { continue }
            $at = @($spell[$lk] | ForEach-Object { $k = $_; $where[$k] | ForEach-Object { "$k in $($_.Path) line $($_.Line)" } })
            $m = "WARNING: the same setting is spelled in different ways: $($at -join '; '). The server only reads the exact spelling it expects (the one in $name.conf), so the other spelling does nothing."
            $show.Add($m); $full.Add($m)
        }
        $multi = @($where.Keys | Where-Object { $where[$_].Count -gt 1 } | Sort-Object)
        # worldserver.conf and the two files every update replaces set many of the same settings on purpose; a file of the
        # player's own (zz-9-local.conf, or any other they added) is what can surprise: its value not used, or two of them fighting
        $ours = @("$name.conf", 'zz-0-playerbot-defaults.conf', 'zz-1-wow-forever-realm.conf')
        $own = { param($e) $ours -notcontains (Split-Path $e.Path -Leaf) }
        $surprise = @($multi | Where-Object {
            $list = $where[$_]; $mine = @($list | Where-Object { & $own $_ })
            ($mine.Count -ge 1 -and -not (& $own $list[$list.Count - 1])) -or $mine.Count -ge 2 })
        if ($multi.Count) {
            $full.Add(''); $full.Add("$($multi.Count) $name settings are set in more than one file (the last one is used):")
            foreach ($k in $multi) {
                $list = $where[$k]
                $full.Add("  $k")
                for ($j = 0; $j -lt $list.Count; $j++) {
                    $mark = if ($j -eq $list.Count - 1) { 'USED   ' } else { 'ignored' }
                    $full.Add("     $mark $($list[$j].Path) line $($list[$j].Line): $($list[$j].Value)")
                }
            }
        }
        # shown: the surprising ones (every one with -All); the full list is in the report
        $tell = if ($All) { $multi } else { $surprise }
        foreach ($k in ($tell | Select-Object -First 20)) {
            $list = $where[$k]; $last = $list[$list.Count - 1]
            $others = @($list | Select-Object -First ($list.Count - 1) | ForEach-Object { "$(Split-Path $_.Path -Leaf) line $($_.Line) = $($_.Value)" })
            $why = if (-not (& $own $last)) { " A file read later wins (by name: a file named zz-9-... is read after zz-1-...), so your own value is not used; put it in zz-9-local.conf." } else { '' }
            $show.Add("NOTE: $k is set in $($list.Count) files. Used: $($last.Value) from $($last.Path) line $($last.Line). Not used: $($others -join '; ').$why")
        }
        if ($tell.Count -gt 20) { $show.Add("NOTE: $($tell.Count - 20) more settings are set in more than one file; see the full list.") }
    }
    $report = Join-Path (Join-Path $ServerDir 'logs') 'config-check.txt'
    try { New-Item -ItemType Directory -Force (Split-Path $report) | Out-Null; [IO.File]::WriteAllLines($report, $full) } catch { $report = $null }
    if ($report -and ($show.Count -or -not $ok)) { $show.Add("Full list of every settings file and which value is used: $report") }
    return [pscustomobject]@{ Ok = $ok; Lines = $show; Report = $report }
}
