# Bot chat (Playerbot.ChatModel.*): Ollama runs only while the realm runs. Dot-sourced by Start-WoWForever.ps1,
# AutoRestart-WoWForever.ps1 and Stop-WoWForever.ps1.
# Start-BotChat <root>: when bot chat is on, starts an installed Ollama ("ollama serve", hidden) if it is not answering yet.
# Stop-BotChat <root>: when the launcher installed Ollama (config\bot-chat.txt says managed=1), shuts Ollama down with the realm,
# so it does not hold memory while nobody plays. An Ollama the player installed and runs themselves is left alone.

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

function Start-BotChat([string]$Root) {
    if (-not (Test-BotChatOn $Root)) { return }
    if (Test-OllamaUp) { 'Bot chat: Ollama is running.'; return }
    $exe = Find-Ollama
    if (-not $exe) { Write-Warning 'Bot chat is on but Ollama is not installed: bots use their usual lines. Turn it on again in the launcher (Settings, Bot chat) to install it.'; return }
    Start-Process $exe -ArgumentList 'serve' -WorkingDirectory (Split-Path $exe) -WindowStyle Hidden
    'Bot chat: Ollama started.'
}

function Stop-BotChat([string]$Root) {
    $f = Join-Path $Root 'config\bot-chat.txt'
    if (-not (Select-String -Path $f -Pattern '^\s*managed\s*=\s*1' -Quiet -ErrorAction SilentlyContinue)) { return }
    $p = @(Get-Process 'ollama app', 'ollama', 'ollama_llama_server' -ErrorAction SilentlyContinue)
    if (-not $p.Count) { return }
    $p | Stop-Process -Force -ErrorAction SilentlyContinue
    'Bot chat: Ollama stopped.'
}
