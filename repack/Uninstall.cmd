@echo off
rem WoW Forever Bots: removes it from this PC (shortcuts, add-ons, certificates, hosts lines, firewall rules). It asks before it starts,
rem and asks whether to delete this folder too (your characters are in it). Windows asks once for permission.
cd /d "%TEMP%"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0repack\uninstall.ps1" %*
pause
