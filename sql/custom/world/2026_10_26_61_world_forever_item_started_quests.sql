-- WoW Forever quests started by an item, on the Wowhead Forever list and in AnoCore v10 but missing from our world
-- (AnoCore v11: "Nineteen quest-starting items that never dropped now do, among them Whispering Horror Residue and the
-- drops of Croaky, Elmpaw, Ukorsbane, Halikor and Baron Marinous"). Ported from AnoCore v10 with their starting drops.
-- Croaky's Head, Elmpaw's Head and Halikor's Hoof need the rares' spawns from 2026_10_26_44_world_forever_roaming_rares.
-- Not added: Sign Me Up! x2 (their starting items drop nowhere), Lost Relic Carry (see the end).

-- NEW 86613 Excavation Tools (level 18, required 13)
DELETE FROM `quest_template` WHERE `ID`=86613;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(86613,2,0,0,38,0,0,0,5,1.0,5,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,47,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Excavation Tools','Return 6 Excavation Tools to Magmar Fellhew.','The excavation''s tools, left behind when the dwarves fled from the troggs, seem mostly untouched. Returning them to the excavators will surely aid their work.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=86613;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400234,86613,1,0,0,278398,6,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=86613;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(86613,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=86613;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(86613,0,0,0,0,0,0,0,0,'Our tools!$B$BWhen the troggs overran the camp, we had to leave most of our tools behind. This''ll be a big help once we get this invasion under control and can start working again!',0);
DELETE FROM `quest_request_items` WHERE `ID`=86613;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(86613,0,0,0,0,'We just, uh, need to adjust our dig site and we can get this whole thing back on track!',0);
DELETE FROM `quest_details` WHERE `ID`=86613;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=86613;
DELETE FROM `quest_poi` WHERE `QuestID`=86613;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(86613,0,0,-1,0,0,0,1432,0,0,0,0,0,0,0,0),
(86613,0,1,0,9400234,278398,0,1432,0,0,0,0,0,0,0,0),
(86613,1,2,0,9400234,278398,0,1432,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=86613;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(86613,0,0,-5695,-3812,322,0),
(86613,1,0,-5723,-3832,323,0),
(86613,2,0,-5744,-3955,325,0),
(86613,2,1,-5683,-3941,325,0),
(86613,2,2,-5641,-3914,325,0),
(86613,2,3,-5729,-3908,325,0),
(86613,2,4,-5731,-3911,325,0);
DELETE FROM `quest_classic_level` WHERE `ID`=86613;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (86613,18,13,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=86613;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (86613,2,18);

-- 86613 Excavation Tools
DELETE FROM `creature_questender` WHERE `quest`=86613;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(1344,86613,0);

-- NEW 91740 Croaky's Head (level 10, required 7)
DELETE FROM `quest_template` WHERE `ID`=91740;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(91740,2,0,0,12,0,0,0,5,1.0,5,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,72,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Croaky''s Head','Deliver Croaky''s Head to Merell Ross at Ridgepoint Tower.','This murloc has no doubt been terrorizing the local roads for some time. You suspect the nearby watch guards will want to know of its demise.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=91740;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400198,91740,1,0,0,247826,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=91740;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(91740,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=91740;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(91740,0,0,0,0,0,0,0,0,'We lost two members of the watch last week to the murlocs, $C. Hopefully with their leader slain, we can start pushing them out of Elwynn.',0);
DELETE FROM `quest_request_items` WHERE `ID`=91740;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(91740,0,0,0,0,'Yes?',0);
DELETE FROM `quest_details` WHERE `ID`=91740;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=91740;
DELETE FROM `quest_poi` WHERE `QuestID`=91740;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(91740,0,0,-1,0,0,0,1429,0,0,0,0,0,0,0,0),
(91740,0,1,0,9400198,247826,0,1429,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=91740;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(91740,0,0,-9773,-1394,103,0),
(91740,1,0,-9940,-1119,26,0),
(91740,1,1,-9888,-1130,26,0),
(91740,1,2,-9893,-1109,26,0);
DELETE FROM `quest_classic_level` WHERE `ID`=91740;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (91740,10,7,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=91740;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (91740,2,10);

-- 91740 Croaky's Head
DELETE FROM `creature_questender` WHERE `quest`=91740;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(248277,91740,0);

-- NEW 91746 Elmpaw's Head (level 10, required 7)
DELETE FROM `quest_template` WHERE `ID`=91746;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(91746,2,0,0,12,0,0,0,5,1.0,5,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,72,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Elmpaw''s Head','Deliver Elmpaw''s Head to Helene Peltskinner near Goldshire.','The trophy serves as an impressive reminder of your victory over Elmpaw. A local hunter or skinner might be interested to hear the story.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=91746;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400199,91746,1,0,0,247862,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=91746;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(91746,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=91746;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(91746,0,0,0,0,0,0,0,0,'So, you took down Elmpaw? Very impressive, $n!$B$BLet me give you something in return for your trophy - I know a few collectors who will pay quite well to have this on their mantle once I''ve prepared it.',0);
DELETE FROM `quest_request_items` WHERE `ID`=91746;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(91746,0,0,0,0,'Yes?',0);
DELETE FROM `quest_details` WHERE `ID`=91746;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=91746;
DELETE FROM `quest_poi` WHERE `QuestID`=91746;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(91746,0,0,-1,0,0,0,1429,0,0,0,0,0,0,0,0),
(91746,0,1,0,9400199,247862,0,1429,0,0,0,0,0,0,0,0),
(91746,1,2,0,9400199,247862,0,1429,0,0,0,0,0,0,0,0),
(91746,2,3,0,9400199,247862,0,1429,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=91746;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(91746,0,0,-9380,-70,65,0),
(91746,1,0,-8907,-1047,76,0),
(91746,1,1,-8865,-1172,76,0),
(91746,1,2,-8824,-1193,76,0),
(91746,1,3,-8814,-1158,76,0),
(91746,1,4,-8810,-1130,76,0),
(91746,1,5,-8833,-998,76,0),
(91746,1,6,-8865,-977,76,0),
(91746,2,0,-9963,-1352,33,0),
(91746,2,1,-9907,-1408,33,0),
(91746,2,2,-9833,-1380,33,0),
(91746,2,3,-9847,-1311,33,0),
(91746,2,4,-9907,-1290,33,0),
(91746,2,5,-9963,-1311,33,0),
(91746,3,0,-9814,-1450,44,0),
(91746,3,1,-9791,-1519,44,0),
(91746,3,2,-9763,-1491,44,0),
(91746,3,3,-9796,-1456,44,0);
DELETE FROM `quest_classic_level` WHERE `ID`=91746;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (91746,10,7,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=91746;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (91746,2,10);

-- 91746 Elmpaw's Head
DELETE FROM `creature_questender` WHERE `quest`=91746;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(6306,91746,0);

-- NEW 95195 Bloodied Insignia (level 22, required 16)
DELETE FROM `quest_template` WHERE `ID`=95195;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(95195,2,0,0,16611,81,0,0,7,1.0,7,1.0,0,0,0,0,0,0,0,0,0,1.0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,279868,1,0,279869,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Bloodied Insignia','Collect 10 Bloodied Insignias and take them to General Marcus Jonathan in Stormwind City.','<The old Alliance insignia appears to have belonged to a soldier of Lordaeron. These ruins are likely filled with similar medals that living relatives would be grateful to have returned to them.>','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=95195;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400400,95195,1,0,0,268540,10,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=95195;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(95195,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=95195;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(95195,0,0,0,0,0,0,0,0,'Your instincts to bring these to me were not unfounded. When Lordaeron fell to the scourge, many people fled to take refuge here in Stormwind. There are likely few who remain to claim these insignias themselves.$B$BYour duty to Stormwind is commended, $n. I''ll begin distributing these tokens to next of kin right away.',0);
DELETE FROM `quest_request_items` WHERE `ID`=95195;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(95195,0,0,0,0,'You look as if you''re carrying a heavy burden, $n. What is it?',0);
DELETE FROM `quest_details` WHERE `ID`=95195;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=95195;
DELETE FROM `quest_poi` WHERE `QuestID`=95195;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(95195,0,0,-1,0,0,0,1453,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=95195;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(95195,0,0,-8954,521,97,0);
DELETE FROM `quest_classic_level` WHERE `ID`=95195;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95195,22,16,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95195;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95195,2,22);

-- 95195 Bloodied Insignia
DELETE FROM `creature_questender` WHERE `quest`=95195;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(466,95195,0);

-- NEW 95328 Whispering Horror Residue (level 10, required 7)
DELETE FROM `quest_template` WHERE `ID`=95328;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(95328,2,0,0,85,0,0,0,5,1.0,5,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,68,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'Whispering Horror Residue','Deliver Whispering Horror Residue to Father Lankester in the War Quarter of Undercity.','Against your better judgement you scrape up and collect the squirming remains of the beast. Someone in Undercity might have a use for them.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=95328;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400201,95328,1,0,0,268812,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=95328;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(95328,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=95328;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(95328,0,0,0,0,0,0,0,0,'What an interesting specimen. From underneath the Whispering Forest, you say? It''s no secret that foul place is touched by the void.$B$BI welcome the opportunity to explore the mysteries of shadow, $C. Allow me to offer you payment for what you''ve found.',0);
DELETE FROM `quest_request_items` WHERE `ID`=95328;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(95328,0,0,0,0,'Do you have something for me, $C?',0);
DELETE FROM `quest_details` WHERE `ID`=95328;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=95328;
DELETE FROM `quest_poi` WHERE `QuestID`=95328;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(95328,0,0,-1,0,0,0,1420,0,0,0,0,0,0,0,0),
(95328,0,1,0,9400201,268812,0,1420,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=95328;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(95328,0,0,1784,402,-57,0),
(95328,1,0,1958,2627,181,0),
(95328,1,1,2036,2600,181,0),
(95328,1,2,2054,2600,181,0),
(95328,1,3,2048,2645,181,0);
DELETE FROM `quest_classic_level` WHERE `ID`=95328;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95328,10,7,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95328;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95328,2,10);

-- 95328 Whispering Horror Residue
DELETE FROM `creature_questender` WHERE `quest`=95328;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(4607,95328,0);
UPDATE `creature_template_difficulty` SET `LootID`=260396 WHERE `Entry`=260396 AND `LootID`=0;
DELETE FROM `creature_loot_template` WHERE `Entry`=260396 AND `Item`=268812;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(260396,0,268812,100.0,1,1,0,1,1,'Wowhead Forever drop 85/85 x1.84 floor 48.0 (quest item, INFERRED, 1328)');

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
DELETE FROM `creature_loot_template` WHERE `Entry`=260326 AND `Item`=270865;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(260326,0,270865,100.0,0,1,0,1,1,'Titan Relic (Alliance) (975)');

-- NEW 95884 The Offering Stone (level 23, required 20)
DELETE FROM `quest_template` WHERE `ID`=95884;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(95884,2,0,0,130,0,0,95883,1,1.0,0,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'The Offering Stone','Find the Offering Stone in Beren''s Peril in Silverpine Forest.','<The scrap of note is mostly illegible. What is still readable, however, are notes about preparations for an offering.$B$BAn offering stone is mentioned, as well as a ritual.$B$BPerhaps you can find this offering stone nearby.>','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=95884;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400285,95884,1,0,0,271343,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=95884;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(95884,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=95884;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(95884,0,0,0,0,0,0,0,0,'<Strange implements and items litter the rough surface of the stone.$B$BThis is surely the offering stone that is mentioned in the note.>',0);
DELETE FROM `quest_request_items` WHERE `ID`=95884;
DELETE FROM `quest_details` WHERE `ID`=95884;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=95884;
DELETE FROM `quest_poi` WHERE `QuestID`=95884;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(95884,0,0,-1,0,0,0,1421,0,0,0,0,0,0,0,0),
(95884,0,1,0,9400285,271343,0,1421,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=95884;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(95884,0,0,-288,1010,115,0),
(95884,1,0,-406,916,124,0),
(95884,1,1,-366,902,124,0),
(95884,1,2,-290,944,124,0),
(95884,1,3,-288,1024,124,0),
(95884,1,4,-288,1025,124,0),
(95884,1,5,-290,1044,124,0),
(95884,1,6,-305,1067,124,0),
(95884,1,7,-322,1051,124,0),
(95884,1,8,-336,1032,124,0);
DELETE FROM `quest_classic_level` WHERE `ID`=95884;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95884,23,20,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95884;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95884,2,23);

-- 95884 The Offering Stone
DELETE FROM `gameobject_questender` WHERE `quest`=95884;
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(645153,95884,0);
DELETE FROM `creature_loot_template` WHERE `Entry`=1973 AND `Item`=271343;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(1973,0,271343,0.445,0,1,0,1,1,'Wowhead Forever drop 39/8761');
DELETE FROM `creature_loot_template` WHERE `Entry`=1974 AND `Item`=271343;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(1974,0,271343,0.481,0,1,0,1,1,'Wowhead Forever drop 47/9781');

-- NEW 96138 Merrick's Bow (level 28, required 18)
DELETE FROM `quest_template` WHERE `ID`=96138;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(96138,2,0,0,10,0,0,0,5,1.0,0,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Merrick''s Bow','Defeat 8 Splint Fist Warriors and 4 Splint Fist Taskmasters then return to Sirra Von''Indi in Darkshire for more information.','A bow left by the spirit of Merrick Valor, famed Watcher who prided himself on keeping the roads safe from encroaching enemies.$B$BWith Merrick''s spirit still wandering the roads, perhaps his unfinished business was to clear out invaders near his home in Raven Hill. The ogres south of town may be what''s troubling his spirit.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=96138;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9801023,96138,0,0,0,212,8,0,0,0,0.0,0,1,'',0),
(9801024,96138,0,1,1,892,4,0,0,0,0.0,0,1,'',0),
(9801025,96138,1,2,2,281142,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=96138;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(96138,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=96138;
DELETE FROM `quest_request_items` WHERE `ID`=96138;
DELETE FROM `quest_details` WHERE `ID`=96138;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=96138;
DELETE FROM `quest_poi` WHERE `QuestID`=96138;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(96138,0,0,-1,0,0,0,1431,0,0,0,0,0,0,0,0),
(96138,0,1,0,9801023,212,0,1431,0,0,0,0,0,0,0,0),
(96138,0,3,1,9801024,892,0,1431,0,0,0,0,0,0,0,0),
(96138,0,5,2,9801025,281142,0,1431,0,0,0,0,0,0,0,0),
(96138,1,2,0,9801023,212,0,1431,0,0,0,0,0,0,0,0),
(96138,1,4,1,9801024,892,0,1431,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=96138;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(96138,0,0,-10574,-1127,29,0),
(96138,1,0,-11234,-187,11,0),
(96138,1,1,-11171,-196,11,0),
(96138,1,2,-11151,-187,11,0),
(96138,1,3,-11110,-156,11,0),
(96138,1,4,-11078,-103,11,0),
(96138,1,5,-11070,-60,11,0),
(96138,1,6,-11180,-113,11,0),
(96138,1,7,-11231,-175,11,0),
(96138,2,0,-10997,-55,15,0),
(96138,2,1,-10969,-55,15,0),
(96138,2,2,-10960,-37,15,0),
(96138,2,3,-10982,-41,15,0),
(96138,3,0,-11066,-233,17,0),
(96138,4,0,-11071,-146,17,0),
(96138,4,1,-11021,-154,17,0),
(96138,4,2,-10993,-146,17,0),
(96138,4,3,-10944,-78,17,0),
(96138,4,4,-10986,-80,17,0),
(96138,4,5,-11048,-84,17,0),
(96138,5,0,-10908,-333,36,0);
DELETE FROM `quest_classic_level` WHERE `ID`=96138;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96138,28,18,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96138;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96138,2,28);

-- 96138 Merrick's Bow
DELETE FROM `creature_questender` WHERE `quest`=96138;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(268,96138,0);

-- NEW 96294 A Darker Truth (level 30, required 23)
DELETE FROM `quest_template` WHERE `ID`=96294;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(96294,2,0,0,215,0,0,0,4,1.0,5,1.0,0,0,0,0,0,0,0,273659,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,76,5,0,0,2787,5,0,0,81,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'A Darker Truth','Bring the letter you recovered from Broodmother Valraxx to Muln Earthfury at Skywatcher Plateau.','<The Broodmother you just killed is no spider at all, but rather a night elf druid who assumed a twisted animal form. A variety of questions flood your mind about the nature--and purpose--of the spiders at Gloomrise.$B$BYou notice a note peeking out of the folds of the dead elf''s robe. Perhaps this document may answer some of the questions filling your head.>','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=96294;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(91500046,96294,1,0,0,273659,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=96294;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(96294,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=96294;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(96294,0,0,0,0,0,0,0,0,'This is... most disturbing. Why would a druid be behind a brood of dangerous spiders? Who or what is this "Wild King" and "Pact" that is referenced in this letter?$B$BI will confer with the druids of the Cenarion Circle on this. Perhaps they will know more.$B$BThank you again for your aid. As disturbing as this information is, we will rest easier knowing that the person controlling these vile creatures has been destroyed.',0);
DELETE FROM `quest_request_items` WHERE `ID`=96294;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(96294,0,0,0,0,'What is this?',0);
DELETE FROM `quest_details` WHERE `ID`=96294;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=96294;
DELETE FROM `quest_poi` WHERE `QuestID`=96294;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(96294,0,0,-1,0,0,1,1412,0,0,0,0,0,0,0,0),
(96294,0,1,32,0,0,1,1412,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=96294;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(96294,0,0,-656,424,180,0),
(96294,1,0,-656,424,180,0);
DELETE FROM `quest_classic_level` WHERE `ID`=96294;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96294,30,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96294;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96294,2,30);

-- 96294 A Darker Truth
DELETE FROM `creature_questender` WHERE `quest`=96294;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(259118,96294,0);

-- NEW 96877 Halikor's Hoof (level 12, required 6)
DELETE FROM `quest_template` WHERE `ID`=96877;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(96877,2,0,0,14,0,0,0,4,1.0,4,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,76,4,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'Halikor''s Hoof','Deliver Halikor''s Hoof to Orgrimmar.','The enormous hoof serves as proof of your victory over the mighty lizard.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=96877;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400203,96877,1,0,0,275723,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=96877;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(96877,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=96877;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(96877,0,0,0,0,0,0,0,0,'What a trophy, $C! That must have been some fight!',0);
DELETE FROM `quest_request_items` WHERE `ID`=96877;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(96877,0,0,0,0,'Yes?',0);
DELETE FROM `quest_details` WHERE `ID`=96877;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=96877;
DELETE FROM `quest_poi` WHERE `QuestID`=96877;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(96877,0,0,-1,0,0,1,1454,0,0,0,0,0,0,0,0),
(96877,0,1,0,9400203,275723,1,1411,0,0,0,0,0,0,0,0),
(96877,1,2,0,9400203,275723,1,1411,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=96877;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(96877,0,0,1855,-4568,25,0),
(96877,1,0,962,-4268,-8,0),
(96877,1,1,969,-4247,-8,0),
(96877,1,2,976,-4204,-8,0),
(96877,2,0,730,-4130,-10,0),
(96877,2,1,786,-4099,-10,0),
(96877,2,2,828,-4067,-10,0),
(96877,2,3,758,-4099,-10,0);
DELETE FROM `quest_classic_level` WHERE `ID`=96877;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96877,12,6,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96877;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96877,2,12);

-- 96877 Halikor's Hoof
DELETE FROM `creature_questender` WHERE `quest`=96877;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(5811,96877,0);

-- NEW 97236 Fang of Githyiss (level 5, required 1)
DELETE FROM `quest_template` WHERE `ID`=97236;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(97236,2,0,0,141,0,0,0,5,1.0,5,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,69,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Fang of Githyiss','Deliver the Fang of Githyiss to someone interested in the study of spiders in Aldrassil.','A fresh specimen from a beast of this size is quite a find. Perhaps someone in Aldrassil familiar with the study of spiders would be interested in the fang.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=97236;
DELETE FROM `quest_template_addon` WHERE `ID`=97236;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(97236,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=97236;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(97236,0,0,0,0,0,0,0,0,'My, my. How I do love surprises, $n.$B$BThis specimen will surely help further my studies.',0);
DELETE FROM `quest_request_items` WHERE `ID`=97236;
DELETE FROM `quest_details` WHERE `ID`=97236;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=97236;
DELETE FROM `quest_poi` WHERE `QuestID`=97236;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(97236,0,0,-1,0,0,1,1438,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=97236;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(97236,0,0,10418,871,1319,0);
DELETE FROM `quest_classic_level` WHERE `ID`=97236;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (97236,5,1,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=97236;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (97236,2,5);

-- 97236 Fang of Githyiss
DELETE FROM `creature_questender` WHERE `quest`=97236;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(2082,97236,0);

-- NEW 98028 Baron Marinous (level 21, required 17)
DELETE FROM `quest_template` WHERE `ID`=98028;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(98028,2,0,0,148,0,0,0,6,1.0,6,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,281291,1,0,281292,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,69,6,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Baron Marinous','Bring the Clouded Water Globe to Onu at the Grove of the Ancients in Darkshore.','All that remains of the powerful elemental is a globe of what seems to be pure water, clouded by some unknown substance. The edges of the sphere seem to be clear until you turn it--as if the cloud actively prevents you from peering within.$B$BWhatever happened to it--and to the ruins it was guarding--is still active in some way.$B$BOnly Onu, the Ancient of Lore at the Grove of the Ancients to the far south, would have a chance at knowing more.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=98028;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400205,98028,1,0,0,279275,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=98028;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(98028,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=98028;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(98028,0,0,0,0,0,0,0,0,'<Onu appears surprised--or as surprised as an ancient can appear.>$B$BStairs descending down in Mathystra? Could be it be?$B$B<Onu shakes his head.>$B$BI must confer with the others on this. For now, know that it is good you uncovered this before the naga... or their cult allies.$B$BPlease accept this as thanks for your efforts. It is no small feat to defeat an elemental guardian.',0);
DELETE FROM `quest_request_items` WHERE `ID`=98028;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(98028,0,0,0,0,'I can sense something far older than you in my presence, $R... what have you brought me?',0);
DELETE FROM `quest_details` WHERE `ID`=98028;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=98028;
DELETE FROM `quest_poi` WHERE `QuestID`=98028;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(98028,0,0,-1,0,0,1,1439,0,0,0,0,0,0,0,0),
(98028,0,1,0,9400205,279275,1,1439,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=98028;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(98028,0,0,5002,89,53,0),
(98028,1,0,7346,-936,32,0);
DELETE FROM `quest_classic_level` WHERE `ID`=98028;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98028,21,17,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=98028;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98028,2,21);

-- 98028 Baron Marinous
DELETE FROM `creature_questender` WHERE `quest`=98028;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(3616,98028,0);

-- Quest-starting drops these quests need that our world lacked (rows from AnoCore v10 / Wowhead Forever).
DELETE FROM `creature_loot_template` WHERE `Item`=273658 AND `Entry`=264082;
DELETE FROM `creature_loot_template` WHERE `Item`=277190 AND `Entry`=1994;
DELETE FROM `creature_loot_template` WHERE `Item`=268535 AND `Entry` IN (250618,250622,250623,250624,250630,250656,250689,255964);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(264082,0,273658,97.938,0,1,0,1,1,'Bloody Parchment - Wowhead Forever 95/97'),
(1994,0,277190,4.937,0,1,0,1,1,'Fang of Githyiss - Wowhead Forever drop 235/4760'),
(250618,0,268535,4,0,1,0,1,1,'Bloodied Insignia - Ruins of Lordaeron quest starter'),
(250622,0,268535,4,0,1,0,1,1,'Bloodied Insignia - Ruins of Lordaeron quest starter'),
(250623,0,268535,4,0,1,0,1,1,'Bloodied Insignia - Ruins of Lordaeron quest starter'),
(250624,0,268535,3.759,0,1,0,1,1,'Bloodied Insignia - Wowhead Forever drop 5/133'),
(250630,0,268535,3.846,0,1,0,1,1,'Bloodied Insignia - Wowhead Forever drop 3/78'),
(250656,0,268535,5.263,0,1,0,1,1,'Bloodied Insignia - Wowhead Forever drop 2/38'),
(250689,0,268535,11.111,0,1,0,1,1,'Bloodied Insignia - Wowhead Forever drop 2/18'),
(255964,0,268535,3.571,0,1,0,1,1,'Bloodied Insignia - Wowhead Forever drop 3/84');

-- 95810 Lost Relic Carry is taken out again: its Titan Relic drops only from the Relic Guardian, which stays unselectable
-- until its AnoCore C++ boss script (not ours) wakes it. Elder Knowledge 95664 has the same problem.
DELETE FROM `creature_queststarter` WHERE `quest` IN (95810);
DELETE FROM `creature_questender` WHERE `quest` IN (95810);
DELETE FROM `gameobject_queststarter` WHERE `quest` IN (95810);
DELETE FROM `gameobject_questender` WHERE `quest` IN (95810);
DELETE FROM `quest_objectives` WHERE `QuestID` IN (95810);
DELETE FROM `quest_poi` WHERE `QuestID` IN (95810);
DELETE FROM `quest_poi_points` WHERE `QuestID` IN (95810);
DELETE FROM `quest_reward_display_spell` WHERE `QuestID` IN (95810);
DELETE FROM `quest_template_addon` WHERE `ID` IN (95810);
DELETE FROM `quest_offer_reward` WHERE `ID` IN (95810);
DELETE FROM `quest_request_items` WHERE `ID` IN (95810);
DELETE FROM `quest_details` WHERE `ID` IN (95810);
DELETE FROM `quest_classic_level` WHERE `ID` IN (95810);
DELETE FROM `quest_template_classic_level` WHERE `ID` IN (95810);
DELETE FROM `quest_template` WHERE `ID` IN (95810);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (95810);
