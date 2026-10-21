# A small window with an "Update" button. It runs update.ps1 and shows what it does. Windows PowerShell 5.1.
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$here = $PSScriptRoot
$form = New-Object System.Windows.Forms.Form
$form.Text = 'WoW Forever Bots - Update'; $form.Size = New-Object System.Drawing.Size(640, 460); $form.StartPosition = 'CenterScreen'
$status = New-Object System.Windows.Forms.Label
$status.Location = New-Object System.Drawing.Point(12, 12); $status.Size = New-Object System.Drawing.Size(600, 24); $status.Text = 'Checking for updates...'
$status.Font = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$btn = New-Object System.Windows.Forms.Button
$btn.Location = New-Object System.Drawing.Point(12, 44); $btn.Size = New-Object System.Drawing.Size(180, 34); $btn.Text = 'Update now'; $btn.Enabled = $false
$log = New-Object System.Windows.Forms.TextBox
$log.Location = New-Object System.Drawing.Point(12, 90); $log.Size = New-Object System.Drawing.Size(600, 320)
$log.Multiline = $true; $log.ScrollBars = 'Vertical'; $log.ReadOnly = $true; $log.Font = New-Object System.Drawing.Font('Consolas', 9)
$form.Controls.AddRange(@($status, $btn, $log))

# The updater runs as a hidden child process that writes to a file; a timer on the window tails that file
# (event handlers on process output do not work reliably in Windows PowerShell).
$script:proc = $null; $script:outFile = $null; $script:pos = 0; $script:onLine = $null; $script:onDone = $null
$timer = New-Object System.Windows.Forms.Timer; $timer.Interval = 400
function Read-NewText {
    if (-not (Test-Path $script:outFile)) { return '' }
    $fs = [IO.File]::Open($script:outFile, 'Open', 'Read', 'ReadWrite')
    try {
        [void]$fs.Seek($script:pos, 'Begin')
        $sr = New-Object IO.StreamReader($fs, [Text.Encoding]::UTF8)
        $t = $sr.ReadToEnd(); $script:pos = $fs.Position; return $t
    } finally { $fs.Dispose() }
}
$timer.Add_Tick({
    $t = Read-NewText
    if ($t) { & $script:onLine $t }
    if ($script:proc.HasExited) {
        $timer.Stop()
        $t = Read-NewText; if ($t) { & $script:onLine $t }
        $script:proc.WaitForExit()   # without this Windows PowerShell 5.1 can leave ExitCode empty for a process started with redirected output
        & $script:onDone $script:proc.ExitCode
    }
})
function Run-Updater($extraArgs, $onLine, $onDone) {
    $script:outFile = Join-Path $env:TEMP ('wf-update-' + [guid]::NewGuid().ToString('N') + '.txt'); $script:pos = 0
    $script:onLine = $onLine; $script:onDone = $onDone
    $argList = "-NoProfile -ExecutionPolicy Bypass -File `"$here\update.ps1`" $extraArgs"
    $script:proc = Start-Process powershell.exe -ArgumentList $argList -WindowStyle Hidden -PassThru -RedirectStandardOutput $script:outFile -RedirectStandardError ($script:outFile + '.err')
    $null = $script:proc.Handle   # Windows PowerShell 5.1 leaves ExitCode empty unless the process handle is read right after the start
    $timer.Start()
}

$script:updateAvailable = $false
function Check {
    $log.Text = ''
    Run-Updater '-CheckOnly' { param($t) $log.AppendText($t.Replace("`n", "`r`n")); if ($t -match 'An update is available') { $script:updateAvailable = $true } } {
        param($code)
        if ($script:updateAvailable) { $status.Text = 'A new version is ready.'; $btn.Enabled = $true }
        elseif ($log.Text -match 'up to date') { $status.Text = 'You are up to date.' }
        else { $status.Text = 'Could not check. Are you online?' }
    }
}
$btn.Add_Click({
    $btn.Enabled = $false; $status.Text = 'Updating: please do not close this window...'; $log.Text = ''
    Run-Updater '' { param($t) $log.AppendText($t.Replace("`n", "`r`n")) } {
        param($code)
        $finished = ($code -eq 0) -or (($null -eq $code -or "$code" -eq '') -and $log.Text -match 'Installed version' -and $log.Text -notmatch 'Update stopped')
        if ($finished) { $status.Text = 'Done. The server is running the new version.' } else { $status.Text = 'The update did not finish. See the text below.' }
    }
})
$form.Add_Shown({ Check })
[void]$form.ShowDialog()
