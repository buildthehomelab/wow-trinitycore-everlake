-- Classic 1.60 (Forever): Excavation Site: Wetlands (map 2998, zone 16732) had spawns (_35) but no way in. As in the Ruins of Lordaeron and the Hall of
--    Thanes, the official entrance is a server-side trigger (the 70532 AreaTrigger.db2 has none), at the Instance Portal (620184)
--    at (-3703.71, -2368.39) on map 0. Arrival inside at (-3698.41, -2355.64, 165.53) and the way out at the dungeon mouth
--    (-3702.3, -2374.0) back to (-3704.87, -2380.68, 166.32) outside: AnoCore's points from an official recording of 2026-10-10.
--    Trigger sizes INFERRED (sphere 4 yd at the portal, 3 yd inside). Ghosts release to the Wetlands Crossroads graveyard (7).
DELETE FROM `instance_template` WHERE `map`=2998;
INSERT INTO `instance_template` (`map`,`parent`,`script`) VALUES
(2998,0,'classic_instance_excavation_site_wetlands');

DELETE FROM `world_safe_locs` WHERE `ID` IN (1104104,1104105);
INSERT INTO `world_safe_locs` (`ID`,`MapID`,`LocX`,`LocY`,`LocZ`,`Facing`,`Comment`) VALUES
(1104104,2998,-3698.41,-2355.64,165.531,5.167,'Excavation Site: Wetlands (dungeon) - entrance inside'),
(1104105,0,-3704.87,-2380.68,166.317,4.618,'Excavation Site: Wetlands (dungeon) - exit outside, Wetlands');

DELETE FROM `areatrigger_template` WHERE `IsCustom`=1 AND `Id` IN (304,305);
INSERT INTO `areatrigger_template` (`Id`,`IsCustom`,`Flags`,`ActionSetId`,`ActionSetFlags`,`VerifiedBuild`) VALUES
(304,1,0,0,0,0),
(305,1,0,0,0,0);
DELETE FROM `areatrigger_template_actions` WHERE `IsCustom`=1 AND `AreaTriggerId` IN (304,305);
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`,`IsCustom`,`ActionType`,`ActionParam`,`TargetType`) VALUES
(304,1,2,1104104,5),
(305,1,2,1104105,5);
DELETE FROM `areatrigger_create_properties` WHERE `IsCustom`=1 AND `Id` IN (304,305);
INSERT INTO `areatrigger_create_properties` (`Id`,`IsCustom`,`AreaTriggerId`,`IsAreatriggerCustom`,`Flags`,`MoveCurveId`,`ScaleCurveId`,`MorphCurveId`,`FacingCurveId`,`AnimId`,`AnimKitId`,`DecalPropertiesId`,`SpellForVisuals`,`PositionalSoundKitId`,`TimeToTargetScale`,`Speed`,`SpeedIsTime`,`Shape`,`ShapeData0`,`ShapeData1`,`ShapeData2`,`ShapeData3`,`ShapeData4`,`ShapeData5`,`ShapeData6`,`ShapeData7`,`Roll`,`Pitch`,`Yaw`,`TargetRoll`,`TargetPitch`,`TargetYaw`,`ScriptName`,`VerifiedBuild`) VALUES
(304,1,304,1,0,0,0,0,0,-1,0,0,NULL,0,0,0,0,0,4,4,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,'',0),
(305,1,305,1,0,0,0,0,0,-1,0,0,NULL,0,0,0,0,0,3,3,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,'',0);
DELETE FROM `areatrigger` WHERE `SpawnId` IN (9,10);
INSERT INTO `areatrigger` (`SpawnId`,`AreaTriggerCreatePropertiesId`,`IsCustom`,`MapId`,`SpawnDifficulties`,`PosX`,`PosY`,`PosZ`,`Orientation`,`PhaseUseFlags`,`PhaseId`,`PhaseGroup`,`ScriptName`,`Comment`,`VerifiedBuild`) VALUES
(9,304,1,0,'0',-3703.71,-2368.39,166.3,0,1,0,0,'','Excavation Site: Wetlands - dungeon entrance (Instance Portal 620184)',0),
(10,305,1,2998,'1,201',-3702.3,-2374.0,166.3,0,1,0,0,'','Excavation Site: Wetlands (dungeon) - exit at the dungeon mouth',0);

DELETE FROM `graveyard_zone` WHERE `GhostZone`=16732;
INSERT INTO `graveyard_zone` (`ID`,`GhostZone`,`Comment`) VALUES
(7,16732,'Excavation Site: Wetlands (dungeon) - Wetlands, Crossroads GY');

-- Bosses: Saltspine and Shadetooth named AnoCore C++ scripts we don't have (boss_saltspine, boss_shadetooth); they fight with the
--    default AI. The Relic Guardian and the Archival Panel get ours (classic_instance_excavation_site_wetlands.cpp).
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry` IN (260322,260325);
UPDATE `creature_template` SET `AIName`='',`ScriptName`='classic_boss_relic_guardian' WHERE `entry`=260326;
UPDATE `gameobject_template` SET `AIName`='',`ScriptName`='classic_go_excavation_archival_panel' WHERE `entry`=640041;
DELETE FROM `creature_text` WHERE `CreatureID`=260326;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`SoundPlayType`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(260326,0,0,'Archival process suspended. Initializing stabilization protocol.',14,0,100,0,0,0,0,310733,0,'Relic Guardian - stabilization start (official yell)'),
(260326,1,0,'Stabilization resolved. Defensive measures reactivated.',14,0,100,0,0,0,0,310735,0,'Relic Guardian - stabilization end (official yell)');

-- Titan Relic: one per side (AnoCore: 270865 for the Alliance, 270866 for the Horde), each starts its side's quest.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=260326 AND `SourceEntry` IN (270865,270866);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(1,260326,270865,0,0,6,0,469,0,0,0,0,0,'','Titan Relic (Alliance): looter is Alliance'),
(1,260326,270866,0,0,6,0,67,0,0,0,0,0,'','Titan Relic (Horde): looter is Horde');

-- Shadetooth and Relic Guardian loot from AnoCore (boss items from the Wowhead Forever drop counts; Saltspine already has his).
-- AnoCore's reference ids 50601, 60005, 60143, 60219 and 60443 don't exist in ours and are left out.
DELETE FROM `creature_loot_template` WHERE `Entry`=260325 AND `Item` IN (422,929,1205,1206,1529,1705,2455,2592,3385,3396,3608,3611,3612,3770,4296,4297,4299,4306,4347,4349,4350,4352,4412,4414,4538,4542,4606,4633,5543,5578,5972,6045,6211,6454,7090,7091,7092,7360,7363,7364,7449,10316,10424,11038,11098,11164,30004,273025,273026,273027,273106);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(260325,0,422,0.06,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,929,1.221,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,1205,2.4268,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,1206,0.41,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,1529,0.142,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,1705,0.458,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,2455,0.04,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,2592,9.4464,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,3385,0.6486,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,3396,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,3608,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,3611,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,3612,0.04,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,3770,0.06,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4296,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4297,0.03,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4299,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4306,22.3673,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4347,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4349,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4350,0.04,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4352,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4412,0.03,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4414,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4538,4.4537,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4542,2.05,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4606,0.08,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,4633,0.4556,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,5543,0.04,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,5578,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,5972,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,6045,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,6211,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,6454,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,7090,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,7091,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,7092,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,7360,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,7363,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,7364,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,7449,0.025,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,10316,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,10424,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,11038,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,11098,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,0,11164,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260325,1,30004,0.25,0,1,0,1,1,'world drop reference (classic group: minlevel + rank, 1274)'),
(260325,0,273025,27.0833,0,1,1,1,1,'Raptorclaw Greaves - Wowhead Forever 91/336 (1317)'),
(260325,0,273026,32.4405,0,1,1,1,1,'Garb of Florid Feathers - Wowhead Forever 109/336 (1317)'),
(260325,0,273027,33.631,0,1,1,1,1,'Raptor''s Gaze - Wowhead Forever 113/336 (1317)'),
(260325,0,273106,6.854,0,1,0,1,1,'Shadetooth - Wowhead Forever 22/321 (refreshed 1106)');
DELETE FROM `creature_loot_template` WHERE `Entry`=260326 AND `Item` IN (422,929,1205,1206,1529,1705,2455,2592,3385,3396,3608,3611,3612,3770,4296,4297,4299,4306,4347,4349,4350,4352,4412,4414,4538,4542,4606,4633,5543,5578,5972,6045,6211,6454,7090,7091,7092,7360,7363,7364,7449,10316,10424,11038,11098,11164,30004,273028,273029,273030,273097);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(260326,0,422,0.06,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,929,1.221,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,1205,2.4268,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,1206,0.41,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,1529,0.142,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,1705,0.458,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,2455,0.04,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,2592,9.4464,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,3385,0.6486,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,3396,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,3608,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,3611,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,3612,0.04,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,3770,0.06,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4296,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4297,0.03,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4299,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4306,22.3673,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4347,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4349,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4350,0.04,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4352,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4412,0.03,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4414,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4538,4.4537,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4542,2.05,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4606,0.08,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,4633,0.4556,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,5543,0.04,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,5578,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,5972,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,6045,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,6211,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,6454,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,7090,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,7091,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,7092,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,7360,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,7363,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,7364,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,7449,0.025,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,10316,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,10424,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,11038,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,11098,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,0,11164,0.02,0,1,0,1,1,'common classic world drop (group: minlevel + rank, 1274)'),
(260326,1,30004,0.25,0,1,0,1,1,'world drop reference (classic group: minlevel + rank, 1274)'),
(260326,0,273028,33.6299,0,1,1,1,1,'Reliquary Mantle - Wowhead Forever 189/562 (1317)'),
(260326,0,273029,33.452,0,1,1,1,1,'Golemsight Long Gun - Wowhead Forever 188/562 (1317)'),
(260326,0,273030,27.9359,0,1,1,1,1,'Ring of Power Regulation - Wowhead Forever 157/562 (1317)'),
(260326,0,273097,7.664,0,1,0,1,1,'Relic Guardian - Wowhead Forever 41/535 (refreshed 1106)');

-- Lost Relic Carry (95810, Alliance): back from AnoCore now that the Relic Guardian can be fought. Elder Knowledge (95664) is the
--    Horde one and was already in.
-- NEW 95810 Lost Relic Carry (level 31, required 24)
DELETE FROM `quest_template` WHERE `ID`=95810;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(95810,2,0,0,16732,0,0,98824,2,1.95,0,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,6130900294268439629,0,0,0,'Lost Relic Carry','Bring the Titan Relic to Prospector Whelgar in the Wetlands excavation site.','You pick up a fractured piece of the rock-mech automaton. It has a texture unlike anything you''ve touched before, a composite material of unknown makeup. This is certainly bound to be more ''device'' than ''debris.''

Prospector Whelgar himself at his excavation site might have something useful to share about the relic.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=95810;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(471430,95810,1,0,0,270865,1,0,32,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=95810;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(95810,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=95810;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(95810,0,0,0,0,0,0,0,0,'Ah, ye ventured all the way in and survived to tell the tale?! Let''s have a look at what ye carry there. $B$BWell, knowing what ye went through to bring it back to me, I think it warrants a certain reverence for your artifact.',0);
DELETE FROM `quest_request_items` WHERE `ID`=95810;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(95810,0,0,0,0,'Here for the dig?',0);
DELETE FROM `quest_details` WHERE `ID`=95810;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=95810;
DELETE FROM `quest_poi` WHERE `QuestID`=95810;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(95810,0,0,-1,0,0,0,1437,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=95810;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(95810,0,0,-3592,-1994,117,0);
DELETE FROM `quest_classic_level` WHERE `ID`=95810;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95810,31,24,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95810;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95810,2,31);

-- 95810 Lost Relic Carry
DELETE FROM `creature_questender` WHERE `quest`=95810;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(1077,95810,0);
