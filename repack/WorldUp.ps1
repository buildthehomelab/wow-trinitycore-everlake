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
