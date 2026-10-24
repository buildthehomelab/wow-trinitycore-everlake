# Dot-sourced by the start scripts. True when the worldserver started at $Since printed "World initialized" in Server.log or in a
# rotated copy of it (Server.log is cut at 100 MB; the line then sits in the older file). Files older than $Since are ignored.
function Test-WorldInitialized([string]$LogDir, [datetime]$Since) {
    $files = @(Get-ChildItem -Path (Join-Path $LogDir 'Server.log*') -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -ge $Since })
    foreach ($f in $files) {
        try { if (Select-String -Path $f.FullName -Pattern 'World initialized' -Quiet) { return $true } } catch { }
    }
    return $false
}
