-- Quests that are in our data (and on the Wowhead WoW Forever quest list) but had no quest giver or no turn-in NPC, so
-- nobody could take or finish them. Givers, turn-ins and what the quests need were taken from the AnoCore v10 world
-- database (WoW Forever 70532), only where ours had nothing:
-- - 65 quests: the giver/turn-in rows; quest-giver flag where missing
-- - 23 NPCs missing from our creature data (template, difficulty, model, addon, equipment, trainer, SmartAI, level), among
--   them the camping adventurers Brakk (Durotar), Kaga Wildhoof (Mulgore) and Lyreena Duskblade (Teldrassil), the Dwarf
--   shaman trainer Eldrun Stormbreaker and Ozwin Ironsprocket. Class trainers use our trainer list of their class.
-- - spawns of givers and kill targets that had none, hostile faction where ours had the friendly placeholder 35, levels
-- - objects and their loot for item objectives that had no source (Waterlogged tools, Forgotten Loa Idols, Sprung Traps,
--   the cat relics, the rifles for Treacherous Cold, Stolen Enchanting Supplies, ...)
-- Not covered: the AQ war effort "Needs Your Help!" quests (8793-8797, event only) and 490 (unused).
-- Still open: Call of Water 94497/94499/94500 need the water source objects (spell focus 2274-2276) that neither database
-- has; Elder Knowledge's Titan Relic drops from the Relic Guardian, whose encounter script (boss_relic_guardian) we
-- don't have, so its ScriptName is left out and it stays unattackable.

-- 7221 Speak with Prospector Stonehewer
DELETE FROM `creature_questender` WHERE `quest`=7221;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(13816,7221,0);

-- 7222 Speak with Voggah Deathgrip
DELETE FROM `creature_questender` WHERE `quest`=7222;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(13817,7222,0);

-- 7462 The Treasure of the Shen'dralar
DELETE FROM `creature_queststarter` WHERE `quest`=7462;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(14358,7462,0);

-- 7704 Look at the Size of It!
DELETE FROM `creature_questender` WHERE `quest`=7704;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(14628,7704,0);

-- 79007 ... and that note you found
-- object 415106 Burned-Out Remains
DELETE FROM `gameobject_template` WHERE `entry`=415106;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(415106,2,2610,'Burned-Out Remains','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=415106;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(415106,12,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 41510600 AND 41510699;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(41510600,415106,1,0,0,'0',0,0,0,-1,-3380.37,-2078.95,96.621,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(41510601,415106,0,0,0,'0',0,0,0,-1,-10580.7,1707.67,40.928,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_queststarter` WHERE `quest`=79007;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(415106,79007,0);
-- object 415107 Burned-Out Remains
DELETE FROM `gameobject_template` WHERE `entry`=415107;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(415107,2,2610,'Burned-Out Remains','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=415107;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(415107,12,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 41510700 AND 41510799;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(41510700,415107,0,0,0,'0',0,0,0,-1,-10580.7,1707.67,40.928,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
-- object 424010 Nailed Plank
DELETE FROM `gameobject_template` WHERE `entry`=424010;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(424010,2,303,'Nailed Plank','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=424010;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(424010,12,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 42401000 AND 42401099;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42401000,424010,0,0,0,'0',0,0,0,-1,-10587.7,1707.67,40.841,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_questender` WHERE `quest`=79007;
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(415107,79007,0),
(424010,79007,0);

-- 79097 Baxtan: On Destructive Magics
DELETE FROM `creature_queststarter` WHERE `quest`=79097;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(211033,79097,0);
DELETE FROM `creature_questender` WHERE `quest`=79097;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(211022,79097,0),
(211033,79097,0);

-- 79358 Storm, Earth, and Fire
-- creature 259023 Veyric Thunderhame <>
DELETE FROM `creature_template` WHERE `entry`=259023;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(259023,0,0,'Veyric Thunderhame',NULL,NULL,NULL,NULL,0,0,15,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,2,0,0,0,0,0,7,0,'SmartAI',0,1.0,0,1693,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=259023;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(259023,0,0,0,0,0,1.3,1.0,1.0,1.0,342179,0,67108864,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=259023;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(259023,0,143439,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=259023;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=259023;
DELETE FROM `smart_scripts` WHERE `entryorguid`=259023 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(259023,0,0,0,'',4,0,100,0,0,0,0,0,0,'',11,8385,0,0,0,0,0,0,'',1,0,0,0,0,'',0.0,0.0,0.0,0.0,'Veyric Thunderhame - cast 8385 (INFERRED: on aggro)');
DELETE FROM `creature_queststarter` WHERE `quest`=79358;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(259023,79358,0);
DELETE FROM `creature_classic_level` WHERE `entry`=259023;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (259023,33,33);
-- starter 259023 Veyric Thunderhame: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25902300 AND 25902399;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25902300,259023,0,0,0,'0',0,0,0,-1,0,0,-795.733,-3012.27,153.957,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);
DELETE FROM `creature_questender` WHERE `quest`=79358;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(259023,79358,0);
DELETE FROM `creature_loot_template` WHERE `Entry`=4359 AND `Item`=274046;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4359,0,274046,65.0,1,1,0,1,1,'Mirefin Murloc - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4361 AND `Item`=274046;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4361,0,274046,65.0,1,1,0,1,1,'Mirefin Muckdweller - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4362 AND `Item`=274046;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4362,0,274046,65.0,1,1,0,1,1,'Mirefin Coastrunner - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4363 AND `Item`=274046;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4363,0,274046,65.0,1,1,0,1,1,'Mirefin Oracle - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=755 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(755,0,274045,65.0,1,1,0,1,1,'Lost One Mudlurker - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=757 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(757,0,274045,65.0,1,1,0,1,1,'Lost One Fisherman - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=759 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(759,0,274045,65.0,1,1,0,1,1,'Lost One Hunter - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=760 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(760,0,274045,65.0,1,1,0,1,1,'Lost One Muckdweller - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=761 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(761,0,274045,65.0,1,1,0,1,1,'Lost One Seer - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=762 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(762,0,274045,65.0,1,1,0,1,1,'Lost One Riftseeker - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=763 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(763,0,274045,65.0,1,1,0,1,1,'Lost One Chieftain - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=1106 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(1106,0,274045,65.0,1,1,0,1,1,'Lost One Cook - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2701 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2701,0,274044,65.0,1,1,0,1,1,'Dustbelcher Ogre - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2715 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2715,0,274044,65.0,1,1,0,1,1,'Dustbelcher Brute - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2893 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2893,0,274044,65.0,1,1,0,1,1,'Stonevault Bonesnapper - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2894 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2894,0,274044,65.0,1,1,0,1,1,'Stonevault Shaman - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2906 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2906,0,274044,65.0,1,1,0,1,1,'Dustbelcher Warrior - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2907 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2907,0,274044,65.0,1,1,0,1,1,'Dustbelcher Mystic - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=6733 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(6733,0,274044,65.0,1,1,0,1,1,'Stonevault Basher - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4654 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4654,0,274047,65.0,1,1,0,1,1,'Maraudine Scout - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4655 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4655,0,274047,65.0,1,1,0,1,1,'Maraudine Wrangler - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4656 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4656,0,274047,65.0,1,1,0,1,1,'Maraudine Mauler - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4657 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4657,0,274047,65.0,1,1,0,1,1,'Maraudine Windchaser - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4658 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4658,0,274047,65.0,1,1,0,1,1,'Maraudine Stormer - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4659 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4659,0,274047,65.0,1,1,0,1,1,'Maraudine Marauder - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');

-- 79361 Storm, Earth, and Fire
DELETE FROM `creature_queststarter` WHERE `quest`=79361;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(6176,79361,0);
DELETE FROM `creature_questender` WHERE `quest`=79361;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(6176,79361,0);
DELETE FROM `creature_loot_template` WHERE `Entry`=4359 AND `Item`=274046;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4359,0,274046,65.0,1,1,0,1,1,'Mirefin Murloc - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4361 AND `Item`=274046;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4361,0,274046,65.0,1,1,0,1,1,'Mirefin Muckdweller - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4362 AND `Item`=274046;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4362,0,274046,65.0,1,1,0,1,1,'Mirefin Coastrunner - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4363 AND `Item`=274046;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4363,0,274046,65.0,1,1,0,1,1,'Mirefin Oracle - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=755 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(755,0,274045,65.0,1,1,0,1,1,'Lost One Mudlurker - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=757 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(757,0,274045,65.0,1,1,0,1,1,'Lost One Fisherman - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=759 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(759,0,274045,65.0,1,1,0,1,1,'Lost One Hunter - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=760 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(760,0,274045,65.0,1,1,0,1,1,'Lost One Muckdweller - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=761 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(761,0,274045,65.0,1,1,0,1,1,'Lost One Seer - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=762 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(762,0,274045,65.0,1,1,0,1,1,'Lost One Riftseeker - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=763 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(763,0,274045,65.0,1,1,0,1,1,'Lost One Chieftain - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=1106 AND `Item`=274045;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(1106,0,274045,65.0,1,1,0,1,1,'Lost One Cook - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2701 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2701,0,274044,65.0,1,1,0,1,1,'Dustbelcher Ogre - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2715 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2715,0,274044,65.0,1,1,0,1,1,'Dustbelcher Brute - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2893 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2893,0,274044,65.0,1,1,0,1,1,'Stonevault Bonesnapper - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2894 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2894,0,274044,65.0,1,1,0,1,1,'Stonevault Shaman - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2906 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2906,0,274044,65.0,1,1,0,1,1,'Dustbelcher Warrior - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=2907 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2907,0,274044,65.0,1,1,0,1,1,'Dustbelcher Mystic - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=6733 AND `Item`=274044;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(6733,0,274044,65.0,1,1,0,1,1,'Stonevault Basher - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4654 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4654,0,274047,65.0,1,1,0,1,1,'Maraudine Scout - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4655 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4655,0,274047,65.0,1,1,0,1,1,'Maraudine Wrangler - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4656 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4656,0,274047,65.0,1,1,0,1,1,'Maraudine Mauler - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4657 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4657,0,274047,65.0,1,1,0,1,1,'Maraudine Windchaser - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4658 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4658,0,274047,65.0,1,1,0,1,1,'Maraudine Stormer - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');
DELETE FROM `creature_loot_template` WHERE `Entry`=4659 AND `Item`=274047;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(4659,0,274047,65.0,1,1,0,1,1,'Maraudine Marauder - quest drop, Wowhead Forever dropped-by; chance INFERRED (median of DEV 5-item quest drops) (1111)');

-- 91723 Delicate Instruments
-- creature 248242 Hamish Bergwort <>
DELETE FROM `creature_template` WHERE `entry`=248242;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(248242,0,0,'Hamish Bergwort',NULL,NULL,NULL,NULL,0,0,12,3,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=248242;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(248242,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=248242;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(248242,0,148276,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=248242;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=248242;
DELETE FROM `creature_queststarter` WHERE `quest`=91723;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(248242,91723,0);
DELETE FROM `creature_classic_level` WHERE `entry`=248242;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (248242,35,35);
-- starter 248242 Hamish Bergwort: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 24824200 AND 24824299;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(24824200,248242,0,0,0,'0',0,0,0,-1,0,0,-9555.16,-720.625,64.739,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);
DELETE FROM `creature_questender` WHERE `quest`=91723;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(248242,91723,0);

-- 91725 Stolen Enchanting Supplies
-- creature 248248 Blixie Fitzwink <>
DELETE FROM `creature_template` WHERE `entry`=248248;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(248248,0,0,'Blixie Fitzwink',NULL,NULL,NULL,NULL,0,0,12,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=248248;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(248248,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=248248;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(248248,0,148275,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=248248;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=248248;
DELETE FROM `creature_queststarter` WHERE `quest`=91725;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(248248,91725,0);
DELETE FROM `creature_classic_level` WHERE `entry`=248248;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (248248,35,35);
-- starter 248248 Blixie Fitzwink: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 24824800 AND 24824899;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(24824800,248248,0,0,0,'0',0,0,0,-1,0,0,-9619.97,-658.15,50.853,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);
DELETE FROM `creature_questender` WHERE `quest`=91725;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(248248,91725,0);
-- object 561159 Stolen Enchanting Supplies
DELETE FROM `gameobject_template` WHERE `entry`=561159;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(561159,3,6396,'Stolen Enchanting Supplies','','','',1.0,43,561159,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=561159;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(561159,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 56115900 AND 56115999;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(56115900,561159,0,0,0,'0',0,0,0,-1,-8874.67,-706.742,74.422,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115901,561159,0,0,0,'0',0,0,0,-1,-8890.88,-720.625,70.0,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115902,561159,0,0,0,'0',0,0,0,-1,-8874.67,-755.333,68.598,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115903,561159,0,0,0,'0',0,0,0,-1,-8879.3,-755.333,68.586,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115904,561159,0,0,0,'0',0,0,0,-1,-8842.27,-765.746,71.061,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115905,561159,0,0,0,'0',0,0,0,-1,-8934.85,-765.746,68.339,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115906,561159,0,0,0,'0',0,0,0,-1,-8909.39,-769.217,69.694,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115907,561159,0,0,0,'0',0,0,0,-1,-8837.64,-772.687,70.524,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115908,561159,0,0,0,'0',0,0,0,-1,-8907.08,-776.158,69.709,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115909,561159,0,0,0,'0',0,0,0,-1,-8927.91,-803.925,68.25,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115910,561159,0,0,0,'0',0,0,0,-1,-8927.91,-807.396,68.263,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115911,561159,0,0,0,'0',0,0,0,-1,-8846.9,-817.808,71.191,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115912,561159,0,0,0,'0',0,0,0,-1,-9087.62,-821.279,69.59,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115913,561159,0,0,0,'0',0,0,0,-1,-8902.45,-824.75,70.954,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115914,561159,0,0,0,'0',0,0,0,-1,-8865.42,-828.221,72.241,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115915,561159,0,0,0,'0',0,0,0,-1,-8897.82,-828.221,71.445,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115916,561159,0,0,0,'0',0,0,0,-1,-8988.09,-828.221,69.955,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115917,561159,0,0,0,'0',0,0,0,-1,-8995.03,-838.633,69.186,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115918,561159,0,0,0,'0',0,0,0,-1,-8997.35,-842.104,69.152,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115919,561159,0,0,0,'0',0,0,0,-1,-9122.33,-849.046,67.924,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115920,561159,0,0,0,'0',0,0,0,-1,-8828.38,-873.342,74.589,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115921,561159,0,0,0,'0',0,0,0,-1,-8823.75,-880.283,74.653,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56115922,561159,0,0,0,'0',0,0,0,-1,-8842.27,-887.225,73.902,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=561159 AND `Item`=247805;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(561159,0,247805,100.0,1,1,0,1,1,'Stolen Enchanting Supplies - Wowhead Forever contains 142/142');

-- 91733 Downstream
-- creature 248265 Ormin Pelford <>
DELETE FROM `creature_template` WHERE `entry`=248265;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(248265,0,0,'Ormin Pelford',NULL,NULL,NULL,NULL,0,0,12,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=248265;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(248265,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=248265;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(248265,0,148277,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=248265;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=248265;
DELETE FROM `creature_queststarter` WHERE `quest`=91733;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(248265,91733,0);
DELETE FROM `creature_classic_level` WHERE `entry`=248265;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (248265,35,35);
-- starter 248265 Ormin Pelford: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 24826500 AND 24826599;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(24826500,248265,0,0,0,'0',0,0,0,-1,0,0,-9606.08,-1116.3,42.406,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);
DELETE FROM `creature_questender` WHERE `quest`=91733;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(248265,91733,0);
-- object 562105 Waterlogged Axe
DELETE FROM `gameobject_template` WHERE `entry`=562105;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(562105,3,103649,'Waterlogged Axe','','','',1.0,43,562105,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=562105;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(562105,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 56210500 AND 56210599;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(56210500,562105,0,0,0,'0',0,0,0,-1,-9846.8,-1126.71,27.813,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=562105 AND `Item`=247817;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(562105,0,247817,100.0,1,1,0,1,1,'Waterlogged Axe - Wowhead Forever contains 31/31');
-- object 562103 Waterlogged Saw
DELETE FROM `gameobject_template` WHERE `entry`=562103;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(562103,3,132656,'Waterlogged Saw','','','',0.1,43,562103,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=562103;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(562103,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 56210300 AND 56210399;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(56210300,562103,0,0,0,'0',0,0,0,-1,-9705.61,-1039.94,38.652,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(56210301,562103,0,0,0,'0',0,0,0,-1,-9707.92,-1050.35,40.144,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=562103 AND `Item`=247813;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(562103,0,247813,100.0,1,1,0,1,1,'Waterlogged Saw - Wowhead Forever contains 44/44');
-- object 562106 Waterlogged Toolbox
DELETE FROM `gameobject_template` WHERE `entry`=562106;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(562106,3,317,'Waterlogged Toolbox','','','',1.0,43,562106,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=562106;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(562106,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 56210600 AND 56210699;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(56210600,562106,0,0,0,'0',0,0,0,-1,-9946.33,-1147.54,19.243,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=562106 AND `Item`=247818;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(562106,0,247818,100.0,1,1,0,1,1,'Waterlogged Toolbox - Wowhead Forever contains 22/22');

-- 92467 Call of Earth
-- creature 251166 Minor Manifestation of Earth <>
DELETE FROM `creature_template` WHERE `entry`=251166;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(251166,0,0,'Minor Manifestation of Earth',NULL,'',NULL,NULL,0,0,35,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=251166;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(251166,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=251166;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(251166,0,1162,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=251166;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=251166;
DELETE FROM `creature_questender` WHERE `quest`=92467;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(251166,92467,0);
DELETE FROM `creature_classic_level` WHERE `entry`=251166;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (251166,15,15);
-- ender 251166 Minor Manifestation of Earth: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25116600 AND 25116699;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25116600,251166,2991,0,0,'0',0,0,0,-1,0,0,4066.25,1472.25,1024.76,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 92468 Call of Earth
DELETE FROM `creature_queststarter` WHERE `quest`=92468;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(251166,92468,0);

-- 92744 Murloc Gills
-- creature 253092 Alba Fairmoon <>
DELETE FROM `creature_template` WHERE `entry`=253092;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(253092,0,0,'Alba Fairmoon',NULL,NULL,NULL,NULL,0,0,12,3,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=253092;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(253092,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=253092;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(253092,0,137727,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=253092;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=253092;
DELETE FROM `creature_queststarter` WHERE `quest`=92744;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(253092,92744,0);
DELETE FROM `creature_classic_level` WHERE `entry`=253092;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (253092,24,24);
-- starter 253092 Alba Fairmoon: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25309200 AND 25309299;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25309200,253092,0,0,0,'0',0,0,0,-1,0,0,-10636.7,1182.67,33.06,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);
DELETE FROM `creature_questender` WHERE `quest`=92744;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(253092,92744,0);

-- 92909 Harvesting the Harvesters
-- creature 253395 Ozwin Ironsprocket <>
DELETE FROM `creature_template` WHERE `entry`=253395;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(253395,0,0,'Ozwin Ironsprocket',NULL,NULL,NULL,NULL,0,0,12,3,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=253395;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(253395,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=253395;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(253395,0,148280,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=253395;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=253395;
DELETE FROM `creature_queststarter` WHERE `quest`=92909;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(253395,92909,0);
DELETE FROM `creature_classic_level` WHERE `entry`=253395;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (253395,15,15);
-- starter 253395 Ozwin Ironsprocket: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25339500 AND 25339599;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25339500,253395,0,0,0,'0',0,0,0,-1,0,0,-10151.3,1220.67,37.98,1.571,300,0.0,0,100,0,0,0,0,0,'',NULL,0);
DELETE FROM `creature_questender` WHERE `quest`=92909;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(253395,92909,0);
DELETE FROM `creature_loot_template` WHERE `Entry`=36 AND `Item`=255007;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(36,0,255007,5.668,0,1,0,1,1,'Harvest Golem - Wowhead Forever drop (724)');
DELETE FROM `creature_loot_template` WHERE `Entry`=114 AND `Item`=255007;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(114,0,255007,3.888,0,1,0,1,1,'Harvest Watcher - Wowhead Forever drop (724)');
DELETE FROM `creature_loot_template` WHERE `Entry`=115 AND `Item`=255007;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(115,0,255007,4.627,0,1,0,1,1,'Harvest Reaper - Wowhead Forever drop (724)');
DELETE FROM `creature_loot_template` WHERE `Entry`=480 AND `Item`=255007;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(480,0,255007,5.441,0,1,0,1,1,'Rusty Harvest Golem - Wowhead Forever drop (724)');
DELETE FROM `creature_loot_template` WHERE `Entry`=276061 AND `Item`=255007;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(276061,0,255007,55.769,0,1,0,1,1,'Wowhead Forever drop 29/52');

-- 92910 Harvesting the Harvesters
DELETE FROM `creature_questender` WHERE `quest`=92910;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(253395,92910,0);

-- 92911 Harvesting the Harvesters
DELETE FROM `creature_queststarter` WHERE `quest`=92911;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(253395,92911,0);
DELETE FROM `creature_questender` WHERE `quest`=92911;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(253395,92911,0);
DELETE FROM `creature_loot_template` WHERE `Entry`=36 AND `Item`=255007;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(36,0,255007,5.668,0,1,0,1,1,'Harvest Golem - Wowhead Forever drop (724)');
DELETE FROM `creature_loot_template` WHERE `Entry`=114 AND `Item`=255007;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(114,0,255007,3.888,0,1,0,1,1,'Harvest Watcher - Wowhead Forever drop (724)');
DELETE FROM `creature_loot_template` WHERE `Entry`=115 AND `Item`=255007;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(115,0,255007,4.627,0,1,0,1,1,'Harvest Reaper - Wowhead Forever drop (724)');
DELETE FROM `creature_loot_template` WHERE `Entry`=480 AND `Item`=255007;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(480,0,255007,5.441,0,1,0,1,1,'Rusty Harvest Golem - Wowhead Forever drop (724)');
DELETE FROM `creature_loot_template` WHERE `Entry`=276061 AND `Item`=255007;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(276061,0,255007,55.769,0,1,0,1,1,'Wowhead Forever drop 29/52');

-- 94438 A Lesson in Divinity
DELETE FROM `creature_queststarter` WHERE `quest`=94438;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(257655,94438,0);
DELETE FROM `creature_questender` WHERE `quest`=94438;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(257663,94438,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=257663;
DELETE FROM `creature_classic_level` WHERE `entry`=257663;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (257663,10,10);
-- ender 257663 Deathguard Falgan: 2 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25766300 AND 25766399;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25766300,257663,0,0,0,'0',0,0,0,-1,0,0,2397.52,-870.867,66.584,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0),
(25766301,257663,0,0,0,'0',0,0,0,-1,0,0,2409.57,-879.904,63.9,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 94440 A Lesson in Divinity
DELETE FROM `creature_queststarter` WHERE `quest`=94440;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(257663,94440,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=257663;

-- 94449 Call of Fire
-- creature 258098 Eldrun Stormbreaker <Shaman Trainer>
DELETE FROM `creature_template` WHERE `entry`=258098;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(258098,0,0,'Eldrun Stormbreaker',NULL,'Shaman Trainer',NULL,NULL,0,0,55,19,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=258098;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(258098,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=258098;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(258098,0,143525,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=258098;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=258098;
DELETE FROM `creature_trainer` WHERE `CreatureID`=258098;
INSERT INTO `creature_trainer` (`CreatureID`,`TrainerID`,`MenuID`,`OptionID`) VALUES
(258098,10,0,0);
DELETE FROM `creature_queststarter` WHERE `quest`=94449;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(258098,94449,0),
(258113,94449,0);
DELETE FROM `creature_classic_level` WHERE `entry`=258098;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (258098,5,5);
-- starter 258098 Eldrun Stormbreaker: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25809800 AND 25809899;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25809800,258098,0,0,0,'0',0,0,0,-1,0,0,-4639.94,-1085.18,500.74,1.11701,300,0.0,0,100,0,0,0,0,0,'',NULL,0);
DELETE FROM `creature_questender` WHERE `quest`=94449;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(257597,94449,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=257597;
DELETE FROM `creature_classic_level` WHERE `entry`=257597;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (257597,15,15);
-- ender 257597 Bruegs Kindleborn: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25759700 AND 25759799;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25759700,257597,0,0,0,'0',0,0,0,-1,0,0,-5308.62,-2512.22,485.13,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 94465 Call of Fire
DELETE FROM `creature_queststarter` WHERE `quest`=94465;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(257597,94465,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=257597;
-- creature 257808 Braldir Ashmantle <>
DELETE FROM `creature_template` WHERE `entry`=257808;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(257808,0,0,'Braldir Ashmantle',NULL,NULL,NULL,NULL,0,0,55,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=257808;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(257808,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=257808;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(257808,0,143528,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=257808;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=257808;
DELETE FROM `creature_questender` WHERE `quest`=94465;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(257808,94465,0);
DELETE FROM `creature_classic_level` WHERE `entry`=257808;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (257808,35,35);
-- ender 257808 Braldir Ashmantle: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25780800 AND 25780899;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25780800,257808,0,0,0,'0',0,0,0,-1,0,0,-5701.62,-2876.42,457.478,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 94466 Call of Fire
DELETE FROM `creature_queststarter` WHERE `quest`=94466;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(257808,94466,0);
DELETE FROM `creature_questender` WHERE `quest`=94466;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(257808,94466,0);

-- 94467 Call of Fire
DELETE FROM `creature_queststarter` WHERE `quest`=94467;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(257808,94467,0);
DELETE FROM `gameobject_questender` WHERE `quest`=94467;
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(61934,94467,0);

-- 94468 Call of Fire
DELETE FROM `creature_questender` WHERE `quest`=94468;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(257597,94468,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=257597;
DELETE FROM `gameobject_queststarter` WHERE `quest`=94468;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(61934,94468,0);

-- 94494 Call of Water
DELETE FROM `creature_queststarter` WHERE `quest`=94494;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(258098,94494,0);
-- creature 258043 Norric Lochthane <>
DELETE FROM `creature_template` WHERE `entry`=258043;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(258043,0,0,'Norric Lochthane',NULL,NULL,NULL,NULL,0,0,55,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=258043;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(258043,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=258043;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(258043,0,143522,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=258043;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=258043;
DELETE FROM `creature_questender` WHERE `quest`=94494;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(258043,94494,0);
DELETE FROM `creature_classic_level` WHERE `entry`=258043;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (258043,32,32);
-- ender 258043 Norric Lochthane: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25804300 AND 25804399;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25804300,258043,0,0,0,'0',0,0,0,-1,0,0,-4837.02,-3146.73,299.61,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 94495 Call of Water
DELETE FROM `creature_queststarter` WHERE `quest`=94495;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(258043,94495,0);
-- creature 258203 Hervdana Saegrund <>
DELETE FROM `creature_template` WHERE `entry`=258203;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(258203,0,0,'Hervdana Saegrund',NULL,NULL,NULL,NULL,0,0,55,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=258203;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(258203,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=258203;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(258203,0,143526,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=258203;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=258203;
DELETE FROM `creature_questender` WHERE `quest`=94495;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(258203,94495,0);
DELETE FROM `creature_classic_level` WHERE `entry`=258203;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (258203,30,30);
-- ender 258203 Hervdana Saegrund: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25820300 AND 25820399;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25820300,258203,0,0,0,'0',0,0,0,-1,0,0,-4259.2,-3110.69,90.616,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 94497 Call of Water
DELETE FROM `creature_queststarter` WHERE `quest`=94497;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(258203,94497,0);
DELETE FROM `creature_questender` WHERE `quest`=94497;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(258203,94497,0);

-- 94499 Call of Water
DELETE FROM `creature_queststarter` WHERE `quest`=94499;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(258203,94499,0);
DELETE FROM `creature_questender` WHERE `quest`=94499;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(258203,94499,0);

-- 94500 Call of Water
DELETE FROM `creature_queststarter` WHERE `quest`=94500;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(258203,94500,0);
DELETE FROM `creature_questender` WHERE `quest`=94500;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(258203,94500,0);

-- 94501 Call of Water
DELETE FROM `creature_queststarter` WHERE `quest`=94501;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(258203,94501,0);
DELETE FROM `creature_questender` WHERE `quest`=94501;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(258043,94501,0);

-- 94502 Call of Water
DELETE FROM `creature_queststarter` WHERE `quest`=94502;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(258043,94502,0);
-- object 619896 Forgotten Shrine
DELETE FROM `gameobject_template` WHERE `entry`=619896;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(619896,2,1027,'Forgotten Shrine','','','',0.25,0,29427,2,43463,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=619896;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(619896,35,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 61989600 AND 61989699;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(61989600,619896,0,0,0,'0',0,0,0,-1,-10802.3,1427.67,34.979,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(61989601,619896,0,0,0,'0',0,0,0,-1,-10797.7,1420.67,32.717,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_questender` WHERE `quest`=94502;
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(619896,94502,0);

-- 94503 Call of Water
DELETE FROM `creature_questender` WHERE `quest`=94503;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(5895,94503,0);
DELETE FROM `gameobject_queststarter` WHERE `quest`=94503;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(619896,94503,0);

-- 94505 Call of Water
DELETE FROM `creature_queststarter` WHERE `quest`=94505;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(5895,94505,0);
DELETE FROM `creature_questender` WHERE `quest`=94505;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(258043,94505,0);

-- 94774 Divine Grace
DELETE FROM `creature_queststarter` WHERE `quest`=94774;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(377,94774,0);

-- 94817 Confounding Flash
-- creature 258785 High Priestess Mims <Priest Trainer>
DELETE FROM `creature_template` WHERE `entry`=258785;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(258785,0,0,'High Priestess Mims',NULL,'Priest Trainer',NULL,NULL,0,0,55,19,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=258785;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(258785,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=258785;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(258785,0,140941,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=258785;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=258785;
DELETE FROM `creature_trainer` WHERE `CreatureID`=258785;
INSERT INTO `creature_trainer` (`CreatureID`,`TrainerID`,`MenuID`,`OptionID`) VALUES
(258785,8,0,0);
DELETE FROM `creature_queststarter` WHERE `quest`=94817;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(258785,94817,0);
DELETE FROM `creature_classic_level` WHERE `entry`=258785;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (258785,60,60);
-- starter 258785 High Priestess Mims: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 25878500 AND 25878599;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25878500,258785,0,0,0,'0',0,0,0,-1,0,0,-4622.0,-909.666,501.152,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);
DELETE FROM `creature_questender` WHERE `quest`=94817;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(258785,94817,0);

-- 94818 Contingency Plan
DELETE FROM `creature_queststarter` WHERE `quest`=94818;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(258785,94818,0);
DELETE FROM `creature_questender` WHERE `quest`=94818;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(258785,94818,0);

-- 95494 Bruised Pride and Lion Hides
DELETE FROM `creature_queststarter` WHERE `quest`=95494;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(3682,95494,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=3682;
DELETE FROM `creature_questender` WHERE `quest`=95494;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(3682,95494,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=3682;

-- 95495 The Hermit Tanner
DELETE FROM `creature_queststarter` WHERE `quest`=95495;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(3682,95495,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=3682;
-- creature 261366 Walton <Tanner>
DELETE FROM `creature_template` WHERE `entry`=261366;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(261366,0,0,'Walton',NULL,'Tanner',NULL,NULL,0,0,29,19,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,512,2048,0,0,0,7,0,'SmartAI',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=261366;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(261366,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=261366;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(261366,0,142852,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=261366;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=261366;
DELETE FROM `smart_scripts` WHERE `entryorguid`=261366 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(261366,0,0,1,'',19,0,100,0,95508,0,0,0,0,'',12,261367,1,180000,1,0,0,0,'',8,0,0,0,0,'',842.3,-1612.8,211.4,4.71,'Walton - On Quest Unwelcome Guests Accepted - Summon Terry Longdrink (attacks the player)'),
(261366,0,1,2,'',61,0,100,0,0,0,0,0,0,'',12,261368,1,180000,1,0,0,0,'',8,0,0,0,0,'',839.3,-1610.8,211.4,4.71,'Walton - Linked - Summon Kul Tiras Marine'),
(261366,0,2,0,'',61,0,100,0,0,0,0,0,0,'',12,261368,1,180000,1,0,0,0,'',8,0,0,0,0,'',845.3,-1610.8,211.4,4.71,'Walton - Linked - Summon Kul Tiras Marine');
DELETE FROM `creature_questender` WHERE `quest`=95495;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(261366,95495,0);
DELETE FROM `creature_classic_level` WHERE `entry`=261366;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (261366,20,20);
-- ender 261366 Walton: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26136600 AND 26136699;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26136600,261366,1,0,0,'0',0,0,0,-1,0,0,842.287,-1633.08,213.275,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 95507 Vrang's Game
DELETE FROM `creature_queststarter` WHERE `quest`=95507;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(3682,95507,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=3682;
DELETE FROM `creature_questender` WHERE `quest`=95507;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(3682,95507,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=3682;
-- object 640104 Sprung Trap
DELETE FROM `gameobject_template` WHERE `entry`=640104;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(640104,3,123691,'Sprung Trap','','','',1.0,43,640104,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=640104;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(640104,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 64010400 AND 64010499;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(64010400,640104,1,0,0,'0',0,0,0,-1,673.381,-1704.02,91.676,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010401,640104,1,0,0,'0',0,0,0,-1,180.175,-1704.02,93.083,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010402,640104,1,0,0,'0',0,0,0,-1,599.062,-1724.28,91.887,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010403,640104,1,0,0,'0',0,0,0,-1,504.475,-1744.55,94.234,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010404,640104,1,0,0,'0',0,0,0,-1,639.6,-1825.62,91.666,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010405,640104,1,0,0,'0',0,0,0,-1,632.844,-1825.62,91.666,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010406,640104,1,0,0,'0',0,0,0,-1,727.431,-1856.02,91.924,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010407,640104,1,0,0,'0',0,0,0,-1,477.45,-1916.82,91.666,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010408,640104,1,0,0,'0',0,0,0,-1,666.625,-1967.48,92.389,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010409,640104,1,0,0,'0',0,0,0,-1,720.675,-1977.62,92.638,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010410,640104,1,0,0,'0',0,0,0,-1,578.794,-1977.62,91.676,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010411,640104,1,0,0,'0',0,0,0,-1,578.794,-1987.75,91.666,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010412,640104,1,0,0,'0',0,0,0,-1,734.187,-2078.95,92.002,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010413,640104,1,0,0,'0',0,0,0,-1,774.725,-2139.75,91.823,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010414,640104,1,0,0,'0',0,0,0,-1,734.187,-2139.75,91.678,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010415,640104,1,0,0,'0',0,0,0,-1,761.212,-2200.55,91.666,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010416,640104,1,0,0,'0',0,0,0,-1,862.556,-2230.95,93.727,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(64010417,640104,1,0,0,'0',0,0,0,-1,754.456,-2464.02,91.666,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=640104 AND `Item`=269719;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(640104,0,269719,62.222,1,1,0,1,1,'Sprung Trap - Wowhead Forever contains 84/135');

-- 95664 Elder Knowledge
DELETE FROM `creature_questender` WHERE `quest`=95664;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(9087,95664,0);
-- creature 260326 Relic Guardian <>
DELETE FROM `creature_template` WHERE `entry`=260326;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(260326,0,0,'Relic Guardian',NULL,NULL,NULL,NULL,0,0,416,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,33554496,2048,0,0,0,4,0,'',0,1.0,0,1703,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=260326;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(260326,0,0,0,0,0,10.0,1.0,1.0,4.32,343533,2097256,128,0,260326,0,0,148,368,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=260326;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(260326,0,144224,2.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=260326;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=260326;
DELETE FROM `creature_loot_template` WHERE `Entry`=260326 AND `Item`=270866;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(260326,0,270866,100.0,0,1,0,1,1,'Titan Relic (Horde) (975)');
DELETE FROM `creature_classic_level` WHERE `entry`=260326;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (260326,31,31);
-- target 260326 Relic Guardian: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26032600 AND 26032699;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26032600,260326,2998,0,0,'1,201',0,0,0,-1,0,0,-3987.67,-1917.21,163.243,2.3038,7200,0.0,0,100,0,0,0,0,0,'',NULL,0);
UPDATE `creature_template` SET `faction`=416 WHERE `entry`=260326; -- was 35 (friendly)

-- 96102 Camping 101: Tailoring
-- creature 265809 Brakk <Adventurer>
DELETE FROM `creature_template` WHERE `entry`=265809;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(265809,0,0,'Brakk',NULL,'Adventurer',NULL,NULL,0,0,29,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=265809;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(265809,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=265809;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(265809,0,144648,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=265809;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=265809;
DELETE FROM `creature_queststarter` WHERE `quest`=96102;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(265809,96102,0);
DELETE FROM `creature_classic_level` WHERE `entry`=265809;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (265809,12,12);
-- starter 265809 Brakk: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26580900 AND 26580999;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26580900,265809,1,0,0,'0',0,0,0,-1,0,0,137.483,-4712.0,18.602,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 96260 Stronger than Steel
DELETE FROM `creature_queststarter` WHERE `quest`=96260;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(264072,96260,0);
DELETE FROM `creature_questender` WHERE `quest`=96260;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(264072,96260,0);
-- creature 264081 Gloomrise Spinner <>
DELETE FROM `creature_template` WHERE `entry`=264081;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(264081,0,0,'Gloomrise Spinner',NULL,NULL,NULL,NULL,0,0,111,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,0,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=264081;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(264081,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,264081,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=264081;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(264081,0,4456,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=264081;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=264081;
DELETE FROM `creature_loot_template` WHERE `Entry`=264081 AND `Item`=273181;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(264081,0,273181,50.0,0,1,0,1,1,'Wowhead Forever drop 1/2');
DELETE FROM `creature_classic_level` WHERE `entry`=264081;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (264081,28,28);
-- target 264081 Gloomrise Spinner: 3 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26408100 AND 26408199;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26408100,264081,1,0,0,'0',0,0,0,-1,0,0,-241.992,485.217,177.624,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26408101,264081,1,0,0,'0',0,0,0,-1,0,0,-209.175,460.6,181.841,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26408102,264081,1,0,0,'0',0,0,0,-1,0,0,-176.359,288.284,180.387,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0);
UPDATE `creature_template` SET `faction`=111 WHERE `entry`=264081; -- was 35 (friendly)

-- 96261 The Broodmother
DELETE FROM `creature_queststarter` WHERE `quest`=96261;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(259118,96261,0);
DELETE FROM `creature_questender` WHERE `quest`=96261;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(259118,96261,0);
-- creature 264082 Broodmother Valraxx <>
DELETE FROM `creature_template` WHERE `entry`=264082;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(264082,0,0,'Broodmother Valraxx',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,0,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=264082;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(264082,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,264082,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=264082;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(264082,0,118566,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=264082;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=264082;
DELETE FROM `creature_classic_level` WHERE `entry`=264082;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (264082,19,19);
-- target 264082 Broodmother Valraxx: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26408200 AND 26408299;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26408200,264082,1,0,0,'0',0,0,0,-1,0,0,-45.092,423.675,102.23,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);
UPDATE `creature_template` SET `faction`=16 WHERE `entry`=264082; -- was 35 (friendly)

-- 96604 The Great Outdoors
DELETE FROM `creature_queststarter` WHERE `quest`=96604;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(265809,96604,0);
DELETE FROM `creature_questender` WHERE `quest`=96604;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(265809,96604,0);

-- 96605 The Great Outdoors
-- creature 265810 Kaga Wildhoof <Adventurer>
DELETE FROM `creature_template` WHERE `entry`=265810;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(265810,0,0,'Kaga Wildhoof',NULL,'Adventurer',NULL,NULL,0,0,104,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=265810;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(265810,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=265810;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(265810,0,144649,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=265810;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=265810;
DELETE FROM `creature_queststarter` WHERE `quest`=96605;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(265810,96605,0);
DELETE FROM `creature_classic_level` WHERE `entry`=265810;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (265810,12,12);
-- starter 265810 Kaga Wildhoof: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26581000 AND 26581099;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26581000,265810,1,0,0,'0',0,0,0,-1,0,0,-2489.93,-364.058,-11.114,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);
DELETE FROM `creature_questender` WHERE `quest`=96605;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(265810,96605,0);

-- 96659 The Adventurer
DELETE FROM `creature_queststarter` WHERE `quest`=96659;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(2981,96659,0);
DELETE FROM `creature_questender` WHERE `quest`=96659;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(265810,96659,0);

-- 96895 The Argent Emissary
DELETE FROM `creature_queststarter` WHERE `quest`=96895;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(1738,96895,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=1738;

-- 96899 Bandarion Keep
DELETE FROM `creature_queststarter` WHERE `quest`=96899;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(267009,96899,0);
-- creature 267008 Leonid Barthalomew the Revered <The Argent Dawn>
DELETE FROM `creature_template` WHERE `entry`=267008;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(267008,0,0,'Leonid Barthalomew the Revered',NULL,'The Argent Dawn',NULL,NULL,0,0,68,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=267008;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(267008,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=267008;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(267008,0,10474,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=267008;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=267008;
DELETE FROM `creature_questender` WHERE `quest`=96899;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(267008,96899,0);
DELETE FROM `creature_classic_level` WHERE `entry`=267008;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (267008,60,60);
-- ender 267008 Leonid Barthalomew the Revered: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26700800 AND 26700899;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26700800,267008,0,0,0,'0',0,0,0,-1,0,0,2485.84,2037.8,138.243,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 97223 Bloodtalon Matriarch
DELETE FROM `creature_queststarter` WHERE `quest`=97223;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(7953,97223,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=7953;
DELETE FROM `creature_questender` WHERE `quest`=97223;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(7953,97223,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=7953;
-- creature 268530 Bloodtalon Matriarch <>
DELETE FROM `creature_template` WHERE `entry`=268530;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(268530,0,0,'Bloodtalon Matriarch',NULL,NULL,NULL,NULL,0,0,14,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'SmartAI',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=268530;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(268530,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,268530,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=268530;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(268530,0,11316,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=268530;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=268530;
DELETE FROM `smart_scripts` WHERE `entryorguid`=268530 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(268530,0,0,0,'',9,0,100,1,5,20,0,0,0,'',11,6268,0,0,0,0,0,0,'',1,0,0,0,0,'',0.0,0.0,0.0,0.0,'Forever Bloodtalon Matriarch - cast Rushing Charge (TEMPLATE_SAME_SPELL)');
DELETE FROM `creature_loot_template` WHERE `Entry`=268530 AND `Item`=277128;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(268530,0,277128,100.0,1,1,0,1,1,'Wowhead Forever drop 307/386 x1.84 floor 48.0 (quest item, INFERRED, 1328)');
DELETE FROM `creature_classic_level` WHERE `entry`=268530;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (268530,9,9);
-- target 268530 Bloodtalon Matriarch: 5 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26853000 AND 26853099;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26853000,268530,1,0,0,'0',0,0,0,-1,0,0,-722.617,-5573.86,27.688,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26853001,268530,1,0,0,'0',0,0,0,-1,0,0,-694.417,-5579.15,24.094,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26853002,268530,1,0,0,'0',0,0,0,-1,0,0,-750.817,-5589.73,25.831,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26853003,268530,1,0,0,'0',0,0,0,-1,0,0,-704.992,-5595.01,24.744,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(26853004,268530,1,0,0,'0',0,0,0,-1,0,0,-722.617,-5600.3,25.713,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0);
UPDATE `creature_template` SET `faction`=14 WHERE `entry`=268530; -- was 35 (friendly)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=268530;
DELETE FROM `smart_scripts` WHERE `entryorguid`=268530 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(268530,0,0,0,'',9,0,100,1,5,20,0,0,0,'',11,6268,0,0,0,0,0,0,'',1,0,0,0,0,'',0.0,0.0,0.0,0.0,'Forever Bloodtalon Matriarch - cast Rushing Charge (TEMPLATE_SAME_SPELL)');

-- 97225 Forgotten Loa Idols
DELETE FROM `creature_queststarter` WHERE `quest`=97225;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(3304,97225,0);
DELETE FROM `creature_questender` WHERE `quest`=97225;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(3188,97225,0);
-- object 660647 Forgotten Loa Idol
DELETE FROM `gameobject_template` WHERE `entry`=660647;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(660647,3,127185,'Forgotten Loa Idol','','','',1.0,43,660647,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=660647;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(660647,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 66064700 AND 66064799;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(66064700,660647,1,0,0,'0',0,0,0,-1,-1152.67,-5378.23,8.564,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064701,660647,1,0,0,'0',0,0,0,-1,-1127.99,-5383.51,8.601,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064702,660647,1,0,0,'0',0,0,0,-1,-1198.49,-5394.09,7.233,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064703,660647,1,0,0,'0',0,0,0,-1,-1216.12,-5399.38,6.577,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064704,660647,1,0,0,'0',0,0,0,-1,-1089.22,-5404.66,12.109,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064705,660647,1,0,0,'0',0,0,0,-1,-1290.14,-5409.95,4.3,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064706,660647,1,0,0,'0',0,0,0,-1,-1177.34,-5425.81,4.403,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064707,660647,1,0,0,'0',0,0,0,-1,-1117.42,-5431.1,11.513,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064708,660647,1,0,0,'0',0,0,0,-1,-1216.12,-5431.1,5.476,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064709,660647,1,0,0,'0',0,0,0,-1,-1265.47,-5436.39,5.119,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064710,660647,1,0,0,'0',0,0,0,-1,-1304.24,-5462.83,3.99,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064711,660647,1,0,0,'0',0,0,0,-1,-1286.62,-5505.12,5.005,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064712,660647,1,0,0,'0',0,0,0,-1,-1135.04,-5510.41,6.075,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064713,660647,1,0,0,'0',0,0,0,-1,-1240.79,-5515.7,6.106,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064714,660647,1,0,0,'0',0,0,0,-1,-1103.32,-5526.27,11.77,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064715,660647,1,0,0,'0',0,0,0,-1,-1085.69,-5542.14,10.067,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064716,660647,1,0,0,'0',0,0,0,-1,-1061.02,-5547.42,8.856,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064717,660647,1,0,0,'0',0,0,0,-1,-1142.09,-5573.86,7.669,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064718,660647,1,0,0,'0',0,0,0,-1,-1212.59,-5579.15,8.99,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064719,660647,1,0,0,'0',0,0,0,-1,-1163.24,-5584.44,8.753,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064720,660647,1,0,0,'0',0,0,0,-1,-1212.59,-5584.44,8.575,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064721,660647,1,0,0,'0',0,0,0,-1,-1117.42,-5610.88,7.224,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(66064722,660647,1,0,0,'0',0,0,0,-1,-1180.87,-5616.16,4.883,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=660647 AND `Item`=277135;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(660647,0,277135,100.0,1,1,0,1,1,'Forgotten Loa Idol - Wowhead Forever contains 205/205');

-- 97932 Camping 101: Fishing
DELETE FROM `creature_queststarter` WHERE `quest`=97932;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(265810,97932,0);

-- 97937 Camping 101: Tailoring
DELETE FROM `creature_queststarter` WHERE `quest`=97937;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(265810,97937,0);

-- 97950 Camping 101: Tailoring
-- creature 265811 Lyreena Duskblade <Adventurer>
DELETE FROM `creature_template` WHERE `entry`=265811;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(265811,0,0,'Lyreena Duskblade',NULL,'Adventurer',NULL,NULL,0,0,80,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=265811;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(265811,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=265811;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(265811,0,144650,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=265811;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=265811;
DELETE FROM `creature_queststarter` WHERE `quest`=97950;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(265811,97950,0);
DELETE FROM `creature_classic_level` WHERE `entry`=265811;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (265811,12,12);
-- starter 265811 Lyreena Duskblade: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 26581100 AND 26581199;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(26581100,265811,1,0,0,'0',0,0,0,-1,0,0,9910.39,891.967,1313.19,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 98341 The Great Windborne Cat Spirit
DELETE FROM `creature_queststarter` WHERE `quest`=98341;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(11802,98341,0);
DELETE FROM `creature_questender` WHERE `quest`=98341;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(272054,98341,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=272054;
DELETE FROM `creature_classic_level` WHERE `entry`=272054;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (272054,60,60);
-- ender 272054 Avatar of Saeyleenan: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 27205400 AND 27205499;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(27205400,272054,1,0,0,'0',0,0,0,-1,0,0,7358.53,-2396.92,488.0,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 98404 The Great Windborne Cat Spirit
DELETE FROM `creature_queststarter` WHERE `quest`=98404;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(272054,98404,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=272054;
DELETE FROM `creature_questender` WHERE `quest`=98404;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(272054,98404,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=272054;
-- object 672821 Relic of the Fang
DELETE FROM `gameobject_template` WHERE `entry`=672821;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(672821,3,404,'Relic of the Fang','','','',1.0,43,672821,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=672821;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(672821,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 67282100 AND 67282199;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(67282100,672821,1,0,0,'0',0,0,0,-1,7475.54,-3052.48,433.18,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(67282101,672821,1,0,0,'0',0,0,0,-1,7474.0,-3057.1,429.97,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=672821 AND `Item`=280502;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(672821,0,280502,100.0,1,1,0,1,1,'Relic of the Fang - Wowhead Forever contains 14/14');
-- object 673093 Relic of the Claw
DELETE FROM `gameobject_template` WHERE `entry`=673093;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(673093,3,404,'Relic of the Claw','','','',1.0,43,673093,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=673093;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(673093,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 67309300 AND 67309399;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(67309300,673093,1,0,0,'0',0,0,0,-1,7457.07,-3117.12,592.861,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=673093 AND `Item`=280679;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(673093,0,280679,100.0,1,1,0,1,1,'Relic of the Claw - INFERRED same-name loot');
-- object 673094 Relic of the Silent Shadow
DELETE FROM `gameobject_template` WHERE `entry`=673094;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(673094,3,404,'Relic of the Silent Shadow','','','',1.0,43,673094,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=673094;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(673094,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 67309400 AND 67309499;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(67309400,673094,1,0,0,'0',0,0,0,-1,7484.78,-3098.65,415.55,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0),
(67309401,673094,1,0,0,'0',0,0,0,-1,7489.4,-3100.96,430.35,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=673094 AND `Item`=280680;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(673094,0,280680,100.0,1,1,0,1,1,'Relic of the Silent Shadow - Wowhead Forever contains 16/16');

-- 98738 Blessings of the Great Windborne Cat Spirit
DELETE FROM `creature_queststarter` WHERE `quest`=98738;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(272054,98738,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=272054;
DELETE FROM `creature_questender` WHERE `quest`=98738;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(11802,98738,0);

-- 98823 Earthen Echo
DELETE FROM `creature_queststarter` WHERE `quest`=98823;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(9087,98823,0);

-- 99048 A Missing Hand
-- creature 275657 Heglan Shadeeye <>
DELETE FROM `creature_template` WHERE `entry`=275657;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(275657,0,0,'Heglan Shadeeye',NULL,NULL,NULL,NULL,0,0,29,2,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=275657;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(275657,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=275657;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(275657,0,148335,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=275657;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=275657;
DELETE FROM `creature_questender` WHERE `quest`=99048;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(275657,99048,0);
DELETE FROM `creature_classic_level` WHERE `entry`=275657;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (275657,9,9);
-- ender 275657 Heglan Shadeeye: 1 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 27565700 AND 27565799;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(27565700,275657,1,0,0,'0',0,0,0,-1,0,0,200.933,-5060.98,13.284,0.0,300,0.0,0,100,0,0,0,0,0,'',NULL,0);

-- 99052 Threat from Below
DELETE FROM `creature_queststarter` WHERE `quest`=99052;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(3142,99052,0);
DELETE FROM `creature_questender` WHERE `quest`=99052;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(3142,99052,0);

-- 99159 Finding Warmth
DELETE FROM `creature_queststarter` WHERE `quest`=99159;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(1253,99159,0);
DELETE FROM `creature_questender` WHERE `quest`=99159;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(1253,99159,0);

-- 99160 Rime's Wrath
DELETE FROM `creature_queststarter` WHERE `quest`=99160;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(1253,99160,0);
DELETE FROM `creature_questender` WHERE `quest`=99160;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(1253,99160,0);
DELETE FROM `creature_classic_level` WHERE `entry`=276003;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (276003,7,8);
-- target 276003 Minor Ice Elemental: 42 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 27600300 AND 27600399;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(27600300,276003,0,0,0,'0',0,0,0,-1,0,0,-5354.58,-630.867,396.035,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600301,276003,0,0,0,'0',0,0,0,-1,0,0,-5275.78,-709.667,389.599,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600302,276003,0,0,0,'0',0,0,0,-1,0,0,-5315.18,-729.367,398.894,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600303,276003,0,0,0,'0',0,0,0,-1,0,0,-5262.65,-739.217,389.947,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600304,276003,0,0,0,'0',0,0,0,-1,0,0,-5321.75,-758.917,388.435,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600305,276003,0,0,0,'0',0,0,0,-1,0,0,-5302.05,-768.767,392.536,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600306,276003,0,0,0,'0',0,0,0,-1,0,0,-5374.28,-768.767,397.234,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600307,276003,0,0,0,'0',0,0,0,-1,0,0,-5348.02,-778.617,399.513,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600308,276003,0,0,0,'0',0,0,0,-1,0,0,-5321.75,-788.467,388.333,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600309,276003,0,0,0,'0',0,0,0,-1,0,0,-5295.48,-818.017,395.592,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600310,276003,0,0,0,'0',0,0,0,-1,0,0,-5348.02,-818.017,399.701,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600311,276003,0,0,0,'0',0,0,0,-1,0,0,-5387.42,-827.867,394.231,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600312,276003,0,0,0,'0',0,0,0,-1,0,0,-5288.92,-837.717,403.475,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600313,276003,0,0,0,'0',0,0,0,-1,0,0,-5433.38,-837.717,394.055,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600314,276003,0,0,0,'0',0,0,0,-1,0,0,-5334.88,-847.567,388.332,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600315,276003,0,0,0,'0',0,0,0,-1,0,0,-5446.52,-847.567,394.826,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600316,276003,0,0,0,'0',0,0,0,-1,0,0,-5380.85,-857.417,391.732,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600317,276003,0,0,0,'0',0,0,0,-1,0,0,-5328.32,-896.817,395.665,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600318,276003,0,0,0,'0',0,0,0,-1,0,0,-5341.45,-916.517,389.657,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600319,276003,0,0,0,'0',0,0,0,-1,0,0,-5380.85,-916.517,394.198,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600320,276003,0,0,0,'0',0,0,0,-1,0,0,-5407.12,-916.517,392.215,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600321,276003,0,0,0,'0',0,0,0,-1,0,0,-5341.45,-936.217,388.332,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600322,276003,0,0,0,'0',0,0,0,-1,0,0,-5420.25,-946.067,392.216,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600323,276003,0,0,0,'0',0,0,0,-1,0,0,-5302.05,-955.917,389.642,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600324,276003,0,0,0,'0',0,0,0,-1,0,0,-5328.32,-965.767,388.333,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600325,276003,0,0,0,'0',0,0,0,-1,0,0,-5393.98,-965.767,390.496,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600326,276003,0,0,0,'0',0,0,0,-1,0,0,-5439.95,-975.617,392.213,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600327,276003,0,0,0,'0',0,0,0,-1,0,0,-5499.05,-975.617,399.389,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600328,276003,0,0,0,'0',0,0,0,-1,0,0,-5374.28,-985.467,388.332,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600329,276003,0,0,0,'0',0,0,0,-1,0,0,-5334.88,-995.317,388.332,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600330,276003,0,0,0,'0',0,0,0,-1,0,0,-5361.15,-1005.17,388.332,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600331,276003,0,0,0,'0',0,0,0,-1,0,0,-5407.12,-1005.17,390.184,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600332,276003,0,0,0,'0',0,0,0,-1,0,0,-5505.62,-1005.17,393.446,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600333,276003,0,0,0,'0',0,0,0,-1,0,0,-5492.48,-1015.02,392.9,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600334,276003,0,0,0,'0',0,0,0,-1,0,0,-5302.05,-1024.87,388.115,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600335,276003,0,0,0,'0',0,0,0,-1,0,0,-5446.52,-1024.87,389.784,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600336,276003,0,0,0,'0',0,0,0,-1,0,0,-5348.02,-1034.72,393.683,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600337,276003,0,0,0,'0',0,0,0,-1,0,0,-5380.85,-1034.72,395.828,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600338,276003,0,0,0,'0',0,0,0,-1,0,0,-5407.12,-1034.72,390.712,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600339,276003,0,0,0,'0',0,0,0,-1,0,0,-5538.45,-1034.72,394.035,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600340,276003,0,0,0,'0',0,0,0,-1,0,0,-5262.65,-1044.57,397.722,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600341,276003,0,0,0,'0',0,0,0,-1,0,0,-5354.58,-1083.97,394.103,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0);
UPDATE `creature_template` SET `faction`=14 WHERE `entry`=276003; -- was 35 (friendly)

-- 99161 Rime's Wrath
DELETE FROM `creature_queststarter` WHERE `quest`=99161;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(1253,99161,0);
DELETE FROM `creature_questender` WHERE `quest`=99161;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(1253,99161,0);
-- creature 276009 Avala <The Lost Rime>
DELETE FROM `creature_template` WHERE `entry`=276009;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(276009,0,0,'Avala',NULL,'The Lost Rime',NULL,NULL,0,0,37,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=276009;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(276009,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,276009,0,0,2,13,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=276009;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(276009,0,146644,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=276009;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=276009;
DELETE FROM `creature_loot_template` WHERE `Entry`=276009 AND `Item`=286325;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(276009,0,286325,100.0,1,1,0,1,1,'Wowhead Forever drop 336/336 x1.84 floor 48.0 (quest item, INFERRED, 1328)');
DELETE FROM `creature_classic_level` WHERE `entry`=276009;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (276009,8,8);
-- target 276009 Avala: 5 spawns
DELETE FROM `creature` WHERE `guid` BETWEEN 27600900 AND 27600999;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(27600900,276009,0,0,0,'0',0,0,0,-1,0,0,-5308.62,-1015.02,388.333,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600901,276009,0,0,0,'0',0,0,0,-1,0,0,-5262.65,-1024.87,395.733,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600902,276009,0,0,0,'0',0,0,0,-1,0,0,-5282.35,-1024.87,388.333,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600903,276009,0,0,0,'0',0,0,0,-1,0,0,-5282.35,-1054.42,408.594,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0),
(27600904,276009,0,0,0,'0',0,0,0,-1,0,0,-5256.08,-1064.27,403.611,0.0,300,5.0,0,100,1,0,0,0,0,'',NULL,0);
UPDATE `creature_template` SET `faction`=37 WHERE `entry`=276009; -- was 35 (friendly)

-- 99162 Treacherous Cold
DELETE FROM `creature_queststarter` WHERE `quest`=99162;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(1253,99162,0);
DELETE FROM `creature_questender` WHERE `quest`=99162;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(1253,99162,0);
-- object 695277 Stoneanvil's Rifle
DELETE FROM `gameobject_template` WHERE `entry`=695277;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(695277,3,88133,'Stoneanvil''s Rifle','','','',1.0,43,695277,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=695277;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(695277,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 69527700 AND 69527799;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(69527700,695277,0,0,0,'0',0,0,0,-1,-5804.4,-818.017,398.043,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=695277 AND `Item`=286360;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(695277,0,286360,100.0,1,1,0,1,1,'Stoneanvil''s Rifle - Wowhead Forever contains 22/22');
-- object 695223 Sunhammer's Rifle
DELETE FROM `gameobject_template` WHERE `entry`=695223;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(695223,3,88133,'Sunhammer''s Rifle','','','',1.0,43,695223,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=695223;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(695223,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 69522300 AND 69522399;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(69522300,695223,0,0,0,'0',0,0,0,-1,-5522.03,-1147.99,398.425,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=695223 AND `Item`=286359;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(695223,0,286359,100.0,1,1,0,1,1,'Sunhammer''s Rifle - Wowhead Forever contains 18/18');
-- object 695222 Coalbeard's Rifle
DELETE FROM `gameobject_template` WHERE `entry`=695222;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(695222,3,88133,'Coalbeard''s Rifle','','','',1.0,43,695222,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject_template_addon` WHERE `entry`=695222;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`,`artkit0`,`artkit1`,`artkit2`,`artkit3`,`artkit4`,`WorldEffectID`,`AIAnimKitID`) VALUES
(695222,0,4,0,0,0,0,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 69522200 AND 69522299;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(69522200,695222,0,0,0,'0',0,0,0,-1,-5321.75,-763.842,388.333,0.0,0.0,0.0,0.0,1.0,300,255,1,'',NULL,0);
DELETE FROM `gameobject_loot_template` WHERE `Entry`=695222 AND `Item`=286358;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(695222,0,286358,100.0,1,1,0,1,1,'Coalbeard''s Rifle - Wowhead Forever contains 30/30');
