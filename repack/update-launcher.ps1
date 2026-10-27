# Puts a new launcher in place. The update zip carries the launcher as repack\WoWForeverLauncher.exe.new, not in the main
# folder: while the launcher window is open Windows will not let anything overwrite WoWForeverLauncher.exe, and the 0.1.21
# Update button stopped half-way on exactly that. Windows does let a running program be renamed, so the current one is always
# moved aside to WoWForeverLauncher.exe.old first and the new one copied in; the window keeps running the old one until it is
# reopened, and the new launcher deletes the .old file once nothing runs it any more.
# Nothing here tries a copy that can fail on the open launcher: the update's transcript (update.log) records every thrown error,
# even a caught one, and a "used by another process" line before the success line reads as a failed update.
# make-shortcuts.ps1 runs this, because every updater (the old ones too) runs make-shortcuts.ps1 after it copied the new files.
# Safe to run again; does nothing when there is no new launcher waiting.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$new = Join-Path $PSScriptRoot 'WoWForeverLauncher.exe.new'
$exe = Join-Path $root 'WoWForeverLauncher.exe'
# left from earlier updates; one that a launcher window still runs stays, and goes next time
Get-ChildItem $root -Filter 'WoWForeverLauncher.exe.old*' -File -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
if (-not (Test-Path $new)) { return }
if ((Test-Path $exe) -and (Get-FileHash $exe).Hash -eq (Get-FileHash $new).Hash) { Remove-Item $new -Force; return }
$aside = $null
if (Test-Path $exe) {
    $aside = "$exe.old"
    if (Test-Path $aside) { $aside = "$exe.old-$(Get-Date -Format yyyyMMddHHmmss)" }   # an older launcher window still runs the .old one
    Move-Item $exe $aside -Force
}
try { Copy-Item $new $exe -Force }
catch { if ($aside) { Move-Item $aside $exe -Force }; throw }
Remove-Item $new -Force
if ($aside) {
    Remove-Item $aside -Force -ErrorAction SilentlyContinue   # gone at once when no launcher window was open
    if (Test-Path $aside) { 'The launcher was updated. Close it and open it again to use the new one.' }
}
