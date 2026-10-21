# Run as Administrator. Removes the local CA from Windows trust and the hosts entry. Does not delete the folder.
Get-ChildItem Cert:\LocalMachine\Root | Where-Object Subject -like '*WoW Forever Local CA*' | Remove-Item
$hosts = "$env:SystemRoot\System32\drivers\etc\hosts"
(Get-Content $hosts) | Where-Object { $_ -notmatch 'wow-forever-local' } | Set-Content $hosts
"Removed the WoW Forever local CA and hosts entry. You can delete this folder now."
