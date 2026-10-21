# WoW Forever Bots - game launcher window: Play button, server status, update notice, shortcuts to the control panel and Discord.
# Starts Play-WoWForever.ps1 (which sets the portal and writes the server login key into the running game) and shows what it does.
# Windows PowerShell 5.1, no administrator rights needed. Started by Play-WoWForever.cmd.
#   .\Launcher.ps1 -SelfTest   -> build the window, print what it would show, close (no game, no server action)
param([switch]$SelfTest)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$here = $PSScriptRoot
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# --- settings ----------------------------------------------------------------------------------------------------------------------
$cfg = $null
$cfgFile = Join-Path $root 'config\server.json'
if (Test-Path $cfgFile) { try { $cfg = Get-Content $cfgFile -Raw | ConvertFrom-Json } catch { } }
$defaultKey = '02596F0D0C061A8B30745988FD72C59E29EC367FB0F341F28E0F08D037BAFC69'
$listFile = Join-Path $root 'config\launcher-servers.json'
function New-Server($name, $address, $portal, $key, $group, $lp, $wp) {
    [pscustomobject]@{ name = $name; address = $address; portal = $portal; publicKey = $key; regionGroup = [int]$group; loginPort = [int]$lp; worldPort = [int]$wp }
}
# the first entry is always this PC's own server; the others are added by the player
$ownServer = New-Server 'This PC (own server)' $(if ($cfg -and $cfg.host) { [string]$cfg.host } else { '127.0.0.1' }) `
    $(if ($cfg -and $cfg.portal) { [string]$cfg.portal } else { 'trinity.actual.battle.net' }) `
    $(if ($cfg -and $cfg.publicKey) { [string]$cfg.publicKey } else { $defaultKey }) `
    $(if ($cfg -and $cfg.regionGroup) { [int]$cfg.regionGroup } else { 8 }) `
    $(if ($cfg -and $cfg.loginPort) { [int]$cfg.loginPort } else { 1119 }) `
    $(if ($cfg -and $cfg.worldPort) { [int]$cfg.worldPort } else { 8085 })
$script:servers = New-Object System.Collections.ArrayList
[void]$script:servers.Add($ownServer)
$script:selectedName = $ownServer.name
if (Test-Path $listFile) {
    try {
        $j = Get-Content $listFile -Raw | ConvertFrom-Json
        foreach ($e in @($j.servers)) {
            if ($e.name -and $e.address -and $e.portal) {
                [void]$script:servers.Add((New-Server ([string]$e.name) ([string]$e.address) ([string]$e.portal) $(if ($e.publicKey) { [string]$e.publicKey } else { $defaultKey }) $(if ($e.regionGroup) { $e.regionGroup } else { 8 }) $(if ($e.loginPort) { $e.loginPort } else { 1119 }) $(if ($e.worldPort) { $e.worldPort } else { 8085 })))
            }
        }
        if ($j.selected) { $script:selectedName = [string]$j.selected }
    } catch { }
}
function Save-Servers {
    $extra = @($script:servers | Select-Object -Skip 1)
    $o = [ordered]@{ selected = $script:selectedName; servers = $extra }
    New-Item -ItemType Directory -Force (Split-Path $listFile) | Out-Null
    ($o | ConvertTo-Json -Depth 4) | Set-Content $listFile -Encoding ASCII
}
function Current-Server {
    $m = $script:servers | Where-Object { $_.name -eq $script:selectedName } | Select-Object -First 1
    if ($m) { $m } else { $script:servers[0] }
}
function Server-IsLocal($srv) { $srv.address -eq '127.0.0.1' -or $srv.address -eq 'localhost' }
$discord = $null
try { $discord = @(Get-Content (Join-Path $here 'discord-link.txt') | Where-Object { $_ -match '^\s*https://' })[0].Trim() } catch { }
$version = '?'
try { $v = Get-Content (Join-Path $root 'version.json') -Raw | ConvertFrom-Json; if ($v.version) { $version = [string]$v.version } } catch { }

# --- colours / fonts -----------------------------------------------------------------------------------------------------------------
$cBg = [Drawing.Color]::FromArgb(20, 22, 34)
$cPanel = [Drawing.Color]::FromArgb(30, 33, 50)
$cGold = [Drawing.Color]::FromArgb(224, 176, 72)
$cGoldDark = [Drawing.Color]::FromArgb(138, 104, 40)
$cText = [Drawing.Color]::FromArgb(226, 222, 210)
$cMute = [Drawing.Color]::FromArgb(140, 140, 150)
$cGreen = [Drawing.Color]::FromArgb(90, 200, 120)
$cRed = [Drawing.Color]::FromArgb(220, 90, 80)
$cAmber = [Drawing.Color]::FromArgb(230, 180, 60)
$fTitle = New-Object Drawing.Font('Georgia', 22, [Drawing.FontStyle]::Bold)
$fSub = New-Object Drawing.Font('Segoe UI', 9)
$fBody = New-Object Drawing.Font('Segoe UI', 10)
$fBtn = New-Object Drawing.Font('Segoe UI', 16, [Drawing.FontStyle]::Bold)
$fSmall = New-Object Drawing.Font('Segoe UI', 8.5)

# --- helpers ---------------------------------------------------------------------------------------------------------------------------
function Test-Port([string]$h, [int]$port) {
    $c = New-Object Net.Sockets.TcpClient
    try {
        $iar = $c.BeginConnect($h, $port, $null, $null)
        if ($iar.AsyncWaitHandle.WaitOne(250)) { try { $c.EndConnect($iar); return $true } catch { return $false } }
        return $false
    } catch { return $false } finally { $c.Close() }
}
function New-Label([string]$text, [int]$x, [int]$y, [int]$w, $font, $color) {
    $l = New-Object Windows.Forms.Label
    $l.Text = $text; $l.Location = New-Object Drawing.Point($x, $y); $l.Size = New-Object Drawing.Size($w, 22)
    $l.Font = $font; $l.ForeColor = $color; $l.BackColor = [Drawing.Color]::Transparent
    $l
}
function New-Button([string]$text, [int]$x, [int]$y, [int]$w, [int]$h, $font) {
    $b = New-Object Windows.Forms.Button
    $b.Text = $text; $b.Location = New-Object Drawing.Point($x, $y); $b.Size = New-Object Drawing.Size($w, $h)
    $b.Font = $font; $b.FlatStyle = 'Flat'; $b.Cursor = 'Hand'; $b.UseVisualStyleBackColor = $false
    $b.FlatAppearance.BorderColor = $cGoldDark; $b.FlatAppearance.BorderSize = 1
    $b.BackColor = $cPanel; $b.ForeColor = $cText
    $b
}

# --- window ------------------------------------------------------------------------------------------------------------------------------
$form = New-Object Windows.Forms.Form
$form.Text = 'WoW Forever Bots'
$form.ClientSize = New-Object Drawing.Size(520, 440)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedSingle'
$form.MaximizeBox = $false
$form.BackColor = $cBg
$form.ForeColor = $cText
$icoFile = Join-Path $here 'wow-forever.ico'
if (Test-Path $icoFile) { try { $form.Icon = New-Object Drawing.Icon($icoFile) } catch { } }

# header: gradient, star, title (all drawn here, no image files)
$head = New-Object Windows.Forms.Panel
$head.Location = New-Object Drawing.Point(0, 0); $head.Size = New-Object Drawing.Size(520, 110)
$head.Add_Paint({
    param($s, $e)
    $g = $e.Graphics
    $g.SmoothingMode = 'AntiAlias'; $g.TextRenderingHint = 'ClearTypeGridFit'
    $r = New-Object Drawing.Rectangle(0, 0, 520, 110)
    $br = New-Object Drawing.Drawing2D.LinearGradientBrush($r, [Drawing.Color]::FromArgb(44, 40, 70), $cBg, 90)
    $g.FillRectangle($br, $r); $br.Dispose()
    # eight-point star
    $pts = New-Object 'System.Collections.Generic.List[Drawing.PointF]'
    for ($i = 0; $i -lt 16; $i++) {
        $rad = if ($i % 2 -eq 0) { 38.0 } else { 16.0 }
        $a = [Math]::PI * $i / 8 - [Math]::PI / 2
        $pts.Add((New-Object Drawing.PointF([single](56 + $rad * [Math]::Cos($a)), [single](55 + $rad * [Math]::Sin($a)))))
    }
    $gb = New-Object Drawing.SolidBrush($cGold)
    $g.FillPolygon($gb, $pts.ToArray())
    $ib = New-Object Drawing.SolidBrush($cBg)
    $g.FillEllipse($ib, 44, 43, 24, 24)
    $f = New-Object Drawing.Font('Georgia', 12, [Drawing.FontStyle]::Bold)
    $g.DrawString('F', $f, $gb, 49, 45)
    $f.Dispose(); $ib.Dispose()
    $g.DrawString('WoW Forever Bots', $fTitle, $gb, 102, 22)
    $sb = New-Object Drawing.SolidBrush($cMute)
    $g.DrawString('play with bots in your own world', $fSub, $sb, 106, 66)
    $sb.Dispose(); $gb.Dispose()
    $pen = New-Object Drawing.Pen($cGoldDark, 2)
    $g.DrawLine($pen, 0, 108, 520, 108); $pen.Dispose()
})
$form.Controls.Add($head)

# server selector
$lblPlayingOn = New-Label 'Server' 24 126 60 $fBody $cMute
$cmbServer = New-Object Windows.Forms.ComboBox
$cmbServer.DropDownStyle = 'DropDownList'; $cmbServer.FlatStyle = 'Flat'; $cmbServer.Font = $fBody
$cmbServer.BackColor = $cPanel; $cmbServer.ForeColor = $cText
$cmbServer.Location = New-Object Drawing.Point(88, 123); $cmbServer.Size = New-Object Drawing.Size(250, 28)
$btnAdd = New-Button 'Add...' 346 122 70 28 $fSmall
$btnRemove = New-Button 'Remove' 424 122 72 28 $fSmall
$form.Controls.AddRange(@($lblPlayingOn, $cmbServer, $btnAdd, $btnRemove))
function Fill-Servers {
    $cmbServer.Items.Clear()
    foreach ($x in $script:servers) { [void]$cmbServer.Items.Add($x.name) }
    $i = $cmbServer.Items.IndexOf($script:selectedName)
    $cmbServer.SelectedIndex = $(if ($i -ge 0) { $i } else { 0 })
}

# status card
$card = New-Object Windows.Forms.Panel
$card.Location = New-Object Drawing.Point(24, 164); $card.Size = New-Object Drawing.Size(472, 104); $card.BackColor = $cPanel
$form.Controls.Add($card)
$lblSrvName = New-Label 'Server' 16 12 100 $fBody $cMute
$lblSrv = New-Label '...' 120 12 340 $fBody $cText
$lblLoginName = New-Label 'Login' 16 40 100 $fBody $cMute
$lblLogin = New-Label '...' 120 40 340 $fBody $cText
$lblVerName = New-Label 'Repack' 16 68 100 $fBody $cMute
$lblVer = New-Label ('Bots repack ' + $version) 120 68 340 $fBody $cText
foreach ($c in $lblSrvName, $lblSrv, $lblLoginName, $lblLogin, $lblVerName, $lblVer) { $card.Controls.Add($c) }

# update notice
$lblUpdate = New-Label '' 24 280 380 $fBody $cAmber
$lblUpdate.Visible = $false
$btnUpdate = New-Button 'Update...' 412 274 84 28 $fSmall
$btnUpdate.Visible = $false
$form.Controls.AddRange(@($lblUpdate, $btnUpdate))

# buttons
$btnPlay = New-Button 'PLAY' 24 304 472 58 $fBtn
$btnPlay.BackColor = $cGold; $btnPlay.ForeColor = [Drawing.Color]::FromArgb(30, 22, 6); $btnPlay.FlatAppearance.BorderColor = $cGold
$btnStart = New-Button 'Start server' 24 372 148 34 $fBody
$btnPanel = New-Button 'Control panel' 186 372 148 34 $fBody
$btnDiscord = New-Button 'Discord' 348 372 148 34 $fBody
$form.Controls.AddRange(@($btnPlay, $btnStart, $btnPanel, $btnDiscord))
$lblNote = New-Label 'Keep this window open while you play.' 24 412 472 $fSmall $cMute
$form.Controls.Add($lblNote)
if (-not $discord) { $btnDiscord.Visible = $false }

# --- state ---------------------------------------------------------------------------------------------------------------------------------
$script:playProc = $null
$script:playLog = Join-Path ([IO.Path]::GetTempPath()) ('wowforever-play-' + $PID + '.log')
$script:updProc = $null
$script:updChecked = $false
$script:startedServer = $false

function Refresh-Status {
    $srv = Current-Server
    $isLocal = Server-IsLocal $srv
    $btnStart.Visible = $isLocal
    $btnRemove.Visible = ($srv.name -ne $ownServer.name)
    $login = Test-Port $srv.address $srv.loginPort
    $world = Test-Port $srv.address $srv.worldPort
    if ($login -and $world) { $lblSrv.Text = 'Online'; $lblSrv.ForeColor = $cGreen }
    elseif ($login -or $world) { $lblSrv.Text = 'Starting...'; $lblSrv.ForeColor = $cAmber }
    else { $lblSrv.Text = $(if ($script:startedServer) { 'Starting... (the first start takes a few minutes)' } else { 'Offline' }); $lblSrv.ForeColor = $(if ($script:startedServer) { $cAmber } else { $cRed }) }
    $lblLogin.Text = $(if ($login) { 'Ready' } else { 'Not available yet' }); $lblLogin.ForeColor = $(if ($login) { $cGreen } else { $cMute })
    if ($login -and $world) { $script:startedServer = $false }
    $btnStart.Enabled = $isLocal -and -not ($login -or $world) -and -not $script:startedServer
    $running = ($script:playProc -and -not $script:playProc.HasExited)
    $btnPlay.Enabled = (-not $running)
    $btnPlay.Text = $(if ($running) { 'GAME RUNNING' } else { 'PLAY' })
    if ($running -and (Test-Path $script:playLog)) {
        try {
            $line = Get-Content $script:playLog -ErrorAction Stop | Where-Object { $_ -match '\S' } | Select-Object -Last 1
            if ($line) { $lblNote.Text = ($line -replace '^\[\d\d:\d\d:\d\d\]\s*', '') }
        } catch { }
    } elseif (-not $running) {
        $lblNote.Text = 'Keep this window open while you play.'
        if ($script:playProc -and $script:playProc.ExitCode -ne 0) {
            $why = $null
            try { $why = Get-Content ($script:playLog + '.err') -ErrorAction Stop | Where-Object { $_ -match '\S' } | Select-Object -First 1 } catch { }
            if (-not $why) { try { $why = Get-Content $script:playLog -ErrorAction Stop | Where-Object { $_ -match '\S' } | Select-Object -Last 1 } catch { } }
            if ($why) { $lblNote.Text = 'Could not start the game: ' + $why; $lblNote.ForeColor = $cRed }
        } else { $lblNote.ForeColor = $cMute }
    }
    # update check: once, in the background
    if (-not $script:updChecked) {
        $script:updChecked = $true
        try {
            $script:updProc = Start-Process powershell -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$here\update.ps1`"", '-Quiet' -PassThru -WindowStyle Hidden
            $null = $script:updProc.Handle   # Windows PowerShell 5.1 leaves ExitCode empty unless the process handle is read right after the start
        } catch { }
    } elseif ($script:updProc -and $script:updProc.HasExited) {
        if ($script:updProc.ExitCode -eq 10) {
            $latest = '?'
            try { $latest = (Get-Content (Join-Path $here 'latest-version.txt') -TotalCount 1).Trim() } catch { }
            $lblUpdate.Text = 'Bots repack ' + $latest + ' is out (you have ' + $version + ').'
            $lblUpdate.Visible = $true; $btnUpdate.Visible = $true
        }
        $script:updProc = $null
    }
}

function Get-ServerIp($srv) {
    $ip = $null
    if ([Net.IPAddress]::TryParse($srv.address, [ref]$ip)) { return $ip.ToString() }
    try {
        $r = [Net.Dns]::GetHostAddresses($srv.address) | Where-Object { $_.AddressFamily -eq 'InterNetwork' } | Select-Object -First 1
        if ($r) { return $r.ToString() }
    } catch { }
    $null
}
# makes the portal name point at the chosen server (hosts file); asks for administrator rights once, only when it has to change
function Ensure-Hosts($srv) {
    $ip = Get-ServerIp $srv
    if (-not $ip) { [Windows.Forms.MessageBox]::Show("Could not find the address '" + $srv.address + "'. Check the spelling and your internet connection.", 'WoW Forever Bots') | Out-Null; return $false }
    $hostsFile = Join-Path $env:SystemRoot 'System32\drivers\etc\hosts'
    $current = $null
    try {
        foreach ($l in Get-Content $hostsFile) {
            $t = ($l -replace '#.*$', '').Trim() -split '\s+'
            if ($t.Count -ge 2 -and ($t[1..($t.Count - 1)] -contains $srv.portal)) { $current = $t[0] }
        }
    } catch { }
    if ($current -eq $ip) { return $true }
    $a = [Windows.Forms.MessageBox]::Show("To connect to '" + $srv.name + "' Windows must be told that " + $srv.portal + " is " + $ip + ". Windows will ask for permission once. Continue?", 'WoW Forever Bots', 'YesNo', 'Question')
    if ($a -ne 'Yes') { return $false }
    try {
        $p = Start-Process powershell -Verb RunAs -Wait -PassThru -WindowStyle Hidden -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$here\Apply-Server.ps1`"", '-Portal', $srv.portal, '-Address', $ip
        $null = $p.Handle   # Windows PowerShell 5.1 leaves ExitCode empty unless the process handle is read right after the start
        if ($p.ExitCode -ne 0) { throw 'The change was not applied.' }
    } catch { [Windows.Forms.MessageBox]::Show('Could not update the hosts file: ' + $_.Exception.Message, 'WoW Forever Bots') | Out-Null; return $false }
    $true
}
function Show-AddServer {
    $d = New-Object Windows.Forms.Form
    $d.Text = 'Add a server'; $d.ClientSize = New-Object Drawing.Size(440, 380); $d.StartPosition = 'CenterParent'
    $d.FormBorderStyle = 'FixedDialog'; $d.MaximizeBox = $false; $d.MinimizeBox = $false; $d.BackColor = $cBg; $d.ForeColor = $cText
    $fields = @(
        @('Name', 'e.g. Sam''s server', ''),
        @('Address', 'IP address or host name', ''),
        @('Portal name', 'ends in .actual.battle.net', 'trinity.actual.battle.net'),
        @('Public key', '64 hex characters', $defaultKey),
        @('Region group', '2-12, not 9', '8'))
    $boxes = @{}
    $y = 18
    foreach ($f in $fields) {
        $d.Controls.Add((New-Label $f[0] 18 ($y + 3) 100 $fBody $cMute))
        $t = New-Object Windows.Forms.TextBox
        $t.Location = New-Object Drawing.Point(124, $y); $t.Size = New-Object Drawing.Size(296, 26); $t.Font = $fBody
        $t.BackColor = $cPanel; $t.ForeColor = $cText; $t.BorderStyle = 'FixedSingle'; $t.Text = $f[2]
        $d.Controls.Add($t); $boxes[$f[0]] = $t
        $d.Controls.Add((New-Label $f[1] 124 ($y + 28) 296 $fSmall $cMute))
        $y += 54
    }
    $help = New-Object Windows.Forms.LinkLabel
    $help.Text = 'How to join a friend (certificate, address)'; $help.Location = New-Object Drawing.Point(18, 292); $help.Size = New-Object Drawing.Size(300, 20)
    $help.Font = $fSmall; $help.LinkColor = $cGold; $help.BackColor = [Drawing.Color]::Transparent
    $help.Add_LinkClicked({ try { Start-Process notepad.exe -ArgumentList ('"' + (Join-Path $here 'JOIN-A-FRIEND.md') + '"') } catch { } })
    $d.Controls.Add($help)
    $ok = New-Button 'Add server' 124 $(($y + 40)) 140 34 $fBody
    $ok.BackColor = $cGold; $ok.ForeColor = [Drawing.Color]::FromArgb(30, 22, 6)
    $cancel = New-Button 'Cancel' 280 $(($y + 40)) 140 34 $fBody
    $d.Controls.AddRange(@($ok, $cancel))
    $d.AcceptButton = $ok; $d.CancelButton = $cancel
    $script:addResult = $null
    $ok.Add_Click({
        $n = $boxes['Name'].Text.Trim(); $ad = $boxes['Address'].Text.Trim(); $po = $boxes['Portal name'].Text.Trim().ToLower()
        $k = $boxes['Public key'].Text.Trim().ToUpper(); $g = 0
        $err = $null
        if (-not $n) { $err = 'Give the server a name.' }
        elseif ($script:servers | Where-Object { $_.name -eq $n }) { $err = 'A server with that name already exists.' }
        elseif (-not $ad -or $ad -match '[\s/]') { $err = 'Enter the IP address or host name of the server.' }
        elseif ($po -notmatch '^[a-z0-9.-]+\.actual\.battle\.net$') { $err = 'The portal name must end in .actual.battle.net.' }
        elseif ($k -notmatch '^[0-9A-F]{64}$') { $err = 'The public key must be 64 hex characters.' }
        elseif (-not [int]::TryParse($boxes['Region group'].Text, [ref]$g) -or $g -lt 2 -or $g -gt 12 -or $g -eq 9) { $err = 'The region group must be 2-12 (not 9).' }
        if ($err) { [Windows.Forms.MessageBox]::Show($err, 'Add a server') | Out-Null; return }
        $script:addResult = New-Server $n $ad $po $k $g 1119 8085
        $d.DialogResult = 'OK'
    }.GetNewClosure())
    [void]$d.ShowDialog($form)
    $script:addResult
}
$btnAdd.Add_Click({
    $n = Show-AddServer
    if ($n) {
        [void]$script:servers.Add($n); $script:selectedName = $n.name; Save-Servers; Fill-Servers; Refresh-Status
    }
})
$btnRemove.Add_Click({
    $srv = Current-Server
    if ($srv.name -eq $ownServer.name) { return }
    $a = [Windows.Forms.MessageBox]::Show("Remove '" + $srv.name + "' from the list?", 'WoW Forever Bots', 'YesNo', 'Question')
    if ($a -eq 'Yes') {
        $script:servers.Remove($srv); $script:selectedName = $ownServer.name; Save-Servers; Fill-Servers; Refresh-Status
    }
})
$cmbServer.Add_SelectedIndexChanged({
    if ($cmbServer.SelectedItem -and $cmbServer.SelectedItem -ne $script:selectedName) {
        $script:selectedName = [string]$cmbServer.SelectedItem; try { Save-Servers } catch { }
        Refresh-Status
    }
})

$btnPlay.Add_Click({
    $srv = Current-Server
    if (-not (Test-Port $srv.address $srv.loginPort)) {
        $a = [Windows.Forms.MessageBox]::Show('The server does not seem to be online. Start the game anyway?', 'WoW Forever Bots', 'YesNo', 'Question')
        if ($a -ne 'Yes') { return }
    }
    if (-not (Ensure-Hosts $srv)) { return }
    Remove-Item $script:playLog -ErrorAction SilentlyContinue
    try {
        $script:playProc = Start-Process powershell -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$here\Play-WoWForever.ps1`"", '-NoUpdateCheck', '-Portal', $srv.portal, '-PublicKey', $srv.publicKey, '-RegionGroup', $srv.regionGroup `
            -RedirectStandardOutput $script:playLog -RedirectStandardError ($script:playLog + '.err') -PassThru -WindowStyle Hidden
    $null = $script:playProc.Handle   # Windows PowerShell 5.1 leaves ExitCode empty unless the process handle is read right after the start
    } catch { [Windows.Forms.MessageBox]::Show($_.Exception.Message, 'WoW Forever Bots') | Out-Null }
    Refresh-Status
})
$btnStart.Add_Click({
    try {
        Start-Process powershell -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$here\Start-WoWForever.ps1`"" -WindowStyle Minimized
        $script:startedServer = $true
    } catch { [Windows.Forms.MessageBox]::Show($_.Exception.Message, 'WoW Forever Bots') | Out-Null }
    Refresh-Status
})
$btnUpdate.Add_Click({
    $msg = 'Install the new Bots repack now? The server is stopped and restarted, characters are kept and a backup is made first.'
    if ($script:playProc -and -not $script:playProc.HasExited) { $msg = 'The game is running. Close it first, then update.'; [Windows.Forms.MessageBox]::Show($msg, 'WoW Forever Bots') | Out-Null; return }
    if ([Windows.Forms.MessageBox]::Show($msg, 'WoW Forever Bots', 'YesNo', 'Question') -eq 'Yes') {
        Start-Process powershell -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$here\Update-Window.ps1`""
    }
})
$btnPanel.Add_Click({ Start-Process (Join-Path $root 'WoW-Forever-Bots.cmd') })
$btnDiscord.Add_Click({ if ($discord) { Start-Process $discord } })

$timer = New-Object Windows.Forms.Timer
$timer.Interval = 2500
$timer.Add_Tick({ try { Refresh-Status } catch { } })

$form.Add_Shown({
    Fill-Servers
    Refresh-Status
    # a failed start shows its reason: if the game script ends with an error, say so
    $timer.Start()
})
$form.Add_FormClosing({
    $timer.Stop()
    if ($script:playProc -and -not $script:playProc.HasExited) {
        $a = [Windows.Forms.MessageBox]::Show('The game is still running. Closing this window stops the login key from being re-applied if you log out and in again. Close anyway?', 'WoW Forever Bots', 'YesNo', 'Question')
        if ($a -ne 'Yes') { $_.Cancel = $true; $timer.Start(); return }
    }
    Remove-Item $script:playLog, ($script:playLog + '.err') -ErrorAction SilentlyContinue
})

if ($SelfTest) {
    $form.Show(); Fill-Servers; Refresh-Status
    "server: $($lblSrv.Text); login: $($lblLogin.Text); version: $($lblVer.Text); icon: $([bool]$form.Icon)"
    $form.Close()
    return
}
[void]$form.ShowDialog()
