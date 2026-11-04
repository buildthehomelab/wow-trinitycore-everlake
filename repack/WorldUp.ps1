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

# The bot clothes setting (Bots.HolidayClothes: holiday hats on bots or not) came with 0.1.28. A player's own zz-9-local.conf
# from an older install does not have it, and updates never rewrite that file. So the block from templates\zz-9-local.conf is
# added to it once, above "Your own settings", with the server's own default (1, as before). A player's own line is kept.
function Sync-BotClothesSettings([string]$ServerDir) {
    try {
        $path = Join-Path (Join-Path $ServerDir 'worldserver.conf.d') 'zz-9-local.conf'
        $tpl = Join-Path (Join-Path $PSScriptRoot 'templates') 'zz-9-local.conf'
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

# The hired bots settings (NPC hire broker: on/off, what each broker gives, gear, health, prices) came with 0.1.28. A player's own
# zz-9-local.conf from an older install does not have them, and updates never rewrite that file. So the block from
# templates\zz-9-local.conf is added to it once, above "Your own settings", with the hire mode OFF (0) as the server's own default.
# A setting the player already has in the file is left as it is and not added again. Old copy: zz-9-local.conf.bak.
function Sync-HireSettings([string]$ServerDir) {
    try {
        $path = Join-Path (Join-Path $ServerDir 'worldserver.conf.d') 'zz-9-local.conf'
        $tpl = Join-Path (Join-Path $PSScriptRoot 'templates') 'zz-9-local.conf'
        if (-not (Test-Path $path) -or -not (Test-Path $tpl)) { return }
        $lines = @(Get-Content $path)
        if ($lines | Where-Object { $_ -match '^\s*Playerbot\.Hire\.Mode\s*=' }) { return }
        $have = @{}
        foreach ($l in $lines) { if ($l -match '^\s*([^#;\[\s][^=\s]*)\s*=') { $have[$Matches[1].ToLowerInvariant()] = $true } }
        $block = @(); $in = $false
        foreach ($l in @(Get-Content $tpl)) {
            if ($l -match '^# ---- Hired bots') { $in = $true }
            elseif ($in -and $l -match '^# ----') { break }
            if (-not $in) { continue }
            if ($l -match '^\s*([^#;\[\s][^=\s]*)\s*=' -and $have.ContainsKey($Matches[1].ToLowerInvariant())) { continue }
            $block += $l
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
        'Added the hired bots settings to zz-9-local.conf (off; old copy: zz-9-local.conf.bak).'
    } catch { Write-Warning "Could not add the hired bots settings to zz-9-local.conf: $($_.Exception.Message)" }
}
