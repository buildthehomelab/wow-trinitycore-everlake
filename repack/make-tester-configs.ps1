# Writes worldserver.conf, bnetserver.conf and playerbot.conf for a tester install (relative to this folder, local only).
#   .\make-tester-configs.ps1                 -> auto preset by RAM
#   .\make-tester-configs.ps1 -Preset small   -> small | medium | large
# Presets only change the world-bot crowd; everything else is the verified setup from the dev PC.
#   Existing config files are KEPT (players edit them, e.g. MaxBots). They are written only when missing, or when -Preset or -Force is
#   given on purpose. Custom settings belong in server\worldserver.conf.d\zz-9-local.conf (menu S), which updates never touch.
param([ValidateSet('auto', 'small', 'medium', 'large')][string]$Preset = 'auto', [switch]$Force)
$ErrorActionPreference = 'Stop'
$overwrite = $Force -or $PSBoundParameters.ContainsKey('Preset')
$kept = @()
$root = Split-Path $PSScriptRoot -Parent
$server = Join-Path $root 'server'
$fwd = { param($p) ($p -replace '\\', '/') }
$pw = (Select-String -Path "$root\secrets\mysql.txt" -Pattern '^mysql trinity: (.+)$').Matches[0].Groups[1].Value
if ($Preset -eq 'auto') {
    $gb = [Math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
    $Preset = if ($gb -ge 30) { 'large' } elseif ($gb -ge 16) { 'medium' } else { 'small' }
    "Detected $gb GB RAM -> preset $Preset"
}
# Bot numbers (Bots.* lines, the same as the launcher's Bots button and Fleet/BotSize.h in the bot module). They go into the
# player's own file zz-9-local.conf, never into playerbot.conf: one place for them. About 5 MB of RAM per active bot.
$p = @{
    small  = @{ Size = 'Low';    Reserve = 600;  Cap = 120; Zone = '15-25'; City = 50 }
    medium = @{ Size = 'Normal'; Reserve = 1500; Cap = 250; Zone = '30-45'; City = 80 }
    large  = @{ Size = 'High';   Reserve = 3000; Cap = 500; Zone = '50-70'; City = 120 }
}[$Preset]

function Set-Options($dist, $out, $options) {
    if ((Test-Path $out) -and -not $overwrite) { $script:kept += (Split-Path $out -Leaf); return }
    $text = Get-Content $dist; $extra = [ordered]@{}
    foreach ($key in $options.Keys) {
        $pattern = '^' + [regex]::Escape($key) + '\s*='; $hit = $false
        $text = $text | ForEach-Object { if ($_ -match $pattern) { $hit = $true; "$key = $($options[$key])" } else { $_ } }
        if (-not $hit) { $extra[$key] = $options[$key] }
    }
    if ($extra.Count) { $text += ''; $text += '# Added by make-tester-configs.ps1'; foreach ($k in $extra.Keys) { $text += "$k = $($extra[$k])" } }
    Set-Content -Path $out -Value $text -Encoding ascii
}
. "$PSScriptRoot\mysql-helpers.ps1"
$dbPort = Get-OurMySqlPort $root   # 3307 unless the start moved MySQL to another port (one Windows had reserved)
$db = { param($name) "`"127.0.0.1;$dbPort;trinity;$pw;$name`"" }
New-Item -ItemType Directory -Force "$server\logs", "$server\data" | Out-Null

# Protocol-layer keys for the supported client build (e.g. opcode index shifts) are NOT hard-coded here. They come from
# repack\templates\protocol.conf (lines 'Key = value'), which is written from the final protocol layer's own config once
# that work is verified. If the file is missing, the server's .conf.dist defaults apply.
$protocol = [ordered]@{}
$protoFile = Join-Path $PSScriptRoot 'templates\protocol.conf'
if (Test-Path $protoFile) {
    foreach ($line in Get-Content $protoFile) {
        if ($line -match '^\s*([A-Za-z0-9_.]+)\s*=\s*(.+?)\s*$' -and $line -notmatch '^\s*#') { $protocol[$Matches[1]] = $Matches[2] }
    }
}
$worldOptions = [ordered]@{
    'RealmID' = '70'; 'BindIP' = '"127.0.0.1"'
    'DataDir' = "`"$(& $fwd "$server\data")`""; 'LogsDir' = '"./logs"'
    'LoginDatabaseInfo' = (& $db 'auth'); 'WorldDatabaseInfo' = (& $db 'world')
    'CharacterDatabaseInfo' = (& $db 'characters'); 'HotfixDatabaseInfo' = (& $db 'hotfixes')
    'Expansion' = '0'; 'MaxPlayerLevel' = '60'; 'Classic.Hardcore' = '0';
    'Instance.IgnoreRaid' = '1'; 'Instance.BindOnEntry' = '1'; 'Instance.PersistRaidTrash' = '1'
    'Updates.EnableDatabases' = '15'; 'Updates.AutoSetup' = '1'
    'SourceDirectory' = "`"$(& $fwd $root)`""; 'MySQLExecutable' = "`"$(& $fwd "$root\mysql\bin\mysql.exe")`""
    'Network.EnterEncryptedModeRegionGroup' = '8'
    'Logger.sql.sql' = '6,Console DBErrors'
    # bot module logs
    'Appender.Console' = '1,6,0'
    'Appender.Loading' = '1,3,0'; 'Logger.server.loading' = '3,Loading Server CrashRing'; 'Logger.server.worldserver' = '3,Loading Server CrashRing'
    'Appender.Playerbot' = '2,3,0,Playerbot.log,w'
    'Logger.playerbot.v2' = '3,Playerbot'; 'Logger.playerbot.api' = '3,Playerbot'
    'Logger.instance.locks' = '3,Console Server'; 'Logger.bg.battleground' = '3,Console Server'
    # auction house bot (tester-safe: neutral house only)
    'AuctionHouseBot.Seller.Enabled' = '1'; 'AuctionHouseBot.Buyer.Enabled' = '1'
    'AuctionHouseBot.Buyer.Alliance.Enabled' = '0'; 'AuctionHouseBot.Buyer.Horde.Enabled' = '0'; 'AuctionHouseBot.Buyer.Neutral.Enabled' = '1'
    'AuctionHouseBot.Account' = '2000000001'; 'AuctionHouseBot.Sellers.Count' = '12'
    'AuctionHouseBot.Vanilla.Only' = '1'; 'AuctionHouseBot.Vanilla.MaxReqLevel' = '60'; 'AuctionHouseBot.Vanilla.MaxItemLevel' = '100'
    'AuctionHouseBot.Alliance.Items.Amount.Ratio' = '0'; 'AuctionHouseBot.Horde.Items.Amount.Ratio' = '0'; 'AuctionHouseBot.Neutral.Items.Amount.Ratio' = '100'
    'AuctionHouseBot.Buyer.FairPricing' = '1'; 'AuctionHouseBot.Buyer.DailyBudgetGold' = '5000'; 'AuctionHouseBot.Buyer.MaxBuysPerHour' = '60'
    'PlayerSave.Stats.MinLevel' = '1'
}
foreach ($k in $protocol.Keys) { $worldOptions[$k] = $protocol[$k] }
Set-Options "$server\worldserver.conf.dist" "$server\worldserver.conf" $worldOptions

Set-Options "$server\bnetserver.conf.dist" "$server\bnetserver.conf" ([ordered]@{
    'LogsDir' = '"./logs"'; 'BindIP' = '"127.0.0.1"'
    'LoginDatabaseInfo' = (& $db 'auth')
    'SourceDirectory' = "`"$(& $fwd $root)`""; 'MySQLExecutable' = "`"$(& $fwd "$root\mysql\bin\mysql.exe")`""
    'LoginREST.ExternalAddress' = 'trinity.actual.battle.net'; 'LoginREST.LocalAddress' = 'trinity.actual.battle.net'
    'Realm.CfgContentSetID' = '137'
    'CertificatesFile' = "`"$(& $fwd "$root\certs\chain.pem")`""
    'PrivateKeyFile' = "`"$(& $fwd "$root\certs\server.key")`""
})

$pbDist = "$server\worldserver.conf.d\playerbot.conf.dist"
if (Test-Path $pbDist) {
    Set-Options $pbDist "$server\worldserver.conf.d\playerbot.conf" ([ordered]@{
        'Playerbot.SharedDatabase' = '"playerbot"'
        'Playerbot.Population.TotalTarget' = '0'; 'Playerbot.Population.Floor' = '0'; 'Playerbot.Population.Ceiling' = '0'; 'Playerbot.Population.AutoScale' = '0'
        'Playerbot.Housing.Enabled' = '0'
        'Playerbot.Raid.Enable' = '1'
        'Playerbot.Cast.Enable' = '0'; 'Playerbot.Cast.RaidSpeedPct' = '75'; 'Playerbot.Cast.DungeonSpeedPct' = '90'
        'Playerbot.Cast.WorldSpeedPct' = '100'; 'Playerbot.Cast.BgSpeedPct' = '115'; 'Playerbot.Cast.WorldPvpSpeedPct' = '115'
        'Playerbot.Gear.MaxTier' = '2'
        'Playerbot.Raid.ProvideConsumables' = '1'; 'Playerbot.Consumables.PvE' = '1'; 'Playerbot.Consumables.PvP' = '0'
        'Playerbot.Raid.DpsWaitTimeoutMs' = '8000'
        'Playerbot.Bg.AutoSeed.Matches' = '0'; 'Playerbot.Bg.AutoJoin' = '0'
        'PlayerbotV2.Guilds.Enabled' = '0'; 'PlayerbotV2.SessionRhythm.Enabled' = '0'
        'Playerbot.World.Enable' = '1'; 'Playerbot.World.FriendlyPct' = '100'; 'Playerbot.World.GlobalFill' = '0'; 'Playerbot.World.TownPct' = '100'
        'Playerbot.World.ActivityRadius' = '600'; 'Playerbot.World.SpawnRingMin' = '150'; 'Playerbot.World.SpawnRingMax' = '350'; 'Playerbot.World.AreaCapOutdoors' = '8'
        'Playerbot.World.TickMs' = '500'
        'Playerbot.World.SpawnPerTick' = '6'; 'Playerbot.World.CitySpawnPerTick' = '12'
        'Playerbot.World.FillerHubOnly' = '1'
    })
}
# The player's own file: written once from templates\zz-9-local.conf with the RAM pick, then it is theirs (never overwritten).
# An older own file without Bots.* lines gets the four bot lines under its [worldserver] line, so the bot count is never lost.
$mine = "$server\worldserver.conf.d\zz-9-local.conf"
$botLines = @("# Bots ($($p.Size)): the launcher's Bots button changes these four",
    "Bots.Reserve = $($p.Reserve)", "Bots.ActiveCap = $($p.Cap)", "Bots.PerZone = $($p.Zone)", "Bots.InCity = $($p.City)")
if (-not (Test-Path $mine)) {
    $tpl = Get-Content (Join-Path $PSScriptRoot 'templates\zz-9-local.conf')
    $out = foreach ($l in $tpl) { if ($l -eq '#BOTS#') { $botLines } else { $l } }
    Set-Content -Path $mine -Value $out -Encoding ascii
    "Wrote server\worldserver.conf.d\zz-9-local.conf (your own settings, bots $($p.Size))."
} elseif (-not (Select-String -Path $mine -Pattern '^\s*Bots\.' -Quiet)) {
    $old = Get-Content $mine; $out = @(); $done = $false
    foreach ($l in $old) { $out += $l; if (-not $done -and $l -match '^\s*\[\s*worldserver\s*\]\s*$') { $out += $botLines; $done = $true } }
    if (-not $done) { $out = @('[worldserver]') + $botLines + $old }
    Copy-Item $mine "$mine.bak" -Force
    Set-Content -Path $mine -Value $out -Encoding ascii
    "Added the bot lines ($($p.Size)) to your zz-9-local.conf (old copy: zz-9-local.conf.bak)."
}
if ($kept.Count) { "Kept your existing $($kept -join ', ') (not changed). Put your own settings in server\worldserver.conf.d\zz-9-local.conf (menu S); updates never touch it." }
if ($overwrite) { "Wrote server\worldserver.conf, bnetserver.conf and playerbot.conf (preset $Preset). Restart the server to apply." }
else { "Config files written where missing (preset $Preset). To change the bot crowd later, run make-tester-configs.ps1 -Preset small|medium|large (this rewrites the three files), then restart." }
