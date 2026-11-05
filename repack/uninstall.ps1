# Removes WoW Forever Bots from this PC. Double-click Uninstall.cmd in the main folder (or run this file in PowerShell).
# What it removes:
#   - the running server, MySQL and launcher of this folder (stopped cleanly first, so characters are saved)
#   - the "WoW Forever" and "WoW Forever Bots" shortcuts on the Desktop and in the Start Menu (only ones that point into this folder)
#   - the ForeverBots and ForeverDots add-ons and the launcher's WTF\ForeverLauncher.wtf in your game folder
#     (your own game settings, Config.wtf and SavedVariables are not touched)
#   - the WoW Forever certificates in the Windows trust store (your own and the ones added for friends' servers)
#   - the hosts lines this repack added (marked wow-forever-local and wow-forever-join); a backup of the hosts file is kept
#   - the firewall rule of Host for others and the Windows firewall rules for this folder's worldserver.exe and bnetserver.exe
#   - with -DeleteFolder (or answering Y): this whole folder, INCLUDING YOUR CHARACTERS. Without it the folder stays.
# The Windows parts need administrator rights: Windows asks once.
#   .\uninstall.ps1                    asks before it starts, and asks about the folder
#   .\uninstall.ps1 -Yes               no questions, the folder stays
#   .\uninstall.ps1 -Yes -DeleteFolder no questions, the folder is deleted too
#   .\uninstall.ps1 -DryRun            (or -WhatIf) only lists what it would remove: nothing is stopped, removed or changed, no questions, no administrator prompt
param([switch]$Yes, [switch]$DeleteFolder, [switch]$KeepFolder, [switch]$AdminPart, [Alias('WhatIf')][switch]$DryRun)
$ErrorActionPreference = 'Continue'
$root = (Split-Path $PSScriptRoot -Parent).TrimEnd('\')
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
# Y, or the Russian D (da) / N key (the Y key on a Russian keyboard)
$yesPattern = '^\s*([Yy]|\u0414|\u0434|\u041D|\u043D)'

# ------------------------------------------------------------------ the Windows parts (administrator)
function Remove-WindowsParts {
    # certificates: our own CA and every friend's server CA carry this name
    foreach ($store in 'Cert:\LocalMachine\Root', 'Cert:\CurrentUser\Root') {
        $certs = @(Get-ChildItem $store -ErrorAction SilentlyContinue | Where-Object { $_.Subject -like '*WoW Forever Local CA*' })
        foreach ($c in $certs) {
            if ($DryRun) { "Would remove certificate $($c.Subject) ($($c.Thumbprint)) from $store"; continue }
            try { Remove-Item -LiteralPath $c.PSPath -Force -ErrorAction Stop; "Removed certificate $($c.Subject) ($store)" }
            catch { Write-Warning "Could not remove certificate $($c.Thumbprint): $($_.Exception.Message)" }
        }
    }
    # hosts lines
    $hosts = Join-Path $env:SystemRoot 'System32\drivers\etc\hosts'
    try {
        $all = @(Get-Content -LiteralPath $hosts -ErrorAction Stop)
        $keep = @($all | Where-Object { $_ -notmatch 'wow-forever-(local|join)' })
        if ($keep.Count -ne $all.Count -and $DryRun) {
            @($all | Where-Object { $_ -match 'wow-forever-(local|join)' }) | ForEach-Object { "Would remove this hosts line: $_" }
        } elseif ($keep.Count -ne $all.Count) {
            Copy-Item -LiteralPath $hosts ($hosts + '.wowforever-uninstall.bak') -Force
            Set-Content -LiteralPath $hosts $keep -Encoding ASCII -ErrorAction Stop
            "Removed $($all.Count - $keep.Count) line(s) from the hosts file (backup: hosts.wowforever-uninstall.bak)"
        }
    } catch { Write-Warning "Could not change the hosts file: $($_.Exception.Message)" }
    # firewall: the Host for others rule (same name in HostForOthers.ps1 and the launcher) and the rules Windows made for our servers
    try {
        $r = @(Get-NetFirewallRule -DisplayName 'WoW Forever Bots (friends)' -ErrorAction SilentlyContinue)
        if ($r.Count -and $DryRun) { "Would remove the firewall rule 'WoW Forever Bots (friends)'" }
        elseif ($r.Count) { $r | Remove-NetFirewallRule; "Removed the firewall rule 'WoW Forever Bots (friends)'" }
        foreach ($exe in 'worldserver.exe', 'bnetserver.exe') {
            $p = Join-Path (Join-Path $root 'server') $exe
            $r = @(Get-NetFirewallApplicationFilter -Program $p -ErrorAction SilentlyContinue | Get-NetFirewallRule -ErrorAction SilentlyContinue)
            if ($r.Count -and $DryRun) { "Would remove $($r.Count) firewall rule(s) for $exe" }
            elseif ($r.Count) { $r | Remove-NetFirewallRule; "Removed $($r.Count) firewall rule(s) for $exe" }
        }
    } catch { Write-Warning "Could not change the firewall: $($_.Exception.Message)" }
}

if ($AdminPart) { Remove-WindowsParts; Start-Sleep -Seconds 2; return }   # the elevated second window

# ------------------------------------------------------------------ questions
if (-not (Test-Path -LiteralPath (Join-Path $root 'repack\uninstall.ps1'))) { throw "This file must be in the repack folder of WoW Forever Bots." }
if ($DryRun) { Write-Host 'DRY RUN: nothing is stopped, removed or changed. This only lists what the uninstall would do.'; $Yes = $true }
if (-not $Yes) {
    Write-Host ''
    Write-Host 'This removes WoW Forever Bots from this PC: shortcuts, add-ons, certificates, hosts lines and firewall rules.'
    Write-Host "Folder: $root"
    $a = Read-Host 'Continue? (Y/N)'
    if ($a -notmatch $yesPattern) { 'Nothing was changed.'; return }
    if (-not $DeleteFolder -and -not $KeepFolder) {
        Write-Host ''
        Write-Host 'Delete the whole folder too? Your characters and bots are stored in it and will be gone for good.'
        Write-Host "To keep your characters, answer N, or copy the folder $root\backups somewhere safe first."
        $a = Read-Host 'Delete the folder? (Y/N)'
        if ($a -match $yesPattern) { $DeleteFolder = $true }
    }
}
if ($KeepFolder) { $DeleteFolder = $false }

# ------------------------------------------------------------------ the server, MySQL and the launcher
$stop = Join-Path $PSScriptRoot 'Stop-WoWForever.ps1'
if ($DryRun) {
    'Would stop the server, MySQL and the launcher of this folder.'
    foreach ($p in @(Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.Id -ne $PID -and $_.Path -and $_.Path -like "$root\*" })) { "  running now: $($p.Name) ($($p.Path))" }
} elseif (Test-Path -LiteralPath $stop) {
    'Stopping the server (characters are saved)...'
    try { & $stop | Out-Null } catch { Write-Warning "Stopping the server: $($_.Exception.Message)" }
}
if (-not $DryRun) {
    foreach ($p in @(Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.Id -ne $PID -and $_.Path -and $_.Path -like "$root\*" })) {
        try { Stop-Process -Id $p.Id -Force -ErrorAction Stop; "Closed $($p.Name)" } catch { }
    }
}

# ------------------------------------------------------------------ shortcuts (this user's Desktop and Start Menu, and the shared ones)
$sh = New-Object -ComObject WScript.Shell
$discord = $null
$linkFile = Join-Path $PSScriptRoot 'discord-link.txt'
if (Test-Path -LiteralPath $linkFile) {
    $first = @(Get-Content -LiteralPath $linkFile | Where-Object { $_ -match '^\s*https://' })[0]
    if ($first) { $discord = $first.Trim() }
}
function Is-Ours($file) {
    try {
        if ($file.Extension -eq '.lnk') {
            $l = $sh.CreateShortcut($file.FullName)
            return (($l.TargetPath -like "$root\*") -or ($l.Arguments -like "*$root\*") -or ($l.WorkingDirectory.TrimEnd('\') -eq $root))
        }
        if ($file.Extension -eq '.url' -and $discord) {
            return ([bool](Select-String -LiteralPath $file.FullName -Pattern ([regex]::Escape($discord)) -Quiet))
        }
    } catch { }
    $false
}
foreach ($dir in @([Environment]::GetFolderPath('Desktop'), [Environment]::GetFolderPath('Programs'),
                   [Environment]::GetFolderPath('CommonDesktopDirectory'), [Environment]::GetFolderPath('CommonPrograms'))) {
    if (-not $dir -or -not (Test-Path -LiteralPath $dir)) { continue }
    $files = @(Get-ChildItem -LiteralPath $dir -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -like 'WoW Forever*' })
    $sub = Join-Path $dir 'WoW Forever Bots'
    if (Test-Path -LiteralPath $sub -PathType Container) { $files += @(Get-ChildItem -LiteralPath $sub -File -ErrorAction SilentlyContinue) }
    foreach ($f in $files) {
        if (Is-Ours $f) {
            if ($DryRun) { "Would remove shortcut $($f.FullName)" } else { Remove-Item -LiteralPath $f.FullName -Force -ErrorAction SilentlyContinue; "Removed shortcut $($f.FullName)" }
        }
    }
    if (-not $DryRun -and (Test-Path -LiteralPath $sub -PathType Container) -and -not (Get-ChildItem -LiteralPath $sub -Force)) { Remove-Item -LiteralPath $sub -Force -ErrorAction SilentlyContinue }
}

# ------------------------------------------------------------------ add-ons and the launcher's settings file in the game folder
$client = $null
try { . (Join-Path $PSScriptRoot 'ClientBuild.ps1'); $s = Get-SavedClient $root; if ($s) { $client = $s.Dir } } catch { }
if ($client -and (Test-Path -LiteralPath $client)) {
    # the saved folder can be the install root or one of its game folders (_forever_, _classic_beta_ ...)
    $bases = @($client)
    $parent = Split-Path $client -Parent
    if ($parent -and (Test-Path -LiteralPath (Join-Path $parent '.build.info'))) { $bases += $parent }
    foreach ($base in $bases) {
        foreach ($sub in '_forever_', '_classic_beta_', '_classic_', '_classic_era_', '') {
            $game = if ($sub) { Join-Path $base $sub } else { $base }
            if (-not (Test-Path -LiteralPath $game)) { continue }
            foreach ($a in 'ForeverBots', 'ForeverDots') {
                $d = Join-Path $game "Interface\AddOns\$a"
                if (Test-Path -LiteralPath $d) { if ($DryRun) { "Would remove add-on $d" } else { Remove-Item -LiteralPath $d -Recurse -Force -ErrorAction SilentlyContinue; "Removed add-on $d" } }
            }
            $w = Join-Path $game 'WTF\ForeverLauncher.wtf'
            if (Test-Path -LiteralPath $w) { if ($DryRun) { "Would remove $w" } else { Remove-Item -LiteralPath $w -Force -ErrorAction SilentlyContinue; "Removed $w" } }
        }
    }
} else { 'No game folder saved, so the add-ons were not looked for. Delete Interface\AddOns\ForeverBots and ForeverDots in your game folder if you want.' }

# ------------------------------------------------------------------ the Windows parts
if ($isAdmin -or $DryRun) { Remove-WindowsParts }   # a dry run only reads, so it needs no administrator window
else {
    'Windows will ask for permission once: it is needed to remove the certificates, hosts lines and firewall rules.'
    try {
        $p = Start-Process powershell.exe -Verb RunAs -Wait -PassThru -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$PSCommandPath`"", '-AdminPart'
        $null = $p.Handle
    } catch { Write-Warning 'The Windows permission was refused, so the certificates, hosts lines and firewall rules are still there. Run Uninstall.cmd again and answer Yes.' }
}

# ------------------------------------------------------------------ the folder
if ($DryRun) {
    $dfm = if ($DeleteFolder) { "Would delete the whole folder $root (characters included)." } else { "Would keep the folder $root." }
    $dfm; 'Dry run finished: nothing was changed.'; return
}
if ($DeleteFolder) {
    if (-not (Test-Path -LiteralPath (Join-Path $root 'server')) -or $root.Length -lt 6) { Write-Warning "Not deleting $root : it does not look like a WoW Forever Bots folder."; return }
    "Deleting $root in a few seconds, after this window closes."
    $cmd = 'ping -n 6 127.0.0.1 >nul & rd /s /q "' + $root + '"'
    Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory $env:TEMP -WindowStyle Hidden
} else {
    "Done. The folder $root was kept (your characters are in it). Delete it yourself when you no longer need it."
}
