-- Classic 1.60 (Forever): Bounty: Gnarlpine Furbolg (490), Sentinel Shayla Nightbreeze outside Darnassus. Vanilla left the id unused; Forever
-- uses it (70532 QuestV2, Wowhead Forever: level 8, requires 5, 700 XP, 2s 25c). Quest rows from AnoCore v10: 15 Gnarlpine Fangs (its
-- log text), Darnassus reputation. The fangs already drop from every Gnarlpine furbolg for players on the quest (80%, ours).
-- Replaces the vanilla objective row (20 fangs) that was left without its quest.
DELETE FROM `quest_objectives` WHERE `ID`=90004904;
-- NEW 490 Bounty: Gnarlpine Furbolg (level 8, required 5)
DELETE FROM `quest_template` WHERE `ID`=490;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(490,2,0,0,141,0,0,0,5,1.0,5,1.0,0,0,0,0,0,0,0,0,0,1.0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,69,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Bounty: Gnarlpine Furbolg','Shayla Nightbreeze on the road outside of Darnassus wants you to bring her 15 Gnarlpine Fangs.','By strict orders from the Sentinels, I am commissioning a bounty on the Gnarlpine. They are no longer friends of the forest. Their corruption has left them mindless threats to our people and the creatures of the glade.$B$BAs decreed, you shall be rewarded for removing the furbolg menaces from Teldrassil. Bring to me their fangs as proof of your deeds.$B$BYou will find furbolg concentrated in Ban''ethil Hollow, west of Dolanaar and south of the road, and in Starbreeze Village to the east.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=490;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400088,490,1,0,0,5220,15,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=490;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(490,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=490;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(490,0,0,0,0,0,0,0,0,'You have served well, $n. You shall be rewarded for your contribution.',0);
DELETE FROM `quest_request_items` WHERE `ID`=490;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(490,0,0,0,0,'Teldrassil cannot thrive with corruption tainting the land. Drive the Gnarlpine from this forest, once and for all.',0);
DELETE FROM `quest_details` WHERE `ID`=490;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=490;
DELETE FROM `quest_poi` WHERE `QuestID`=490;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(490,0,0,-1,0,0,1,1438,0,0,0,0,0,0,0,0),
(490,0,1,0,9400088,5220,1,1438,0,0,0,0,0,0,0,0),
(490,0,2,32,0,0,1,1438,0,0,0,0,0,0,0,0),
(490,0,3,0,9400088,5220,1,1438,0,0,0,0,0,0,0,0),
(490,0,4,0,9400088,5220,1,1438,0,0,0,0,0,0,0,0),
(490,0,5,0,9400088,5220,1,1438,0,0,0,0,0,0,0,0),
(490,0,6,0,9400088,5220,1,1438,0,0,0,0,0,0,0,0),
(490,0,7,0,9400088,5220,1,1438,0,0,0,0,0,0,0,0),
(490,0,8,0,9400088,5220,1,1438,0,0,0,0,0,0,0,0),
(490,0,9,0,9400088,5220,1,1438,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=490;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(490,0,0,10091,1665,1325,0),
(490,1,0,9703,1547,1285,0),
(490,1,1,9850,1461,1285,0),
(490,1,2,9986,1432,1285,0),
(490,1,3,10050,1437,1285,0),
(490,1,4,10096,1465,1285,0),
(490,1,5,9827,1625,1285,0),
(490,1,6,9753,1631,1285,0),
(490,1,7,9730,1608,1285,0),
(490,2,0,10091,1665,1325,0),
(490,3,0,9606,492,1310,0),
(490,3,1,9645,420,1310,0),
(490,3,2,9857,310,1310,0),
(490,3,3,9951,383,1310,0),
(490,3,4,9880,519,1310,0),
(490,3,5,9657,521,1310,0),
(490,4,0,9072,1872,1324,0),
(490,4,1,9111,1676,1324,0),
(490,4,2,9120,1656,1324,0),
(490,4,3,9151,1609,1324,0),
(490,4,4,9218,1712,1324,0),
(490,4,5,9171,1839,1324,0),
(490,4,6,9076,1886,1324,0),
(490,5,0,9954,270,1324,0),
(490,5,1,10054,226,1324,0),
(490,5,2,10076,329,1324,0),
(490,5,3,10047,354,1324,0),
(490,6,0,9158,1338,1314,0),
(490,6,1,9182,1318,1314,0),
(490,6,2,9221,1318,1314,0),
(490,6,3,9221,1407,1314,0),
(490,6,4,9206,1453,1314,0),
(490,6,5,9182,1483,1314,0),
(490,6,6,9167,1393,1314,0),
(490,7,0,9528,1861,1309,0),
(490,7,1,9556,1825,1309,0),
(490,7,2,9583,1813,1309,0),
(490,7,3,9605,1862,1309,0),
(490,7,4,9582,1908,1309,0),
(490,7,5,9558,1910,1309,0),
(490,8,0,9520,1282,1297,0),
(490,8,1,9586,1253,1297,0),
(490,8,2,9604,1270,1297,0),
(490,8,3,9589,1301,1297,0),
(490,8,4,9545,1306,1297,0),
(490,9,0,9210,936,1316,0),
(490,9,1,9253,902,1316,0),
(490,9,2,9286,919,1316,0),
(490,9,3,9279,1017,1316,0);
DELETE FROM `quest_classic_level` WHERE `ID`=490;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (490,8,5,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=490;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (490,2,8);
-- 490 Bounty: Gnarlpine Furbolg
DELETE FROM `creature_queststarter` WHERE `quest`=490;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(2155,490,0);
DELETE FROM `creature_questender` WHERE `quest`=490;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(2155,490,0);
UPDATE `quest_classic_money` SET `RewardMoney`=225 WHERE `ID`=490;
