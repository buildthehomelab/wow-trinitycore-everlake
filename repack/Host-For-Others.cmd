@echo off
rem Lets other people join your server (internet, home network or VPN), or turns that off again. Double-click.
title WoW Forever Bots - host for others
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0repack\HostForOthers.ps1" %*
pause
