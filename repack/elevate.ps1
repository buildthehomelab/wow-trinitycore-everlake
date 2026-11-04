# Administrator rights for the installer (it trusts the local certificate and adds the hosts line in make-certs.ps1).
#   elevate.ps1 -Test                       -> $true when this window already runs as administrator
#   elevate.ps1 -Script <path> [-Pass ...]  -> starts that script again as administrator (Windows asks once) and waits for it
param([switch]$Test, [string]$Script, [string[]]$Pass = @())
if ($Test) {
    return ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
Write-Host 'Windows will ask for permission once: it is needed to trust the local certificate and add the hosts line.'
$argList = "-NoProfile -ExecutionPolicy Bypass -File `"$Script`" -Elevated"
foreach ($a in $Pass) { $argList += ' ' + $a }
Start-Process powershell.exe -ArgumentList $argList -Verb RunAs -Wait
