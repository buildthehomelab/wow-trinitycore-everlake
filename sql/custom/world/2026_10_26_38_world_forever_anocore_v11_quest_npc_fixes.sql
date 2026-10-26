-- AnoCore v11 changelog (Quests / NPCs and world) items that were still wrong in our world.

-- "Troll warlocks get Tainted Tablet instead of the orc quest Tainted Parchment": Tainted Tablet 98575 is the troll quest,
-- Tainted Parchment 3090 was still offered to trolls as well.
UPDATE `quest_template` SET `AllowableRaces`=`AllowableRaces`&~0x80 WHERE `ID`=3090;

-- "Melanie Sable and Gritta Chumwater train": both had the trainer flag but no trainer.
-- INFERRED trainer lists from their titles: Expert Enchanter -> the classic Expert enchanting list (Kitta Firewind),
-- Fisherman -> the fishing list of Lumak.
DELETE FROM `creature_trainer` WHERE `CreatureID` IN (259287,260487);
INSERT INTO `creature_trainer` (`CreatureID`,`TrainerID`,`MenuID`,`OptionID`) VALUES
(259287,1011072,0,0), -- Melanie Sable, Expert Enchanter
(260487,100,0,0);     -- Gritta Chumwater, Fisherman

-- "The Elder Crocolisk, Murache, Deathstalker Masoj and the Goaz Warders have their official level": Wowhead Forever levels.
DELETE FROM `creature_classic_level` WHERE `entry` IN (260797,257322,270892,270438);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES
(260797,27,27), -- Elder Crocolisk (was 25-28)
(257322,22,22), -- Murache (was 26)
(270892,32,32), -- Goaz Warder (was 28)
(270438,30,30); -- Deathstalker Masoj (had no level row)

-- "Sentinel Lynessa Duskblossom ... and Finaida Earthbore no longer stand three times at once": keep their three spots,
-- one at a time.
DELETE FROM `pool_members` WHERE `type`=0 AND `spawnId` IN (27312700,27312701,27312702,27574400,27574401,27574402);
DELETE FROM `pool_template` WHERE `entry` IN (1302287,1302288);
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(1302287,1,'Finaida Earthbore - one of three spots'),
(1302288,1,'Sentinel Lynessa Duskblossom - one of three spots');
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,27312700,1302287,0,'Finaida Earthbore'),(0,27312701,1302287,0,'Finaida Earthbore'),(0,27312702,1302287,0,'Finaida Earthbore'),
(0,27574400,1302288,0,'Sentinel Lynessa Duskblossom'),(0,27574401,1302288,0,'Sentinel Lynessa Duskblossom'),(0,27574402,1302288,0,'Sentinel Lynessa Duskblossom');

-- "The Vengeful Guards at the Crossroads no longer attack Horde players, and the Gray Fox is neutral."
-- Vengeful Guard (faction 91, hostile to all) gets the Crossroads Horde Guard faction 85; Gray Fox (38) gets neutral 7,
-- matching their Wowhead Forever reactions.
UPDATE `creature_template` SET `faction`=85 WHERE `entry`=274978;
UPDATE `creature_template` SET `faction`=7 WHERE `entry`=277645;

-- "The escort quests Seeking Refuge, Lost in the Shadows, The Longwalkers and The Windshaper's Wrath fail when you leave the
-- escorted NPC behind": ours already pass the quest to the route start, but the routes of The Windshaper's Wrath (96204),
-- The Longwalkers (98430) and Lost in the Shadows (99123) did not exist, so those NPCs never walked and the quests could
-- not be finished. Routes from AnoCore v10 (built from Wowhead pins: INFERRED).
DELETE FROM `waypoint_path` WHERE `PathId` IN (1100248755,1100272203,1100275811,1100275954);
INSERT INTO `waypoint_path` (`PathId`,`MoveType`,`Flags`,`Velocity`,`Comment`) VALUES
(1100248755,0,0,NULL,'Lumina Windsinger escort (Wowhead pins, migration 1771, INFERRED)'),
(1100272203,0,0,NULL,'Perith Stormhoof escort (Wowhead pins, migration 1782, INFERRED)'),
(1100275811,0,0,NULL,'Pal''juh escort (Wowhead pins, migration 1771, INFERRED)'),
(1100275954,0,0,NULL,'Bareth Dawnstone escort (Wowhead pins, migration 1771, INFERRED)');
DELETE FROM `waypoint_path_node` WHERE `PathId` IN (1100248755,1100272203,1100275811,1100275954);
INSERT INTO `waypoint_path_node` (`PathId`,`NodeId`,`PositionX`,`PositionY`,`PositionZ`,`Orientation`,`Delay`) VALUES
(1100248755,1,989.067,678.0,59.264,NULL,0),
(1100248755,2,961.067,690.6,59.92,NULL,0),
(1100248755,3,927.467,690.6,53.713,NULL,0),
(1100248755,4,893.867,686.4,53.165,NULL,0),
(1100248755,5,868.667,690.6,53.578,NULL,0),
(1100248755,6,837.867,694.8,53.706,NULL,0),
(1100248755,7,748.267,703.2,39.748,NULL,0),
(1100248755,8,714.667,762.0,31.363,NULL,0),
(1100272203,1,-2432.5,448.3,59.69,NULL,0),
(1100272203,2,-2391.5,485.2,52.39,NULL,0),
(1100272203,3,-2342.3,485.2,45.72,NULL,0),
(1100272203,4,-2334.1,423.7,51.8,NULL,0),
(1100272203,5,-2325.8,411.4,53.23,NULL,0),
(1100272203,6,-2342.3,423.7,53.4,NULL,0),
(1100272203,7,-2342.3,399.1,65.88,NULL,0),
(1100272203,8,-2366.9,349.8,70.04,NULL,0),
(1100272203,9,-2391.5,362.1,65.29,NULL,0),
(1100272203,10,-2391.5,325.2,64.96,NULL,0),
(1100272203,11,-2391.5,288.3,62.613,NULL,0),
(1100272203,12,-2375.1,202.1,49.553,NULL,0),
(1100272203,13,-2383.3,189.8,48.479,NULL,0),
(1100275811,1,-962.317,-4405.33,30.315,NULL,0),
(1100275811,2,-1018.72,-4426.48,26.315,NULL,0),
(1100275811,3,-1022.24,-4495.21,25.843,NULL,0),
(1100275811,4,-997.567,-4532.23,25.817,NULL,0),
(1100275811,5,-979.942,-4648.55,30.46,NULL,0),
(1100275811,6,-986.992,-4690.85,23.009,NULL,0),
(1100275954,1,2445.73,1587.33,37.067,NULL,0),
(1100275954,2,2415.6,1578.3,33.019,NULL,0),
(1100275954,3,2403.55,1569.26,31.51,NULL,0),
(1100275954,4,2403.55,1533.11,31.759,NULL,0),
(1100275954,5,2397.52,1506.0,32.818,NULL,0),
(1100275954,6,2391.5,1469.85,34.24,NULL,0),
(1100275954,7,2385.48,1397.55,34.448,NULL,0),
(1100275954,8,2385.48,1343.32,34.448,NULL,0),
(1100275954,9,2385.48,1325.25,33.976,NULL,0),
(1100275954,10,2379.45,1289.1,30.917,NULL,0),
(1100275954,11,2367.4,1271.02,31.332,NULL,0);
-- Seeking Refuge 99144: Bareth Dawnstone had no escort at all and the quest no objective. AnoCore v10's escort
-- (route from Wowhead pins, credit at the end of the route: INFERRED), objective as in AnoCore.
DELETE FROM `quest_objectives` WHERE `QuestID`=99144;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(91500101,99144,0,0,0,275954,1,0,0,0,0,0,1,'Escort Bareth Dawnstone out of Crusader''s Outpost',0);
DELETE FROM `smart_scripts` WHERE `entryorguid`=275954 AND `source_type`=0 AND `id` BETWEEN 10 AND 13;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_chance`,`event_param1`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`target_type`,`target_param2`,`comment`) VALUES
(275954,0,10,11,19,100,99144,81,0,0,0,0,1,0,'escort 99144 - On quest accepted - No quest-giver flag'),
(275954,0,11,0,61,100,0,53,0,1100275954,0,99144,1,0,'escort 99144 - Linked - Start the route (escort quest 99144)'),
(275954,0,12,13,58,100,0,33,275954,0,0,0,17,40,'escort 99144 - Route ended - Escort credit to players within 40 yd (INFERRED)'),
(275954,0,13,0,61,100,0,41,5000,0,0,0,1,0,'escort 99144 - Linked - Despawn, respawn at the start');
