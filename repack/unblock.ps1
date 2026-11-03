# Takes the "from the internet" mark off the programs and scripts of this package (not every file), so Windows Smart App
# Control does not block them later. Run by Install.cmd before install.ps1; the launcher does the same itself.
$root = Split-Path $PSScriptRoot -Parent
foreach ($dir in 'repack', 'server', 'mysql\bin') {
    Get-ChildItem -LiteralPath (Join-Path $root $dir) -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Extension -in '.ps1', '.exe', '.dll', '.cmd' } |
        ForEach-Object { try { Unblock-File -LiteralPath $_.FullName -ErrorAction Stop } catch { } }
}
