@echo off
rem WoW Forever Bots - launcher (Play button, server list). Double-click.
if exist "%~dp0WoWForeverLauncher.exe" (
  start "" "%~dp0WoWForeverLauncher.exe"
  exit /b 0
)
rem No compiled launcher in this folder: fall back to the script launcher window, then to the text launcher.
powershell.exe -NoProfile -STA -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0repack\Launcher.ps1"
if errorlevel 1 (
  title WoW Forever - game
  powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0repack\Play-WoWForever.ps1" %*
  if errorlevel 1 pause
)
