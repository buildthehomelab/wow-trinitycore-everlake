# Cleanly shuts down the local MySQL server. Root password comes from secrets\mysql.txt (never committed).
. "$PSScriptRoot\common.ps1"
$pw = (Select-String -Path "$root\secrets\mysql.txt" -Pattern '^mysql root: (.+)$').Matches[0].Groups[1].Value
& C:\local\mysql-8.4.11\bin\mysqladmin.exe -uroot "-p$pw" shutdown
