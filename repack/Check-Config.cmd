@echo off
rem Checks the server settings files and shows the file and line number of anything the server would stop on.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0repack\Check-Config.ps1"
