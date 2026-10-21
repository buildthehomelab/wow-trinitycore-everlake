# Values scripts\install.ps1 asserts in the generated configs. Keep this in step with make-configs.ps1: when a setting is
# changed on purpose, change it in both places (the assertion is what catches a config that silently reverted).
# Only list settings that are decided; anything still being worked on (protocol-layer keys) stays out until verified.
@{
    world = @{
        RealmID                             = '70'
        BindIP                              = '127.0.0.1'
        Expansion                           = '0'
        MaxPlayerLevel                      = '60'
        'Instance.BindOnEntry'              = '1'
        'Instance.PersistRaidTrash'         = '1'
        'Instance.IgnoreRaid'               = '1'
        'Network.SkipBuildAuthKeyCheck'     = '1'
        'Updates.EnableDatabases'           = '15'
    }
    playerbot = @{
        'Playerbot.SharedDatabase'          = 'playerbot'
        'Playerbot.World.Enable'            = '1'
        'RoadGraph.Enable'                  = '1'
        'Playerbot.World.MaxBots'           = '220'
        'Playerbot.World.BotsPerPlayer'     = '160'
        'Playerbot.World.CityBots'          = '160'
        'Playerbot.World.ZoneBots'          = '60'
        'Playerbot.World.PoolMax'           = '3000'
        'Playerbot.AddonHint.Enable'        = '0'
        'Playerbot.World.ActivityRadius'    = '600'
        'Playerbot.World.TickMs'            = '500'
        'Playerbot.World.SpawnPerTick'      = '8'
        'Playerbot.World.CitySpawnPerTick'  = '20'
        'Playerbot.World.WakeRadius'        = '450'
        'Playerbot.World.RssBudgetMb'       = '9000'
        'Playerbot.World.SeedRoster'        = '1'
        'Playerbot.World.SeedInFlight'      = '12'
        'Playerbot.Bg.Av.MinPlayersPerTeam' = '20'
        'Pathfinding.SlopeCoefficient'      = '1.0'
        'HandcraftedRoads.Enable'           = '1'
    }
    bnet = @{
        BindIP                              = '127.0.0.1'
        'LoginREST.ExternalAddress'         = 'trinity.actual.battle.net'
        'Realm.CfgContentSetID'             = '137'
    }
}
