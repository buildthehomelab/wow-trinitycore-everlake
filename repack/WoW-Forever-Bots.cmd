@echo off
rem WoW Forever Bots - control panel. Double-click. Optional: give a key to run it first (WoW-Forever-Bots.cmd 1 = start the server).
title WoW Forever Bots
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0repack\Menu.ps1" %1
