-- Razor Hill: "For Honor" (96822, Turroc) and "Legging It" (96821, Vel'rin Fang -> Gar'Thok) were in quest_template but
-- had no giver, so nobody could take them (Discord report: a level 5 troll at the Razor Hill barracks, Turroc offers
-- nothing). Both are on the Wowhead WoW Forever quest list (level 6, Horde).
-- What was missing besides the givers, all taken from the AnoCore v10 world database (WoW Forever 70532):
-- For Honor asks for the Raider's Bow, Battleaxe and Shield (275713/275716/275717, in the 70532 ItemSparse) but no object
-- held them: the three Tiragarde Keep loot objects 656180-656182 (lock 43, only usable with the quest) and their 5 spawns.
-- Legging It asks for 6 Ridgeshade Lurkers and 6 Ridgeshade Creepers, which had no spawns and were friendly (faction 35):
-- their 63 spawns north of Razor Hill, faction 14 and their Poison SmartAI.


-- 96821 Legging It
DELETE FROM `creature_queststarter` WHERE `quest`=96821;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(3194,96821,0);
DELETE FROM `creature_questender` WHERE `quest`=96821;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(3139,96821,0);
-- target 266850 Ridgeshade Creeper: 21 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26685000 AND 26685099;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26685000,266850,1,0,0,'0',0,0,0,-1,0,0,-81.067,-4616.83,42.09,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685001,266850,1,0,0,'0',0,0,0,-1,0,0,-116.317,-4616.83,44.477,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685002,266850,1,0,0,'0',0,0,0,-1,0,0,24.683,-4632.69,42.064,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685003,266850,1,0,0,'0',0,0,0,-1,0,0,-116.317,-4648.55,34.474,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685004,266850,1,0,0,'0',0,0,0,-1,0,0,-10.567,-4659.12,38.309,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685005,266850,1,0,0,'0',0,0,0,-1,0,0,-102.217,-4659.12,33.496,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685006,266850,1,0,0,'0',0,0,0,-1,0,0,-158.617,-4659.12,35.752,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685007,266850,1,0,0,'0',0,0,0,-1,0,0,-186.817,-4669.7,33.474,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685008,266850,1,0,0,'0',0,0,0,-1,0,0,-59.917,-4680.27,33.969,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685009,266850,1,0,0,'0',0,0,0,-1,0,0,-229.117,-4680.27,40.782,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685010,266850,1,0,0,'0',0,0,0,-1,0,0,-419.467,-4680.27,38.752,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685011,266850,1,0,0,'0',0,0,0,-1,0,0,-88.117,-4690.85,30.952,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685012,266850,1,0,0,'0',0,0,0,-1,0,0,-207.967,-4690.85,32.558,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685013,266850,1,0,0,'0',0,0,0,-1,0,0,-384.217,-4690.85,42.683,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685014,266850,1,0,0,'0',0,0,0,-1,0,0,-440.617,-4690.85,37.847,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685015,266850,1,0,0,'0',0,0,0,-1,0,0,-320.767,-4701.42,36.43,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685016,266850,1,0,0,'0',0,0,0,-1,0,0,-222.067,-4712.0,29.01,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685017,266850,1,0,0,'0',0,0,0,-1,0,0,-327.817,-4733.15,35.966,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685018,266850,1,0,0,'0',0,0,0,-1,0,0,-257.317,-4749.01,32.155,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685019,266850,1,0,0,'0',0,0,0,-1,0,0,-313.717,-4754.3,36.293,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26685020,266850,1,0,0,'0',0,0,0,-1,0,0,-341.917,-4754.3,37.074,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0);
UPDATE `creature_template` SET `faction`=14 WHERE `entry`=266850; -- was 35 (friendly)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=266850;
DELETE FROM `smart_scripts` WHERE `entryorguid`=266850 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(266850,0,0,0,'',0,0,100,0,7000,14000,120000,125000,0,'',11,744,0,0,0,0,0,0,'',2,0,0,0,0,'',0.0,0.0,0.0,0.0,'Forever Ridgeshade Creeper - cast Poison (TEMPLATE_SAME_SPELL)');
-- target 266849 Ridgeshade Lurker: 42 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26684900 AND 26684999;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26684900,266849,1,0,0,'0',0,0,0,-1,0,0,-193.867,-4574.52,59.942,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684901,266849,1,0,0,'0',0,0,0,-1,0,0,-109.267,-4616.83,43.66,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684902,266849,1,0,0,'0',0,0,0,-1,0,0,3.533,-4627.4,42.449,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684903,266849,1,0,0,'0',0,0,0,-1,0,0,-17.617,-4627.4,42.66,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684904,266849,1,0,0,'0',0,0,0,-1,0,0,-45.817,-4627.4,40.917,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684905,266849,1,0,0,'0',0,0,0,-1,0,0,-31.717,-4637.98,39.047,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684906,266849,1,0,0,'0',0,0,0,-1,0,0,-74.017,-4648.55,36.798,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684907,266849,1,0,0,'0',0,0,0,-1,0,0,-186.817,-4648.55,38.543,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684908,266849,1,0,0,'0',0,0,0,-1,0,0,-426.517,-4648.55,42.887,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684909,266849,1,0,0,'0',0,0,0,-1,0,0,-95.167,-4659.12,34.192,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684910,266849,1,0,0,'0',0,0,0,-1,0,0,-116.317,-4659.12,32.95,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684911,266849,1,0,0,'0',0,0,0,-1,0,0,24.683,-4669.7,37.719,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684912,266849,1,0,0,'0',0,0,0,-1,0,0,-158.617,-4669.7,34.119,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684913,266849,1,0,0,'0',0,0,0,-1,0,0,-447.667,-4669.7,39.434,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684914,266849,1,0,0,'0',0,0,0,-1,0,0,74.033,-4680.27,35.604,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684915,266849,1,0,0,'0',0,0,0,-1,0,0,52.883,-4680.27,36.036,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684916,266849,1,0,0,'0',0,0,0,-1,0,0,-250.267,-4680.27,47.188,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684917,266849,1,0,0,'0',0,0,0,-1,0,0,-278.467,-4680.27,41.576,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684918,266849,1,0,0,'0',0,0,0,-1,0,0,-341.917,-4680.27,41.103,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684919,266849,1,0,0,'0',0,0,0,-1,0,0,-377.167,-4680.27,44.113,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684920,266849,1,0,0,'0',0,0,0,-1,0,0,-468.817,-4680.27,37.486,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684921,266849,1,0,0,'0',0,0,0,-1,0,0,38.783,-4690.85,34.135,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684922,266849,1,0,0,'0',0,0,0,-1,0,0,-66.967,-4690.85,31.677,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684923,266849,1,0,0,'0',0,0,0,-1,0,0,-88.117,-4690.85,30.952,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684924,266849,1,0,0,'0',0,0,0,-1,0,0,-412.417,-4690.85,39.63,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684925,266849,1,0,0,'0',0,0,0,-1,0,0,-440.617,-4690.85,37.847,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684926,266849,1,0,0,'0',0,0,0,-1,0,0,123.383,-4701.42,25.154,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684927,266849,1,0,0,'0',0,0,0,-1,0,0,-504.067,-4701.42,36.522,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684928,266849,1,0,0,'0',0,0,0,-1,0,0,-144.517,-4712.0,29.017,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684929,266849,1,0,0,'0',0,0,0,-1,0,0,-179.767,-4712.0,32.057,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684930,266849,1,0,0,'0',0,0,0,-1,0,0,-215.017,-4712.0,29.01,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684931,266849,1,0,0,'0',0,0,0,-1,0,0,-236.167,-4712.0,32.366,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684932,266849,1,0,0,'0',0,0,0,-1,0,0,-482.917,-4712.0,36.578,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684933,266849,1,0,0,'0',0,0,0,-1,0,0,-313.717,-4722.58,34.698,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684934,266849,1,0,0,'0',0,0,0,-1,0,0,-377.167,-4722.58,37.117,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684935,266849,1,0,0,'0',0,0,0,-1,0,0,-215.017,-4743.73,28.081,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684936,266849,1,0,0,'0',0,0,0,-1,0,0,-264.367,-4743.73,33.593,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684937,266849,1,0,0,'0',0,0,0,-1,0,0,-306.667,-4743.73,34.955,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684938,266849,1,0,0,'0',0,0,0,-1,0,0,-334.867,-4743.73,36.543,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684939,266849,1,0,0,'0',0,0,0,-1,0,0,-426.517,-4743.73,38.591,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684940,266849,1,0,0,'0',0,0,0,-1,0,0,-370.117,-4786.02,35.898,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26684941,266849,1,0,0,'0',0,0,0,-1,0,0,-433.567,-4796.6,35.869,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0);
UPDATE `creature_template` SET `faction`=14 WHERE `entry`=266849; -- was 35 (friendly)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=266849;
DELETE FROM `smart_scripts` WHERE `entryorguid`=266849 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(266849,0,0,0,'',0,0,100,0,7000,14000,120000,125000,0,'',11,11918,0,0,0,0,0,0,'',2,0,0,0,0,'',0.0,0.0,0.0,0.0,'Forever Ridgeshade Lurker - cast Poison (TEMPLATE_SAME_NAME:744)');

-- 96822 For Honor
DELETE FROM `creature_queststarter` WHERE `quest`=96822;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(266940,96822,0);
DELETE FROM `creature_questender` WHERE `quest`=96822;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(266940,96822,0);
-- object 656180 Raider's Bow
DELETE FROM `gameobject_template` WHERE `entry`=656180;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(656180,3,126298,'Raider''s Bow','','','',1.0,43,656180,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=656180;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(656180,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 65618000 AND 65618099;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(65618000,656180,1,0,0,'0',0,0,0,-1,-232.642,-4992.24,21.303,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=656180 AND `Item`=275713;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(656180,0,275713,100.0,1,1,0,1,1,'Raider''s Bow - Wowhead Forever contains 23/23');
-- object 656181 Raider's Battleaxe
DELETE FROM `gameobject_template` WHERE `entry`=656181;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(656181,3,126299,'Raider''s Battleaxe','','','',1.0,43,656181,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=656181;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(656181,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 65618100 AND 65618199;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(65618100,656181,1,0,0,'0',0,0,0,-1,-179.767,-4997.52,26.61,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(65618101,656181,1,0,0,'0',0,0,0,-1,-183.292,-4997.52,26.61,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(65618102,656181,1,0,0,'0',0,0,0,-1,-179.767,-5002.81,21.061,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=656181 AND `Item`=275716;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(656181,0,275716,100.0,1,1,0,1,1,'Raider''s Battleaxe - Wowhead Forever contains 27/27');
-- object 656182 Raider's Shield
DELETE FROM `gameobject_template` WHERE `entry`=656182;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(656182,3,126300,'Raider''s Shield','','','',1.0,43,656182,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=656182;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(656182,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 65618200 AND 65618299;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(65618200,656182,1,0,0,'0',0,0,0,-1,-59.917,-4955.23,23.69,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=656182 AND `Item`=275717;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(656182,0,275717,100.0,1,1,0,1,1,'Raider''s Shield - Wowhead Forever contains 32/32');
