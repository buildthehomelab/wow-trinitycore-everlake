# Starts the local MySQL server (no Windows service; runs as chris's process).
. "$PSScriptRoot\common.ps1"
if (Get-Process mysqld -ErrorAction SilentlyContinue) { "MySQL already running"; return }
Start-Process C:\local\mysql-8.4.11\bin\mysqld.exe -ArgumentList "`"--defaults-file=$root\config\my.ini`"" -WindowStyle Hidden
"MySQL started"
