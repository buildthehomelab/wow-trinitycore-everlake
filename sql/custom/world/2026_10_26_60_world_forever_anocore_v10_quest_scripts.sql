-- AnoCore v10 changelog (Quests) items still missing in our world: gossip and quest scripts ported from the AnoCore v10 world.
-- Patience: Deathguard Dillinger, Deathguard Kristof and Gordo hand over their report for Executor Zygand when asked.
-- Missionary Jasaan gives the Mark of Akir again if it was lost; Resaan Nimbuswalker hands over the heirloom
-- (The Fate of a Loved One); Fillion Flamebreeze can be picked up and carried to safety (The Missing Scholar);
-- the Captured Bandit closes the conversation; Aquementas hands the Silver Totem of Aquementas to an attacker who has the
-- Book of Aquor, 11 Silvery Claws and the Irontree Heart (our summon event 3708 stays).
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`,`action_param_string`,`target_param_string`) VALUES
(1496,0,'0',0,62,0,100,0,44990,6,0,0,0,'',85,1319468,2,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Patience: report option 44990/6 casts 1319468 (gives 286200) (1356); invoker self-casts (1735)','','');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=1496;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`,`action_param_string`,`target_param_string`) VALUES
(251001,0,'0',0,62,0,100,0,44991,6,0,0,0,'',85,1319489,2,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Patience: report option 44991/6 casts 1319489 (gives 286201) (1356); invoker self-casts (1735)','','');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=251001;
-- 10666: appended after our 26 rows
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`,`action_param_string`,`target_param_string`) VALUES
(10666,0,'26',0,62,0,100,0,44993,0,0,0,0,'',85,1319508,2,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Patience: report option 44993/0 casts 1319508 (gives 286202) (1356); invoker self-casts (1735)','','');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=10666;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`,`action_param_string`,`target_param_string`) VALUES
(257065,0,'0','1',62,0,100,0,41761,0,0,0,0,'',134,1254832,2,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Missionary Jasaan - lost mark option: player casts Mark of Akir (1738)','',''),
(257065,0,'1',0,61,0,100,0,0,0,0,0,0,'',72,0,0,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Missionary Jasaan - lost mark option: close gossip (1738)','','');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=257065;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`,`action_param_string`,`target_param_string`) VALUES
(259013,0,'0','1',62,0,100,0,42472,0,0,0,0,'',134,1282793,2,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Resaan Nimbuswalker - heirloom option: player casts Retrieve Heirloom (1738)','',''),
(259013,0,'1',0,61,0,100,0,0,0,0,0,0,'',72,0,0,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Resaan Nimbuswalker - heirloom option: close gossip (1738)','','');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=259013;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`,`action_param_string`,`target_param_string`) VALUES
(253002,0,'0','1',62,0,100,0,40877,0,0,0,1,'',33,253002,0,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Fillion Flamebreeze (injured) - carry option 40877/0 - Quest Credit Find Fillion Flamebreeze (1740: was OOC LOS 5 yd)','',''),
(253002,0,'1','3',61,0,100,0,0,0,0,0,0,'',12,253281,3,300000,0,3,0,1,0,0,0,0,0.0,0.0,0.0,0.0,'Fillion Flamebreeze (injured) - Linked - Summon Carried Fillion (5 min, personal, summoner = finder) (TEMPORARY override 884/264)','',''),
(253002,0,'3','4',61,0,100,0,0,0,0,0,0,'',41,1000,60,0,0,0,0,1,0,0,0,0,0.0,0.0,0.0,0.0,'Fillion Flamebreeze (injured) - Linked - Despawn In 1 s (Respawn 60 s)','',''),
(253002,0,'4',0,61,0,100,0,0,0,0,0,0,'',72,0,0,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Fillion Flamebreeze (injured) - carry option: close gossip (1740)','','');
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`,`ConditionStringValue1`) VALUES
(22,'1',253002,0,0,1,0,1258429,0,0,1,0,0,'','Fillion Flamebreeze (injured) - only if the player is not carrying him yet',''),
(22,'1',253002,0,0,47,0,92849,8,0,0,0,0,'','Fillion Flamebreeze (injured) - only while The Missing Scholar is incomplete','');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=253002;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`,`action_param_string`,`target_param_string`) VALUES
(253284,0,'0','1',10,0,100,0,2,10,5000,5000,1,'',134,1258446,2,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Fillion Flamebreeze (safe) - On Carrier In 10 yd LOS - Player Casts Saving Fillion Flamebreeze (credit, carry ends)','',''),
(253284,0,'1',0,61,0,100,0,0,0,0,0,0,'',41,2000,0,0,0,0,0,11,253281,30,0,0,0.0,0.0,0.0,0.0,'Fillion Flamebreeze (safe) - Linked - Despawn Carried Fillion','','');
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`,`ConditionStringValue1`) VALUES
(22,'1',253284,0,0,1,0,1258429,0,0,0,0,0,'','Fillion Flamebreeze (safe) - only for a player carrying Fillion','');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=253284;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`,`action_param_string`,`target_param_string`) VALUES
(256930,0,'0',0,62,0,100,0,41696,0,0,0,0,'',72,0,0,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Captured Bandit - Thank you for sharing.: close gossip (1740)','','');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=256930;
DELETE FROM `smart_scripts` WHERE `entryorguid`=9453 AND `source_type`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=9453 AND `SourceId`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`,`action_param_string`,`target_param_string`) VALUES
(9453,0,0,1,54,0,100,0,0,0,0,0,0,'',2,35,0,0,0,0,0,1,0,0,0,0,0.0,0.0,0.0,0.0,'Aquementas - summoned: friendly (CMaNGOS mob_aquementas) (1746)','',''),
(9453,0,1,0,61,0,100,0,0,0,0,0,0,'',67,1,10000,10000,0,0,0,1,0,0,0,0,0.0,0.0,0.0,0.0,'Aquementas - summoned: turns hostile after 10 s (1746)','',''),
(9453,0,2,0,59,0,100,0,1,0,0,0,0,'',2,91,0,0,0,0,0,1,0,0,0,0,0.0,0.0,0.0,0.0,'Aquementas - 10 s: elemental faction 91 (1746)','',''),
(9453,0,3,4,4,0,100,0,0,0,0,0,0,'',1,0,0,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Aquementas - aggro: yell (1746)','',''),
(9453,0,4,0,61,0,100,0,0,0,0,0,0,'',56,11522,1,0,0,0,0,7,0,0,0,0,0.0,0.0,0.0,0.0,'Aquementas - aggro: Silver Totem of Aquementas to the attacker with the three reagents (1746)','',''),
(9453,0,5,0,0,0,100,0,1000,1000,15000,15000,0,'',11,15089,0,0,0,0,0,2,0,0,0,0,0.0,0.0,0.0,0.0,'Aquementas - in combat: Frost Shock (1746)','',''),
(9453,0,6,0,0,0,100,0,5000,5000,15000,15000,0,'',11,13586,0,0,0,0,0,1,0,0,0,0,0.0,0.0,0.0,0.0,'Aquementas - in combat: Aqua Jet (1746)','','');
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`,`ConditionStringValue1`) VALUES
(22,5,9453,0,0,2,0,11169,1,0,0,0,0,'','Aquementas totem: attacker has the Book of Aquor (1746)',''),
(22,5,9453,0,0,2,0,11172,11,0,0,0,0,'','Aquementas totem: attacker has 11 Silvery Claws (1746)',''),
(22,5,9453,0,0,2,0,11173,1,0,0,0,0,'','Aquementas totem: attacker has the Irontree Heart (1746)',''),
(22,5,9453,0,0,2,0,11522,1,0,1,0,0,'','Aquementas totem: attacker has no Silver Totem yet (1746)','');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=9453;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND ((`SourceGroup`=40877 AND `SourceEntry`=0) OR (`SourceGroup`=42472 AND `SourceEntry`=0));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`,`ConditionStringValue1`) VALUES
(15,40877,0,0,0,9,0,92849,0,0,0,0,0,'','Fillion carry option: The Missing Scholar taken (1740, INFERRED)',''),
(15,42472,0,0,0,2,0,266434,1,0,1,0,0,'','Resaan heirloom option: heirloom not in bags (1738, INFERRED)',''),
(15,42472,0,0,0,9,0,94897,0,0,0,0,0,'','Resaan heirloom option: The Fate of a Loved One taken (1738, INFERRED)','');
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry`=10666; -- Gordo: gossip for the Patience report

-- "Alliance warlocks can take The Binding (Felhunter) again. It required a Horde quest.": The Binding 1795 had PrevQuestID
-- 1805 (end of the Horde Tome of the Cabal chain), which our core requires for everyone. The Alliance chain end 1804 already
-- unlocks it through NextQuestID; the Horde end 1805 now does the same, so either chain opens it.
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=1795;
UPDATE `quest_template_addon` SET `NextQuestID`=1795 WHERE `ID`=1805;
