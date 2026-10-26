-- Classic 1.60 (Forever): Anachronos (15192): faction 776 is the Brood of Nozdormu, which every race starts at Hated (Faction.db2 ReputationBase -42000),
--    so he attacked everyone who came to him in Tanaris. He hands out the Scepter of the Shifting Sands chain and nobody should
--    fight him: friendly to both sides. His quests check Brood of Nozdormu reputation on the player, not his faction.
UPDATE `creature_template` SET `faction`=35 WHERE `entry`=15192;

-- Archmage Celindra (252085, Violet Citadel): turn-in for Friend of the Kirin Tor (Alliance) and Shrewd Negotiations (Horde). Faction
--    3562 (Kirin Tor) is hostile to the Horde, so Horde players could not hand in. Wowhead Forever shows her friendly to the Alliance
--    and neutral to the Horde; FactionTemplate 3591 is the only template with exactly that reaction (no reputation faction).
UPDATE `creature_template` SET `faction`=3591 WHERE `entry`=252085;

-- Shrewd Negotiations (97287, Horde, after Heart of Disruption 96984): taken out in _37 because Archmage Celindra was hostile to the
--    Horde; with her new faction above it can be handed in. Same rows as _37 ported from AnoCore.
-- NEW 97287 Shrewd Negotiations (level 33, required 24)
DELETE FROM `quest_template` WHERE `ID`=97287;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(97287,2,0,0,36,0,0,0,1,1.0,0,1.0,0,0,0,0,0,0,0,251961,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'Shrewd Negotiations','Speak with Archmage Celindra in the City of Dalaran.','You have done well to infiltrate the city of mages, but I believe it is time for us to be more... negotiatory. As much as it pains me to admit, there is no other place on Azeroth with such a vast knowledge of the arcane. My brilliant work still pales in comparison to the ancient wisdom the Kirin Tor have amassed over the years.$B$BI think it''s high time we are granted access to this exclusive order, don''t you think? Take the mote you acquired. They will surely give anything to get it back. Anything.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=97287;
DELETE FROM `quest_template_addon` WHERE `ID`=97287;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(97287,0,0,0,96984,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=97287;
DELETE FROM `quest_request_items` WHERE `ID`=97287;
DELETE FROM `quest_details` WHERE `ID`=97287;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=97287;
DELETE FROM `quest_poi` WHERE `QuestID`=97287;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(97287,0,0,-1,0,0,0,1416,0,0,0,0,0,0,0,0),
(97287,0,1,32,0,0,0,1416,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=97287;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(97287,0,0,379,387,111,0),
(97287,1,0,379,387,111,0);
DELETE FROM `quest_classic_level` WHERE `ID`=97287;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (97287,33,24,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=97287;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (97287,2,33);

-- 97287 Shrewd Negotiations
DELETE FROM `creature_queststarter` WHERE `quest`=97287;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(2410,97287,0);
DELETE FROM `creature_questender` WHERE `quest`=97287;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(252085,97287,0);
