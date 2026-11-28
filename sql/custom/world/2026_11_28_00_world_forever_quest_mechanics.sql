-- Classic 1.60 (WoW Forever): nine new quests whose kill credit nothing on the realm gave. C++ and the why of each:
-- Custom/Classic/world/classic_forever_quest_mechanics.cpp. Every mechanic is INFERRED from the quest's text and the client spell of
-- the item it hands out; no sniff, Wowhead page, QuestieDB entry or Icy Veins record says how live gives these credits.
-- Spots: heights from the server's maps and vmaps (the tracker's tools/height.py). Own guid block 92100000-92100039 (creatures)
-- and 92100000-92100009 (gameobjects). Safe to run again.

-- scripts on the templates, only where none is set
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1, `ScriptName` = 'classic_npc_forever_area_denial_skunk' WHERE `entry` = 249476 AND `ScriptName` IN ('', 'classic_npc_forever_area_denial_skunk');
UPDATE `creature_template` SET `ScriptName` = 'classic_npc_forever_twilight_ritual_circle' WHERE `entry` = 262006 AND `ScriptName` = '';
UPDATE `creature_template` SET `ScriptName` = 'classic_npc_forever_vaxug_firefure' WHERE `entry` = 267214 AND `ScriptName` = '';
-- the Eye of Kilrogg is where A Void Path ends (creature_questender): it needs the quest giver flag
UPDATE `creature_template` SET `npcflag` = `npcflag` | 2, `ScriptName` = 'classic_npc_forever_void_path_eye' WHERE `entry` = 271181 AND `ScriptName` IN ('', 'classic_npc_forever_void_path_eye');

-- the item spells and the send-event
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('classic_spell_forever_toss_enchanted_seeds', 'classic_spell_forever_drawing_kit',
    'classic_spell_forever_memory_of_the_mist', 'classic_spell_forever_explosive_runeshard');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(1287099, 'classic_spell_forever_toss_enchanted_seeds'),
(1289422, 'classic_spell_forever_drawing_kit'),
(1292804, 'classic_spell_forever_memory_of_the_mist'),
(1298707, 'classic_spell_forever_explosive_runeshard');
DELETE FROM `event_script_names` WHERE `Id` = 104098;
INSERT INTO `event_script_names` (`Id`, `ScriptName`) VALUES (104098, 'classic_event_forever_battle_memories');

-- Memory of the Mist (target type 38, a nearby creature of an entry) reaches the Memory Mist wisps
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 1292804;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 1292804, 0, 0, 31, 0, 3, 273458, 0, '', 0, 0, 0, '', 'Memory of the Mist - the Memory Mist wisps');

-- spawns. Area Denial Skunks: six skunks around Johun "Punchy" Dillas (Mount Hyjal), two minutes after being shooed.
-- Siegecraft: a Glaive Thrower eight yards from Kaylaena Springwhisper, talked to for the gears and the cables.
-- Sickening Lights: a Twilight Ritual Circle five yards from each of the eight Twilight Ritualists (Riverglades), back after a minute.
-- Memory Mist: nine wisps by the three Ashen Soil mounds near Thisalee Crow, back after a minute.
DELETE FROM `creature` WHERE `guid` BETWEEN 92100000 AND 92100039;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(92100000,249476,1,0,0,'0',0,0,0,-1,0,0,5469.6,-2438.78,1465.35,3.442,120,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100001,249476,1,0,0,'0',0,0,0,-1,0,0,5456.39,-2426.55,1461.3,4.489,120,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100002,249476,1,0,0,'0',0,0,0,-1,0,0,5439.2,-2431.87,1467.02,5.536,120,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100003,249476,1,0,0,'0',0,0,0,-1,0,0,5435.2,-2449.42,1470.69,0.300,120,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100004,249476,1,0,0,'0',0,0,0,-1,0,0,5461.46,-2420.8,1459.79,4.342,120,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100005,249476,1,0,0,'0',0,0,0,-1,0,0,5427.71,-2448.04,1471.03,0.158,120,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100006,35419,1,0,0,'0',0,0,0,-1,0,0,4891.0,-3008.0,1192.71,3.752,300,0,0,100,0,1,NULL,NULL,NULL,'classic_npc_forever_siegecraft_glaive_thrower',NULL,0),
(92100010,262006,0,0,0,'0',0,0,0,-1,0,0,-8093.53,-4182.23,29.13,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100011,262006,0,0,0,'0',0,0,0,-1,0,0,-8053.44,-4229.76,25.04,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100012,262006,0,0,0,'0',0,0,0,-1,0,0,-7981.98,-4367.5,39.97,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100013,262006,0,0,0,'0',0,0,0,-1,0,0,-7949.97,-4308.33,25.63,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100014,262006,0,0,0,'0',0,0,0,-1,0,0,-7948.03,-4235.1,25.5,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100015,262006,0,0,0,'0',0,0,0,-1,0,0,-7935.42,-4400.0,32.24,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100016,262006,0,0,0,'0',0,0,0,-1,0,0,-7921.52,-4360.71,32.09,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100017,262006,0,0,0,'0',0,0,0,-1,0,0,-7901.47,-4248.19,26.69,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100020,273458,1,0,0,'0',0,0,0,-1,0,0,5180.65,-3386.69,1628.15,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100021,273458,1,0,0,'0',0,0,0,-1,0,0,5170.65,-3382.69,1629.2,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100022,273458,1,0,0,'0',0,0,0,-1,0,0,5175.65,-3395.69,1625.61,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100023,273458,1,0,0,'0',0,0,0,-1,0,0,5250.09,-3331.12,1649.44,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100024,273458,1,0,0,'0',0,0,0,-1,0,0,5240.09,-3327.12,1647.33,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100025,273458,1,0,0,'0',0,0,0,-1,0,0,5245.09,-3340.12,1647.33,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100026,273458,1,0,0,'0',0,0,0,-1,0,0,5187.59,-3351.96,1637.95,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100027,273458,1,0,0,'0',0,0,0,-1,0,0,5177.59,-3347.96,1637.77,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(92100028,273458,1,0,0,'0',0,0,0,-1,0,0,5182.59,-3360.96,1635.16,0.000,60,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0);

-- Violence Into Verdure: the three wrecks around the Loose Cog (650234) south-east of Ketharas: a ballista, a flying machine, a catapult
DELETE FROM `gameobject` WHERE `guid` BETWEEN 92100000 AND 92100009;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(92100000,188673,1,0,0,'0',0,0,0,-1,4524.91,-3533.68,986.63,2.9,0,0,0.992713,0.120503,300,255,1,'',NULL,0),
(92100001,188019,1,0,0,'0',0,0,0,-1,4506.91,-3524.68,988.85,4.4,0,0,0.808496,-0.588501,300,255,1,'',NULL,0),
(92100002,180744,1,0,0,'0',0,0,0,-1,4503.91,-3548.68,987.7,0.9,0,0,0.434966,0.900447,300,255,1,'',NULL,0);
