# Builds worldserver.conf and bnetserver.conf from the installed .conf.dist files.
# DB password comes from secrets\mysql.txt, so the generated .conf files are never committed.
# Re-run after every install (new .conf.dist) to pick up new options.
#   .\make-configs.ps1                     -> server\      (plain Forever server)
#   .\make-configs.ps1 -Server server-bot  -> server-bot\  (PlayerbotV2 build; also writes playerbot.conf)
# Both servers use the same game data (server\data) and the same databases.
param([string]$Server = 'server')
. "$PSScriptRoot\common.ps1"
$server = Join-Path $root $Server
$data   = ("$root\server\data" -replace '\\','/')
$pw     = (Select-String -Path "$root\secrets\mysql.txt" -Pattern '^mysql trinity: (.+)$').Matches[0].Groups[1].Value
$src    = ("$repoRoot" -replace '\\','/')
$mysql  = 'C:/local/mysql-8.4.11/bin/mysql.exe'
New-Item -ItemType Directory -Force "$root\server\data","$server\logs" | Out-Null

function Set-Options($dist, $out, $options, $extra) {
    # $extra holds additional per-server options; merge them so keys already in the .dist get replaced, not duplicated
    foreach ($key in @($extra.Keys)) { $options[$key] = $extra[$key] }
    $extra = [ordered]@{}
    $text = Get-Content $dist
    foreach ($key in $options.Keys) {
        $pattern = '^' + [regex]::Escape($key) + '\s*='
        $hit = $false
        $text = $text | ForEach-Object {
            if ($_ -match $pattern) { $hit = $true; "$key = $($options[$key])" } else { $_ }
        }
        if (-not $hit) { $extra[$key] = $options[$key] }
    }
    if ($extra.Count) {
        $text += ''
        $text += '# Added by scripts\make-configs.ps1 (not in .conf.dist)'
        foreach ($key in $extra.Keys) { $text += "$key = $($extra[$key])" }
    }
    Set-Content -Path $out -Value $text -Encoding ascii
}

$db = { param($name) "`"127.0.0.1;3306;trinity;$pw;$name`"" }

# Realm.AlsoAcceptBuilds must never be blanked by a re-run: the dev realm is on 70707 and the 70790/70755 clients only see it through this list
# (a blank value gave "No realms are currently available" after the 0.1.31 install). Merge the value already in bnetserver.conf / worldserver.conf
# with the full list below: every default build plus any extra build the user added, newest first, each once. Keeping only the saved value
# left a new client out (70862 on 7 November 2026: the saved 70840 list stayed). Both servers need it (worldserver builds the realm entry for
# character create).
$defaultAlso = '70888,70862,70840,70790,70755,70685,70658,70634,70630,70532'
$savedAlso = $null
foreach ($f in "$server\bnetserver.conf", "$server\worldserver.conf") {
    if ((-not $savedAlso) -and (Test-Path $f)) {
        $m = Select-String -Path $f -Pattern '^\s*Realm\.AlsoAcceptBuilds\s*=\s*"([\d,\s]+)"' | Select-Object -First 1
        if ($m) { $savedAlso = $m.Matches[0].Groups[1].Value.Trim() }
    }
}
$alsoBuilds = (@(("$defaultAlso,$savedAlso" -split '[,\s]+') | Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ } |
    Sort-Object -Descending -Unique) -join ',')

# BindIP 127.0.0.1: local only, so Windows never shows a firewall prompt.
Set-Options "$server\worldserver.conf.dist" "$server\worldserver.conf" ([ordered]@{
    'RealmID'                               = '70'
    'BindIP'                                = '"127.0.0.1"'
    'DataDir'                               = "`"$data`""
    'LogsDir'                               = '"./logs"'
    'LoginDatabaseInfo'                     = (& $db 'auth')
    'WorldDatabaseInfo'                     = (& $db 'world')
    'CharacterDatabaseInfo'                 = (& $db 'characters')
    'HotfixDatabaseInfo'                    = (& $db 'hotfixes')
    'SourceDirectory'                       = "`"$src`""
    'MySQLExecutable'                       = "`"$mysql`""
    'Expansion'                             = '0'
    'Realm.AlsoAcceptBuilds'                = "`"$alsoBuilds`""
    'MaxPlayerLevel'                        = '60'
    'Classic.Hardcore'                      = '0'
    # enUS only (the client and the extracted data are enUS): the query cache and locale strings were built for all 13 locales (RAM)
    'Load.Locales'                          = '0'
    # A solo player (no raid group) may walk into a raid instance and call the bots inside (core Map::PlayerCannotEnter / Player::CheckInstanceValidity)
    'Instance.IgnoreRaid'                   = '1'
    # Raids keep their lockout: real players are bound on entry and killed raid trash stays dead until the weekly reset (core Map.cpp / Creature.cpp)
    'Instance.BindOnEntry'                  = '1'
    'Instance.PersistRaidTrash'             = '1'
    # chris's own server only (every optional switch is 0 in the release): no runes / all MC bosses up, no attunements, AQ gates open, trash stays dead
    'Instance.MoltenCoreSkipRunes'          = '1'
    'Instance.IgnoreAttunement'             = '1'
    'Instance.AhnQirajGatesOpen'            = '1'
    # advocaite's in-game Store: 0 (his default) answers the product list with "nothing for sale" and the Shop window stays on Loading
    'Classic.Shop.Enabled'                  = '1'
    'Updates.EnableDatabases'               = '15'
    'Updates.AutoSetup'                     = '1'
    'Network.SkipBuildAuthKeyCheck'         = '1'
    'Network.EnterEncryptedModeRegionGroup' = '8'
    # The converted vanilla world logs ~600 MB of DB errors per start; keep only fatal ones (disk rule)
    'Logger.sql.sql'                        = '6,Console DBErrors'
}) $(if (Test-Path "$server\worldserver.conf.d\playerbot.conf.dist") {
    # Bot server: module logs go to Server.log only; the console window shows fatal messages only, so chris can
    # type commands without the window being flooded (bot reputation/path spam).
    [ordered]@{
        # Auction house bot (core AuctionHouseBot + vanilla filter, playerbot-v2-ahbot): fills all three houses and
        # buys player listings. Keys are ignored by builds without the filter. 1 = on, change to 0 to switch off.
        'AuctionHouseBot.Seller.Enabled'      = '1'
        'AuctionHouseBot.Buyer.Alliance.Enabled' = '0'
        'AuctionHouseBot.Buyer.Horde.Enabled' = '0'
        'AuctionHouseBot.Buyer.Neutral.Enabled' = '1'
        # Named sellers: a reserved account id (no real account) topped up to 12 characters at startup.
        # The id must stay under 2147483647 (the core reads it as a signed int).
        'AuctionHouseBot.Account'             = '2000000001'
        'AuctionHouseBot.Sellers.Count'       = '12'
        'Logger.ahbot'                        = '3,Console Server'
        # Save character stats (maxhealth, stamina, spell power, crit) to characters.character_stats on logout, for checks
        'PlayerSave.Stats.MinLevel'           = '1'
        # [bg_join] payload / queue lines are INFO on bg.battleground (Logger.root is error-only)
        'Logger.bg.battleground'              = '3,Console Server'   # also [bg_port] / [bg_leave]
        'Logger.instance.locks'               = '3,Console Server'   # [raid_lock] and lock removals (INFO)
        # Unhandled opcodes are ERROR here anyway; INFO adds only the ClubFinder/GroupFinder payload lines (no per-packet trace)
        'Logger.network.opcode'               = '3,Console Server'
        'AuctionHouseBot.Vanilla.Only'        = '1'
        'AuctionHouseBot.Vanilla.MaxReqLevel' = '60'
        'AuctionHouseBot.Vanilla.MaxItemLevel' = '100'
        'AuctionHouseBot.Items.Amount.White'  = '3500'
        'AuctionHouseBot.Items.Amount.Green'  = '3500'
        'AuctionHouseBot.Items.Amount.Blue'   = '1200'
        'AuctionHouseBot.Items.Amount.Purple' = '250'
        'AuctionHouseBot.Vanilla.ValueCurve'  = '1'
        # Copper per item level squared by quality: level 60 blue ~40g, level 66 epic ~390g (vanilla-like)
        'AuctionHouseBot.Vanilla.ValueCurve.Gray'  = '1'
        'AuctionHouseBot.Vanilla.ValueCurve.White' = '2'
        'AuctionHouseBot.Vanilla.ValueCurve.Green' = '28'
        'AuctionHouseBot.Vanilla.ValueCurve.Blue'  = '110'
        'AuctionHouseBot.Vanilla.ValueCurve.Epic'  = '900'
        'AuctionHouseBot.Items.Vendor'        = '1'
        'AuctionHouseBot.Items.Crafted'       = '1'
        'AuctionHouseBot.Items.Crafted.MinStock' = '1'
        # Buyer: bots buy player listings at fair prices, with a natural delay and a daily budget
        # Master buyer switch: without it the per-house buyer keys are ignored and nothing is ever bought
        'AuctionHouseBot.Buyer.Enabled'            = '1'
        # Fair-price buying: always buys at or under fair value, tapering to 35% chance at the 1.5x cap; recheck every 5 min
        'AuctionHouseBot.Buyer.FairPricing'        = '1'
        'AuctionHouseBot.Buyer.FairMinChance'      = '35'
        'AuctionHouseBot.Buyer.Recheck.Interval'   = '5'
        # AllowTwoSide.Interaction.Auction=1 means every auctioneer uses the Neutral house: stock and buy only there
        'AuctionHouseBot.Alliance.Items.Amount.Ratio' = '0'
        'AuctionHouseBot.Horde.Items.Amount.Ratio' = '0'
        'AuctionHouseBot.Neutral.Items.Amount.Ratio' = '100'
        'AuctionHouseBot.Buyer.Commodities'        = '1'
        'AuctionHouseBot.Buyer.MaxPriceMultiplier' = '1.5'
        'AuctionHouseBot.Buyer.MinDelay'           = '30'
        'AuctionHouseBot.Buyer.MaxDelay'           = '600'
        'AuctionHouseBot.Buyer.DailyBudgetGold'    = '5000'
        'AuctionHouseBot.Buyer.MaxBuysPerHour'     = '60'
        # Broader stock: weight towards trade goods, consumables, recipes, reagents, bags and ammo; varied stacks; faster restock
        'AuctionHouseBot.Class.WeightByPoolSize' = '1'
        'AuctionHouseBot.Class.TradeGood'     = '10'
        'AuctionHouseBot.Class.Consumable'    = '8'
        'AuctionHouseBot.Class.Recipe'        = '3'
        'AuctionHouseBot.Class.Container'     = '5'
        'AuctionHouseBot.Class.Weapon'        = '6'
        'AuctionHouseBot.Class.Armor'         = '6'
        'AuctionHouseBot.Class.Reagent'       = '2'
        'AuctionHouseBot.Class.Projectile'    = '3'
        'AuctionHouseBot.Class.Misc'          = '2'
        'AuctionHouseBot.Class.Quest'         = '0'
        'AuctionHouseBot.Class.Key'           = '0'
        'AuctionHouseBot.Class.Gem'           = '0'
        'AuctionHouseBot.Class.Glyph'         = '0'
        'AuctionHouseBot.Class.RandomStackRatio.Consumable' = '50'
        'AuctionHouseBot.Class.RandomStackRatio.TradeGood'  = '80'
        'AuctionHouseBot.Update.Interval'     = '10'
        'AuctionHouseBot.ItemsPerCycle.Normal' = '100'
        'Appender.Console'     = '1,6,0'
        'Appender.Playerbot'   = '2,3,1,Playerbot.log,w'   # bot module logs in their own file, rewritten each start
        'Logger.playerbot.v2'  = '3,Playerbot'
        'Logger.playerbot.api' = '3,Playerbot'
        'Appender.Chat'        = '2,2,1,Chat.log,a'        # all chat with a timestamp prefix (flag 1), appended across restarts
        'Logger.chat.log'      = '2,Chat'                  # chat_log.cpp logs at DEBUG
        'Logger.chat.log.whisper' = '2,Chat'                # whispers, to see what happens to /w to a bot
    }
} else { [ordered]@{} })

Set-Options "$server\bnetserver.conf.dist" "$server\bnetserver.conf" ([ordered]@{
    'LogsDir'                   = '"./logs"'
    'BindIP'                    = '"127.0.0.1"'
    'LoginDatabaseInfo'         = (& $db 'auth')
    'SourceDirectory'           = "`"$src`""
    'MySQLExecutable'           = "`"$mysql`""
    'LoginREST.ExternalAddress' = 'trinity.actual.battle.net'
    'LoginREST.LocalAddress'    = 'trinity.actual.battle.net'
    'Realm.CfgContentSetID'     = '137'
    'Realm.AlsoAcceptBuilds'    = "`"$alsoBuilds`""
    # Cert for trinity.actual.battle.net signed by our local CA (secrets\tls, never committed)
    'CertificatesFile'          = "`"$(($root -replace '\\','/'))/secrets/tls/server.chain.pem`""
    'PrivateKeyFile'            = "`"$(($root -replace '\\','/'))/secrets/tls/server.key.pem`""
}) ([ordered]@{})
"Wrote $server\worldserver.conf and $server\bnetserver.conf"

# PlayerbotV2: short playerbot.conf. Only the settings that differ from the built-in defaults are written; every other
# key is documented in playerbot.conf.dist next to it and keeps its default until added here.
$pbDist = "$server\worldserver.conf.d\playerbot.conf.dist"
if (Test-Path $pbDist) {
    $pbLines = @(
        '# Written by scripts\make-configs.ps1. Only the settings that differ from the built-in defaults are listed here.',
        '# All other options, with their documentation, are in playerbot.conf.dist in this folder; copy a line over to change it.',
        '',
        '# The config loader reads only the first section of a file in worldserver.conf.d, so this header must stay the first line that is not a comment.',
        '[playerbot]',
        '',
        '# Shared bot schema',
        'Playerbot.SharedDatabase = "playerbot"',
        '',
        '# World bots (ambient characters around players). 0 switches them off; restart the server after changing it.',
        'Playerbot.World.Enable = 1',
        '',
        '# World bot sizing (sized for a 32 GB PC; the built-in defaults are smaller)',
        'Playerbot.World.MaxBots = 220',
        'Playerbot.World.BotsPerPlayer = 160',
        'Playerbot.World.CityBots = 160',
        'Playerbot.World.ZoneBots = 48',
        'Playerbot.World.ActivityRadius = 600',
        'Playerbot.World.SpawnRingMin = 150',
        'Playerbot.World.SpawnRingMax = 350',
        'Playerbot.World.AreaCapOutdoors = 8',
        'Playerbot.World.PoolMax = 3000',
        'Playerbot.World.TickMs = 500',
        'Playerbot.World.SpawnPerTick = 8',
        'Playerbot.World.CitySpawnPerTick = 20',
        'Playerbot.World.WakeRadius = 450',
        'Playerbot.World.RssBudgetMb = 9000',
        'Playerbot.World.SeedRoster = 1',
        'Playerbot.World.SeedInFlight = 12',
        '',
        '# No add-on download hint whispered to players who log in without the add-on',
        'Playerbot.AddonHint.Enable = 0',
        '',
        '# Core settings the bots were tested with',
        'Pathfinding.SlopeCoefficient = 1.0',
        'HandcraftedRoads.Enable = 1',
        'RoadGraph.Enable = 1',
        '',
        '# Bot battlegrounds: Alterac Valley starts at 20 a side',
        'Playerbot.Bg.Av.MinPlayersPerTeam = 20',
        '',
        '# Bots kept supplied: in the open world, consumables on (flask/elixirs, scrolls, food, weapon stone, 58+), world buffs off',
        'Playerbot.AlwaysBuffs.WorldBuffs.World = 0',
        'Playerbot.AlwaysBuffs.Consumables.World = 1',
        '',
        '# Logging: bot module logs in their own file, rewritten each start',
        'Appender.Playerbot = 2,3,1,Playerbot.log,w',
        'Logger.playerbot.v2 = 3,Playerbot',
        'Logger.playerbot.api = 3,Playerbot'
    )
    Set-Content -Path "$server\worldserver.conf.d\playerbot.conf" -Value $pbLines -Encoding ascii
    "Wrote $server\worldserver.conf.d\playerbot.conf (short: only non-default settings)"
}
