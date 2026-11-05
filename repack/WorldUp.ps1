# Dot-sourced by the start scripts. True when the worldserver started at $Since printed "World initialized" in Server.log or in a
# rotated copy of it (Server.log is cut at 100 MB; the line then sits in the older file). Files older than $Since are ignored.
function Test-WorldInitialized([string]$LogDir, [datetime]$Since) {
    $files = @(Get-ChildItem -Path (Join-Path $LogDir 'Server.log*') -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -ge $Since })
    foreach ($f in $files) {
        try { if (Select-String -Path $f.FullName -Pattern 'World initialized' -Quiet) { return $true } } catch { }
    }
    return $false
}

# A settings file in worldserver.conf.d with no setting in it (only [worldserver] and comments, as the 0.1.15 updater and menu S
# wrote zz-9-local.conf) is an "empty file" to the server of 0.1.15, which then closes at once. It is renamed to <name>.empty, which
# the server does not read; nothing in it is lost. Run before every worldserver start.
function Repair-ConfDir([string]$ServerDir) {
    foreach ($cf in Get-ChildItem (Join-Path $ServerDir 'worldserver.conf.d') -Filter '*.conf' -File -ErrorAction SilentlyContinue) {
        $settings = @(Get-Content $cf.FullName -ErrorAction SilentlyContinue | Where-Object { $_ -match '^\s*[^#;\[\s][^=]*=' })
        if (-not $settings.Count) { Move-Item $cf.FullName "$($cf.FullName).empty" -Force; "Set aside $($cf.Name): it had no settings in it (now $($cf.Name).empty)." }
    }
}

# The worldserver refuses to start when a setting is twice in one file of worldserver.conf.d (a setting in two different files is
# fine, the later file wins). All it says is "duplicate key name" and the window closes. Returns one line per repeated setting
# naming the file and the line numbers, so a player can delete the extra line.
function Test-ConfDuplicates([string]$ServerDir) {
    $out = @()
    foreach ($cf in Get-ChildItem (Join-Path $ServerDir 'worldserver.conf.d') -Filter '*.conf' -File -ErrorAction SilentlyContinue | Sort-Object Name) {
        $n = 0; $seen = @{}
        foreach ($line in @(Get-Content $cf.FullName -ErrorAction SilentlyContinue)) {
            $n++
            if ($line -match '^\s*([^#;\[\s][^=\s]*)\s*=') {
                $k = $Matches[1].ToLowerInvariant()
                if ($seen.ContainsKey($k)) { $out += "The setting $($Matches[1]) is in $($cf.Name) on line $($seen[$k]) and again on line $n. Delete one of the two lines, then start the server again." }
                else { $seen[$k] = $n }
            }
        }
    }
    $out
}

# The network limits the 0.1.25 server reads (connections per address, the login timeouts and the Battle.net
# requests per second) are missing from the settings files of
# installs made before them, and the server logs a "Missing name ..." line for each one on every connection. The defaults are used
# anyway, so this changes nothing in how the server behaves: it writes the same values into the files, once, to end that log noise.
# Settings files are written without a byte order mark: the server does not read a file that starts with one.
function Sync-NetworkKeys([string]$ServerDir) {
    $want = @(
        @{ File = 'worldserver.conf'; Keys = [ordered]@{ 'Network.ConnectionsPerIp' = '16'; 'Network.AuthTimeout' = '60' } },
        @{ File = 'bnetserver.conf';  Keys = [ordered]@{ 'Network.ConnectionsPerIp' = '16'; 'Network.HandshakeTimeout' = '30'; 'Network.LoginTimeout' = '600'; 'Network.RequestsPerSecond' = '10' } })
    foreach ($w in $want) {
        try {
            $path = Join-Path $ServerDir $w.File
            if (-not (Test-Path $path)) { continue }
            $text = [IO.File]::ReadAllText($path)
            $add = ''
            foreach ($k in $w.Keys.Keys) {
                if ($text -notmatch ('(?m)^\s*' + [regex]::Escape($k) + '\s*=')) { $add += "$k = $($w.Keys[$k])`r`n" }
            }
            if (-not $add) { continue }
            if (-not $text.EndsWith("`n")) { $text += "`r`n" }
            [IO.File]::WriteAllText($path, $text + "`r`n# added by the updater: the defaults the server used anyway`r`n" + $add, (New-Object Text.UTF8Encoding $false))
        } catch { Write-Warning "Could not add the network settings to $($w.File): $($_.Exception.Message)" }
    }
}

# The template of the player's file, templates\zz-9-local.conf. Updates never copy *.conf files (players' settings), so an
# update could not bring a newer template and the start had nothing to add to zz-9-local.conf. Every package also carries it as
# templates\zz-9-local.template, which updates do copy: when that one differs, it is put back as the .conf here (the template
# only, never the player's own file). Returns the template to read.
function Get-LocalSettingsTemplate {
    $dir = Join-Path $PSScriptRoot 'templates'
    $conf = Join-Path $dir 'zz-9-local.conf'
    $new = Join-Path $dir 'zz-9-local.template'
    if (-not (Test-Path $new)) { return $conf }
    try {
        $bytes = [IO.File]::ReadAllBytes($new)
        $same = (Test-Path $conf) -and ([Convert]::ToBase64String($bytes) -eq [Convert]::ToBase64String([IO.File]::ReadAllBytes($conf)))
        if (-not $same) { [IO.File]::WriteAllBytes($conf, $bytes) }
        return $conf
    } catch { Write-Warning "Could not refresh templates\zz-9-local.conf: $($_.Exception.Message)"; return $new }
}

# The bot clothes setting (Bots.HolidayClothes: holiday hats on bots or not) came with 0.1.28. A player's own zz-9-local.conf
# from an older install does not have it, and updates never rewrite that file. So the block from templates\zz-9-local.conf is
# added to it once, above "Your own settings", with the server's own default (1, as before). A player's own line is kept.
function Sync-BotClothesSettings([string]$ServerDir) {
    try {
        $path = Join-Path (Join-Path $ServerDir 'worldserver.conf.d') 'zz-9-local.conf'
        $tpl = Get-LocalSettingsTemplate
        if (-not (Test-Path $path) -or -not (Test-Path $tpl)) { return }
        $lines = @(Get-Content $path)
        if ($lines | Where-Object { $_ -match '^\s*Bots\.HolidayClothes\s*=' }) { return }
        $block = @(); $in = $false
        foreach ($l in @(Get-Content $tpl)) {
            if ($l -match '^# ---- Bot clothes') { $in = $true }
            elseif ($in -and $l -match '^# ----') { break }
            if ($in) { $block += $l }
        }
        if (-not $block.Count) { return }
        $out = @(); $done = $false
        foreach ($l in $lines) {
            if (-not $done -and $l -match '^# ---- Your own settings') { $out += $block; $done = $true }
            $out += $l
        }
        if (-not $done) { $out += ''; $out += $block }
        Copy-Item $path "$path.bak" -Force
        [IO.File]::WriteAllText($path, (($out -join "`r`n") + "`r`n"), (New-Object Text.UTF8Encoding $false))
        'Added the bot clothes setting to zz-9-local.conf (holiday hats on, as before; old copy: zz-9-local.conf.bak).'
    } catch { Write-Warning "Could not add the bot clothes setting to zz-9-local.conf: $($_.Exception.Message)" }
}

# Hired NPC bots (Playerbot.Hire.Mode) are off by default from 0.1.30 (owner decision). 0.1.29 wrote "Playerbot.Hire.Mode = 1" into
# a new install's zz-9-local.conf, and updates never rewrite that file, so an updater would keep hired bots on. Once, at the first
# start after the update, an exact "Playerbot.Hire.Mode = 1" line is set to 0, with the marker line above it. A file that has the
# marker (0.1.30 installs have it from the template, and every file this has run on) is never changed again, so a player who sets 1
# afterwards keeps 1. A file with 0 or 2 keeps its value and only gets the marker. A file without the setting is left alone: Sync-
# LocalSettings adds it with its comment and the marker. Old copy: zz-9-local.conf.before-hire-off.bak.
function Set-HireModeOffOnce([string]$ServerDir) {
    try {
        $path = Join-Path (Join-Path $ServerDir 'worldserver.conf.d') 'zz-9-local.conf'
        if (-not (Test-Path $path)) { return }
        $marker = '# 0.1.30: hired NPC bots are off by default now. Set 1 to turn them back on.'
        $lines = @(Get-Content $path)
        if ($lines | Where-Object { $_ -match '^\s*#\s*0\.1\.30: hired NPC bots are off by default' }) { return }
        $at = @(); for ($i = 0; $i -lt $lines.Count; $i++) { if ($lines[$i] -match '^\s*Playerbot\.Hire\.Mode\s*=') { $at += $i } }
        if ($at.Count -ne 1) { return }
        $i = $at[0]
        $on = $lines[$i] -match '^\s*Playerbot\.Hire\.Mode\s*=\s*1\s*$'
        $out = @(); if ($i -gt 0) { $out += $lines[0..($i - 1)] }
        $out += $marker
        $out += $(if ($on) { 'Playerbot.Hire.Mode = 0' } else { $lines[$i] })
        if ($i + 1 -lt $lines.Count) { $out += $lines[($i + 1)..($lines.Count - 1)] }
        Copy-Item $path "$path.before-hire-off.bak" -Force
        [IO.File]::WriteAllText($path, (($out -join "`r`n") + "`r`n"), (New-Object Text.UTF8Encoding $false))
        if ($on) { 'Hired NPC bots are off by default from 0.1.30: Playerbot.Hire.Mode set to 0 in zz-9-local.conf, once (set 1 to turn them back on; old copy: zz-9-local.conf.before-hire-off.bak).' }
    } catch { Write-Warning "Could not update Playerbot.Hire.Mode in zz-9-local.conf: $($_.Exception.Message)" }
}

# The player's own zz-9-local.conf is written once and updates never rewrite it, so a file from an older install lacks the settings
# that came later (raids and dungeons, rates, travel, guilds, hired bots, bots on/off...). Before every start, each setting of
# templates\zz-9-local.conf that the file does not have yet is added once, with its comment, under its heading (the whole section
# above "Your own settings" when the heading is missing too). A setting counts as there when the file sets it or has it commented
# out ("# Name = ..."), so a line the player turned off is never added back, and no setting is ever put twice in the file (the
# server refuses to start on that). The value written is the one the server uses today (worldserver.conf, then our files in
# worldserver.conf.d in name order; template value when none sets it), so adding the lines changes nothing in the game.
# The launcher's bot lines (#BOTS#) are never touched. Old copy: zz-9-local.conf.bak.
function Sync-LocalSettings([string]$ServerDir) {
    Set-HireModeOffOnce $ServerDir
    try {
        $confD = Join-Path $ServerDir 'worldserver.conf.d'
        $path = Join-Path $confD 'zz-9-local.conf'
        $tpl = Get-LocalSettingsTemplate
        if (-not (Test-Path $path) -or -not (Test-Path $tpl)) { return }
        $keyRx = '^\s*([^#;\[\s][^=\s]*)\s*=\s*(.*?)\s*$'
        $lines = @(Get-Content $path)
        $have = @{}; $mineVal = @{}
        foreach ($l in $lines) {
            if ($l -match $keyRx) { $have[$Matches[1].ToLowerInvariant()] = $true; $mineVal[$Matches[1].ToLowerInvariant()] = $Matches[2] }
            elseif ($l -match '^\s*[#;]+\s*([A-Za-z][A-Za-z0-9_.]*)\s*=') { $have[$Matches[1].ToLowerInvariant()] = $true }
        }
        # what the server uses today without the player's file: worldserver.conf, then the other conf.d files by name (last wins)
        $now = @{}
        $files = @()
        if (Test-Path (Join-Path $ServerDir 'worldserver.conf')) { $files += (Join-Path $ServerDir 'worldserver.conf') }
        $files += @(Get-ChildItem $confD -Filter '*.conf' -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -ne 'zz-9-local.conf' } |
            Sort-Object Name | ForEach-Object { $_.FullName })
        foreach ($f in $files) {
            foreach ($l in @(Get-Content $f -ErrorAction SilentlyContinue)) { if ($l -match $keyRx) { $now[$Matches[1].ToLowerInvariant()] = $Matches[2] } }
        }
        # template: sections (heading line + body); in a body, comment lines belong to the setting lines right under them
        $sections = @(); $cur = $null
        foreach ($l in @(Get-Content $tpl)) {
            if ($l -match '^# ---- (.+?) -*\s*$') { $cur = @{ Name = $Matches[1].Trim(); Head = $l; Body = @() }; $sections += $cur; continue }
            if ($cur) { $cur.Body += $l }
        }
        # Instance.MoltenCoreRagnarosReady came out of Instance.MoltenCoreSkipRunes (which used to do both)
        $follows = @{ 'instance.moltencoreragnarosready' = 'instance.moltencoreskiprunes' }
        $added = @(); $out = [System.Collections.ArrayList]@($lines)
        foreach ($sec in $sections) {
            if ($sec.Name -eq 'Your own settings') { continue }
            $block = @(); $notes = @()
            foreach ($l in $sec.Body) {
                if ($l -eq '#BOTS#') { $notes = @(); continue }
                if ($l -match $keyRx) {
                    $k = $Matches[1]
                    if (-not $have.ContainsKey($k.ToLowerInvariant())) {
                        $block += $notes
                        $v = if ($now.ContainsKey($k.ToLowerInvariant())) { $now[$k.ToLowerInvariant()] } else { $Matches[2] }
                        # a new setting whose old behaviour came from another one takes that one's value
                        $from = $follows[$k.ToLowerInvariant()]
                        if ($from -and -not $now.ContainsKey($k.ToLowerInvariant())) {
                            if ($mineVal.ContainsKey($from)) { $v = $mineVal[$from] } elseif ($now.ContainsKey($from)) { $v = $now[$from] }
                        }
                        $block += "$k = $v"
                        $have[$k.ToLowerInvariant()] = $true; $added += $k
                    }
                    $notes = @()
                }
                elseif ($l -match '^\s*$') { $notes = @() }
                else { $notes += $l }
            }
            if (-not $block.Count) { continue }
            # under the heading if the file has it (at the end of that section), else the whole section above "Your own settings"
            $head = -1; $mine = -1
            for ($i = 0; $i -lt $out.Count; $i++) {
                if ($out[$i] -match '^# ---- (.+?) -*\s*$') {
                    if ($Matches[1].Trim() -eq $sec.Name) { $head = $i }
                    elseif ($Matches[1].Trim() -eq 'Your own settings') { $mine = $i }
                }
            }
            if ($head -ge 0) {
                $at = $out.Count
                for ($i = $head + 1; $i -lt $out.Count; $i++) { if ($out[$i] -match '^# ---- ') { $at = $i; break } }
                while ($at -gt $head + 1 -and $out[$at - 1] -match '^\s*$') { $at-- }
                $out.InsertRange($at, [object[]]$block)
            } else {
                $ins = @($sec.Head) + $block + @('')
                if ($mine -ge 0) { $out.InsertRange($mine, [object[]]$ins) } else { [void]$out.Add(''); $out.AddRange([object[]]$ins) }
            }
        }
        if (-not $added.Count) { return }
        Copy-Item $path "$path.bak" -Force
        [IO.File]::WriteAllText($path, ((@($out) -join "`r`n") + "`r`n"), (New-Object Text.UTF8Encoding $false))
        "Added $($added.Count) new settings to zz-9-local.conf with the values the server already used ($($added -join ', ')). Old copy: zz-9-local.conf.bak."
    } catch { Write-Warning "Could not add the new settings to zz-9-local.conf: $($_.Exception.Message)" }
}

# Older start scripts and the launcher call this name.
function Sync-HireSettings([string]$ServerDir) { Sync-LocalSettings $ServerDir }
