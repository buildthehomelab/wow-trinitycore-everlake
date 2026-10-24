@echo off
rem Makes a zip of the logs on your Desktop to post in our Discord when something goes wrong. Names and IPs are masked.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0repack\bug-bundle.ps1"
