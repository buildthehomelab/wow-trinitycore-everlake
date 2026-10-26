-- Forever quests left out of _32 because they couldn't be finished, ported again now that _35 brought their NPCs and objects
-- and the Wowhead Forever quest pages give their givers, turn-ins and map points. 15 are playable now:
-- The Binding x3, Snowbound, Explosive Consultation, Destruction in Deadmines, Ott's Masterwork, Unwelcome Guests,
-- Changing Tastes, The Tortured Soul, The Offering of Blood, Ira's Dagger, Gatehouse Goods, Eyes of the Sentinels,
-- Prehistoric Prism. The scripts they need come after the port. The 9 that still can't be done are taken out again at the end.

-- NEW 65597 The Binding (level 20, required 20)
DELETE FROM `quest_template` WHERE `ID`=65597;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(65597,2,0,0,-61,0,0,0,5,1.0,0,1.0,0,713,0,0,366815,0,0,190181,0,1.0,0,0,0,0,0,22243,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'The Binding','Using the Lovers'' Hearts, summon and subdue an incubus, then return the Lovers'' Hearts to Carendin Halgar in the Magic Quarter of the Undercity.','The time has come at last. Bring the hearts to the summoning circle below. Place them at its center and call forth the incubus.$B$BThe demon will not be pleased when it realizes that you have tempted it into a trap. Do not fall prey to its beguilement, $n. You must subdue it fully.$B$BOnly then can I teach you the spell to bind it to your will.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=65597;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400415,65597,0,0,0,185335,1,0,0,0,0.0,0,1,'',0),
(9400416,65597,1,1,1,190181,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=65597;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(65597,0,256,0,65593,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=65597;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(65597,0,0,0,0,0,0,0,0,'Impressive. Very impressive. The sayaad specialize in preying upon mortals. Many a $C has thought themselves strong enough to command one, only to find themselves being commanded instead.$B$BThis trial did not break you, $n, and your efforts have earned your reward. I will teach you the spell to summon the incubus.',0);
DELETE FROM `quest_request_items` WHERE `ID`=65597;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(65597,0,0,0,0,'The incubus possesses martial prowess, but its illusory charms are its most potent weapon. Falter for even a moment, and the demon will seize upon the opportunity to enthrall you.$B$BDo not let it, $n.',0);
DELETE FROM `quest_details` WHERE `ID`=65597;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=65597;
DELETE FROM `quest_poi` WHERE `QuestID`=65597;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(65597,0,0,-1,0,0,0,1420,0,0,0,0,0,0,0,0),
(65597,0,1,32,0,0,0,1420,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=65597;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(65597,0,0,1712,57,-62,0),
(65597,1,0,1712,57,-62,0);
DELETE FROM `quest_classic_level` WHERE `ID`=65597;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (65597,20,20,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=65597;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (65597,2,20);

-- 65597 The Binding
DELETE FROM `creature_queststarter` WHERE `quest`=65597;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(5675,65597,0);
DELETE FROM `creature_questender` WHERE `quest`=65597;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(5675,65597,0);

-- NEW 65603 The Binding (level 20, required 20)
DELETE FROM `quest_template` WHERE `ID`=65603;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(65603,2,0,0,-61,0,0,0,4,1.0,0,1.0,0,713,0,0,366815,0,0,190186,0,1.0,0,0,0,0,0,22243,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,890,878,0,0,65,0,0,0,'The Binding','Using the Wooden Figurine, summon and subdue an incubus, then return the Wooden Figurine to Gakin the Darkbinder in the Slaughtered Lamb.','The time has come. Take the figurine and descend into the crypts below. A summoning circle has been prepared, and you must place the figurine at its center.$B$BThen the gateway will open, and the incubus will cross into our world.$B$BA sayaad is not to be underestimated. The demon will not hesitate to attack when it realizes your ruse. You must draw upon all you have been taught to defeat it.$B$BIf you succeed, return to me and I shall bind the creature to your will. Fail, and your soul is forfeit.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=65603;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(91823014,65603,0,0,0,185335,1,0,0,0,0.0,0,1,'',0),
(91823015,65603,1,1,1,190186,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=65603;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(65603,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=65603;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(65603,0,0,0,0,0,0,0,0,'Not bad, $n. Your have bested the fiend, and your will remains unbroken.$B$BMany a $C has believed themselves strong enough to bind a sayaad, only to become the demon''s next meal instead. I am pleased to see you are not so foolish.$B$BWatch closely, and I will teach you the invocation to call upon your newly bound incubus.',0);
DELETE FROM `quest_request_items` WHERE `ID`=65603;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(65603,0,0,0,0,'The incubus will try to lower your guard through beguilement and deception. The demon is adept at swaying the hearts of mortals.$B$BRemember that anything it may offer you is false. To the demon, you are merely prey.',0);
DELETE FROM `quest_details` WHERE `ID`=65603;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=65603;
DELETE FROM `quest_poi` WHERE `QuestID`=65603;
DELETE FROM `quest_poi_points` WHERE `QuestID`=65603;
DELETE FROM `quest_classic_level` WHERE `ID`=65603;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (65603,20,20,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=65603;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (65603,2,20);

-- 65603 The Binding
DELETE FROM `creature_queststarter` WHERE `quest`=65603;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(6122,65603,0);
DELETE FROM `creature_questender` WHERE `quest`=65603;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(6122,65603,0);

-- NEW 65604 The Binding (level 20, required 20)
DELETE FROM `quest_template` WHERE `ID`=65604;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(65604,2,0,0,-61,0,0,0,4,1.0,0,1.0,0,713,0,0,366815,0,0,190187,0,1.0,0,0,0,0,0,22243,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,8589934738,0,0,0,'The Binding','Using the Withered Scarf, summon and subdue an incubus, then return the Withered Scarf to Gan''rul Bloodeye in Orgrimmar.','Yes... I see. I feel the residual emotions bound within these threads. Love is woven into its stitches. The incubus will not be able to resist.$B$BTake this to the summoning circle in Neeru''s tent, $n. Summon forth a malevolent incubus, then show it your mastery. Do not expect it to be subdued quietly. Ready your magic and prepare yourself for a fight. Underestimating a demon has been many a warlock''s final mistake.$B$BWhen you have defeated it, return the cloth to me. I will let Magar know what you found.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=65604;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400089,65604,0,0,0,185335,1,0,0,0,0.0,0,1,'',0),
(9400090,65604,1,1,1,190187,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=65604;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(65604,0,256,0,65610,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=65604;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(65604,0,0,0,0,0,0,0,0,'Hah! Victorious, as expected!$B$BThe incubus is subdued, and it will be my pleasure to teach you to summon the demon. You strength is growing, and I have no doubt that this is a mere stepping stone to even greater powers.$B$BI will return the scarf to Magar. I have known that orc for many years, and never did I think he would care for someone the way he cared for Krilge.$B$BIt is a reminder of what separates us from the demons. We wield their darkness, but they will never wield us.',0);
DELETE FROM `quest_request_items` WHERE `ID`=65604;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(65604,0,0,0,0,'The sayaad are dominators of minds and torturers of souls. Their visage brings the heart joy, leaving you defenseless when they rend your flesh with whip and claw.$B$BDo not entertain the incubus'' charms, $n. Slay it quickly and let it be done.',0);
DELETE FROM `quest_details` WHERE `ID`=65604;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=65604;
DELETE FROM `quest_poi` WHERE `QuestID`=65604;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(65604,0,0,-1,0,0,1,1454,0,0,0,0,0,0,0,0),
(65604,0,1,0,9400089,185335,1,1454,0,0,0,0,0,0,0,0),
(65604,0,2,32,0,0,1,1454,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=65604;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(65604,0,0,1850,-4357,-15,0),
(65604,1,0,1806,-4373,-25,0),
(65604,2,0,1850,-4357,-15,0);
DELETE FROM `quest_classic_level` WHERE `ID`=65604;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (65604,20,20,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=65604;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (65604,2,20);

-- 65604 The Binding
DELETE FROM `creature_queststarter` WHERE `quest`=65604;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(5875,65604,0);
DELETE FROM `creature_questender` WHERE `quest`=65604;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(5875,65604,0);

-- NEW 78134 Dragonslayer's Lance (level 25, required 15)
DELETE FROM `quest_template` WHERE `ID`=78134;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(78134,2,0,0,0,0,0,0,6,1.0,6,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,12884902143,0,0,0,'Dragonslayer''s Lance','','','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=78134;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(91822002,78134,1,0,0,209874,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=78134;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(78134,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=78134;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(78134,0,0,0,0,0,0,0,0,'Splendid job, $n! With this, I am one step further on my path to glory.',0);
DELETE FROM `quest_request_items` WHERE `ID`=78134;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(78134,0,0,0,0,'The lance of the Dragonslayer has changed hands many times. Every now and then, rumor spreads of it appearing in black market arms deals. Perhaps the lance''s current unsavory proprietor would be willing to part with it; for a price.',0);
DELETE FROM `quest_details` WHERE `ID`=78134;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=78134;
DELETE FROM `quest_poi` WHERE `QuestID`=78134;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(78134,0,0,-1,0,0,1,1440,0,0,0,0,0,0,0,0),
(78134,0,1,32,0,0,1,1440,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=78134;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(78134,0,0,2013,-722,101,0),
(78134,1,0,2013,-722,101,0);
DELETE FROM `quest_classic_level` WHERE `ID`=78134;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (78134,25,15,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=78134;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (78134,2,25);

-- 78134 Dragonslayer's Lance
DELETE FROM `creature_queststarter` WHERE `quest`=78134;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(210995,78134,0);
DELETE FROM `creature_questender` WHERE `quest`=78134;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(210995,78134,0);

-- NEW 78143 Secrets of the Dreamers (level 20, required 1)
DELETE FROM `quest_template` WHERE `ID`=78143;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(78143,2,0,0,-284,0,0,0,1,1.0,1,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,211779,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,12884902143,0,0,0,'Secrets of the Dreamers','','','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=78143;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(91822004,78143,1,0,0,209846,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=78143;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(78143,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=78143;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(78143,0,0,0,0,0,0,0,0,'Thank you, $n. Our knowledge expands through your efforts.$B$BIf you discover more magical works that might benefit the library, please bring them to me.',0);
DELETE FROM `quest_request_items` WHERE `ID`=78143;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(78143,0,0,0,0,'Have you brought something to add to our collection?',0);
DELETE FROM `quest_details` WHERE `ID`=78143;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=78143;
DELETE FROM `quest_poi` WHERE `QuestID`=78143;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(78143,0,0,-1,0,0,0,1453,0,0,0,0,0,0,0,0),
(78143,0,1,32,0,0,0,1453,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=78143;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(78143,0,0,-8932,1070,61,0),
(78143,1,0,-8932,1070,61,0);
DELETE FROM `quest_classic_level` WHERE `ID`=78143;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (78143,20,1,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=78143;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (78143,2,20);

-- 78143 Secrets of the Dreamers
DELETE FROM `creature_queststarter` WHERE `quest`=78143;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(211033,78143,0);
DELETE FROM `creature_questender` WHERE `quest`=78143;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(211022,78143,0),
(211033,78143,0);

-- NEW 79366 Heed My Call (level 40, required 30)
DELETE FROM `quest_template` WHERE `ID`=79366;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(79366,2,0,0,-82,1,0,0,5,1.0,5,1.0,0,0,0,0,0,0,0,268582,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'Heed My Call','Use the Twisted Totems to put an end to the quilboar ritual.','Now that you have the twisted totems, we must wield them to summon forth the corrupted elementals the quilboar are calling upon. Defeat them to cleanse these lands and put an end to the Razormane''s abominable ritual then report back to Rau Cliffrunner with your success.$B$BYou should begin your clensing at the steam pools to the west. That area is rich with each of the elements. But be careful, $n. The quilboar will not sit idly while you interrupt their plans.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=79366;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9847051,79366,1,0,0,212792,1,0,0,0,0.0,0,1,'',0),
(9847052,79366,1,1,1,268582,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=79366;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(79366,0,64,0,79361,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=79366;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(79366,0,0,0,0,0,0,0,0,'The rumbling ground fell silent and in my heart I knew you had saved us. You have our gratitude, $n.$B$BPlease accept one of these gifts as a token of our appreciation.',0);
DELETE FROM `quest_request_items` WHERE `ID`=79366;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(79366,0,0,0,0,'What did you find?',0);
DELETE FROM `quest_details` WHERE `ID`=79366;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=79366;
DELETE FROM `quest_poi` WHERE `QuestID`=79366;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(79366,0,0,-1,0,0,1,1441,0,0,0,0,0,0,0,0),
(79366,0,1,32,0,0,1,1441,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=79366;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(79366,0,0,-5484,-2463,89,0),
(79366,1,0,-5484,-2463,89,0);
DELETE FROM `quest_classic_level` WHERE `ID`=79366;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (79366,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=79366;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (79366,2,40);

-- 79366 Heed My Call
DELETE FROM `creature_queststarter` WHERE `quest`=79366;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(4722,79366,0);
DELETE FROM `creature_questender` WHERE `quest`=79366;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(4722,79366,0);

-- NEW 79442 The Tempest's Weapons (level 40, required 30)
DELETE FROM `quest_template` WHERE `ID`=79442;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(79442,2,0,0,-82,0,0,0,5,1.0,0,1.0,0,0,0,0,0,0,0,212792,0,1.0,0,0,0,0,0,213086,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,280604,1,0,280605,1,0,280607,1,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,890,878,0,0,162,0,0,0,'The Tempest''s Weapons','Deliver the Eye of the Tempest to Bath''rah the Windwatcher in Alterac Mountains.','Our people cannot thank you enough, but I have no real use for this eye. I have heard of an old shaman in the Alterac mountains that has an eye for storm elemental magic. Perhaps he may be able to craft something for you.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=79442;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9847053,79442,1,0,0,212792,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=79442;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(79442,0,64,0,79366,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=79442;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(79442,0,0,0,0,0,0,0,0,'Tell ya what. No more tricks, no more games. I got somet''in you''d be interested in.$B$BTrade me dat eye and I give you here this mighty fine rune that be ready to teach you new tricks.$B$BWhat ya say?',0);
DELETE FROM `quest_request_items` WHERE `ID`=79442;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(79442,0,0,0,0,'Ahh! Looks like ye made it back in one piece there. Now tell me how did de potion do?$B$BWell ''tis a good thing I had faith in ya. Cuz dat potion be nothing but a mighty fine punch bru''dah. Much tastier than it be effective against those storms.$B$BNow, now... don''t be angry wit me. All ya needed was a little encouragement. T''ings turned out how they was always meant to.$B$BBut since you''s here... I did notice that mighty fine eye you be holdin...',0);
DELETE FROM `quest_details` WHERE `ID`=79442;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=79442;
DELETE FROM `quest_poi` WHERE `QuestID`=79442;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(79442,0,0,-1,0,0,0,1416,0,0,0,0,0,0,0,0),
(79442,0,1,32,0,0,0,1416,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=79442;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(79442,0,0,251,-1471,55,0),
(79442,1,0,251,-1471,55,0);
DELETE FROM `quest_classic_level` WHERE `ID`=79442;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (79442,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=79442;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (79442,2,40);

-- 79442 The Tempest's Weapons
DELETE FROM `creature_queststarter` WHERE `quest`=79442;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(4722,79442,0);
DELETE FROM `creature_questender` WHERE `quest`=79442;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(6176,79442,0);

-- NEW 86585 Banner of the Fallen (level 17, required 10)
DELETE FROM `quest_template` WHERE `ID`=86585;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(86585,2,0,0,38,0,0,0,5,1.0,5,1.0,0,0,0,0,0,0,0,253247,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,281253,1,0,281254,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,47,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Banner of the Fallen','Raise the standard of Ironforge, call out the trogg Headsplitter and kill it, then report to Captain Rugelfuss.','The fallen mountaineer bears a standard of Ironforge. Perhaps she was scouting, or making a doomed charge. Either way, the standard has been cast down and trampled. The mountaineer was hit on the head so hard that her helm was knocked off and she was killed outright by a trogg, likely with a spiked club.$B$BThe trogg that killed her is probably still nearby, and likely remembers the banner. Raising the banner of Ironforge once more may call it out.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=86585;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400097,86585,1,0,0,253247,1,0,0,0,0.0,0,1,'',0),
(9400098,86585,0,1,1,269185,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=86585;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(86585,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=86585;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(86585,0,0,0,0,0,0,0,0,'You found Ylva''s body? Ah, the poor woman. She said she was going to show the troggs that Ironforge would never fall to their kind. She went looking for a few mountaineers who never returned from a patrol through trogg country. She was always too independent-minded to be cautious. Now we know what happened.$B$BI''ll take the banner back and make sure it''s cleaned up and displayed. You should take her weapon. May it serve you well against the troggs.',0);
DELETE FROM `quest_request_items` WHERE `ID`=86585;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(86585,0,0,0,0,'That banner looks like it''s been in a war!',0);
DELETE FROM `quest_details` WHERE `ID`=86585;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=86585;
DELETE FROM `quest_poi` WHERE `QuestID`=86585;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(86585,0,0,-1,0,0,0,1432,0,0,0,0,0,0,0,0),
(86585,0,1,1,9400098,269185,0,1432,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=86585;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(86585,0,0,-5843,-2635,323,0),
(86585,1,0,-6062,-2860,413,0);
DELETE FROM `quest_classic_level` WHERE `ID`=86585;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (86585,17,10,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=86585;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (86585,2,17);

-- 86585 Banner of the Fallen
DELETE FROM `creature_queststarter` WHERE `quest`=86585;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(269153,86585,0);
DELETE FROM `creature_questender` WHERE `quest`=86585;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(1092,86585,0);

-- NEW 86667 Snowbound (level 20, required 10)
DELETE FROM `quest_template` WHERE `ID`=86667;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(86667,2,0,0,38,0,0,0,5,1.0,5,1.0,0,0,0,0,0,0,0,279380,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,47,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Snowbound','Deliver a Jar of Snow to Norric Lochthane.','My old mentor, Norric, sent a minor elemental with an odd request. He needs a jar of snow for some of his shamanic workings! I don''t know what he''s going to do with that, but I learned a long time ago not to question his ways with respect to magic.$B$BI''m busy settling in and learning about the local elementals, so I can''t leave to help him. Could you do this for me? Head over to South Gate Pass where there''s snow year-round. Scoop some up in this ceramic jar and bring it to him before it melts.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=86667;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400397,86667,1,0,0,279379,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=86667;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(86667,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=86667;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(86667,0,0,0,0,0,0,0,0,'This jar is for me?$B$BSnow! Grenhild did it! She sent the snow that I asked for!$B$BA pity, though, I was hoping she would come and visit herself.$B$BUh, anyway, you probably deserve a little something for your effort. Here you go.',0);
DELETE FROM `quest_request_items` WHERE `ID`=86667;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(86667,0,0,0,0,'Eh? What do you want?',0);
DELETE FROM `quest_details` WHERE `ID`=86667;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=86667;
DELETE FROM `quest_poi` WHERE `QuestID`=86667;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(86667,0,0,-1,0,0,0,1432,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=86667;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(86667,0,0,-4837,-3147,300,0);
DELETE FROM `quest_classic_level` WHERE `ID`=86667;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (86667,20,10,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=86667;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (86667,2,20);

-- 86667 Snowbound
DELETE FROM `creature_queststarter` WHERE `quest`=86667;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(49808,86667,0);
DELETE FROM `creature_questender` WHERE `quest`=86667;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(258043,86667,0);

-- NEW 92752 Explosive Consultation (level 16, required 9)
DELETE FROM `quest_template` WHERE `ID`=92752;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(92752,2,0,0,40,0,0,0,3,1.0,3,1.0,0,0,0,0,0,0,0,254553,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,72,3,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Explosive Consultation','Return to Alba Fairmoon in Westfall.','That''s it - the bomb''s ready to go! Careful with that detonator, now.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=92752;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400113,92752,1,0,0,254553,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=92752;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(92752,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=92752;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(92752,0,0,0,0,0,0,0,0,'I''m glad you''ve returned, $n.',0);
DELETE FROM `quest_request_items` WHERE `ID`=92752;
DELETE FROM `quest_details` WHERE `ID`=92752;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=92752;
DELETE FROM `quest_poi` WHERE `QuestID`=92752;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(92752,0,0,-1,0,0,0,1436,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=92752;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(92752,0,0,-10637,1183,47,0);
DELETE FROM `quest_classic_level` WHERE `ID`=92752;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (92752,16,9,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=92752;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (92752,2,16);

-- 92752 Explosive Consultation
DELETE FROM `creature_queststarter` WHERE `quest`=92752;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(11026,92752,0);
DELETE FROM `creature_questender` WHERE `quest`=92752;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(253092,92752,0);

-- NEW 92753 Destruction in Deadmines (level 18, required 9)
DELETE FROM `quest_template` WHERE `ID`=92753;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(92753,2,0,0,40,81,0,0,5,1.0,0,1.0,0,0,0,0,0,0,0,254553,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,72,3,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Destruction in Deadmines','Find the forge hidden in the Deadmines, and plant the Extra-Destructive Explosives nearby. Then, meet up with Alba Fairmoon at the Deadmines exit.','The source of the poison is likely a large metallurgical forge of some kind. Find a way into the Deadmines and locate the forge, then place the explosives.$BI will wait for you in the hills behind Moonbrook. Once you return, we can detonate the explosives. Hopefully with the forge gone, the land can begin to heal.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=92753;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400257,92753,0,0,0,253370,1,0,0,0,0.0,0,1,'Explosives placed',0),
(9400258,92753,1,1,1,254553,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=92753;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(92753,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=92753;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(92753,0,0,0,0,0,0,0,0,'So you found the forge, and planted the bomb... only one thing remains to be done.',0);
DELETE FROM `quest_request_items` WHERE `ID`=92753;
DELETE FROM `quest_details` WHERE `ID`=92753;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=92753;
DELETE FROM `quest_poi` WHERE `QuestID`=92753;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(92753,0,0,-1,0,0,0,1436,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=92753;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(92753,0,0,-11351,1673,66,0);
DELETE FROM `quest_classic_level` WHERE `ID`=92753;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (92753,18,9,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=92753;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (92753,2,18);

-- 92753 Destruction in Deadmines
DELETE FROM `creature_queststarter` WHERE `quest`=92753;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(253092,92753,0);
DELETE FROM `creature_questender` WHERE `quest`=92753;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(253279,92753,0);
-- creature 253370 [DNT] Kill Credit: Place Explosives <>
DELETE FROM `creature_template` WHERE `entry`=253370;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(253370,0,0,'[DNT] Kill Credit: Place Explosives',NULL,NULL,NULL,NULL,0,0,35,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,33555200,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=253370;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(253370,0,0,0,0,0,1.35,1.0,1.0,7.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=253370;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(253370,0,11686,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=253370;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=253370;
DELETE FROM `creature_classic_level` WHERE `entry`=253370;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (253370,1,1);

-- NEW 95125 Ott's Masterwork (level 25, required 20)
DELETE FROM `quest_template` WHERE `ID`=95125;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(95125,2,0,0,-141,0,0,0,3,1.0,0,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,76,3,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,16,0,0,0,'Ott''s Masterwork','Watch as Ott forges your blade.','These are some truly fine materials, $C. You honor me by allowing me to forge this blade for you and I only hope that I can live up to your expectations.$B$BPlease, stand back so that I may begin the forging process.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=95125;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400280,95125,0,0,0,259966,1,0,0,0,0.0,0,1,'Watch Ott craft the blade',0);
DELETE FROM `quest_template_addon` WHERE `ID`=95125;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(95125,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=95125;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(95125,0,0,0,0,0,0,0,0,'This blade is my finest work and I hope it serves you well in your travels. Thank you again for this opportunity.$B$BAka''Magosh, friend.',0);
DELETE FROM `quest_request_items` WHERE `ID`=95125;
DELETE FROM `quest_details` WHERE `ID`=95125;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=95125;
DELETE FROM `quest_poi` WHERE `QuestID`=95125;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(95125,0,0,-1,0,0,0,1424,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=95125;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(95125,0,0,-159,-867,57,0);
DELETE FROM `quest_classic_level` WHERE `ID`=95125;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95125,25,20,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95125;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95125,2,25);

-- 95125 Ott's Masterwork
DELETE FROM `creature_queststarter` WHERE `quest`=95125;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(3539,95125,0);
DELETE FROM `creature_questender` WHERE `quest`=95125;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(3539,95125,0);
-- creature 259966 Ott <>
DELETE FROM `creature_template` WHERE `entry`=259966;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(259966,0,0,'Ott',NULL,NULL,NULL,NULL,0,0,35,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,33555200,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=259966;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(259966,0,0,0,0,0,1.35,1.0,1.0,7.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=259966;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(259966,0,11686,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=259966;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=259966;
DELETE FROM `creature_classic_level` WHERE `entry`=259966;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (259966,1,1);

-- NEW 95508 Unwelcome Guests (level 18, required 14)
DELETE FROM `quest_template` WHERE `ID`=95508;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(95508,2,0,0,17,0,0,0,4,1.0,0,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,269716,1,0,269717,1,0,269742,1,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,76,3,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'Unwelcome Guests','Help Walton survive the encounter with Terry Longdrink and the Kul Tiras marines.','Yes, I used to be a member of the Kul Tiras navy. After Lord Admiral took Theramore and started his campaign in Durotar, I had... "objections" to his methods. Particularly the methods involving executing civilians.$B$BThere''s more to the story but... wait... what''s that?$B$BThere''s a group of men coming up the ridge!','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=95508;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400282,95508,0,0,0,261367,1,0,0,0,0.0,0,1,'Assist Walton',0);
DELETE FROM `quest_template_addon` WHERE `ID`=95508;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(95508,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=95508;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(95508,0,0,0,0,0,0,0,0,'Well, looks like we are all alive. I... knew that someday that would catch up to me. I''m in your debt for your help here today.$B$BPlease, take this. It''s not much, but its the least I can do.$B$BSafe travels, $C.',0);
DELETE FROM `quest_request_items` WHERE `ID`=95508;
DELETE FROM `quest_details` WHERE `ID`=95508;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=95508;
DELETE FROM `quest_poi` WHERE `QuestID`=95508;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(95508,0,0,-1,0,0,1,1413,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=95508;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(95508,0,0,842,-1633,213,0);
DELETE FROM `quest_classic_level` WHERE `ID`=95508;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95508,18,14,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95508;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95508,2,18);

-- 95508 Unwelcome Guests
DELETE FROM `creature_queststarter` WHERE `quest`=95508;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(261366,95508,0);
DELETE FROM `creature_questender` WHERE `quest`=95508;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(261366,95508,0);
-- creature 261367 Terry Longdrink <Bounty Hunter>
DELETE FROM `creature_template` WHERE `entry`=261367;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(261367,0,0,'Terry Longdrink',NULL,'Bounty Hunter',NULL,NULL,0,0,122,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'SmartAI',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=261367;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(261367,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=261367;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(261367,0,142854,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=261367;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=261367;
DELETE FROM `smart_scripts` WHERE `entryorguid`=261367 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(261367,0,0,0,'',6,0,100,0,0,0,0,0,0,'',11,1286177,2,0,0,0,0,0,'',1,0,0,0,0,'',0.0,0.0,0.0,0.0,'Terry Longdrink - On Death - Cast DNT (client credit Assist Walton, players within 31 yd)');
DELETE FROM `creature_classic_level` WHERE `entry`=261367;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (261367,19,19);

-- NEW 95697 Changing Tastes (level 31, required 24)
DELETE FROM `quest_template` WHERE `ID`=95697;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(95697,2,0,0,16732,81,0,0,6,1.0,0,1.0,0,0,0,0,0,0,0,0,0,1.0,0,8,0,0,0,250185,1,250077,5,0,0,0,0,0,0,0,0,0,0,0,0,280766,1,0,280805,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'Changing Tastes','Enter the Excavation Sites in the Wetlands and bring back Thicket Raptor Meat.','Zamja tells me we need more homestyle cooking.$BIf we start selling raptor, she thinks it''ll draw in customers who don''t usually visit Borstan''s Firepit.$B$BHer idea is not so bad. But I want something that rises above the smells of our birth villages. We''re in Orgrimmar! Borstan should serve a grand take on their familiar favorites.$B$BA hunter recently came back from the Wetlands with a giant talon from the thicket raptors in the Excavation Sites.$B$BUp for a job?','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=95697;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9847034,95697,1,0,0,271100,4,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=95697;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(95697,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=95697;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(95697,0,0,0,0,0,0,0,0,'Look at the marbling on these! What are they eating up there? Thank you for going all the way and back for us. If you don''t mind waiting, we''ll cook some for you now, on the house, of course!',0);
DELETE FROM `quest_request_items` WHERE `ID`=95697;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(95697,0,0,0,0,'Farm-raised boar, farm-raised crawler... what''s next, farm-raised raptor?',0);
DELETE FROM `quest_details` WHERE `ID`=95697;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=95697;
DELETE FROM `quest_poi` WHERE `QuestID`=95697;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(95697,0,0,-1,0,0,1,1454,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=95697;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(95697,0,0,1775,-4483,46,0);
DELETE FROM `quest_classic_level` WHERE `ID`=95697;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95697,31,24,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95697;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95697,2,31);

-- 95697 Changing Tastes
DELETE FROM `creature_queststarter` WHERE `quest`=95697;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(3368,95697,0);
DELETE FROM `creature_questender` WHERE `quest`=95697;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(3368,95697,0);
DELETE FROM `creature_loot_template` WHERE `Entry`=260325 AND `Item`=271100;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(260325,0,271100,9.1,1,1,0,1,1,'Thicket Raptor Meat (975)');
DELETE FROM `creature_loot_template` WHERE `Entry`=260800 AND `Item`=271100;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(260800,0,271100,48.0,1,1,0,1,1,'Wowhead Forever drop 189/1002 x1.84 floor 48.0 (quest item, INFERRED, 1328)');
DELETE FROM `creature_loot_template` WHERE `Entry`=260801 AND `Item`=271100;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(260801,0,271100,48.0,1,1,0,1,1,'Wowhead Forever drop 188/940 x1.84 floor 48.0 (quest item, INFERRED, 1328)');
-- creature 271732 Thicket Stalker <>
DELETE FROM `creature_template` WHERE `entry`=271732;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(271732,0,0,'Thicket Stalker',NULL,NULL,NULL,NULL,0,0,14,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,0,0,0,0,1,0,'SmartAI',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=271732;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(271732,0,0,0,0,0,3.0,1.0,1.0,1.7,0,0,0,0,271732,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=271732;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(271732,0,1339,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=271732;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=271732;
DELETE FROM `smart_scripts` WHERE `entryorguid`=271732 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(271732,0,0,0,'',0,0,100,0,3000,6000,8000,14000,0,'',11,22766,0,0,0,0,0,0,'',2,0,0,0,0,'',0.0,0.0,0.0,0.0,'Forever dungeon Thicket Stalker: Wowhead ability 22766 (INFERRED timer, 1042)');
DELETE FROM `creature_loot_template` WHERE `Entry`=271732 AND `Item`=271100;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(271732,0,271100,19.048,1,1,0,1,1,'Wowhead Forever 4/21 (1042)');
DELETE FROM `creature_classic_level` WHERE `entry`=271732;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (271732,25,28);

-- NEW 95885 The Offering of Blood (level 23, required 20)
DELETE FROM `quest_template` WHERE `ID`=95885;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(95885,2,0,0,130,1,0,0,5,1.0,0,1.0,0,0,0,0,0,0,0,210713,0,1.0,0,0,0,0,0,281673,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'The Offering of Blood','Use the Tortured Soul to give an offering of blood at the Offering Stone in Beren''s Peril.','<All that''s left now is the offering of blood.$B$BThe note scrap mentioned a ''willing sacrifice.''$B$BAn intense sense of dread washes over you.>','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=95885;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400396,95885,0,0,0,212753,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=95885;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(95885,0,0,0,95883,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=95885;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(95885,0,0,0,0,0,0,0,0,'<The offering stone is inert now. It appears your ritual drained it of power. To what end, you do not know, but it is over now.$B$BThe rough stone cracks and crumbles, now devoid of purpose.$B$BSomething glitters from within the remnants...>',0);
DELETE FROM `quest_request_items` WHERE `ID`=95885;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(95885,0,0,0,0,'<The offering stone is ominously still.>',0);
DELETE FROM `quest_details` WHERE `ID`=95885;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=95885;
DELETE FROM `quest_poi` WHERE `QuestID`=95885;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(95885,0,0,-1,0,0,0,1421,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=95885;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(95885,0,0,-288,1010,115,0);
DELETE FROM `quest_classic_level` WHERE `ID`=95885;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95885,23,20,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95885;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95885,2,23);

-- 95885 The Offering of Blood
DELETE FROM `gameobject_queststarter` WHERE `quest`=95885;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(645153,95885,0);
DELETE FROM `gameobject_questender` WHERE `quest`=95885;
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(645153,95885,0);
-- creature 212753 Tortured Soul <>
DELETE FROM `creature_template` WHERE `entry`=212753;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(212753,0,0,'Tortured Soul',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,6,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=212753;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(212753,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=212753;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(212753,0,10994,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=212753;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=212753;
DELETE FROM `creature_classic_level` WHERE `entry`=212753;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (212753,20,20);

-- NEW 96016 The Tempest's Weapons (level 40, required 30)
DELETE FROM `quest_template` WHERE `ID`=96016;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(96016,2,0,0,-82,0,0,0,5,1.0,5,1.0,0,0,0,0,0,0,0,212792,0,1.0,0,0,0,0,0,280696,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,280607,1,0,280605,1,0,280604,1,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'The Tempest''s Weapons','Deliver the Eye of the Tempest to Bath''rah the Windwatcher in Alterac Mountains.','Ye did good, and I can see yer itchin'' fer yer reward. Sorry tae say, I''m not exactly a dwarf of many possessions.$B$B<Veyric gestures broadly at his remote location.>$B$BTell ye what, though. I hear a troll named the Windwatcher lives out in the Alterac Mountains. He''s a powerful shaman himself, and an expert in storm elementals. If ye bring that there elemental core to him, I bet he can make ye a weapon worthy of yer victory.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=96016;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9847056,96016,1,0,0,212792,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=96016;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(96016,0,64,0,96135,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=96016;
DELETE FROM `quest_request_items` WHERE `ID`=96016;
DELETE FROM `quest_details` WHERE `ID`=96016;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=96016;
DELETE FROM `quest_poi` WHERE `QuestID`=96016;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(96016,0,0,-1,0,0,0,1416,0,0,0,0,0,0,0,0),
(96016,0,1,32,0,0,0,1416,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=96016;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(96016,0,0,251,-1471,55,0),
(96016,1,0,251,-1471,55,0);
DELETE FROM `quest_classic_level` WHERE `ID`=96016;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96016,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96016;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96016,2,40);

-- 96016 The Tempest's Weapons
DELETE FROM `creature_queststarter` WHERE `quest`=96016;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(259023,96016,0);
DELETE FROM `creature_questender` WHERE `quest`=96016;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(6176,96016,0);

-- NEW 96135 Heed My Call (level 40, required 30)
DELETE FROM `quest_template` WHERE `ID`=96135;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(96135,2,0,0,-82,0,0,96016,5,1.0,5,1.0,0,0,0,0,0,0,0,268582,0,1.0,0,36700160,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,6130900294268439629,0,0,0,'Heed My Call','Use the Twisted Totems to put an end to the quilboar ritual.','Euck, just bein'' around these blasted totems is givin'' me the willies--but that''s good. This much twisted corruption will be exactly what we need tae summon the quilboar''s elementals.

Go to the Thousand Needles and find a suitable spot for your defenses. The steam pools should work. They''re rich with fire, earth, water, and air alike. Place these totems and be ready for a fight. The Razormane won''t take too kindly to yer interference.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=96135;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(475235,96135,1,0,0,212792,1,0,32,1,0.0,0,1,'',0),
(478201,96135,1,1,1,268582,1,0,48,1,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=96135;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(96135,0,64,0,79358,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=96135;
DELETE FROM `quest_request_items` WHERE `ID`=96135;
DELETE FROM `quest_details` WHERE `ID`=96135;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=96135;
DELETE FROM `quest_poi` WHERE `QuestID`=96135;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(96135,0,0,-1,0,0,0,1417,0,0,0,0,0,0,0,0),
(96135,0,1,32,0,0,0,1417,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=96135;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(96135,0,0,-796,-3012,154,0),
(96135,1,0,-796,-3012,154,0);
DELETE FROM `quest_classic_level` WHERE `ID`=96135;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96135,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96135;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96135,2,40);

-- 96135 Heed My Call
DELETE FROM `creature_queststarter` WHERE `quest`=96135;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(259023,96135,0);
DELETE FROM `creature_questender` WHERE `quest`=96135;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(259023,96135,0);

-- NEW 96137 Ira's Dagger (level 24, required 18)
DELETE FROM `quest_template` WHERE `ID`=96137;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(96137,2,0,0,10,0,0,0,5,1.0,0,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Ira''s Dagger','Defeat 10 Young Black Ravagers and 7 Black Ravagers then return to Sirra Von''Indi in Darkshire for more information.','A small dagger belonging to the self-appointed ranger, Ira, who kept the forests safe by preventing the beasts within from attacking travelers.$B$BWith Ira''s spirit still wandering the woods, perhaps her unfinished business was to clear out the worg that continue to claim victims throughout the forest.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=96137;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9801020,96137,0,0,0,923,10,0,0,0,0.0,0,1,'',0),
(9801021,96137,0,1,1,628,7,0,0,0,0.0,0,1,'',0),
(9801022,96137,1,2,2,281143,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=96137;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(96137,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=96137;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(96137,0,0,0,0,0,0,0,0,'Ira? Are you sure? Sounds like the woman was damn near a ghost before she died. I''m surprised you found her.$B$BRest assured I will take great care of this dagger.',0);
DELETE FROM `quest_request_items` WHERE `ID`=96137;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(96137,0,0,0,0,'What have you got there?',0);
DELETE FROM `quest_details` WHERE `ID`=96137;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=96137;
DELETE FROM `quest_poi` WHERE `QuestID`=96137;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(96137,0,0,-1,0,0,0,1431,0,0,0,0,0,0,0,0),
(96137,0,1,0,9801020,923,0,1431,0,0,0,0,0,0,0,0),
(96137,0,4,1,9801021,628,0,1431,0,0,0,0,0,0,0,0),
(96137,0,5,2,9801022,281143,0,1431,0,0,0,0,0,0,0,0),
(96137,1,2,0,9801020,923,0,1431,0,0,0,0,0,0,0,0),
(96137,2,3,0,9801020,923,0,1431,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=96137;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(96137,0,0,-10574,-1127,29,0),
(96137,1,0,-10265,-1041,44,0),
(96137,2,0,-10900,-665,43,0),
(96137,2,1,-10875,-677,43,0),
(96137,2,2,-10834,-691,43,0),
(96137,2,3,-10864,-640,43,0),
(96137,2,4,-10888,-612,43,0),
(96137,3,0,-11088,-579,29,0),
(96137,3,1,-11051,-626,29,0),
(96137,3,2,-11033,-609,29,0),
(96137,3,3,-11028,-572,29,0),
(96137,4,0,-10354,-1056,48,0),
(96137,4,1,-10289,-985,48,0),
(96137,4,2,-10316,-1013,48,0),
(96137,5,0,-10102,-274,32,0);
DELETE FROM `quest_classic_level` WHERE `ID`=96137;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96137,24,18,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96137;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96137,2,24);

-- 96137 Ira's Dagger
DELETE FROM `creature_queststarter` WHERE `quest`=96137;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(6176,96137,0);
DELETE FROM `creature_questender` WHERE `quest`=96137;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(268,96137,0);

-- NEW 97222 Gatehouse Goods (level 15, required 9)
DELETE FROM `quest_template` WHERE `ID`=97222;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(97222,2,0,0,1519,0,0,0,4,1.0,0,1.0,0,0,0,0,0,0,0,277198,0,1.0,0,0,0,0,0,414,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Gatehouse Goods','Carry the Gatehouse Shipment up the stairs in Trias'' shop and leave it outside the door.','Yes, it''s only a flight of stairs, but if it''s such a small ask, it should be no problem for you to finish the delivery yourself! $B$BTrias'' Cheese isn''t part of the Gatehouse or their stocking inventory, but our buildings share a floor.$B$BPlace the crate outside their stockroom door--the guard will send someone for a regular pickup. They will see the package arrival and carry it inside as they return to post.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=97222;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400374,97222,0,0,0,268571,1,0,0,0,0.0,0,1,'Gatehouse Shipment delivered',0);
DELETE FROM `quest_template_addon` WHERE `ID`=97222;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(97222,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=97222;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(97222,0,0,0,0,0,0,0,0,'Yep. There''s a reason that hinge opens inwards towards them, so they don''t get the door blocked by people leaving stuff anywhere they please.$B$BConsider us professionally acquainted, $C. $B$BWe respect your business, and expect you to respect ours.',0);
DELETE FROM `quest_request_items` WHERE `ID`=97222;
DELETE FROM `quest_details` WHERE `ID`=97222;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=97222;
DELETE FROM `quest_poi` WHERE `QuestID`=97222;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(97222,0,0,-1,0,0,0,1453,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=97222;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(97222,0,0,-8846,566,95,0);
DELETE FROM `quest_classic_level` WHERE `ID`=97222;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (97222,15,9,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=97222;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (97222,2,15);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry`=97222;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ConditionStringValue1`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(19,0,97222,0,0,8,0,97220,0,0,'',0,0,0,'','Gatehouse Goods - after all of [97220, 97242, 97249] (Wowhead series row)'),
(19,0,97222,0,0,8,0,97242,0,0,'',0,0,0,'','Gatehouse Goods - after all of [97220, 97242, 97249] (Wowhead series row)'),
(19,0,97222,0,0,8,0,97249,0,0,'',0,0,0,'','Gatehouse Goods - after all of [97220, 97242, 97249] (Wowhead series row)');

-- 97222 Gatehouse Goods
DELETE FROM `creature_queststarter` WHERE `quest`=97222;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(483,97222,0);
DELETE FROM `creature_questender` WHERE `quest`=97222;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(483,97222,0);
-- creature 268571 Credit <>
DELETE FROM `creature_template` WHERE `entry`=268571;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(268571,0,0,'Credit',NULL,NULL,NULL,NULL,0,0,35,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,33555200,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry`=268571;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(268571,0,0,0,0,0,1.35,1.0,1.0,7.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID`=268571;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(268571,0,11686,1.0,1.0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=268571;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=268571;
DELETE FROM `creature_classic_level` WHERE `entry`=268571;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (268571,1,1);

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

-- NEW 98067 Eyes of the Sentinels (level 11, required 1)
DELETE FROM `quest_template` WHERE `ID`=98067;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(98067,2,0,0,1657,0,0,0,4,1.0,0,1.0,0,0,0,0,0,0,0,279378,0,1.0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,69,4,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Eyes of the Sentinels','Place Sentinel Owls at the entrance to the Cenarion Hold depths, the Darnassus Bank, the Craftsman''s Terrace Inn, and the City Gate for Sentinel Dalia Sunblade in the Temple of the Moon in Darnassus.','General Feathermoon ensures all sentinels have time to pray to Elune. A proper huntress wields not blade alone, but gifts of the goddess to overcome our enemies.$B$BYou may help with my daily duties. Place sentinels around the city--start with the tunnels leading beneath Cenarion Hold to the north, the bank at the center of town, the inn in the Craftsman''s Terrace to the northeast, and the city gates. The guards can assist you.$B$BSomething is amiss in Teldrassil--we must remain vigilant.','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=98067;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400380,98067,0,0,0,270418,1,0,0,0,0.0,0,1,'Cenarion Hold depths entrance',0),
(9400381,98067,0,1,1,270419,1,0,0,0,0.0,0,1,'Darnassus Bank',0),
(9400382,98067,0,2,2,270420,1,0,0,0,0.0,0,1,'Craftsman''s Terrace Inn',0),
(9400383,98067,0,3,3,270421,1,0,0,0,0.0,0,1,'City Gate',0);
DELETE FROM `quest_template_addon` WHERE `ID`=98067;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(98067,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=98067;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(98067,0,0,0,0,0,0,0,0,'I thank you for your aid. Though I find peace in the daily rituals, it is nice to have a moment to reflect instead.',0);
DELETE FROM `quest_request_items` WHERE `ID`=98067;
DELETE FROM `quest_details` WHERE `ID`=98067;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=98067;
DELETE FROM `quest_poi` WHERE `QuestID`=98067;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(98067,0,0,-1,0,0,1,1457,0,0,0,0,0,0,0,0),
(98067,0,1,0,9400380,270418,1,1457,0,0,0,0,0,0,0,0),
(98067,0,2,1,9400381,270419,1,1457,0,0,0,0,0,0,0,0),
(98067,0,3,2,9400382,270420,1,1457,0,0,0,0,0,0,0,0),
(98067,0,4,3,9400383,270421,1,1438,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=98067;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(98067,0,0,9606,2519,1332,0),
(98067,1,0,10127,2581,1325,0),
(98067,2,0,9931,2507,1318,0),
(98067,3,0,10128,2231,1328,0),
(98067,4,0,9992,1992,1328,0);
DELETE FROM `quest_classic_level` WHERE `ID`=98067;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98067,11,1,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=98067;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98067,2,11);

-- 98067 Eyes of the Sentinels
DELETE FROM `creature_queststarter` WHERE `quest`=98067;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(8396,98067,0);
DELETE FROM `creature_questender` WHERE `quest`=98067;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(8396,98067,0);

-- NEW 98903 The Battle for Darkspear Islands! (level 39, required 30)
DELETE FROM `quest_template` WHERE `ID`=98903;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(98903,2,0,0,16606,0,0,0,5,1.0,6,1.0,0,0,0,0,0,0,0,0,0,1.0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,2799,7,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,18446744073709551615,0,0,0,'The Battle for Darkspear Islands!','Win a Darkspear Islands battleground and return back to Brelinda McFarry at Northwatch Hold.','Go forth and represent the Theramore Expeditionary Force in battle at Darkspear Islands, $n! Achieve victory and show these Horde dogs the might of the Alliance!','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=98903;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(478910,98903,0,0,0,275188,1,0,32,0,0.0,0,1,'Win in Darkspear Islands',0);
DELETE FROM `quest_template_addon` WHERE `ID`=98903;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(98903,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=98903;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(98903,0,0,0,0,0,0,0,0,'The Theramore Expeditionary Force are grateful for your dedication and prowess in the battle for the Darkspear Islands, $n.$B$BFor the Alliance!',0);
DELETE FROM `quest_request_items` WHERE `ID`=98903;
DELETE FROM `quest_details` WHERE `ID`=98903;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=98903;
DELETE FROM `quest_poi` WHERE `QuestID`=98903;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(98903,0,0,-1,0,0,1,1413,0,0,0,0,0,0,0,0),
(98903,0,1,32,0,0,1,1413,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=98903;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(98903,0,0,-2347,-3802,2,0),
(98903,1,0,-2347,-3802,2,0);
DELETE FROM `quest_classic_level` WHERE `ID`=98903;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98903,39,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=98903;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98903,2,39);

-- 98903 The Battle for Darkspear Islands!
DELETE FROM `creature_queststarter` WHERE `quest`=98903;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(275273,98903,0);
DELETE FROM `creature_questender` WHERE `quest`=98903;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(275273,98903,0);

-- NEW 95883 The Tortured Soul (level 23, required 20)
DELETE FROM `quest_template` WHERE `ID`=95883;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(95883,2,0,0,130,0,0,95885,4,1.0,0,1.0,0,0,0,0,0,0,0,0,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,8589934770,0,0,0,'The Tortured Soul','Collect a Tortured Soul from the nearby undead in Beren''s Peril in Silverpine Forest.','<The preparations for a hastily-assembled ritual are gathered unceremoniously on the altar. According to the scrap of note, everything has been gathered. All that''s missing are the offering of blood and the Tortured Soul.$B$BThe undead around you look tortured enough. They may have what you seek.>','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=95883;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9400284,95883,1,0,0,271350,1,0,0,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=95883;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(95883,0,0,0,95884,0,0,0,0,0,0,0,0,0,0,0,0,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=95883;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(95883,0,0,0,0,0,0,0,0,'<The tortured soul lets out a foul energy in the presence of the offering stone.$B$BIt appears you are closer to fulfilling the ritual.>',0);
DELETE FROM `quest_request_items` WHERE `ID`=95883;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(95883,0,0,0,0,'<The offering stone is ominously still.>',0);
DELETE FROM `quest_details` WHERE `ID`=95883;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=95883;
DELETE FROM `quest_poi` WHERE `QuestID`=95883;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(95883,0,0,-1,0,0,0,1421,0,0,0,0,0,0,0,0),
(95883,0,1,0,9400284,271350,0,1421,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=95883;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(95883,0,0,-288,1010,115,0),
(95883,1,0,-406,916,124,0),
(95883,1,1,-366,902,124,0),
(95883,1,2,-290,944,124,0),
(95883,1,3,-288,1024,124,0),
(95883,1,4,-288,1025,124,0),
(95883,1,5,-290,1044,124,0),
(95883,1,6,-305,1067,124,0),
(95883,1,7,-322,1051,124,0),
(95883,1,8,-336,1032,124,0);
DELETE FROM `quest_classic_level` WHERE `ID`=95883;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95883,23,20,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95883;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95883,2,23);

-- 95883 The Tortured Soul
DELETE FROM `gameobject_queststarter` WHERE `quest`=95883;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(645153,95883,0);
DELETE FROM `gameobject_questender` WHERE `quest`=95883;
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(645153,95883,0);

-- NEW 98824 Prehistoric Prism (level 31, required 24)
DELETE FROM `quest_template` WHERE `ID`=98824;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(98824,2,0,0,16732,0,0,0,6,1.95,6,1.0,0,0,0,0,0,0,0,287959,0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,271716,1,0,271767,1,0,271766,1,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,0,890,878,0,0,6130900294268439629,0,0,0,'Prehistoric Prism','Bring the Titan Relic to High Explorer Magellas in Ironforge''s Hall of Explorers.','With titan-like inscriptions like that on its facets, nothing less than Ironforge''s Hall of Explorers is the right place to bring it.

I''d like to think that you''ll be noted in the history for it in the catalogue -- "Recovered by $n! Authenticated by Prospector Whelgar..." Ah, I''m gettin'' meself carried away.

High Explorer Magellas will receive you, and given the exquisite nature of what you carry, will surely be most generously appreciative should you donate it to the museum.

Good find!','','','','','','',0,0,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=98824;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(478769,98824,1,0,0,287959,1,0,32,0,0.0,0,1,'',0);
DELETE FROM `quest_template_addon` WHERE `ID`=98824;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(98824,0,0,0,95810,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_offer_reward` WHERE `ID`=98824;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(98824,0,0,0,0,0,0,0,0,'What''s this you''ve got...$B$BWoah! Look at this marvel! The light through it dances like nothin'' I''ve seen since my first dig in old Uldaman. The marks of the keepers on this cannot be mistaken.$B$BYou''ve done the League a great service bringin'' this home. A find like this pushes the very boundaries o'' the world''s wisdom forward.$B$BWe''ll be sure to record the details of your contribution! Truly a job well done, adventurer.',0);
DELETE FROM `quest_request_items` WHERE `ID`=98824;
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(98824,0,0,0,0,'Have a look at our gallery, but please, don''t touch the artifacts, unless it''s one you''re here to donate to the library.',0);
DELETE FROM `quest_details` WHERE `ID`=98824;
DELETE FROM `quest_reward_display_spell` WHERE `QuestID`=98824;
DELETE FROM `quest_poi` WHERE `QuestID`=98824;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(98824,0,0,-1,0,0,0,1426,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=98824;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(98824,0,0,-4667,-1266,503,0);
DELETE FROM `quest_classic_level` WHERE `ID`=98824;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98824,31,24,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=98824;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98824,2,31);

-- 98824 Prehistoric Prism
DELETE FROM `creature_queststarter` WHERE `quest`=98824;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES
(1077,98824,0);
DELETE FROM `creature_questender` WHERE `quest`=98824;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(5387,98824,0);

-- ---------------------------------------------------------------------------------------------------------------
-- What these quests need beyond the port
-- ---------------------------------------------------------------------------------------------------------------
-- The Binding (65597/65603/65604): the item spells send events 79833/79836/79837. They summon the Summoned Incubus on the
-- same summoning circles (object 1737) and with the same timer as the vanilla Binding events (1785/1787/1131, 1786/1788/1134).
DELETE FROM `event_scripts` WHERE `id` IN (79833,79836,79837);
INSERT INTO `event_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`,`Comment`) VALUES
(79833,0,10,185335,180000,0,1704.61,41.9147,-63.8433,0.435896,'The Binding 65597: summon Summoned Incubus at the Undercity circle'),
(79836,0,10,185335,180000,0,-8973.05,1043.72,52.8631,2,'The Binding 65603: summon Summoned Incubus at the Stormwind circle'),
(79837,0,10,185335,180000,0,1806.13,-4372.67,-17.4888,4.41785,'The Binding 65604: summon Summoned Incubus at the Orgrimmar circle');
-- The incubus acts like the vanilla Summoned Succubus 5677: arrives friendly, turns hostile after 4 s and attacks its summoner.
UPDATE `creature_template` SET `faction`=35, `AIName`='SmartAI' WHERE `entry`=185335;
DELETE FROM `smart_scripts` WHERE `entryorguid`=185335 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_chance`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`target_type`,`comment`) VALUES
(185335,0,0,0,11,100,0,0,0,0,11,7741,0,1,'Summoned Incubus - On Respawn - Cast Summoned Demon'),
(185335,0,1,0,0,100,3000,5000,7000,11000,11,16583,0,2,'Summoned Incubus - In Combat - Cast Shadow Shock'),
(185335,0,2,0,54,100,0,0,0,0,67,1,4000,1,'Summoned Incubus - On Just Summoned - Create Timed Event 1 (4 s)'),
(185335,0,3,4,59,100,1,0,0,0,2,14,0,1,'Summoned Incubus - On Timed Event 1 - Set Faction Hostile'),
(185335,0,4,0,61,100,0,0,0,0,49,0,0,23,'Summoned Incubus - On Link - Attack Summoner');

-- Ott's Masterwork (95125): talking to Ott while on the quest casts the client credit spell 1282264 (Watch Ott craft the blade).
-- From AnoCore v10; limited here to players on the quest.
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=3539;
DELETE FROM `smart_scripts` WHERE `entryorguid`=3539 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_chance`,`action_type`,`action_param1`,`action_param2`,`target_type`,`comment`) VALUES
(3539,0,0,0,64,100,11,1282264,2,7,'Ott - On Gossip Hello - Cast Watch Ott craft the blade credit (Ott''s Masterwork)');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=1 AND `SourceEntry`=3539 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ConditionStringValue1`,`NegativeCondition`,`Comment`) VALUES
(22,1,3539,0,0,9,0,95125,0,0,'',0,'Ott - credit only while on Ott''s Masterwork');

-- Eyes of the Sentinels (98067): the four location credits (Wowhead Forever map points, AnoCore spawns) give credit to a player
-- who comes within 15 yd. INFERRED: the client has no credit spell for them.
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (270418,270419,270420,270421);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (270418,270419,270420,270421) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_chance`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(270418,0,0,0,10,100,2,15,5000,5000,1,33,270418,7,'Credit - OOC LOS - Kill credit Eyes of the Sentinels (Cenarion Hold depths entrance)'),
(270419,0,0,0,10,100,2,15,5000,5000,1,33,270419,7,'Credit - OOC LOS - Kill credit Eyes of the Sentinels (Darnassus Bank)'),
(270420,0,0,0,10,100,2,15,5000,5000,1,33,270420,7,'Credit - OOC LOS - Kill credit Eyes of the Sentinels (Craftsman''s Terrace Inn)'),
(270421,0,0,0,10,100,2,15,5000,5000,1,33,270421,7,'Credit - OOC LOS - Kill credit Eyes of the Sentinels (City Gate)');

-- Ira's Dagger (96137): the dagger drops from the Lost Stalker in Duskwood, which Wowhead Forever lists as hostile. It had the
-- placeholder faction 35; it gets the faction of the Black Ravagers it runs with (38). INFERRED.
UPDATE `creature_template` SET `faction`=38 WHERE `entry`=272260;

-- ---------------------------------------------------------------------------------------------------------------
-- Ported above but taken out again: they can't be finished with the data we have (the NPCs and objects they brought stay)
-- 78134 Dragonslayer's Lance, 78143 Secrets of the Dreamers: their quest item has no source anywhere.
-- 79366/96135 Heed My Call and 79442/96016 The Tempest's Weapons: Corrupted Totems send event 102554 (Ravaging Tempest ritual), unscripted.
-- 86585 Banner of the Fallen: spell focus 2311 is not spawned and event 105217 is unscripted.
-- 97287 Shrewd Negotiations: the turn-in Archmage Celindra (faction 3562) is hostile to the Horde.
-- 98903 The Battle for Darkspear Islands!: nothing casts the credit spell 1317579.
-- ---------------------------------------------------------------------------------------------------------------
DELETE FROM `creature_queststarter` WHERE `quest` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `creature_questender` WHERE `quest` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `gameobject_queststarter` WHERE `quest` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `gameobject_questender` WHERE `quest` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_objectives` WHERE `QuestID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_poi` WHERE `QuestID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_poi_points` WHERE `QuestID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_reward_display_spell` WHERE `QuestID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_template_addon` WHERE `ID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_offer_reward` WHERE `ID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_request_items` WHERE `ID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_details` WHERE `ID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_classic_level` WHERE `ID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_template_classic_level` WHERE `ID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `quest_template` WHERE `ID` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (78134,78143,79366,96135,79442,96016,86585,97287,98903);
