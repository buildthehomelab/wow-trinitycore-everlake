# AI bots and bot chat (Playerbot.Bridge.*, Playerbot.ChatModel.*): Ollama and the AI program run only while the realm runs.
# Dot-sourced by Start-WoWForever.ps1, AutoRestart-WoWForever.ps1 and Stop-WoWForever.ps1.
# Start-BotChat <root>: when AI bots or bot chat are on, starts an installed Ollama ("ollama serve", hidden) if it is not
#   answering yet, and when AI bots are on (config\ai-bots.txt, the launcher's AI BOTS tab) the AI program
#   (repack\bot-bridge\bot_bridge_ollama.py with the launcher's Python in ai-bots\python), hidden, if it is not running yet.
# Stop-BotChat <root>: ends the AI program, and when the launcher installed Ollama (config\bot-chat.txt says managed=1) shuts
#   Ollama down with the realm, so it does not hold memory while nobody plays. An Ollama the player installed and runs
#   themselves is left alone.

# the realm's setting as it will read it: worldserver.conf, then worldserver.conf.d by name; the last line wins
function Test-BotChatOn([string]$Root) {
    $server = Join-Path $Root 'server'
    $files = @()
    $main = Join-Path $server 'worldserver.conf'
    if (Test-Path $main) { $files += $main }
    $files += @(Get-ChildItem (Join-Path $server 'worldserver.conf.d') -Filter '*.conf' -File -Recurse -ErrorAction SilentlyContinue |
        Sort-Object FullName | ForEach-Object FullName)
    $on = $false
    foreach ($f in $files) {
        foreach ($l in (Get-Content $f -ErrorAction SilentlyContinue)) {
            if ($l -match '^\s*Playerbot\.ChatModel\.Enable\s*=\s*"?(\w+)"?') { $on = ($Matches[1] -eq '1' -or $Matches[1] -eq 'true') }
        }
    }
    return $on
}

# ollama.exe: where its installer puts it, a folder chosen at install time (Windows' list of installed programs), or PATH
function Find-Ollama {
    $c = @((Join-Path $env:LOCALAPPDATA 'Programs\Ollama\ollama.exe'), (Join-Path $env:ProgramFiles 'Ollama\ollama.exe'))
    foreach ($k in 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*', 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
                   'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*') {
        Get-ItemProperty $k -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -like 'Ollama*' -and $_.InstallLocation } |
            ForEach-Object { $c += (Join-Path $_.InstallLocation 'ollama.exe') }
    }
    $cmd = Get-Command ollama.exe -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($cmd) { $c += $cmd.Source }
    foreach ($p in $c) { if ($p -and (Test-Path $p)) { return $p } }
    return $null
}

function Test-OllamaUp {
    $t = New-Object Net.Sockets.TcpClient
    try { return $t.BeginConnect('127.0.0.1', 11434, $null, $null).AsyncWaitHandle.WaitOne(500) -and $t.Connected } catch { return $false } finally { $t.Close() }
}

# config\ai-bots.txt as the launcher's AI BOTS tab wrote it: on, model, workers, swearing
function Get-AiBots([string]$Root) {
    $c = @{ on = $false; model = ''; workers = '2'; swearing = $false }
    $f = Join-Path $Root 'config\ai-bots.txt'
    foreach ($l in (Get-Content $f -ErrorAction SilentlyContinue)) {
        if ($l -match '^\s*on\s*=\s*1\s*$') { $c.on = $true }
        elseif ($l -match '^\s*model\s*=\s*([A-Za-z0-9._:/-]+)\s*$') { $c.model = $Matches[1] }
        elseif ($l -match '^\s*workers\s*=\s*(\d+)\s*$') { $c.workers = $Matches[1] }
        elseif ($l -match '^\s*swearing\s*=\s*1\s*$') { $c.swearing = $true }
    }
    return $c
}

# the server folder (config\server-dir.txt on a developer's tree, as the launcher reads it)
function Get-ServerDir([string]$Root) {
    $f = Join-Path $Root 'config\server-dir.txt'
    $v = Get-Content $f -ErrorAction SilentlyContinue | Where-Object { $_.Trim() -and -not $_.Trim().StartsWith('#') } | Select-Object -First 1
    if ($v) {
        $p = if ([IO.Path]::IsPathRooted($v.Trim())) { $v.Trim() } else { Join-Path $Root $v.Trim() }
        if (Test-Path $p -PathType Container) { return $p }
    }
    return (Join-Path $Root 'server')
}

# the launcher's Python running the AI program (any other python.exe on the PC is not ours)
function Get-AiProgram([string]$Root) {
    $exe = [IO.Path]::GetFullPath((Join-Path $Root 'ai-bots\python\python.exe'))
    @(Get-Process python -ErrorAction SilentlyContinue | Where-Object { $_.Path -and ([IO.Path]::GetFullPath($_.Path) -ieq $exe) })
}

function Start-AiBots([string]$Root) {
    $c = Get-AiBots $Root
    if (-not $c.on -or -not $c.model) { return }
    if ((Get-AiProgram $Root).Count) { 'AI bots: the AI program is running.'; return }
    $py = Join-Path $Root 'ai-bots\python\python.exe'
    $prog = Join-Path $Root 'repack\bot-bridge\bot_bridge_ollama.py'
    if (-not (Test-Path $py) -or -not (Test-Path $prog)) {
        Write-Warning 'AI bots are on but the AI program is missing: bots use their usual lines. In the launcher, AI BOTS tab, press Check and turn on.'
        return
    }
    $bridge = Join-Path (Get-ServerDir $Root) 'BotBridge'
    New-Item -ItemType Directory -Force $bridge | Out-Null   # the realm makes it at its first start with the bridge on; the program needs it now
    $log = Join-Path $Root 'ai-bots\program.log'
    $a = @("`"$prog`"", "`"$bridge`"", '--model', "`"$($c.model)`"", '--workers', $c.workers, '--log', "`"$log`"")
    if (-not $c.swearing) { $a += '--no-swearing' }
    Start-Process $py -ArgumentList $a -WorkingDirectory (Split-Path $prog) -WindowStyle Hidden
    "AI bots: the AI program started ($($c.model))."
}

function Start-BotChat([string]$Root) {
    $ai = (Get-AiBots $Root).on
    if (-not $ai -and -not (Test-BotChatOn $Root)) { return }
    Start-Ollama $Root
    if ($ai) { Start-AiBots $Root }
}

# With AI bots on, Ollama works on as many answers at once as the AI program sends (OLLAMA_NUM_PARALLEL = its workers; Ollama
# reads it only when it starts, and alone it answers one call at a time). An Ollama that already runs keeps what it has.
function Start-Ollama([string]$Root) {
    if (Test-OllamaUp) { 'Bot chat: Ollama is running.'; return }
    $exe = Find-Ollama
    if (-not $exe) { Write-Warning 'AI bots or bot chat are on but Ollama is not installed: bots use their usual lines. In the launcher, AI BOTS tab, press Check and turn on to install it.'; return }
    $c = Get-AiBots $Root
    if ($c.on) { $env:OLLAMA_NUM_PARALLEL = $c.workers }
    Start-Process $exe -ArgumentList 'serve' -WorkingDirectory (Split-Path $exe) -WindowStyle Hidden
    'Bot chat: Ollama started.'
}

function Stop-BotChat([string]$Root) {
    $p = Get-AiProgram $Root
    if ($p.Count) { $p | Stop-Process -Force -ErrorAction SilentlyContinue; 'AI bots: the AI program stopped.' }
    $f = Join-Path $Root 'config\bot-chat.txt'
    if (-not (Test-Path $f)) { return }   # bot chat was never switched on: nothing to stop, and no red error on every stop
    if (-not (Select-String -Path $f -Pattern '^\s*managed\s*=\s*1' -Quiet -ErrorAction SilentlyContinue)) { return }
    $p = @(Get-Process 'ollama app', 'ollama', 'ollama_llama_server' -ErrorAction SilentlyContinue)
    if (-not $p.Count) { return }
    $p | Stop-Process -Force -ErrorAction SilentlyContinue
    'Bot chat: Ollama stopped.'
}
