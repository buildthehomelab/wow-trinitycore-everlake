# Finding the WoW Forever game folder for install.ps1: the folder search, a pasted path, and the folder window.
# Loaded with a dot (. client-search.ps1) by install.ps1 and by tests\repack\test-client-search.ps1; it loads ClientBuild.ps1.
. "$PSScriptRoot\ClientBuild.ps1"   # the build the realm accepts is read from the shipped auth updates, never typed here

# Looks for WoW Forever client folders (a folder with .build.info next to _forever_ (Wow.exe) or _classic_beta_ (WowB.exe)). Returns candidates
# in the order Sort-ClientFolders gives: an accepted build first (repack\client-builds.txt), then the clients Battle.net installed, then
# folders not named like a backup. $roots is a list of folders to search (to depth 3); the Battle.net installs are always included.
# Battle.net can have two WoW Forever installs of different builds (the beta and the Forever release); a build is what decides.
function Find-ClientFolders([string[]]$roots, [int]$maxSeconds = 25, [string[]]$registered = @(Get-BattleNetClients)) {
    $found = New-Object System.Collections.Generic.List[string]
    foreach ($d in $registered) { if (-not $found.Contains($d)) { $found.Add($d) } }
    $clock = [Diagnostics.Stopwatch]::StartNew()   # the search gives up after $maxSeconds; the player can pick the folder by hand
    # Every path is used literally (-LiteralPath): a folder named with [ or ] (common in downloaded media folders) is otherwise read as a
    # wildcard pattern and stopped the whole install ("The specified wildcard character pattern is not valid"). A folder that still
    # cannot be read (no access, a broken link, a name Windows refuses) is skipped; the search goes on.
    foreach ($r in $roots) {
        if (-not $r) { continue }
        try { if (-not (Test-Path -LiteralPath $r)) { continue } } catch { continue }
        $stack = New-Object System.Collections.Generic.Stack[object]
        $stack.Push(@($r, 0))
        while ($stack.Count -and $clock.Elapsed.TotalSeconds -lt $maxSeconds) {
            $item = $stack.Pop(); $dir = $item[0]; $depth = $item[1]
            try {
                if (Test-Path -LiteralPath (Join-Path $dir '.build.info')) {
                    if ((Test-Path -LiteralPath (Join-Path $dir '_forever_')) -or (Test-Path -LiteralPath (Join-Path $dir '_classic_beta_')) -or @(Get-ChildItem -LiteralPath $dir -Filter 'Wow*.exe' -File -ErrorAction SilentlyContinue).Count) {
                        if (-not $found.Contains($dir)) { $found.Add($dir) }
                        continue
                    }
                }
                if ($depth -ge 3) { continue }
                foreach ($sub in @(Get-ChildItem -LiteralPath $dir -Directory -ErrorAction SilentlyContinue)) {
                    if ($sub.Name -in 'Windows', '$Recycle.Bin', 'System Volume Information', 'ProgramData', 'node_modules', '.git') { continue }
                    $stack.Push(@($sub.FullName, ($depth + 1)))
                }
            } catch { continue }
        }
    }
    @(Sort-ClientFolders $root @($found) $registered | ForEach-Object { $_.Dir })
}
# The client folder (with .build.info) for a path the player typed or pasted: quotes and spaces around it are removed, and a game
# folder (_forever_ / _classic_beta_) or the program inside it (Wow.exe) leads to its client folder. $null when there is none.
function Resolve-ClientInput([string]$text) {
    if (-not $text) { return $null }
    $p = $text.Trim().Trim('"').Trim("'").Trim().TrimEnd('\', '/')
    if (-not $p) { return $null }
    if ($p -match '^[A-Za-z]:$') { $p += '\' }
    try {
        if (Test-Path -LiteralPath $p -PathType Leaf) { $p = Split-Path $p -Parent }
        for ($i = 0; $i -lt 3 -and $p; $i++) {
            if (Test-Path -LiteralPath (Join-Path $p '.build.info') -PathType Leaf) { return $p }
            $p = Split-Path $p -Parent
        }
    } catch { }
    $null
}
# The game folders the game launcher installed (see Get-BattleNetClients in ClientBuild.ps1).
function Get-InstalledClients { @(Get-BattleNetClients) }
# The folders the search looks in (to depth 3): the usual game places of this user, then every drive.
function Get-ClientSearchRoots {
    $roots = @("$env:USERPROFILE\Desktop", "$env:USERPROFILE\Downloads", "$env:USERPROFILE\Documents", "$env:PUBLIC\Games", "$env:ProgramFiles", "${env:ProgramFiles(x86)}")
    foreach ($d in Get-PSDrive -PSProvider FileSystem) { $roots += $d.Root }
    $roots
}
function Pick-Folder($start) {
    Add-Type -AssemblyName System.Windows.Forms
    $d = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($start) { $d.SelectedPath = $start }
    $d.Description = 'Select your WoW Forever game folder (the one that contains the file .build.info)'
    $d.ShowNewFolderButton = $false
    if ($d.ShowDialog() -eq 'OK') { return $d.SelectedPath }
    return $null
}
