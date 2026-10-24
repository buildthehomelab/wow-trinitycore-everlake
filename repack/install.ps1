# One-click install: database, client lookup, game data (maps), certificate, add-on, shortcuts, start, and how to log in.
# Run it by double-clicking Install.cmd in the main folder. Safe to run again: finished steps are skipped, so after an
# interruption (or the long map extraction) just run it again.
#   install.ps1 -Client "D:\WoW Forever"   -> use this client folder instead of looking for it
#   install.ps1 -SkipMaps                  -> do not extract the maps now (the server will not run without them)
[CmdletBinding()]
param([string]$Client, [switch]$SkipMaps, [switch]$NoStart, [switch]$Elevated, [switch]$Gui)   # -Gui: started by the launcher window (already administrator): no questions, no pauses
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
. "$PSScriptRoot\ClientBuild.ps1"   # the build the realm accepts is read from the shipped auth updates, never typed here

# Looks for WoW Forever client folders (a folder with .build.info next to _forever_ (Wow.exe) or _classic_beta_ (WowB.exe)). Returns candidates
# in the order Sort-ClientFolders gives: an accepted build first (repack\client-builds.txt), then the clients Battle.net installed, then
# folders not named like a backup. $roots is a list of folders to search (to depth 3); the Battle.net installs are always included.
# Battle.net can have two WoW Forever installs of different builds (the beta and the Forever release); a build is what decides.
function Find-ClientFolders([string[]]$roots, [int]$maxSeconds = 25, [string[]]$registered = @(Get-BattleNetClients)) {
    $found = New-Object System.Collections.Generic.List[string]
    foreach ($d in $registered) { if (-not $found.Contains($d)) { $found.Add($d) } }
    $clock = [Diagnostics.Stopwatch]::StartNew()   # the search gives up after $maxSeconds; the player can pick the folder by hand
    foreach ($r in $roots) {
        if (-not (Test-Path $r)) { continue }
        $stack = New-Object System.Collections.Generic.Stack[object]
        $stack.Push(@($r, 0))
        while ($stack.Count -and $clock.Elapsed.TotalSeconds -lt $maxSeconds) {
            $item = $stack.Pop(); $dir = $item[0]; $depth = $item[1]
            if (Test-Path (Join-Path $dir '.build.info')) {
                if ((Test-Path (Join-Path $dir '_forever_')) -or (Test-Path (Join-Path $dir '_classic_beta_')) -or @(Get-ChildItem $dir -Filter 'Wow*.exe' -ErrorAction SilentlyContinue).Count) {
                    if (-not $found.Contains($dir)) { $found.Add($dir) }
                    continue
                }
            }
            if ($depth -ge 3) { continue }
            foreach ($sub in Get-ChildItem $dir -Directory -ErrorAction SilentlyContinue) {
                if ($sub.Name -in 'Windows', '$Recycle.Bin', 'System Volume Information', 'ProgramData', 'node_modules', '.git') { continue }
                $stack.Push(@($sub.FullName, ($depth + 1)))
            }
        }
    }
    @(Sort-ClientFolders $root @($found) $registered | ForEach-Object { $_.Dir })
}

if ($MyInvocation.InvocationName -eq '.') { return }   # dot-sourced by the tests: functions only

function Step($n, $total, $text) { Write-Host "`n[$n/$total] $text" -ForegroundColor Cyan }
function Pick-Folder($start) {
    Add-Type -AssemblyName System.Windows.Forms
    $d = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($start) { $d.SelectedPath = $start }
    $d.Description = 'Select your WoW Forever game folder (the one that contains the file .build.info)'
    $d.ShowNewFolderButton = $false
    if ($d.ShowDialog() -eq 'OK') { return $d.SelectedPath }
    return $null
}

# --- admin rights (certificate + hosts entry) --------------------------------------------------------------------------
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin -and $Gui) { Write-Host 'Setup needs administrator rights. Open the launcher again and press Yes.'; exit 1 }
if (-not $isAdmin) {
    Write-Host 'Windows will ask for permission once: it is needed to trust the local certificate and add the hosts line.'
    $argList = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -Elevated"
    if ($Client) { $argList += " -Client `"$Client`"" }
    if ($SkipMaps) { $argList += ' -SkipMaps' }
    if ($NoStart) { $argList += ' -NoStart' }
    Start-Process powershell.exe -ArgumentList $argList -Verb RunAs -Wait
    return
}
try { Start-Transcript -Path "$PSScriptRoot\install.log" -Append | Out-Null } catch { }
$total = 8
try {
    Step 1 $total 'Checking the folder'
    if ($root -match '\s') { throw "The folder path has spaces ($root). Move the folder to something like C:\WoWForever and run Install.cmd again." }
    foreach ($f in 'mysql\bin\mysqld.exe', 'server\worldserver.exe', 'server\bnetserver.exe') {
        if (-not (Test-Path (Join-Path $root $f))) { throw "$f is missing. Unzip the WHOLE package into this folder first." }
    }
    $freeGb = [math]::Round((Get-PSDrive ($root.Substring(0, 1))).Free / 1GB)
    if ($freeGb -lt 50) { Write-Warning "Only $freeGb GB free on this drive; about 50 GB are needed while the game data is built (about 45 GB of it is removed again at the end)." }
    # data counts as complete ONLY with the marker; a partial run (even with many navmesh tiles) is finished by extract-data.ps1 -Resume
    $dataDone = Test-Path "$root\server\data\.extract-complete"

    Step 2 $total "Finding your WoW Forever game folder (build $((Get-AcceptedBuilds $root) -join ' or '))"
    $saved = Join-Path $root 'config\client.txt'
    $picked = $false
    if (-not $Client -and (Get-SavedClient $root)) {
        $Client = (Get-SavedClient $root).Dir
        # a backup copy found by an earlier install gives way to the client Battle.net installed
        $better = Get-BetterThanSaved $root
        if ($better) { Write-Host "Not using $Client (it looks like a backup copy); using the Battle.net install $better."; $Client = $better }
    }
    # the launcher saves the game folder (_forever_ / _classic_beta_); the client folder with .build.info is its parent
    if ($Client -and -not (Test-Path (Join-Path $Client '.build.info')) -and (Test-Path (Join-Path (Split-Path $Client -Parent) '.build.info'))) { $Client = Split-Path $Client -Parent }
    if ($Client -and -not (Test-Path (Join-Path $Client '.build.info'))) { Write-Warning "$Client has no .build.info; looking again."; $Client = $null }
    # a remembered folder of another build (the other Forever install) is not used; look again
    if ($Client -and -not $Gui -and (Test-ClientFolder $root $Client)) { Write-Warning (Test-ClientFolder $root $Client); Write-Host 'Looking for another game folder.'; $Client = $null }
    if (-not $Client -and $Gui) { throw 'No valid game folder was given to the installer.' }
    if (-not $Client) {
        # look for it, then let the player confirm or change it in a folder window (it opens at the best guess)
        Write-Host 'Looking for it (at most 25 seconds)...'
        $roots = @("$env:USERPROFILE\Desktop", "$env:USERPROFILE\Downloads", "$env:USERPROFILE\Documents", "$env:PUBLIC\Games", "$env:ProgramFiles", "${env:ProgramFiles(x86)}")
        foreach ($d in Get-PSDrive -PSProvider FileSystem) { $roots += $d.Root }
        $registered = @(Get-BattleNetClients)
        $found = @(Find-ClientFolders $roots 25 $registered)
        $ties = @(Get-ClientTies (Sort-ClientFolders $root $found $registered))
        $guess = if ($found.Count) { $found[0] } else { $null }
        if ($ties.Count -gt 1) {
            # several equally good clients (same build, none set apart by Battle.net or a backup name): the player says which
            Write-Host 'Found more than one WoW Forever game folder that would work:'
            for ($i = 0; $i -lt $ties.Count; $i++) { Write-Host "  $($i + 1)) $($ties[$i])" }
            $n = Read-Host "Type the number of the one you play with (or press Enter to choose a folder yourself)"
            if ($n -match '^\d+$' -and [int]$n -ge 1 -and [int]$n -le $ties.Count) { $Client = $ties[[int]$n - 1]; $picked = $true }
        } elseif ($guess) { Write-Host "Found a likely game folder: $guess" } else { Write-Host 'Could not find it by itself.' }
        if (-not $Client) {
            Write-Host 'A window opens: select the folder of your WoW Forever game (the one that contains the file .build.info).'
            $Client = Pick-Folder $guess
            if ($Client -and $Client -ne $guess) { $picked = $true }
        }
        if (-not $Client -or -not (Test-Path (Join-Path $Client '.build.info'))) { throw 'No valid game folder chosen (it must contain .build.info). Run Install.cmd again.' }
    }
    # the game data is extracted from this client, so it must be a build the server accepts
    $wrong = Test-ClientFolder $root $Client
    if ($wrong) { throw $wrong }
    Save-Client $root $Client -Picked:$picked
    Test-ClientBuild $root

    Step 3 $total 'Setting up the database (a few minutes)'
    & "$PSScriptRoot\first-run.ps1"
    foreach ($dump in 'world.sql', 'hotfixes.sql') { Remove-Item "$root\sql\$dump" -ErrorAction SilentlyContinue }   # imported; no need to keep hundreds of MB

    Step 4 $total 'Game data (maps) from your own client'
    if ($dataDone) { Write-Host 'Already done.' }
    elseif ($SkipMaps) { Write-Warning 'Skipped. Run repack\extract-data.ps1 later; the server will not start without the data.' }
    else {
        Write-Host 'This is the slow part: about 10 to 20 minutes on a modern PC, longer on an older one (maps, then the pathfinding data for every map). The bots need it to walk. Do not close this window; if it is interrupted, run Install.cmd again and it continues.'
        & "$PSScriptRoot\extract-data.ps1" -Client $Client
        $dataDone = Test-Path "$root\server\data\.extract-complete"
    }

    Step 5 $total 'Certificate and hosts entry (so the game client trusts your own server)'
    & "$PSScriptRoot\make-certs.ps1"

    Step 6 $total 'Installing the ForeverBots add-on into your game folder'
    & "$PSScriptRoot\install-addon.ps1" -Client $Client

    Step 7 $total 'Creating Start Menu and Desktop shortcuts'
    & "$PSScriptRoot\make-shortcuts.ps1"

    Step 8 $total 'Starting the server (in its own window; the first start applies database updates: several minutes)'
    if ($NoStart) { Write-Host 'Skipped (-NoStart).' }
    elseif (-not $dataDone) { Write-Warning 'No game data yet, so the server is not started. Finish step 4 (run Install.cmd again), then start it from the menu.' }
    else {
        # Everything above ran as administrator. Stop the database and start the server again through Explorer, so it runs as
        # your normal user (an administrator-started server could not be stopped by the normal Stop/Update buttons).
        & "$root\mysql\bin\mysqladmin.exe" "--defaults-file=$root\config\my.ini" -u root shutdown 2>$null
        Start-Sleep 3
        Start-Process explorer.exe -ArgumentList "`"$root\repack\FirstStart.cmd`""
    }

    # --- first account --------------------------------------------------------------------------------------------------
    try { Stop-Transcript | Out-Null } catch { }   # no log of what is typed from here on (passwords)
    Write-Host ''
    Write-Host 'HOW TO LOG IN' -ForegroundColor Green
    Write-Host 'You need an account. It is created through the running server (the server finishes starting in the other window).'
    if ($Gui) { Write-Host 'The launcher window asks for the account name and password next.' }
    else {
    $make = Read-Host 'Create your account now? [Y/n]'
    if ($make -notmatch '^(n|no|nein)$') {
        try { & "$PSScriptRoot\Create-Account.ps1" } catch { Write-Warning $_.Exception.Message; Write-Host 'You can do it later: menu option A (Create account).' }
    } else { Write-Host 'Later: menu option A (Create account).' }
    }
    $help = @"
Next steps
1. Start the game with Play-WoWForever.cmd (or P in the control panel; it applies the server key, keep its window open) and log in with
   your account name plus @local (for example yourname@local) and your password. Realm: Trinity. In game, type /fb for the bots window.
2. Next time: Start Menu > WoW Forever Bots (or the Desktop shortcut) opens the control panel: 1 Start, 2 Stop, 3 Restart,
   T Restarter mode, A Create account, S Settings, B Backup, U Update.
Help and news: https://discord.gg/QJBM6tR3E4
"@
    Set-Content (Join-Path $root 'secrets\first-login.txt') $help -Encoding ascii
    if (-not $Gui) { Write-Host "`n$help" -ForegroundColor Green }
}
catch {
    Write-Host "`nInstall stopped: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host 'Fix that and run Install.cmd again: the steps already done are skipped. Details: repack\install.log'
    try { Stop-Transcript | Out-Null } catch { }
    # this window was opened for the installer (as administrator) and would close at once: keep the message on screen
    if (-not $Gui) { try { [void](Read-Host 'Press Enter to close this window') } catch { Start-Sleep 60 } }
    exit 1
}
try { Stop-Transcript | Out-Null } catch { }
if (-not $Gui) { try { [void](Read-Host 'Press Enter to close this window') } catch { Start-Sleep 30 } }
exit 0
