@echo off
rem WoW Forever Bots: one-click install. Double-click this file. Windows asks once for permission (needed for the certificate and hosts entry).
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0repack\unblock.ps1"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0repack\install.ps1" %*
pause
