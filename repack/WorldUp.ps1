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

# The network limits the 0.1.25 server reads (connections per address and the login timeouts) are missing from the settings files of
# installs made before them, and the server logs a "Missing name ..." line for each one on every connection. The defaults are used
# anyway, so this changes nothing in how the server behaves: it writes the same values into the files, once, to end that log noise.
# Settings files are written without a byte order mark: the server does not read a file that starts with one.
function Sync-NetworkKeys([string]$ServerDir) {
    $want = @(
        @{ File = 'worldserver.conf'; Keys = [ordered]@{ 'Network.ConnectionsPerIp' = '16'; 'Network.AuthTimeout' = '60' } },
        @{ File = 'bnetserver.conf';  Keys = [ordered]@{ 'Network.ConnectionsPerIp' = '16'; 'Network.HandshakeTimeout' = '30'; 'Network.LoginTimeout' = '600' } })
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
