# Set-ClientLanguageConf <server folder>: called before every worldserver start (Start-WoWForever.ps1, AutoRestart-WoWForever.ps1).
# The realm file sets Load.Locales = 0 (English client, saves RAM), so a Russian or other non-English client got every quest and NPC
# text in English. server\data\dbc holds the language of the client the data was extracted from: for a non-English one, the locale
# strings are turned on in a file of their own (read after the realm file and before zz-9-local.conf, where Load.Locales = 0 still wins).
function Set-ClientLanguageConf([string]$Server) {
    $conf = Join-Path $Server 'worldserver.conf.d\zz-2-client-language.conf'
    $langs = @(Get-ChildItem (Join-Path $Server 'data\dbc') -Directory -ErrorAction SilentlyContinue | ForEach-Object Name | Where-Object { $_ -notin 'enUS', 'enGB' })
    if ($langs.Count -gt 0) {
        Set-Content $conf "[worldserver]`r`n# Written by repack\ClientLanguage.ps1 on every start: the game data is $($langs -join ', '), so quests and NPCs are sent in that language.`r`nLoad.Locales = 1`r`n" -Encoding ascii
    } else { Remove-Item $conf -ErrorAction SilentlyContinue }
    # A settings file without a section line is read without an error and every setting in it is ignored (Config.cpp takes the
    # first section's children), so a zz-9-local.conf written by hand with only 'Load.Locales = 1' did nothing: give it the line.
    $local = Join-Path $Server 'worldserver.conf.d\zz-9-local.conf'
    if ((Test-Path $local) -and -not (Select-String -Path $local -Pattern '^\s*\[' -Quiet)) {
        # byte copy: whatever encoding the player saved the file in stays as it was
        [IO.File]::WriteAllBytes($local, [Text.Encoding]::ASCII.GetBytes("[worldserver]`r`n") + [IO.File]::ReadAllBytes($local))
    }
}
