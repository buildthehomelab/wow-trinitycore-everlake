# One-click install: database, client lookup, game data (maps), certificate, add-on, shortcuts, start, and how to log in.
# Run it by double-clicking Install.cmd in the main folder. Safe to run again: finished steps are skipped, so after an
# interruption (or the long map extraction) just run it again.
#   install.ps1 -Client "D:\WoW Forever"   -> use this client folder instead of looking for it
#   install.ps1 -SkipMaps                  -> do not extract the maps now (the server will not run without them)
[CmdletBinding()]
param([string]$Client, [switch]$SkipMaps, [switch]$NoStart, [switch]$Elevated, [switch]$Gui)   # -Gui: started by the launcher window (already administrator): no questions, no pauses
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
# The "from the internet" mark is taken off the package by the launcher, or by repack\unblock.ps1 that Install.cmd runs first.
. "$PSScriptRoot\client-search.ps1"   # finding the game folder (also loads ClientBuild.ps1)

if ($MyInvocation.InvocationName -eq '.') { return }   # dot-sourced by the tests: functions only

function Step($n, $total, $text) { Write-Host "`n[$n/$total] $text" -ForegroundColor Cyan }

# --- administrator rights (for the certificate and hosts line of step 5) ------------------------------------------------
$isAdmin = & "$PSScriptRoot\elevate.ps1" -Test
if (-not $isAdmin -and $Gui) { Write-Host 'Setup needs administrator rights. Open the launcher again and press Yes.'; exit 1 }
if (-not $isAdmin) {
    $pass = @()
    if ($Client) { $pass += "-Client `"$Client`"" }
    if ($SkipMaps) { $pass += '-SkipMaps' }
    if ($NoStart) { $pass += '-NoStart' }
    & "$PSScriptRoot\elevate.ps1" -Script $PSCommandPath -Pass $pass
    return
}
try { Start-Transcript -Path "$PSScriptRoot\install.log" -Append | Out-Null } catch { }
$total = 8
try {
    Step 1 $total 'Checking the folder'
    if ($root -match '\s') { throw "The folder path has spaces ($root). Move the folder to something like C:\WoWForever and run Install.cmd again." }
    foreach ($f in 'mysql\bin\mysqld.exe', 'server\worldserver.exe', 'server\bnetserver.exe',
                   'server\mapextractor.exe', 'server\vmap4extractor.exe', 'server\vmap4assembler.exe', 'server\mmaps_generator.exe') {
        # checked here, not only at step 4: an antivirus that quarantines one of the map tools otherwise stops the install halfway
        if (-not (Test-Path (Join-Path $root $f))) { throw "$f is missing. Either the zip was not fully unpacked (unzip the WHOLE package into this folder again, overwriting), or an antivirus program removed it: look in its quarantine or protection history (Windows Security > Virus & threat protection > Protection history), restore the file, allow this folder, then run Install.cmd again." }
    }
    $freeGb = [math]::Round((Get-PSDrive ($root.Substring(0, 1))).Free / 1GB)
    if ($freeGb -lt 50) { Write-Warning "Only $freeGb GB free on this drive; about 50 GB are needed while the game data is built (about 45 GB of it is removed again at the end)." }
    # data counts as complete ONLY with the marker; a partial run (even with many navmesh tiles) is finished by extract-data.ps1 -Resume
    # and only when the start-zone files worldserver checks first are there (a marker from a run that stopped part way is not believed;
    # extract-data.ps1 then removes it and builds the data again)
    $dataDone = (Test-Path "$root\server\data\.extract-complete") -and -not @(Get-MissingStartZoneData "$root\server\data").Count

    Step 2 $total "Finding your WoW Forever game folder (build $((Get-AcceptedBuilds $root) -join ' or '))"
    $saved = Join-Path $root 'config\client.txt'
    $picked = $false
    if (-not $Client -and (Get-SavedClient $root)) {
        $Client = (Get-SavedClient $root).Dir
        # a backup copy found by an earlier install gives way to the installed game
        $better = Get-BetterThanSaved $root
        if ($better) { Write-Host "Not using $Client (it looks like a backup copy); using the installed game in $better."; $Client = $better }
    }
    # the launcher saves the game folder (_forever_ / _classic_beta_); the client folder with .build.info is its parent
    if ($Client -and -not (Test-Path -LiteralPath (Join-Path $Client '.build.info')) -and (Test-Path -LiteralPath (Join-Path (Split-Path $Client -Parent) '.build.info'))) { $Client = Split-Path $Client -Parent }
    if ($Client -and -not (Test-Path -LiteralPath (Join-Path $Client '.build.info'))) { Write-Warning "$Client has no .build.info; looking again."; $Client = $null }
    # a remembered folder of another build (the other Forever install) is not used; look again
    if ($Client -and -not $Gui -and (Test-ClientFolder $root $Client)) { Write-Warning (Test-ClientFolder $root $Client); Write-Host 'Looking for another game folder.'; $Client = $null }
    if (-not $Client -and $Gui) { throw 'No valid game folder was given to the installer.' }
    if (-not $Client) {
        # look for it, then let the player confirm or change it in a folder window (it opens at the best guess)
        Write-Host 'Looking for it (at most 25 seconds)...'
        $roots = @(Get-ClientSearchRoots)
        $registered = @(Get-InstalledClients)
        # the search never stops the install: if it fails, the player chooses or pastes the folder below
        $found = @(); try { $found = @(Find-ClientFolders $roots 25 $registered) } catch { Write-Warning "The search stopped early ($($_.Exception.Message)); choose the folder yourself." }
        $ties = @(Get-ClientTies (Sort-ClientFolders $root $found $registered))
        $guess = if ($found.Count) { $found[0] } else { $null }
        if ($ties.Count -gt 1) {
            # several equally good clients (same build, none set apart as installed or by a backup name): the player says which
            Write-Host 'Found more than one WoW Forever game folder that would work:'
            for ($i = 0; $i -lt $ties.Count; $i++) { Write-Host "  $($i + 1)) $($ties[$i])" }
            $n = Read-Host "Type the number of the one you play with (or press Enter to choose a folder yourself)"
            if ($n -match '^\d+$' -and [int]$n -ge 1 -and [int]$n -le $ties.Count) { $Client = $ties[[int]$n - 1]; $picked = $true }
        } elseif ($guess) { Write-Host "Found a likely game folder: $guess" } else { Write-Host 'Could not find it by itself.' }
        if (-not $Client) {
            Write-Host 'A window opens: select the folder of your WoW Forever game (the one that contains the file .build.info).'
            $Client = $null; try { $Client = Pick-Folder $guess } catch { Write-Warning "The folder window could not open ($($_.Exception.Message))." }
            if ($Client) { $Client = Resolve-ClientInput $Client }
            if ($Client -and $Client -ne $guess) { $picked = $true }
        }
        # no folder chosen in the window (or not one with .build.info): the path can be pasted here instead
        for ($try = 0; -not $Client -and $try -lt 3; $try++) {
            Write-Host 'Paste the path of your WoW Forever game folder (the folder with the file .build.info, for example C:\Program Files (x86)\World of Warcraft) and press Enter.'
            Write-Host 'In Explorer: open the folder, click the address bar, Ctrl+C, then right-click in this window to paste. Press Enter on an empty line to stop.'
            $typed = Read-Host 'Game folder'
            if (-not $typed.Trim()) { break }
            $Client = Resolve-ClientInput $typed
            if ($Client) { $picked = $true } else { Write-Warning "No .build.info found in $typed or the folders above it." }
        }
        if (-not $Client -or -not (Test-Path -LiteralPath (Join-Path $Client '.build.info'))) { throw 'No valid game folder chosen (it must contain .build.info). Run Install.cmd again, or run it as: Install.cmd "C:\path\to\your\game folder"' }
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
        $dataDone = (Test-Path "$root\server\data\.extract-complete") -and -not @(Get-MissingStartZoneData "$root\server\data").Count
    }

    Step 5 $total 'Certificate and hosts entry (so the game client trusts your own server)'
    & "$PSScriptRoot\make-certs.ps1"

    Step 6 $total 'Installing the ForeverBots add-on into your game folder'
    & "$PSScriptRoot\install-addon.ps1" -Client $Client

    Step 7 $total 'Creating Start Menu and Desktop shortcuts'
    & "$PSScriptRoot\make-shortcuts.ps1"
    # settings (step 3), certificate and hosts entry (step 5) and shortcuts now all name this folder: a move is finished
    Remove-Item (Join-Path $root 'config\moved-from.txt') -ErrorAction SilentlyContinue

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

    # --- first account and the next-steps note --------------------------------------------------------------------------
    try { Stop-Transcript | Out-Null } catch { }   # the log ends here: the account step is not written to install.log
    & "$PSScriptRoot\finish-install.ps1" -Root $root -Gui:$Gui
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
