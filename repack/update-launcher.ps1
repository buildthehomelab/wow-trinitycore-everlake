# Puts a new launcher in place. The update zip carries the launcher as repack\WoWForeverLauncher.exe.new, not in the main
# folder: while the launcher window is open Windows will not let anything overwrite WoWForeverLauncher.exe, and the 0.1.21
# Update button stopped half-way on exactly that. Windows does let a running program be renamed, so the open one is moved
# aside to WoWForeverLauncher.exe.old and the new one copied in; the window keeps running the old one until it is reopened.
# make-shortcuts.ps1 runs this, because every updater (the old ones too) runs make-shortcuts.ps1 after it copied the new files.
# Safe to run again; does nothing when there is no new launcher waiting.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$new = Join-Path $PSScriptRoot 'WoWForeverLauncher.exe.new'
$exe = Join-Path $root 'WoWForeverLauncher.exe'
$old = "$exe.old"
if (Test-Path $old) { Remove-Item $old -Force -ErrorAction SilentlyContinue }   # left from the last update; still in use while that launcher is open
if (-not (Test-Path $new)) { return }
if ((Test-Path $exe) -and (Get-FileHash $exe).Hash -eq (Get-FileHash $new).Hash) { Remove-Item $new -Force; return }
try { Copy-Item $new $exe -Force }
catch {
    if (Test-Path $old) { throw "The launcher could not be updated: close the launcher window and run the update again. ($($_.Exception.Message))" }
    Move-Item $exe $old -Force
    try { Copy-Item $new $exe -Force }
    catch { Move-Item $old $exe -Force; throw }
    'The launcher was updated. Close it and open it again to use the new one.'
}
Remove-Item $new -Force
