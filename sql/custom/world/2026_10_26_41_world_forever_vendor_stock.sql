-- Vendors: Forever items that no vendor sold here.
-- The stock comes from the AnoCore v10 world (its vendor lists follow Wowhead Forever's 'sold by' data, for example
-- Leonid Barthalomew the Revered, Mokvar, Anachronos, the PvP rank quartermasters and the Argent Dawn quartermasters).
-- Only items the 70532 client or our hotfixes know, and only vendors that are spawned here. Rows that already exist stay.
-- 66 Tharynn Bouden: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=66 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(66,21,277113,0,0,0,1,'',0,0,0),
(66,22,277114,0,0,0,1,'',0,0,0),
(66,23,277115,0,0,0,1,'',0,0,0);
-- 958 Dawn Brightstar: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=958 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(958,1,211779,0,0,0,1,'',0,0,0),
(958,2,212160,0,0,0,1,'',0,0,0);
-- 983 Thultazor: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=983 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(983,1,211779,0,0,0,1,'',0,0,0),
(983,2,212160,0,0,0,1,'',0,0,0);
-- 1250 Drake Lindgren: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=1250 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1250,1015,277113,0,0,0,1,'',0,0,0),
(1250,1016,277114,0,0,0,1,'',0,0,0),
(1250,1017,277115,0,0,0,1,'',0,0,0);
-- 1257 Keldric Boucher: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1257 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1257,30,211779,0,0,0,1,'',0,0,0),
(1257,31,212160,0,0,0,1,'',0,0,0);
-- 1263 Yarlyn Amberstill: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1263 AND `type`=1 AND `item` IN (280797,280801);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1263,1,280797,0,0,0,1,'',0,0,0),
(1263,2,280801,0,0,0,1,'',0,0,0);
-- 1275 Kyra Boucher: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1275 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1275,23,211779,0,0,0,1,'',0,0,0),
(1275,24,212160,0,0,0,1,'',0,0,0);
-- 1285 Thurman Mullby: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=1285 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1285,35,277113,0,0,0,1,'',0,0,0),
(1285,36,277114,0,0,0,1,'',0,0,0),
(1285,37,277115,0,0,0,1,'',0,0,0);
-- 1286 Edna Mullby: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=1286 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1286,1006,277113,0,0,0,1,'',0,0,0),
(1286,1007,277114,0,0,0,1,'',0,0,0),
(1286,1008,277115,0,0,0,1,'',0,0,0);
-- 1307 Charys Yserian: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1307 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1307,1,211779,0,0,0,1,'',0,0,0),
(1307,2,212160,0,0,0,1,'',0,0,0);
-- 1308 Owen Vaughn: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1308 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1308,1,211779,0,0,0,1,'',0,0,0),
(1308,2,212160,0,0,0,1,'',0,0,0);
-- 1318 Jessara Cordell: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=1318 AND `type`=1 AND `item` IN (247786);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1318,1010,247786,0,0,0,1,'',0,0,0);
-- 1347 Alexandra Bolero: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1347 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1347,1,253665,0,0,0,1,'',0,0,0),
(1347,2,253668,0,0,0,1,'',0,0,0);
-- 1351 Brother Cassius: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1351 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1351,1,211779,0,0,0,1,'',0,0,0),
(1351,2,212160,0,0,0,1,'',0,0,0);
-- 1440 Milton Sheaf: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=1440 AND `type`=1 AND `item` IN (216748);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1440,0,216748,0,0,0,1,'',0,0,0);
-- 1454 Jennabink Powerseam: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1454 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1454,1,253665,0,0,0,1,'',0,0,0),
(1454,2,253668,0,0,0,1,'',0,0,0);
-- 1463 Falkan Armonis: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1463 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1463,1,211779,0,0,0,1,'',0,0,0),
(1463,2,212160,0,0,0,1,'',0,0,0);
-- 1474 Rann Flamespinner: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1474 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1474,1,253665,0,0,0,1,'',0,0,0),
(1474,2,253668,0,0,0,1,'',0,0,0);
-- 1650 Terry Palin: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=1650 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1650,2,272941,0,0,0,1,'',0,0,0);
-- 1672 Lohgan Eva: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1672 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1672,1,253665,0,0,0,1,'',0,0,0),
(1672,2,253668,0,0,0,1,'',0,0,0);
-- 1673 Alyssa Eva: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1673 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1673,1,211779,0,0,0,1,'',0,0,0),
(1673,2,212160,0,0,0,1,'',0,0,0);
-- 1678 Vernon Hale: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=1678 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1678,113,273636,0,0,0,1,'',0,0,0);
-- 1684 Khara Deepwater: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=1684 AND `type`=1 AND `item` IN (273636,208855);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(1684,113,273636,0,0,0,1,'',0,0,0),
(1684,114,208855,0,0,0,1,'',0,0,0);
-- 2381 Micha Yance: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=2381 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(2381,112,272941,0,0,0,1,'',0,0,0);
-- 2383 Lindea Rabonne: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=2383 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(2383,107,273636,0,0,0,1,'',0,0,0);
-- 2482 Zarena Cromwind: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=2482 AND `type`=1 AND `item` IN (217282);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(2482,3,217282,0,0,0,1,'',0,0,0);
-- 2626 Old Man Heming: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=2626 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(2626,107,273636,0,0,0,1,'',0,0,0);
-- 2664 Kelsey Yance: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=2664 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(2664,6,272941,0,0,0,1,'',0,0,0);
-- 2668 Danielle Zipstitch: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=2668 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(2668,1,253665,0,0,0,1,'',0,0,0),
(2668,2,253668,0,0,0,1,'',0,0,0);
-- 2669 Sheri Zipstitch: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=2669 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(2669,1,253665,0,0,0,1,'',0,0,0),
(2669,2,253668,0,0,0,1,'',0,0,0);
-- 2670 Xizk Goodstitch: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=2670 AND `type`=1 AND `item` IN (253665,253668,217258);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(2670,1,253665,0,0,0,1,'',0,0,0),
(2670,2,253668,0,0,0,1,'',0,0,0),
(2670,19,217258,0,0,0,1,'',0,0,0);
-- 2805 Deneb Walker: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=2805 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(2805,5,211779,0,0,0,1,'',0,0,0),
(2805,6,212160,0,0,0,1,'',0,0,0);
-- 3005 Mahu: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3005 AND `type`=1 AND `item` IN (281043);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3005,8,281043,0,0,0,1,'',0,0,0);
-- 3012 Nata Dawnstrider: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3012 AND `type`=1 AND `item` IN (281042);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3012,1012,281042,0,0,0,1,'',0,0,0);
-- 3014 Nida Winterhoof: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3014 AND `type`=1 AND `item` IN (281041);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3014,2,281041,0,0,0,1,'',0,0,0);
-- 3027 Naal Mistrunner: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3027 AND `type`=1 AND `item` IN (281044);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3027,8,281044,0,0,0,1,'',0,0,0);
-- 3081 Wunna Darkmane: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=3081 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3081,1015,277113,0,0,0,1,'',0,0,0),
(3081,1016,277114,0,0,0,1,'',0,0,0),
(3081,1017,277115,0,0,0,1,'',0,0,0);
-- 3085 Gloria Femmel: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3085 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3085,6,272941,0,0,0,1,'',0,0,0);
-- 3091 Franklin Hamar: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3091 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3091,1,253665,0,0,0,1,'',0,0,0),
(3091,2,253668,0,0,0,1,'',0,0,0);
-- 3096 Captured Servant of Azora: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3096 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3096,1,253665,0,0,0,1,'',0,0,0),
(3096,2,253668,0,0,0,1,'',0,0,0);
-- 3134 Kzixx: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3134 AND `type`=1 AND `item` IN (210709);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3134,1,210709,0,0,0,1,'',0,0,0);
-- 3158 Duokna: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=3158 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3158,9,277113,0,0,0,1,'',0,0,0),
(3158,10,277114,0,0,0,1,'',0,0,0),
(3158,11,277115,0,0,0,1,'',0,0,0);
-- 3178 Stuart Fleming: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3178 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3178,113,273636,0,0,0,1,'',0,0,0);
-- 3180 Dark Iron Entrepreneur: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3180 AND `type`=1 AND `item` IN (209874);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3180,1,209874,0,0,0,1,'',0,0,0);
-- 3187 Tai'tasi: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=3187 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3187,1015,277113,0,0,0,1,'',0,0,0),
(3187,1016,277114,0,0,0,1,'',0,0,0),
(3187,1017,277115,0,0,0,1,'',0,0,0);
-- 3291 Greishan Ironstove: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3291 AND `type`=1 AND `item` IN (208833);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3291,1,208833,0,0,0,1,'',0,0,0);
-- 3323 Horthus: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3323 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3323,1,211779,0,0,0,1,'',0,0,0),
(3323,2,212160,0,0,0,1,'',0,0,0);
-- 3335 Hagrus: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3335 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3335,1,211779,0,0,0,1,'',0,0,0),
(3335,2,212160,0,0,0,1,'',0,0,0);
-- 3346 Kithas: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3346 AND `type`=1 AND `item` IN (247786);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3346,1010,247786,0,0,0,1,'',0,0,0);
-- 3351 Magenius: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3351 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3351,1,211779,0,0,0,1,'',0,0,0),
(3351,2,212160,0,0,0,1,'',0,0,0);
-- 3364 Borya: 4 items
DELETE FROM `npc_vendor` WHERE `entry`=3364 AND `type`=1 AND `item` IN (253665,253668,215369,215370);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3364,1,253665,0,0,0,1,'',0,0,0),
(3364,2,253668,0,0,0,1,'',0,0,0),
(3364,22,215369,0,0,0,1,'',0,0,0),
(3364,23,215370,0,0,0,1,'',0,0,0);
-- 3366 Tamar: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3366 AND `type`=1 AND `item` IN (252783,252784);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3366,1,252783,0,0,0,1,'',0,0,0),
(3366,2,252784,0,0,0,1,'',0,0,0);
-- 3490 Hula'mahi: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3490 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3490,1,211779,0,0,0,1,'',0,0,0),
(3490,2,212160,0,0,0,1,'',0,0,0);
-- 3497 Kilxx: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3497 AND `type`=1 AND `item` IN (208773);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3497,114,208773,0,0,0,1,'',0,0,0);
-- 3500 Tarhus: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3500 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3500,1,211779,0,0,0,1,'',0,0,0),
(3500,2,212160,0,0,0,1,'',0,0,0);
-- 3536 Kris Legace: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3536 AND `type`=1 AND `item` IN (210330);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3536,7,210330,0,0,0,1,'',0,0,0);
-- 3537 Zixil: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=3537 AND `type`=1 AND `item` IN (210709,211487,210410);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3537,2,210709,0,0,0,1,'',0,0,0),
(3537,3,211487,0,0,0,1,'',0,0,0),
(3537,4,210410,0,0,0,1,'',0,0,0);
-- 3542 Jaysin Lanyda: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3542 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3542,1,211779,0,0,0,1,'',0,0,0),
(3542,2,212160,0,0,0,1,'',0,0,0);
-- 3562 Alaindia: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3562 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3562,1,211779,0,0,0,1,'',0,0,0),
(3562,2,212160,0,0,0,1,'',0,0,0);
-- 3587 Lyrai: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=3587 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3587,9,277113,0,0,0,1,'',0,0,0),
(3587,10,277114,0,0,0,1,'',0,0,0),
(3587,11,277115,0,0,0,1,'',0,0,0);
-- 3605 Nadyia Maneweaver: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=3605 AND `type`=1 AND `item` IN (277114);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3605,4,277114,0,0,0,1,'',0,0,0);
-- 3614 Narret Shadowgrove: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=3614 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3614,1015,277113,0,0,0,1,'',0,0,0),
(3614,1016,277114,0,0,0,1,'',0,0,0),
(3614,1017,277115,0,0,0,1,'',0,0,0);
-- 3700 Jadenvis Seawatcher: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3700 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3700,1,211779,0,0,0,1,'',0,0,0),
(3700,2,212160,0,0,0,1,'',0,0,0);
-- 3970 Llana: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=3970 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3970,1,211779,0,0,0,1,'',0,0,0),
(3970,2,212160,0,0,0,1,'',0,0,0);
-- 4047 Zor Lonetree: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=4047 AND `type`=1 AND `item` IN (216748);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4047,0,216748,0,0,0,1,'',0,0,0);
-- 4083 Jeeda: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=4083 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4083,5,211779,0,0,0,1,'',0,0,0),
(4083,6,212160,0,0,0,1,'',0,0,0);
-- 4168 Elynna: 4 items
DELETE FROM `npc_vendor` WHERE `entry`=4168 AND `type`=1 AND `item` IN (253665,253668,215369,215370);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4168,1,253665,0,0,0,1,'',0,0,0),
(4168,2,253668,0,0,0,1,'',0,0,0),
(4168,3,215369,0,0,0,1,'',0,0,0),
(4168,4,215370,0,0,0,1,'',0,0,0);
-- 4189 Valdaron: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=4189 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4189,1,253665,0,0,0,1,'',0,0,0),
(4189,2,253668,0,0,0,1,'',0,0,0);
-- 4220 Cyroen: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=4220 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4220,1,211779,0,0,0,1,'',0,0,0),
(4220,2,212160,0,0,0,1,'',0,0,0);
-- 4222 Voloren: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=4222 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4222,107,273636,0,0,0,1,'',0,0,0);
-- 4223 Fyldan: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=4223 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4223,6,272941,0,0,0,1,'',0,0,0);
-- 4225 Saenorion: 5 items
DELETE FROM `npc_vendor` WHERE `entry`=4225 AND `type`=1 AND `item` IN (252783,252784,252811,252812,277716);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4225,1,252783,0,0,0,1,'',0,0,0),
(4225,2,252784,0,0,0,1,'',0,0,0),
(4225,3,252811,0,0,0,1,'',0,0,0),
(4225,4,252812,0,0,0,1,'',0,0,0),
(4225,5,277716,0,0,0,1,'',0,0,0);
-- 4228 Vaean: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=4228 AND `type`=1 AND `item` IN (247786);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4228,1010,247786,0,0,0,1,'',0,0,0);
-- 4265 Nyoma: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=4265 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4265,6,272941,0,0,0,1,'',0,0,0);
-- 4553 Ronald Burch: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=4553 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4553,6,272941,0,0,0,1,'',0,0,0);
-- 4561 Daniel Bartlett: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=4561 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4561,111,277113,0,0,0,1,'',0,0,0),
(4561,112,277114,0,0,0,1,'',0,0,0),
(4561,113,277115,0,0,0,1,'',0,0,0);
-- 4562 Thomas Mordan: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=4562 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4562,1,211779,0,0,0,1,'',0,0,0),
(4562,2,212160,0,0,0,1,'',0,0,0);
-- 4574 Lizbeth Cromwell: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=4574 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4574,107,273636,0,0,0,1,'',0,0,0);
-- 4575 Hannah Akeley: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=4575 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4575,1,211779,0,0,0,1,'',0,0,0),
(4575,2,212160,0,0,0,1,'',0,0,0);
-- 4577 Millie Gregorian: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=4577 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4577,6,253665,0,0,0,1,'',0,0,0),
(4577,7,253668,0,0,0,1,'',0,0,0);
-- 4589 Joseph Moore: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=4589 AND `type`=1 AND `item` IN (252783,252784);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4589,2,252783,0,0,0,1,'',0,0,0),
(4589,3,252784,0,0,0,1,'',0,0,0);
-- 4617 Thaddeus Webb: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=4617 AND `type`=1 AND `item` IN (247786);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4617,1010,247786,0,0,0,1,'',0,0,0);
-- 4775 Felicia Doan: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=4775 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4775,111,277113,0,0,0,1,'',0,0,0),
(4775,112,277114,0,0,0,1,'',0,0,0),
(4775,113,277115,0,0,0,1,'',0,0,0);
-- 4878 Montarr: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=4878 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(4878,6,211779,0,0,0,1,'',0,0,0),
(4878,7,212160,0,0,0,1,'',0,0,0);
-- 5110 Barim Jurgenstaad: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=5110 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5110,1,211779,0,0,0,1,'',0,0,0),
(5110,2,212160,0,0,0,1,'',0,0,0);
-- 5128 Bombus Finespindle: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=5128 AND `type`=1 AND `item` IN (252783,252784);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5128,1,252783,0,0,0,1,'',0,0,0),
(5128,2,252784,0,0,0,1,'',0,0,0);
-- 5139 Kurdrum Barleybeard: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=5139 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5139,6,211779,0,0,0,1,'',0,0,0),
(5139,7,212160,0,0,0,1,'',0,0,0);
-- 5151 Ginny Longberry: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=5151 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5151,1,211779,0,0,0,1,'',0,0,0),
(5151,2,212160,0,0,0,1,'',0,0,0);
-- 5154 Poranna Snowbraid: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=5154 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5154,1,253665,0,0,0,1,'',0,0,0),
(5154,2,253668,0,0,0,1,'',0,0,0);
-- 5158 Tilli Thistlefuzz: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=5158 AND `type`=1 AND `item` IN (247786);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5158,1010,247786,0,0,0,1,'',0,0,0);
-- 5160 Emrul Riknussun: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=5160 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5160,6,272941,0,0,0,1,'',0,0,0);
-- 5162 Tansy Puddlefizz: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=5162 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5162,107,273636,0,0,0,1,'',0,0,0);
-- 5411 Krinkle Goodsteel: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=5411 AND `type`=1 AND `item` IN (217280);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5411,8,217280,0,0,0,1,'',0,0,0);
-- 5483 Erika Tate: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=5483 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5483,6,272941,0,0,0,1,'',0,0,0);
-- 5494 Catherine Leland: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=5494 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5494,10,273636,0,0,0,1,'',0,0,0);
-- 5565 Jillian Tanner: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=5565 AND `type`=1 AND `item` IN (252783,252784);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5565,1,252783,0,0,0,1,'',0,0,0),
(5565,2,252784,0,0,0,1,'',0,0,0);
-- 5757 Lilly: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=5757 AND `type`=1 AND `item` IN (247786);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5757,1010,247786,0,0,0,1,'',0,0,0);
-- 5758 Leo Sarn: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=5758 AND `type`=1 AND `item` IN (247786);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5758,1010,247786,0,0,0,1,'',0,0,0);
-- 5940 Harn Longcast: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=5940 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5940,107,273636,0,0,0,1,'',0,0,0);
-- 5942 Zansoa: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=5942 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5942,9,273636,0,0,0,1,'',0,0,0);
-- 5944 Yonada: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=5944 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(5944,2,253665,0,0,0,1,'',0,0,0),
(5944,3,253668,0,0,0,1,'',0,0,0);
-- 6567 Ghok'kah: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=6567 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(6567,1,253665,0,0,0,1,'',0,0,0),
(6567,2,253668,0,0,0,1,'',0,0,0);
-- 6568 Vizzklick: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=6568 AND `type`=1 AND `item` IN (253665,253668,217244);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(6568,1,253665,0,0,0,1,'',0,0,0),
(6568,2,253668,0,0,0,1,'',0,0,0),
(6568,3,217244,0,0,0,1,'',0,0,0);
-- 6574 Jun'ha: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=6574 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(6574,1,253665,0,0,0,1,'',0,0,0),
(6574,2,253668,0,0,0,1,'',0,0,0);
-- 6576 Brienna Starglow: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=6576 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(6576,1,253665,0,0,0,1,'',0,0,0),
(6576,2,253668,0,0,0,1,'',0,0,0);
-- 7852 Pratt McGrubben: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=7852 AND `type`=1 AND `item` IN (217271);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(7852,1,217271,0,0,0,1,'',0,0,0);
-- 7854 Jangdor Swiftstrider: 6 items
DELETE FROM `npc_vendor` WHERE `entry`=7854 AND `type`=1 AND `item` IN (252783,252784,252811,252812,252942,217271);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(7854,1,252783,0,0,0,1,'',0,0,0),
(7854,2,252784,0,0,0,1,'',0,0,0),
(7854,3,252811,0,0,0,1,'',0,0,0),
(7854,4,252812,0,0,0,1,'',0,0,0),
(7854,5,252942,0,0,0,1,'',0,0,0),
(7854,6,217271,0,0,0,1,'',0,0,0);
-- 7945 Savanne: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=7945 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(7945,107,273636,0,0,0,1,'',0,0,0);
-- 8361 Chepi: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=8361 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(8361,1,211779,0,0,0,1,'',0,0,0),
(8361,2,212160,0,0,0,1,'',0,0,0);
-- 8401 Halpa: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=8401 AND `type`=1 AND `item` IN (280794,280795);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(8401,1,280794,0,0,0,1,'',0,0,0),
(8401,2,280795,0,0,0,1,'',0,0,0);
-- 8403 Jeremiah Payson: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=8403 AND `type`=1 AND `item` IN (280697,280699);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(8403,1,280697,0,0,0,1,'',0,0,0),
(8403,2,280699,0,0,0,1,'',0,0,0);
-- 8404 Xan'tish: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=8404 AND `type`=1 AND `item` IN (280703);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(8404,1,280703,0,0,0,1,'',0,0,0);
-- 8508 Gretta Ganter: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=8508 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(8508,107,273636,0,0,0,1,'',0,0,0);
-- 8665 Shylenai: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=8665 AND `type`=1 AND `item` IN (280803);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(8665,1,280803,0,0,0,1,'',0,0,0);
-- 8681 Outfitter Eric: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=8681 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(8681,6,253665,0,0,0,1,'',0,0,0),
(8681,7,253668,0,0,0,1,'',0,0,0);
-- 8934 Christopher Hewen: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=8934 AND `type`=1 AND `item` IN (277113,277114,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(8934,1002,277113,0,0,0,1,'',0,0,0),
(8934,1003,277114,0,0,0,1,'',0,0,0),
(8934,1004,277115,0,0,0,1,'',0,0,0);
-- 9499 Plugger Spazzring: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=9499 AND `type`=1 AND `item` IN (220168,227902);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(9499,12,220168,0,0,0,1,'',0,0,0),
(9499,13,227902,0,0,0,1,'',0,0,0);
-- 10118 Nessa Shadowsong: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=10118 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(10118,107,273636,0,0,0,1,'',0,0,0);
-- 10364 Yaelika Farclaw: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=10364 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(10364,6,211779,0,0,0,1,'',0,0,0),
(10364,7,212160,0,0,0,1,'',0,0,0);
-- 10856 Argent Quartermaster Hasana: 9 items
DELETE FROM `npc_vendor` WHERE `entry`=10856 AND `type`=1 AND `item` IN (227819,227813,227814,227815,227816,227817,227818,227859,227888);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(10856,2009,227819,0,0,0,1,'',0,0,0),
(10856,2010,227813,0,0,9245,1,'',0,0,0),
(10856,2011,227814,0,0,9168,1,'',0,0,0),
(10856,2012,227815,0,0,9169,1,'',0,0,0),
(10856,2013,227816,0,0,9171,1,'',0,0,0),
(10856,2014,227817,0,0,9167,1,'',0,0,0),
(10856,2015,227818,0,0,9170,1,'',0,0,0),
(10856,2016,227859,0,0,9161,1,'',0,0,0),
(10856,2017,227888,0,0,9172,1,'',0,0,0);
-- 10857 Argent Quartermaster Lightspark: 9 items
DELETE FROM `npc_vendor` WHERE `entry`=10857 AND `type`=1 AND `item` IN (227819,227813,227814,227815,227816,227817,227818,227859,227888);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(10857,2009,227819,0,0,0,1,'',0,0,0),
(10857,2010,227813,0,0,9245,1,'',0,0,0),
(10857,2011,227814,0,0,9168,1,'',0,0,0),
(10857,2012,227815,0,0,9169,1,'',0,0,0),
(10857,2013,227816,0,0,9171,1,'',0,0,0),
(10857,2014,227817,0,0,9167,1,'',0,0,0),
(10857,2015,227818,0,0,9170,1,'',0,0,0),
(10857,2016,227859,0,0,9161,1,'',0,0,0),
(10857,2017,227888,0,0,9172,1,'',0,0,0);
-- 11036 Leonid Barthalomew the Revered: 192 items
DELETE FROM `npc_vendor` WHERE `entry`=11036 AND `type`=1 AND `item` IN (239512,239513,239514,239515,239516,239517,239518,239519,239520,239521,239522,239523,239524,239525,239526,239527,239529,239530,239531,239532,239533,239534,239535,239536,239537,239538,239539,239540,239541,239542,239543,239544,239547,239548,239549,239550,239551,239552,239553,239554,239555,239556,239557,239558,239559,239560,239561,239562,239565,239572,239574,239575,239577,239581,239582,239583,239584,239585,239586,239587,239588,239589,239590,239591,240020,240021,240022,240023,240024,240025,240026,240027,240028,240029,240030,240031,240032,240033,240034,240035,240036,240037,240038,240039,240040,240041,240042,240043,240044,240045,240046,240047,240048,240049,240050,240051,240052,240053,240054,240055,240056,240057,240058,240059,240060,240061,240062,240063,240064,240065,240066,240067,240068,240069,240070,240071,240072,240073,240074,240075,240076,240077,240078,240079,240080,240081,240082,240083,240084,240085,240086,240087,240088,240089,240090,240091,240092,240093,240095,240096,240097,240098,240099,240100,240101,240102,240103,240104,240105,240106,240107,240108,240109,240110,240122,240123,240124,240125,240126,240127,240128,240129,240130,240131,240134,240135,240136,240137,240138,240139,240140,240141,240142,240143,240144,240145,240146,240147,240148,240149,240150,240151,240152,240153,246055,246056,246057,246058,246059,246060,246061,246062);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(11036,0,239512,0,0,10404,1,'',0,0,0),
(11036,1,239513,0,0,10406,1,'',0,0,0),
(11036,2,239514,0,0,10405,1,'',0,0,0),
(11036,3,239515,0,0,10408,1,'',0,0,0),
(11036,4,239516,0,0,10402,1,'',0,0,0),
(11036,5,239517,0,0,10401,1,'',0,0,0),
(11036,6,239518,0,0,10407,1,'',0,0,0),
(11036,7,239519,0,0,10403,1,'',0,0,0),
(11036,8,239520,0,0,10404,1,'',0,0,0),
(11036,9,239521,0,0,10406,1,'',0,0,0),
(11036,10,239522,0,0,10405,1,'',0,0,0),
(11036,11,239523,0,0,10408,1,'',0,0,0),
(11036,12,239524,0,0,10402,1,'',0,0,0),
(11036,13,239525,0,0,10401,1,'',0,0,0),
(11036,14,239526,0,0,10407,1,'',0,0,0),
(11036,15,239527,0,0,10403,1,'',0,0,0),
(11036,16,239529,0,0,10403,1,'',0,0,0),
(11036,17,239530,0,0,10408,1,'',0,0,0),
(11036,18,239531,0,0,10405,1,'',0,0,0),
(11036,19,239532,0,0,10401,1,'',0,0,0),
(11036,20,239533,0,0,10407,1,'',0,0,0),
(11036,21,239534,0,0,10402,1,'',0,0,0),
(11036,22,239535,0,0,10406,1,'',0,0,0),
(11036,23,239536,0,0,10404,1,'',0,0,0),
(11036,24,239537,0,0,10408,1,'',0,0,0),
(11036,25,239538,0,0,10406,1,'',0,0,0),
(11036,26,239539,0,0,10405,1,'',0,0,0),
(11036,27,239540,0,0,10401,1,'',0,0,0),
(11036,28,239541,0,0,10407,1,'',0,0,0),
(11036,29,239542,0,0,10402,1,'',0,0,0),
(11036,30,239543,0,0,10403,1,'',0,0,0),
(11036,31,239544,0,0,10404,1,'',0,0,0),
(11036,32,239547,0,0,10396,1,'',0,0,0),
(11036,33,239548,0,0,10395,1,'',0,0,0),
(11036,34,239549,0,0,10397,1,'',0,0,0),
(11036,35,239550,0,0,10393,1,'',0,0,0),
(11036,36,239551,0,0,10399,1,'',0,0,0),
(11036,37,239552,0,0,10394,1,'',0,0,0),
(11036,38,239553,0,0,10400,1,'',0,0,0),
(11036,39,239554,0,0,10398,1,'',0,0,0),
(11036,40,239555,0,0,10396,1,'',0,0,0),
(11036,41,239556,0,0,10398,1,'',0,0,0),
(11036,42,239557,0,0,10397,1,'',0,0,0),
(11036,43,239558,0,0,10400,1,'',0,0,0),
(11036,44,239559,0,0,10394,1,'',0,0,0),
(11036,45,239560,0,0,10393,1,'',0,0,0),
(11036,46,239561,0,0,10399,1,'',0,0,0),
(11036,47,239562,0,0,10395,1,'',0,0,0),
(11036,48,239565,0,0,10395,1,'',0,0,0),
(11036,49,239572,0,0,10400,1,'',0,0,0),
(11036,50,239574,0,0,10397,1,'',0,0,0),
(11036,51,239575,0,0,10393,1,'',0,0,0),
(11036,52,239577,0,0,10399,1,'',0,0,0),
(11036,53,239581,0,0,10394,1,'',0,0,0),
(11036,54,239582,0,0,10398,1,'',0,0,0),
(11036,55,239583,0,0,10396,1,'',0,0,0),
(11036,56,239584,0,0,10397,1,'',0,0,0),
(11036,57,239585,0,0,10393,1,'',0,0,0),
(11036,58,239586,0,0,10394,1,'',0,0,0),
(11036,59,239587,0,0,10399,1,'',0,0,0),
(11036,60,239588,0,0,10396,1,'',0,0,0),
(11036,61,239589,0,0,10400,1,'',0,0,0),
(11036,62,239590,0,0,10398,1,'',0,0,0),
(11036,63,239591,0,0,10395,1,'',0,0,0),
(11036,64,240020,0,0,10415,1,'',0,0,0),
(11036,65,240021,0,0,10410,1,'',0,0,0),
(11036,66,240022,0,0,10416,1,'',0,0,0),
(11036,67,240023,0,0,10412,1,'',0,0,0),
(11036,68,240024,0,0,10414,1,'',0,0,0),
(11036,69,240025,0,0,10410,1,'',0,0,0),
(11036,70,240026,0,0,10415,1,'',0,0,0),
(11036,71,240027,0,0,10409,1,'',0,0,0),
(11036,72,240028,0,0,10413,1,'',0,0,0),
(11036,73,240029,0,0,10416,1,'',0,0,0),
(11036,74,240030,0,0,10411,1,'',0,0,0),
(11036,75,240031,0,0,10412,1,'',0,0,0),
(11036,76,240032,0,0,10414,1,'',0,0,0),
(11036,77,240033,0,0,10410,1,'',0,0,0),
(11036,78,240034,0,0,10415,1,'',0,0,0),
(11036,79,240035,0,0,10409,1,'',0,0,0),
(11036,80,240036,0,0,10413,1,'',0,0,0),
(11036,81,240037,0,0,10416,1,'',0,0,0),
(11036,82,240038,0,0,10411,1,'',0,0,0),
(11036,83,240039,0,0,10411,1,'',0,0,0),
(11036,84,240040,0,0,10409,1,'',0,0,0),
(11036,85,240041,0,0,10413,1,'',0,0,0),
(11036,86,240042,0,0,10412,1,'',0,0,0),
(11036,87,240043,0,0,10414,1,'',0,0,0),
(11036,88,240044,0,0,10404,1,'',0,0,0),
(11036,89,240045,0,0,10406,1,'',0,0,0),
(11036,90,240046,0,0,10402,1,'',0,0,0),
(11036,91,240047,0,0,10407,1,'',0,0,0),
(11036,92,240048,0,0,10401,1,'',0,0,0),
(11036,93,240049,0,0,10405,1,'',0,0,0),
(11036,94,240050,0,0,10408,1,'',0,0,0),
(11036,95,240051,0,0,10403,1,'',0,0,0),
(11036,96,240052,0,0,10404,1,'',0,0,0),
(11036,97,240053,0,0,10406,1,'',0,0,0),
(11036,98,240054,0,0,10402,1,'',0,0,0),
(11036,99,240055,0,0,10407,1,'',0,0,0),
(11036,100,240056,0,0,10401,1,'',0,0,0),
(11036,101,240057,0,0,10405,1,'',0,0,0),
(11036,102,240058,0,0,10408,1,'',0,0,0),
(11036,103,240059,0,0,10403,1,'',0,0,0),
(11036,104,240060,0,0,10412,1,'',0,0,0),
(11036,105,240061,0,0,10414,1,'',0,0,0),
(11036,106,240062,0,0,10410,1,'',0,0,0),
(11036,107,240063,0,0,10415,1,'',0,0,0),
(11036,108,240064,0,0,10409,1,'',0,0,0),
(11036,109,240065,0,0,10413,1,'',0,0,0),
(11036,110,240066,0,0,10416,1,'',0,0,0),
(11036,111,240067,0,0,10411,1,'',0,0,0),
(11036,112,240068,0,0,10412,1,'',0,0,0),
(11036,113,240069,0,0,10414,1,'',0,0,0),
(11036,114,240070,0,0,10410,1,'',0,0,0),
(11036,115,240071,0,0,10415,1,'',0,0,0),
(11036,116,240072,0,0,10409,1,'',0,0,0),
(11036,117,240073,0,0,10413,1,'',0,0,0),
(11036,118,240074,0,0,10416,1,'',0,0,0),
(11036,119,240075,0,0,10411,1,'',0,0,0),
(11036,120,240076,0,0,10412,1,'',0,0,0),
(11036,121,240077,0,0,10414,1,'',0,0,0),
(11036,122,240078,0,0,10410,1,'',0,0,0),
(11036,123,240079,0,0,10415,1,'',0,0,0),
(11036,124,240080,0,0,10409,1,'',0,0,0),
(11036,125,240081,0,0,10413,1,'',0,0,0),
(11036,126,240082,0,0,10416,1,'',0,0,0),
(11036,127,240083,0,0,10411,1,'',0,0,0),
(11036,128,240084,0,0,10412,1,'',0,0,0),
(11036,129,240085,0,0,10414,1,'',0,0,0),
(11036,130,240086,0,0,10410,1,'',0,0,0),
(11036,131,240087,0,0,10415,1,'',0,0,0),
(11036,132,240088,0,0,10409,1,'',0,0,0),
(11036,133,240089,0,0,10413,1,'',0,0,0),
(11036,134,240090,0,0,10416,1,'',0,0,0),
(11036,135,240091,0,0,10411,1,'',0,0,0),
(11036,136,240092,0,0,10411,1,'',0,0,0),
(11036,137,240093,0,0,10416,1,'',0,0,0),
(11036,138,240095,0,0,10413,1,'',0,0,0),
(11036,139,240096,0,0,10409,1,'',0,0,0),
(11036,140,240097,0,0,10415,1,'',0,0,0),
(11036,141,240098,0,0,10410,1,'',0,0,0),
(11036,142,240099,0,0,10414,1,'',0,0,0),
(11036,143,240100,0,0,10412,1,'',0,0,0),
(11036,144,240101,0,0,10411,1,'',0,0,0),
(11036,145,240102,0,0,10416,1,'',0,0,0),
(11036,146,240103,0,0,10413,1,'',0,0,0),
(11036,147,240104,0,0,10409,1,'',0,0,0),
(11036,148,240105,0,0,10415,1,'',0,0,0),
(11036,149,240106,0,0,10410,1,'',0,0,0),
(11036,150,240107,0,0,10414,1,'',0,0,0),
(11036,151,240108,0,0,10412,1,'',0,0,0),
(11036,152,240109,0,0,10411,1,'',0,0,0),
(11036,153,240110,0,0,10416,1,'',0,0,0),
(11036,154,240122,0,0,10413,1,'',0,0,0),
(11036,155,240123,0,0,10409,1,'',0,0,0),
(11036,156,240124,0,0,10415,1,'',0,0,0),
(11036,157,240125,0,0,10410,1,'',0,0,0),
(11036,158,240126,0,0,10414,1,'',0,0,0),
(11036,159,240127,0,0,10412,1,'',0,0,0),
(11036,160,240128,0,0,10411,1,'',0,0,0),
(11036,161,240129,0,0,10416,1,'',0,0,0),
(11036,162,240130,0,0,10413,1,'',0,0,0),
(11036,163,240131,0,0,10409,1,'',0,0,0),
(11036,164,240134,0,0,10415,1,'',0,0,0),
(11036,165,240135,0,0,10410,1,'',0,0,0),
(11036,166,240136,0,0,10414,1,'',0,0,0),
(11036,167,240137,0,0,10412,1,'',0,0,0),
(11036,168,240138,0,0,10395,1,'',0,0,0),
(11036,169,240139,0,0,10400,1,'',0,0,0),
(11036,170,240140,0,0,10397,1,'',0,0,0),
(11036,171,240141,0,0,10393,1,'',0,0,0),
(11036,172,240142,0,0,10399,1,'',0,0,0),
(11036,173,240143,0,0,10394,1,'',0,0,0),
(11036,174,240144,0,0,10398,1,'',0,0,0),
(11036,175,240145,0,0,10396,1,'',0,0,0),
(11036,176,240146,0,0,10395,1,'',0,0,0),
(11036,177,240147,0,0,10397,1,'',0,0,0),
(11036,178,240148,0,0,10393,1,'',0,0,0),
(11036,179,240149,0,0,10399,1,'',0,0,0),
(11036,180,240150,0,0,10394,1,'',0,0,0),
(11036,181,240151,0,0,10398,1,'',0,0,0),
(11036,182,240152,0,0,10396,1,'',0,0,0),
(11036,183,240153,0,0,10400,1,'',0,0,0),
(11036,184,246055,0,0,10413,1,'',0,0,0),
(11036,185,246056,0,0,10412,1,'',0,0,0),
(11036,186,246057,0,0,10416,1,'',0,0,0),
(11036,187,246058,0,0,10415,1,'',0,0,0),
(11036,188,246059,0,0,10414,1,'',0,0,0),
(11036,189,246060,0,0,10411,1,'',0,0,0),
(11036,190,246061,0,0,10410,1,'',0,0,0),
(11036,191,246062,0,0,10409,1,'',0,0,0);
-- 11278 Magnus Frostwake: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=11278 AND `type`=1 AND `item` IN (228313);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(11278,1,228313,0,0,0,1,'',0,0,0);
-- 11536 Quartermaster Miranda Breechlock: 11 items
DELETE FROM `npc_vendor` WHERE `entry`=11536 AND `type`=1 AND `item` IN (227819,227813,227814,227815,227816,227817,227818,227859,227888,233197,233198);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(11536,2009,227819,0,0,0,1,'',0,0,0),
(11536,2010,227813,0,0,9245,1,'',0,0,0),
(11536,2011,227814,0,0,9168,1,'',0,0,0),
(11536,2012,227815,0,0,9169,1,'',0,0,0),
(11536,2013,227816,0,0,9171,1,'',0,0,0),
(11536,2014,227817,0,0,9167,1,'',0,0,0),
(11536,2015,227818,0,0,9170,1,'',0,0,0),
(11536,2016,227859,0,0,9161,1,'',0,0,0),
(11536,2017,227888,0,0,9172,1,'',0,0,0),
(11536,2018,233197,0,0,9651,1,'',0,0,0),
(11536,2019,233198,0,0,9650,1,'',0,0,0);
-- 11557 Meilosh: 12 items
DELETE FROM `npc_vendor` WHERE `entry`=11557 AND `type`=1 AND `item` IN (228982,227808,233217,227809,227810,227862,233209,227803,227804,227805,228190,227807);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(11557,1,228982,0,0,0,1,'',0,0,0),
(11557,2,227808,0,0,9182,1,'',0,0,0),
(11557,3,233217,0,0,9652,1,'',0,0,0),
(11557,4,227809,0,0,9183,1,'',0,0,0),
(11557,5,227810,0,0,9176,1,'',0,0,0),
(11557,6,227862,0,0,9180,1,'',0,0,0),
(11557,7,233209,0,0,9653,1,'',0,0,0),
(11557,8,227803,0,0,9177,1,'',0,0,0),
(11557,9,227804,0,0,9178,1,'',0,0,0),
(11557,10,227805,0,0,9179,1,'',0,0,0),
(11557,11,228190,0,0,9181,1,'',0,0,0),
(11557,12,227807,0,0,9175,1,'',0,0,0);
-- 11874 Masat T'andr: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=11874 AND `type`=1 AND `item` IN (228309);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(11874,1,228309,0,0,0,1,'',0,0,0);
-- 12033 Wulan: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=12033 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12033,6,272941,0,0,0,1,'',0,0,0);
-- 12096 Stormpike Quartermaster: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=12096 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12096,40,211779,0,0,0,1,'',0,0,0),
(12096,41,212160,0,0,0,1,'',0,0,0);
-- 12097 Frostwolf Quartermaster: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=12097 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12097,51,211779,0,0,0,1,'',0,0,0),
(12097,52,212160,0,0,0,1,'',0,0,0);
-- 12777 Captain Dirgehammer: 234 items
DELETE FROM `npc_vendor` WHERE `entry`=12777 AND `type`=1 AND `item` IN (220794,220795,220797,220799,220804,220806,220808,220809,220810,220811,220812,220813,220814,220815,220816,220817,220818,220819,220822,220825,220828,220829,220832,220837,220850,220852,220854,220856,220858,220860,220862,220864,220866,220868,220870,220872,220874,220876,220878,220880,220882,220884,220886,220887,220888,220889,220890,220891,220892,220893,220894,220895,220896,220897,223073,223074,223075,223076,223077,223078,227044,227045,227046,227047,227052,227053,227054,227055,227058,227061,227064,227065,227066,227068,227070,227072,227076,227077,227084,227085,227086,227087,227088,227089,227091,227093,227095,227096,227100,227101,227102,227103,227108,227109,227112,227113,227114,227119,227121,227122,227125,227128,227129,227136,227137,227138,227139,227140,227141,227142,227143,227144,227145,227146,227147,227148,227149,227150,227151,227152,227153,227172,227173,227176,227178,227182,227183,227190,227191,227192,227193,227194,227195,227196,227197,227198,227199,227200,227201,231536,231537,231538,231539,231540,231541,231543,231544,231545,231546,231547,231548,231557,231558,231560,231561,231562,231563,231576,231577,231578,231579,231580,231581,231582,231583,231584,231585,231586,231587,231602,231603,231604,231605,231606,231608,231609,231616,231617,231618,231619,231620,231621,231622,231623,231624,231626,231627,231628,231639,231640,231641,231643,231645,231646,231647,231648,231649,231650,231651,231652,231689,231690,231691,231692,231693,231694,231695,231696,231697,231698,231699,231700,231701,231702,231703,231704,231705,231706,272704,272706,272708,272710,272726,272727,272728,272729,275229,275238,275239,275240,275241,275242,275243,275244);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12777,122,220794,0,0,0,1,'',0,0,0),
(12777,123,220795,0,0,0,1,'',0,0,0),
(12777,124,220797,0,0,0,1,'',0,0,0),
(12777,125,220799,0,0,0,1,'',0,0,0),
(12777,126,220804,0,0,0,1,'',0,0,0),
(12777,127,220806,0,0,0,1,'',0,0,0),
(12777,128,220808,0,0,0,1,'',0,0,0),
(12777,129,220809,0,0,0,1,'',0,0,0),
(12777,130,220810,0,0,0,1,'',0,0,0),
(12777,131,220811,0,0,0,1,'',0,0,0),
(12777,132,220812,0,0,0,1,'',0,0,0),
(12777,133,220813,0,0,0,1,'',0,0,0),
(12777,134,220814,0,0,0,1,'',0,0,0),
(12777,135,220815,0,0,0,1,'',0,0,0),
(12777,136,220816,0,0,0,1,'',0,0,0),
(12777,137,220817,0,0,0,1,'',0,0,0),
(12777,138,220818,0,0,0,1,'',0,0,0),
(12777,139,220819,0,0,0,1,'',0,0,0),
(12777,140,220822,0,0,0,1,'',0,0,0),
(12777,141,220825,0,0,0,1,'',0,0,0),
(12777,142,220828,0,0,0,1,'',0,0,0),
(12777,143,220829,0,0,0,1,'',0,0,0),
(12777,144,220832,0,0,0,1,'',0,0,0),
(12777,145,220837,0,0,0,1,'',0,0,0),
(12777,146,220850,0,0,0,1,'',0,0,0),
(12777,147,220852,0,0,0,1,'',0,0,0),
(12777,148,220854,0,0,0,1,'',0,0,0),
(12777,149,220856,0,0,0,1,'',0,0,0),
(12777,150,220858,0,0,0,1,'',0,0,0),
(12777,151,220860,0,0,0,1,'',0,0,0),
(12777,152,220862,0,0,0,1,'',0,0,0),
(12777,153,220864,0,0,0,1,'',0,0,0),
(12777,154,220866,0,0,0,1,'',0,0,0),
(12777,155,220868,0,0,0,1,'',0,0,0),
(12777,156,220870,0,0,0,1,'',0,0,0),
(12777,157,220872,0,0,0,1,'',0,0,0),
(12777,158,220874,0,0,0,1,'',0,0,0),
(12777,159,220876,0,0,0,1,'',0,0,0),
(12777,160,220878,0,0,0,1,'',0,0,0),
(12777,161,220880,0,0,0,1,'',0,0,0),
(12777,162,220882,0,0,0,1,'',0,0,0),
(12777,163,220884,0,0,0,1,'',0,0,0),
(12777,164,220886,0,0,0,1,'',0,0,0),
(12777,165,220887,0,0,0,1,'',0,0,0),
(12777,166,220888,0,0,0,1,'',0,0,0),
(12777,167,220889,0,0,0,1,'',0,0,0),
(12777,168,220890,0,0,0,1,'',0,0,0),
(12777,169,220891,0,0,0,1,'',0,0,0),
(12777,170,220892,0,0,0,1,'',0,0,0),
(12777,171,220893,0,0,0,1,'',0,0,0),
(12777,172,220894,0,0,0,1,'',0,0,0),
(12777,173,220895,0,0,0,1,'',0,0,0),
(12777,174,220896,0,0,0,1,'',0,0,0),
(12777,175,220897,0,0,0,1,'',0,0,0),
(12777,176,223073,0,0,0,1,'',0,0,0),
(12777,177,223074,0,0,0,1,'',0,0,0),
(12777,178,223075,0,0,0,1,'',0,0,0),
(12777,179,223076,0,0,0,1,'',0,0,0),
(12777,180,223077,0,0,0,1,'',0,0,0),
(12777,181,223078,0,0,0,1,'',0,0,0),
(12777,182,227044,0,0,0,1,'',0,0,0),
(12777,183,227045,0,0,0,1,'',0,0,0),
(12777,184,227046,0,0,0,1,'',0,0,0),
(12777,185,227047,0,0,0,1,'',0,0,0),
(12777,186,227052,0,0,0,1,'',0,0,0),
(12777,187,227053,0,0,0,1,'',0,0,0),
(12777,188,227054,0,0,0,1,'',0,0,0),
(12777,189,227055,0,0,0,1,'',0,0,0),
(12777,190,227058,0,0,0,1,'',0,0,0),
(12777,191,227061,0,0,0,1,'',0,0,0),
(12777,192,227064,0,0,0,1,'',0,0,0),
(12777,193,227065,0,0,0,1,'',0,0,0),
(12777,194,227066,0,0,0,1,'',0,0,0),
(12777,195,227068,0,0,0,1,'',0,0,0),
(12777,196,227070,0,0,0,1,'',0,0,0),
(12777,197,227072,0,0,0,1,'',0,0,0),
(12777,198,227076,0,0,0,1,'',0,0,0),
(12777,199,227077,0,0,0,1,'',0,0,0),
(12777,200,227084,0,0,0,1,'',0,0,0),
(12777,201,227085,0,0,0,1,'',0,0,0),
(12777,202,227086,0,0,0,1,'',0,0,0),
(12777,203,227087,0,0,0,1,'',0,0,0),
(12777,204,227088,0,0,0,1,'',0,0,0),
(12777,205,227089,0,0,0,1,'',0,0,0),
(12777,206,227091,0,0,0,1,'',0,0,0),
(12777,207,227093,0,0,0,1,'',0,0,0),
(12777,208,227095,0,0,0,1,'',0,0,0),
(12777,209,227096,0,0,0,1,'',0,0,0),
(12777,210,227100,0,0,0,1,'',0,0,0),
(12777,211,227101,0,0,0,1,'',0,0,0),
(12777,212,227102,0,0,0,1,'',0,0,0),
(12777,213,227103,0,0,0,1,'',0,0,0),
(12777,214,227108,0,0,0,1,'',0,0,0),
(12777,215,227109,0,0,0,1,'',0,0,0),
(12777,216,227112,0,0,0,1,'',0,0,0),
(12777,217,227113,0,0,0,1,'',0,0,0),
(12777,218,227114,0,0,0,1,'',0,0,0),
(12777,219,227119,0,0,0,1,'',0,0,0),
(12777,220,227121,0,0,0,1,'',0,0,0),
(12777,221,227122,0,0,0,1,'',0,0,0),
(12777,222,227125,0,0,0,1,'',0,0,0),
(12777,223,227128,0,0,0,1,'',0,0,0),
(12777,224,227129,0,0,0,1,'',0,0,0),
(12777,225,227136,0,0,0,1,'',0,0,0),
(12777,226,227137,0,0,0,1,'',0,0,0),
(12777,227,227138,0,0,0,1,'',0,0,0),
(12777,228,227139,0,0,0,1,'',0,0,0),
(12777,229,227140,0,0,0,1,'',0,0,0),
(12777,230,227141,0,0,0,1,'',0,0,0),
(12777,231,227142,0,0,0,1,'',0,0,0),
(12777,232,227143,0,0,0,1,'',0,0,0),
(12777,233,227144,0,0,0,1,'',0,0,0),
(12777,234,227145,0,0,0,1,'',0,0,0),
(12777,235,227146,0,0,0,1,'',0,0,0),
(12777,236,227147,0,0,0,1,'',0,0,0),
(12777,237,227148,0,0,0,1,'',0,0,0),
(12777,238,227149,0,0,0,1,'',0,0,0),
(12777,239,227150,0,0,0,1,'',0,0,0),
(12777,240,227151,0,0,0,1,'',0,0,0),
(12777,241,227152,0,0,0,1,'',0,0,0),
(12777,242,227153,0,0,0,1,'',0,0,0),
(12777,243,227172,0,0,0,1,'',0,0,0),
(12777,244,227173,0,0,0,1,'',0,0,0),
(12777,245,227176,0,0,0,1,'',0,0,0),
(12777,246,227178,0,0,0,1,'',0,0,0),
(12777,247,227182,0,0,0,1,'',0,0,0),
(12777,248,227183,0,0,0,1,'',0,0,0),
(12777,249,227190,0,0,0,1,'',0,0,0),
(12777,250,227191,0,0,0,1,'',0,0,0),
(12777,251,227192,0,0,0,1,'',0,0,0),
(12777,252,227193,0,0,0,1,'',0,0,0),
(12777,253,227194,0,0,0,1,'',0,0,0),
(12777,254,227195,0,0,0,1,'',0,0,0),
(12777,255,227196,0,0,0,1,'',0,0,0),
(12777,256,227197,0,0,0,1,'',0,0,0),
(12777,257,227198,0,0,0,1,'',0,0,0),
(12777,258,227199,0,0,0,1,'',0,0,0),
(12777,259,227200,0,0,0,1,'',0,0,0),
(12777,260,227201,0,0,0,1,'',0,0,0),
(12777,261,231536,0,0,0,1,'',0,0,0),
(12777,262,231537,0,0,0,1,'',0,0,0),
(12777,263,231538,0,0,0,1,'',0,0,0),
(12777,264,231539,0,0,0,1,'',0,0,0),
(12777,265,231540,0,0,0,1,'',0,0,0),
(12777,266,231541,0,0,0,1,'',0,0,0),
(12777,267,231543,0,0,0,1,'',0,0,0),
(12777,268,231544,0,0,0,1,'',0,0,0),
(12777,269,231545,0,0,0,1,'',0,0,0),
(12777,270,231546,0,0,0,1,'',0,0,0),
(12777,271,231547,0,0,0,1,'',0,0,0),
(12777,272,231548,0,0,0,1,'',0,0,0),
(12777,273,231557,0,0,0,1,'',0,0,0),
(12777,274,231558,0,0,0,1,'',0,0,0),
(12777,275,231560,0,0,0,1,'',0,0,0),
(12777,276,231561,0,0,0,1,'',0,0,0),
(12777,277,231562,0,0,0,1,'',0,0,0),
(12777,278,231563,0,0,0,1,'',0,0,0),
(12777,279,231576,0,0,0,1,'',0,0,0),
(12777,280,231577,0,0,0,1,'',0,0,0),
(12777,281,231578,0,0,0,1,'',0,0,0),
(12777,282,231579,0,0,0,1,'',0,0,0),
(12777,283,231580,0,0,0,1,'',0,0,0),
(12777,284,231581,0,0,0,1,'',0,0,0),
(12777,285,231582,0,0,0,1,'',0,0,0),
(12777,286,231583,0,0,0,1,'',0,0,0),
(12777,287,231584,0,0,0,1,'',0,0,0),
(12777,288,231585,0,0,0,1,'',0,0,0),
(12777,289,231586,0,0,0,1,'',0,0,0),
(12777,290,231587,0,0,0,1,'',0,0,0),
(12777,291,231602,0,0,0,1,'',0,0,0),
(12777,292,231603,0,0,0,1,'',0,0,0),
(12777,293,231604,0,0,0,1,'',0,0,0),
(12777,294,231605,0,0,0,1,'',0,0,0),
(12777,295,231606,0,0,0,1,'',0,0,0),
(12777,296,231608,0,0,0,1,'',0,0,0),
(12777,297,231609,0,0,0,1,'',0,0,0),
(12777,298,231616,0,0,0,1,'',0,0,0),
(12777,299,231617,0,0,0,1,'',0,0,0),
(12777,300,231618,0,0,0,1,'',0,0,0),
(12777,301,231619,0,0,0,1,'',0,0,0),
(12777,302,231620,0,0,0,1,'',0,0,0),
(12777,303,231621,0,0,0,1,'',0,0,0),
(12777,304,231622,0,0,0,1,'',0,0,0),
(12777,305,231623,0,0,0,1,'',0,0,0),
(12777,306,231624,0,0,0,1,'',0,0,0),
(12777,307,231626,0,0,0,1,'',0,0,0),
(12777,308,231627,0,0,0,1,'',0,0,0),
(12777,309,231628,0,0,0,1,'',0,0,0),
(12777,310,231639,0,0,0,1,'',0,0,0),
(12777,311,231640,0,0,0,1,'',0,0,0),
(12777,312,231641,0,0,0,1,'',0,0,0),
(12777,313,231643,0,0,0,1,'',0,0,0),
(12777,314,231645,0,0,0,1,'',0,0,0),
(12777,315,231646,0,0,0,1,'',0,0,0),
(12777,316,231647,0,0,0,1,'',0,0,0),
(12777,317,231648,0,0,0,1,'',0,0,0),
(12777,318,231649,0,0,0,1,'',0,0,0),
(12777,319,231650,0,0,0,1,'',0,0,0),
(12777,320,231651,0,0,0,1,'',0,0,0),
(12777,321,231652,0,0,0,1,'',0,0,0),
(12777,322,231689,0,0,0,1,'',0,0,0),
(12777,323,231690,0,0,0,1,'',0,0,0),
(12777,324,231691,0,0,0,1,'',0,0,0),
(12777,325,231692,0,0,0,1,'',0,0,0),
(12777,326,231693,0,0,0,1,'',0,0,0),
(12777,327,231694,0,0,0,1,'',0,0,0),
(12777,328,231695,0,0,0,1,'',0,0,0),
(12777,329,231696,0,0,0,1,'',0,0,0),
(12777,330,231697,0,0,0,1,'',0,0,0),
(12777,331,231698,0,0,0,1,'',0,0,0),
(12777,332,231699,0,0,0,1,'',0,0,0),
(12777,333,231700,0,0,0,1,'',0,0,0),
(12777,334,231701,0,0,0,1,'',0,0,0),
(12777,335,231702,0,0,0,1,'',0,0,0),
(12777,336,231703,0,0,0,1,'',0,0,0),
(12777,337,231704,0,0,0,1,'',0,0,0),
(12777,338,231705,0,0,0,1,'',0,0,0),
(12777,339,231706,0,0,0,1,'',0,0,0),
(12777,340,272704,0,0,11583,1,'13899',0,0,0),
(12777,341,272706,0,0,11579,1,'13899',0,0,0),
(12777,342,272708,0,0,11580,1,'13899',0,0,0),
(12777,343,272710,0,0,11581,1,'13899',0,0,0),
(12777,344,272726,0,0,11578,1,'13899',0,0,0),
(12777,345,272727,0,0,11575,1,'13899',0,0,0),
(12777,346,272728,0,0,11582,1,'13899',0,0,0),
(12777,347,272729,0,0,11576,1,'13899',0,0,0),
(12777,348,275229,0,0,11585,1,'',156250,0,0),
(12777,349,275238,0,0,11587,1,'',156251,0,0),
(12777,350,275239,0,0,11589,1,'',156248,0,0),
(12777,351,275240,0,0,11588,1,'',156246,0,0),
(12777,352,275241,0,0,11584,1,'',156251,0,0),
(12777,353,275242,0,0,11591,1,'',156250,0,0),
(12777,354,275243,0,0,11592,1,'',156247,0,0),
(12777,355,275244,0,0,11590,1,'',156246,0,0);
-- 12781 Master Sergeant Biggins: 6 items
DELETE FROM `npc_vendor` WHERE `entry`=12781 AND `type`=1 AND `item` IN (272694,272695,272698,272699,274445,274969);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12781,5,272694,0,0,0,1,'',156238,0,0),
(12781,6,272695,0,0,0,1,'',156243,0,0),
(12781,7,272698,0,0,11577,1,'',156240,0,0),
(12781,8,272699,0,0,11577,1,'',156240,0,0),
(12781,9,274445,0,0,11596,1,'',156239,0,0),
(12781,10,274969,0,0,11595,1,'',156241,0,0);
-- 12782 Captain O'Neal: 48 items
DELETE FROM `npc_vendor` WHERE `entry`=12782 AND `type`=1 AND `item` IN (234565,234566,234567,234568,234569,234570,234571,234574,234576,234578,234579,234580,234581,234582,234583,234584,234585,234586,234587,234588,234589,234590,235473,235479,235480,235481,272693,272838,272839,272840,272841,272842,272843,272844,272845,272846,272847,272848,272849,272850,272851,272856,272857,272858,272859,278157,278158,278468);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12782,22,234565,0,0,0,1,'',0,0,0),
(12782,23,234566,0,0,0,1,'',0,0,0),
(12782,24,234567,0,0,0,1,'',0,0,0),
(12782,25,234568,0,0,0,1,'',0,0,0),
(12782,26,234569,0,0,0,1,'',0,0,0),
(12782,27,234570,0,0,0,1,'',0,0,0),
(12782,28,234571,0,0,0,1,'',0,0,0),
(12782,29,234574,0,0,0,1,'',0,0,0),
(12782,30,234576,0,0,0,1,'',0,0,0),
(12782,31,234578,0,0,0,1,'',0,0,0),
(12782,32,234579,0,0,0,1,'',0,0,0),
(12782,33,234580,0,0,0,1,'',0,0,0),
(12782,34,234581,0,0,0,1,'',0,0,0),
(12782,35,234582,0,0,0,1,'',0,0,0),
(12782,36,234583,0,0,0,1,'',0,0,0),
(12782,37,234584,0,0,0,1,'',0,0,0),
(12782,38,234585,0,0,0,1,'',0,0,0),
(12782,39,234586,0,0,0,1,'',0,0,0),
(12782,40,234587,0,0,0,1,'',0,0,0),
(12782,41,234588,0,0,0,1,'',0,0,0),
(12782,42,234589,0,0,0,1,'',0,0,0),
(12782,43,234590,0,0,0,1,'',0,0,0),
(12782,44,235473,0,0,0,1,'',0,0,0),
(12782,45,235479,0,0,0,1,'',0,0,0),
(12782,46,235480,0,0,0,1,'',0,0,0),
(12782,47,235481,0,0,0,1,'',0,0,0),
(12782,48,272693,0,0,11593,1,'',156252,0,0),
(12782,49,272838,0,0,11706,1,'',156252,0,0),
(12782,50,272839,0,0,11593,1,'',156252,0,0),
(12782,51,272840,0,0,11594,1,'',156252,0,0),
(12782,52,272841,0,0,11593,1,'',156252,0,0),
(12782,53,272842,0,0,11593,1,'',156252,0,0),
(12782,54,272843,0,0,11593,1,'',156252,0,0),
(12782,55,272844,0,0,11593,1,'',156252,0,0),
(12782,56,272845,0,0,11593,1,'',156252,0,0),
(12782,57,272846,0,0,11593,1,'',156252,0,0),
(12782,58,272847,0,0,11593,1,'',156252,0,0),
(12782,59,272848,0,0,11594,1,'',156252,0,0),
(12782,60,272849,0,0,11594,1,'',156252,0,0),
(12782,61,272850,0,0,11594,1,'',156252,0,0),
(12782,62,272851,0,0,11594,1,'',156252,0,0),
(12782,63,272856,0,0,11593,1,'',156252,0,0),
(12782,64,272857,0,0,11593,1,'',156252,0,0),
(12782,65,272858,0,0,11594,1,'',156252,0,0),
(12782,66,272859,0,0,11593,1,'',156252,0,0),
(12782,67,278157,0,0,11706,1,'',156252,0,0),
(12782,68,278158,0,0,11706,1,'',156252,0,0),
(12782,69,278468,0,0,11706,1,'',156252,0,0);
-- 12784 Lieutenant Jackspring: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=12784 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12784,20,211779,0,0,0,1,'',0,0,0),
(12784,21,212160,0,0,0,1,'',0,0,0);
-- 12792 Lady Palanseer: 230 items
DELETE FROM `npc_vendor` WHERE `entry`=12792 AND `type`=1 AND `item` IN (220796,220798,220800,220801,220803,220807,220820,220821,220823,220824,220826,220827,220830,220831,220833,220834,220835,220836,220838,220839,220840,220841,220842,220843,220844,220845,220846,220847,220848,220849,220851,220853,220855,220857,220859,220861,220863,220865,220867,220869,220871,220873,220875,220877,220879,220881,220883,220885,220898,220899,220900,220901,220902,220903,220904,220905,220906,220907,220908,220909,227042,227043,227048,227049,227050,227051,227056,227057,227059,227060,227062,227063,227067,227069,227071,227073,227074,227075,227078,227079,227080,227081,227082,227083,227090,227092,227094,227097,227098,227099,227104,227105,227106,227107,227110,227111,227115,227118,227120,227123,227124,227126,227127,227130,227131,227132,227133,227134,227135,227154,227155,227156,227157,227158,227159,227160,227161,227162,227163,227164,227165,227166,227167,227168,227169,227170,227171,227174,227175,227177,227179,227180,227181,227184,227185,227186,227187,227188,227189,227202,227203,227204,227205,227206,227207,231530,231531,231532,231533,231534,231535,231549,231551,231552,231553,231554,231555,231564,231565,231566,231567,231568,231569,231570,231571,231572,231573,231574,231575,231588,231589,231590,231591,231592,231593,231594,231595,231596,231597,231599,231600,231601,231610,231611,231612,231613,231614,231615,231630,231631,231632,231633,231634,231635,231653,231654,231655,231656,231657,231658,231659,231660,231661,231662,231663,231664,231665,231666,231667,231668,231669,231670,231671,231672,231673,231674,231675,231676,231677,231678,231679,231680,231681,231682,231683,231684,231685,231686,231687,231688);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12792,110,220796,0,0,0,1,'',0,0,0),
(12792,111,220798,0,0,0,1,'',0,0,0),
(12792,112,220800,0,0,0,1,'',0,0,0),
(12792,113,220801,0,0,0,1,'',0,0,0),
(12792,114,220803,0,0,0,1,'',0,0,0),
(12792,115,220807,0,0,0,1,'',0,0,0),
(12792,116,220820,0,0,0,1,'',0,0,0),
(12792,117,220821,0,0,0,1,'',0,0,0),
(12792,118,220823,0,0,0,1,'',0,0,0),
(12792,119,220824,0,0,0,1,'',0,0,0),
(12792,120,220826,0,0,0,1,'',0,0,0),
(12792,121,220827,0,0,0,1,'',0,0,0),
(12792,122,220830,0,0,0,1,'',0,0,0),
(12792,123,220831,0,0,0,1,'',0,0,0),
(12792,124,220833,0,0,0,1,'',0,0,0),
(12792,125,220834,0,0,0,1,'',0,0,0),
(12792,126,220835,0,0,0,1,'',0,0,0),
(12792,127,220836,0,0,0,1,'',0,0,0),
(12792,128,220838,0,0,0,1,'',0,0,0),
(12792,129,220839,0,0,0,1,'',0,0,0),
(12792,130,220840,0,0,0,1,'',0,0,0),
(12792,131,220841,0,0,0,1,'',0,0,0),
(12792,132,220842,0,0,0,1,'',0,0,0),
(12792,133,220843,0,0,0,1,'',0,0,0),
(12792,134,220844,0,0,0,1,'',0,0,0),
(12792,135,220845,0,0,0,1,'',0,0,0),
(12792,136,220846,0,0,0,1,'',0,0,0),
(12792,137,220847,0,0,0,1,'',0,0,0),
(12792,138,220848,0,0,0,1,'',0,0,0),
(12792,139,220849,0,0,0,1,'',0,0,0),
(12792,140,220851,0,0,0,1,'',0,0,0),
(12792,141,220853,0,0,0,1,'',0,0,0),
(12792,142,220855,0,0,0,1,'',0,0,0),
(12792,143,220857,0,0,0,1,'',0,0,0),
(12792,144,220859,0,0,0,1,'',0,0,0),
(12792,145,220861,0,0,0,1,'',0,0,0),
(12792,146,220863,0,0,0,1,'',0,0,0),
(12792,147,220865,0,0,0,1,'',0,0,0),
(12792,148,220867,0,0,0,1,'',0,0,0),
(12792,149,220869,0,0,0,1,'',0,0,0),
(12792,150,220871,0,0,0,1,'',0,0,0),
(12792,151,220873,0,0,0,1,'',0,0,0),
(12792,152,220875,0,0,0,1,'',0,0,0),
(12792,153,220877,0,0,0,1,'',0,0,0),
(12792,154,220879,0,0,0,1,'',0,0,0),
(12792,155,220881,0,0,0,1,'',0,0,0),
(12792,156,220883,0,0,0,1,'',0,0,0),
(12792,157,220885,0,0,0,1,'',0,0,0),
(12792,158,220898,0,0,0,1,'',0,0,0),
(12792,159,220899,0,0,0,1,'',0,0,0),
(12792,160,220900,0,0,0,1,'',0,0,0),
(12792,161,220901,0,0,0,1,'',0,0,0),
(12792,162,220902,0,0,0,1,'',0,0,0),
(12792,163,220903,0,0,0,1,'',0,0,0),
(12792,164,220904,0,0,0,1,'',0,0,0),
(12792,165,220905,0,0,0,1,'',0,0,0),
(12792,166,220906,0,0,0,1,'',0,0,0),
(12792,167,220907,0,0,0,1,'',0,0,0),
(12792,168,220908,0,0,0,1,'',0,0,0),
(12792,169,220909,0,0,0,1,'',0,0,0),
(12792,170,227042,0,0,0,1,'',0,0,0),
(12792,171,227043,0,0,0,1,'',0,0,0),
(12792,172,227048,0,0,0,1,'',0,0,0),
(12792,173,227049,0,0,0,1,'',0,0,0),
(12792,174,227050,0,0,0,1,'',0,0,0),
(12792,175,227051,0,0,0,1,'',0,0,0),
(12792,176,227056,0,0,0,1,'',0,0,0),
(12792,177,227057,0,0,0,1,'',0,0,0),
(12792,178,227059,0,0,0,1,'',0,0,0),
(12792,179,227060,0,0,0,1,'',0,0,0),
(12792,180,227062,0,0,0,1,'',0,0,0),
(12792,181,227063,0,0,0,1,'',0,0,0),
(12792,182,227067,0,0,0,1,'',0,0,0),
(12792,183,227069,0,0,0,1,'',0,0,0),
(12792,184,227071,0,0,0,1,'',0,0,0),
(12792,185,227073,0,0,0,1,'',0,0,0),
(12792,186,227074,0,0,0,1,'',0,0,0),
(12792,187,227075,0,0,0,1,'',0,0,0),
(12792,188,227078,0,0,0,1,'',0,0,0),
(12792,189,227079,0,0,0,1,'',0,0,0),
(12792,190,227080,0,0,0,1,'',0,0,0),
(12792,191,227081,0,0,0,1,'',0,0,0),
(12792,192,227082,0,0,0,1,'',0,0,0),
(12792,193,227083,0,0,0,1,'',0,0,0),
(12792,194,227090,0,0,0,1,'',0,0,0),
(12792,195,227092,0,0,0,1,'',0,0,0),
(12792,196,227094,0,0,0,1,'',0,0,0),
(12792,197,227097,0,0,0,1,'',0,0,0),
(12792,198,227098,0,0,0,1,'',0,0,0),
(12792,199,227099,0,0,0,1,'',0,0,0),
(12792,200,227104,0,0,0,1,'',0,0,0),
(12792,201,227105,0,0,0,1,'',0,0,0),
(12792,202,227106,0,0,0,1,'',0,0,0),
(12792,203,227107,0,0,0,1,'',0,0,0),
(12792,204,227110,0,0,0,1,'',0,0,0),
(12792,205,227111,0,0,0,1,'',0,0,0),
(12792,206,227115,0,0,0,1,'',0,0,0),
(12792,207,227118,0,0,0,1,'',0,0,0),
(12792,208,227120,0,0,0,1,'',0,0,0),
(12792,209,227123,0,0,0,1,'',0,0,0),
(12792,210,227124,0,0,0,1,'',0,0,0),
(12792,211,227126,0,0,0,1,'',0,0,0),
(12792,212,227127,0,0,0,1,'',0,0,0),
(12792,213,227130,0,0,0,1,'',0,0,0),
(12792,214,227131,0,0,0,1,'',0,0,0),
(12792,215,227132,0,0,0,1,'',0,0,0),
(12792,216,227133,0,0,0,1,'',0,0,0),
(12792,217,227134,0,0,0,1,'',0,0,0),
(12792,218,227135,0,0,0,1,'',0,0,0),
(12792,219,227154,0,0,0,1,'',0,0,0),
(12792,220,227155,0,0,0,1,'',0,0,0),
(12792,221,227156,0,0,0,1,'',0,0,0),
(12792,222,227157,0,0,0,1,'',0,0,0),
(12792,223,227158,0,0,0,1,'',0,0,0),
(12792,224,227159,0,0,0,1,'',0,0,0),
(12792,225,227160,0,0,0,1,'',0,0,0),
(12792,226,227161,0,0,0,1,'',0,0,0),
(12792,227,227162,0,0,0,1,'',0,0,0),
(12792,228,227163,0,0,0,1,'',0,0,0),
(12792,229,227164,0,0,0,1,'',0,0,0),
(12792,230,227165,0,0,0,1,'',0,0,0),
(12792,231,227166,0,0,0,1,'',0,0,0),
(12792,232,227167,0,0,0,1,'',0,0,0),
(12792,233,227168,0,0,0,1,'',0,0,0),
(12792,234,227169,0,0,0,1,'',0,0,0),
(12792,235,227170,0,0,0,1,'',0,0,0),
(12792,236,227171,0,0,0,1,'',0,0,0),
(12792,237,227174,0,0,0,1,'',0,0,0),
(12792,238,227175,0,0,0,1,'',0,0,0),
(12792,239,227177,0,0,0,1,'',0,0,0),
(12792,240,227179,0,0,0,1,'',0,0,0),
(12792,241,227180,0,0,0,1,'',0,0,0),
(12792,242,227181,0,0,0,1,'',0,0,0),
(12792,243,227184,0,0,0,1,'',0,0,0),
(12792,244,227185,0,0,0,1,'',0,0,0),
(12792,245,227186,0,0,0,1,'',0,0,0),
(12792,246,227187,0,0,0,1,'',0,0,0),
(12792,247,227188,0,0,0,1,'',0,0,0),
(12792,248,227189,0,0,0,1,'',0,0,0),
(12792,249,227202,0,0,0,1,'',0,0,0),
(12792,250,227203,0,0,0,1,'',0,0,0),
(12792,251,227204,0,0,0,1,'',0,0,0),
(12792,252,227205,0,0,0,1,'',0,0,0),
(12792,253,227206,0,0,0,1,'',0,0,0),
(12792,254,227207,0,0,0,1,'',0,0,0),
(12792,255,231530,0,0,0,1,'',0,0,0),
(12792,256,231531,0,0,0,1,'',0,0,0),
(12792,257,231532,0,0,0,1,'',0,0,0),
(12792,258,231533,0,0,0,1,'',0,0,0),
(12792,259,231534,0,0,0,1,'',0,0,0),
(12792,260,231535,0,0,0,1,'',0,0,0),
(12792,261,231549,0,0,0,1,'',0,0,0),
(12792,262,231551,0,0,0,1,'',0,0,0),
(12792,263,231552,0,0,0,1,'',0,0,0),
(12792,264,231553,0,0,0,1,'',0,0,0),
(12792,265,231554,0,0,0,1,'',0,0,0),
(12792,266,231555,0,0,0,1,'',0,0,0),
(12792,267,231564,0,0,0,1,'',0,0,0),
(12792,268,231565,0,0,0,1,'',0,0,0),
(12792,269,231566,0,0,0,1,'',0,0,0),
(12792,270,231567,0,0,0,1,'',0,0,0),
(12792,271,231568,0,0,0,1,'',0,0,0),
(12792,272,231569,0,0,0,1,'',0,0,0),
(12792,273,231570,0,0,0,1,'',0,0,0),
(12792,274,231571,0,0,0,1,'',0,0,0),
(12792,275,231572,0,0,0,1,'',0,0,0),
(12792,276,231573,0,0,0,1,'',0,0,0),
(12792,277,231574,0,0,0,1,'',0,0,0),
(12792,278,231575,0,0,0,1,'',0,0,0),
(12792,279,231588,0,0,0,1,'',0,0,0),
(12792,280,231589,0,0,0,1,'',0,0,0),
(12792,281,231590,0,0,0,1,'',0,0,0),
(12792,282,231591,0,0,0,1,'',0,0,0),
(12792,283,231592,0,0,0,1,'',0,0,0),
(12792,284,231593,0,0,0,1,'',0,0,0),
(12792,285,231594,0,0,0,1,'',0,0,0),
(12792,286,231595,0,0,0,1,'',0,0,0),
(12792,287,231596,0,0,0,1,'',0,0,0),
(12792,288,231597,0,0,0,1,'',0,0,0),
(12792,289,231599,0,0,0,1,'',0,0,0),
(12792,290,231600,0,0,0,1,'',0,0,0),
(12792,291,231601,0,0,0,1,'',0,0,0),
(12792,292,231610,0,0,0,1,'',0,0,0),
(12792,293,231611,0,0,0,1,'',0,0,0),
(12792,294,231612,0,0,0,1,'',0,0,0),
(12792,295,231613,0,0,0,1,'',0,0,0),
(12792,296,231614,0,0,0,1,'',0,0,0),
(12792,297,231615,0,0,0,1,'',0,0,0),
(12792,298,231630,0,0,0,1,'',0,0,0),
(12792,299,231631,0,0,0,1,'',0,0,0),
(12792,300,231632,0,0,0,1,'',0,0,0),
(12792,301,231633,0,0,0,1,'',0,0,0),
(12792,302,231634,0,0,0,1,'',0,0,0),
(12792,303,231635,0,0,0,1,'',0,0,0),
(12792,304,231653,0,0,0,1,'',0,0,0),
(12792,305,231654,0,0,0,1,'',0,0,0),
(12792,306,231655,0,0,0,1,'',0,0,0),
(12792,307,231656,0,0,0,1,'',0,0,0),
(12792,308,231657,0,0,0,1,'',0,0,0),
(12792,309,231658,0,0,0,1,'',0,0,0),
(12792,310,231659,0,0,0,1,'',0,0,0),
(12792,311,231660,0,0,0,1,'',0,0,0),
(12792,312,231661,0,0,0,1,'',0,0,0),
(12792,313,231662,0,0,0,1,'',0,0,0),
(12792,314,231663,0,0,0,1,'',0,0,0),
(12792,315,231664,0,0,0,1,'',0,0,0),
(12792,316,231665,0,0,0,1,'',0,0,0),
(12792,317,231666,0,0,0,1,'',0,0,0),
(12792,318,231667,0,0,0,1,'',0,0,0),
(12792,319,231668,0,0,0,1,'',0,0,0),
(12792,320,231669,0,0,0,1,'',0,0,0),
(12792,321,231670,0,0,0,1,'',0,0,0),
(12792,322,231671,0,0,0,1,'',0,0,0),
(12792,323,231672,0,0,0,1,'',0,0,0),
(12792,324,231673,0,0,0,1,'',0,0,0),
(12792,325,231674,0,0,0,1,'',0,0,0),
(12792,326,231675,0,0,0,1,'',0,0,0),
(12792,327,231676,0,0,0,1,'',0,0,0),
(12792,328,231677,0,0,0,1,'',0,0,0),
(12792,329,231678,0,0,0,1,'',0,0,0),
(12792,330,231679,0,0,0,1,'',0,0,0),
(12792,331,231680,0,0,0,1,'',0,0,0),
(12792,332,231681,0,0,0,1,'',0,0,0),
(12792,333,231682,0,0,0,1,'',0,0,0),
(12792,334,231683,0,0,0,1,'',0,0,0),
(12792,335,231684,0,0,0,1,'',0,0,0),
(12792,336,231685,0,0,0,1,'',0,0,0),
(12792,337,231686,0,0,0,1,'',0,0,0),
(12792,338,231687,0,0,0,1,'',0,0,0),
(12792,339,231688,0,0,0,1,'',0,0,0);
-- 12793 Brave Stonehide: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=12793 AND `type`=1 AND `item` IN (272449,272450);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12793,5,272449,0,0,0,1,'',0,0,0),
(12793,6,272450,0,0,0,1,'',0,0,0);
-- 12795 First Sergeant Hola'mahi: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=12795 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12795,20,211779,0,0,0,1,'',0,0,0),
(12795,21,212160,0,0,0,1,'',0,0,0);
-- 12799 Sergeant Ba'sha: 28 items
DELETE FROM `npc_vendor` WHERE `entry`=12799 AND `type`=1 AND `item` IN (209619,209620,209621,209622,209623,209624,209625,209626,220800,220807,220830,220831,220835,220836,220840,220843,220845,220846,220857,220861,220863,220867,220881,220885,220898,220900,220908,220909);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12799,27,209619,0,0,0,1,'',0,0,0),
(12799,28,209620,0,0,0,1,'',0,0,0),
(12799,29,209621,0,0,0,1,'',0,0,0),
(12799,30,209622,0,0,0,1,'',0,0,0),
(12799,31,209623,0,0,0,1,'',0,0,0),
(12799,32,209624,0,0,0,1,'',0,0,0),
(12799,33,209625,0,0,0,1,'',0,0,0),
(12799,34,209626,0,0,0,1,'',0,0,0),
(12799,35,220800,0,0,0,1,'',0,0,0),
(12799,36,220807,0,0,0,1,'',0,0,0),
(12799,37,220830,0,0,0,1,'',0,0,0),
(12799,38,220831,0,0,0,1,'',0,0,0),
(12799,39,220835,0,0,0,1,'',0,0,0),
(12799,40,220836,0,0,0,1,'',0,0,0),
(12799,41,220840,0,0,0,1,'',0,0,0),
(12799,42,220843,0,0,0,1,'',0,0,0),
(12799,43,220845,0,0,0,1,'',0,0,0),
(12799,44,220846,0,0,0,1,'',0,0,0),
(12799,45,220857,0,0,0,1,'',0,0,0),
(12799,46,220861,0,0,0,1,'',0,0,0),
(12799,47,220863,0,0,0,1,'',0,0,0),
(12799,48,220867,0,0,0,1,'',0,0,0),
(12799,49,220881,0,0,0,1,'',0,0,0),
(12799,50,220885,0,0,0,1,'',0,0,0),
(12799,51,220898,0,0,0,1,'',0,0,0),
(12799,52,220900,0,0,0,1,'',0,0,0),
(12799,53,220908,0,0,0,1,'',0,0,0),
(12799,54,220909,0,0,0,1,'',0,0,0);
-- 12805 Officer Areyn: 28 items
DELETE FROM `npc_vendor` WHERE `entry`=12805 AND `type`=1 AND `item` IN (209611,209612,209613,209614,209615,209616,209617,209618,220799,220806,220811,220812,220814,220817,220829,220837,220856,220860,220862,220866,220880,220884,220890,220891,220895,220897,223076,223077);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12805,27,209611,0,0,0,1,'',0,0,0),
(12805,28,209612,0,0,0,1,'',0,0,0),
(12805,29,209613,0,0,0,1,'',0,0,0),
(12805,30,209614,0,0,0,1,'',0,0,0),
(12805,31,209615,0,0,0,1,'',0,0,0),
(12805,32,209616,0,0,0,1,'',0,0,0),
(12805,33,209617,0,0,0,1,'',0,0,0),
(12805,34,209618,0,0,0,1,'',0,0,0),
(12805,35,220799,0,0,0,1,'',0,0,0),
(12805,36,220806,0,0,0,1,'',0,0,0),
(12805,37,220811,0,0,0,1,'',0,0,0),
(12805,38,220812,0,0,0,1,'',0,0,0),
(12805,39,220814,0,0,0,1,'',0,0,0),
(12805,40,220817,0,0,0,1,'',0,0,0),
(12805,41,220829,0,0,0,1,'',0,0,0),
(12805,42,220837,0,0,0,1,'',0,0,0),
(12805,43,220856,0,0,0,1,'',0,0,0),
(12805,44,220860,0,0,0,1,'',0,0,0),
(12805,45,220862,0,0,0,1,'',0,0,0),
(12805,46,220866,0,0,0,1,'',0,0,0),
(12805,47,220880,0,0,0,1,'',0,0,0),
(12805,48,220884,0,0,0,1,'',0,0,0),
(12805,49,220890,0,0,0,1,'',0,0,0),
(12805,50,220891,0,0,0,1,'',0,0,0),
(12805,51,220895,0,0,0,1,'',0,0,0),
(12805,52,220897,0,0,0,1,'',0,0,0),
(12805,53,223076,0,0,0,1,'',0,0,0),
(12805,54,223077,0,0,0,1,'',0,0,0);
-- 12944 Lokhtos Darkbargainer: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=12944 AND `type`=1 AND `item` IN (228981,229008,229009);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12944,4,228981,0,0,0,1,'',0,0,0),
(12944,5,229008,0,0,0,1,'',0,0,0),
(12944,6,229009,0,0,0,1,'',0,0,0);
-- 12957 Blimo Gadgetspring: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=12957 AND `type`=1 AND `item` IN (227898);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12957,106,227898,0,0,0,1,'',0,0,0);
-- 12962 Wik'Tar: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=12962 AND `type`=1 AND `item` IN (273636);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(12962,113,273636,0,0,0,1,'',0,0,0);
-- 13278 Duke Hydraxis: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=13278 AND `type`=1 AND `item` IN (228979);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(13278,0,228979,0,0,0,1,'',0,0,0);
-- 13476 Balai Lok'Wein: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=13476 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(13476,6,211779,0,0,0,1,'',0,0,0),
(13476,7,212160,0,0,0,1,'',0,0,0);
-- 14371 Shen'dralar Provisioner: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=14371 AND `type`=1 AND `item` IN (228303);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(14371,1,228303,0,0,0,1,'',0,0,0);
-- 14581 Sergeant Thunderhorn: 26 items
DELETE FROM `npc_vendor` WHERE `entry`=14581 AND `type`=1 AND `item` IN (234542,234543,234545,234546,234547,234548,234549,234550,234551,234552,234553,234554,234555,234556,234557,234558,234559,234560,234561,234562,234563,234564,235474,235476,235477,235478);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(14581,22,234542,0,0,0,1,'',0,0,0),
(14581,23,234543,0,0,0,1,'',0,0,0),
(14581,24,234545,0,0,0,1,'',0,0,0),
(14581,25,234546,0,0,0,1,'',0,0,0),
(14581,26,234547,0,0,0,1,'',0,0,0),
(14581,27,234548,0,0,0,1,'',0,0,0),
(14581,28,234549,0,0,0,1,'',0,0,0),
(14581,29,234550,0,0,0,1,'',0,0,0),
(14581,30,234551,0,0,0,1,'',0,0,0),
(14581,31,234552,0,0,0,1,'',0,0,0),
(14581,32,234553,0,0,0,1,'',0,0,0),
(14581,33,234554,0,0,0,1,'',0,0,0),
(14581,34,234555,0,0,0,1,'',0,0,0),
(14581,35,234556,0,0,0,1,'',0,0,0),
(14581,36,234557,0,0,0,1,'',0,0,0),
(14581,37,234558,0,0,0,1,'',0,0,0),
(14581,38,234559,0,0,0,1,'',0,0,0),
(14581,39,234560,0,0,0,1,'',0,0,0),
(14581,40,234561,0,0,0,1,'',0,0,0),
(14581,41,234562,0,0,0,1,'',0,0,0),
(14581,42,234563,0,0,0,1,'',0,0,0),
(14581,43,234564,0,0,0,1,'',0,0,0),
(14581,44,235474,0,0,0,1,'',0,0,0),
(14581,45,235476,0,0,0,1,'',0,0,0),
(14581,46,235477,0,0,0,1,'',0,0,0),
(14581,47,235478,0,0,0,1,'',0,0,0);
-- 14738 Otho Moji'ko: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=14738 AND `type`=1 AND `item` IN (272941);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(14738,6,272941,0,0,0,1,'',0,0,0);
-- 14739 Mystic Yayo'jin: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=14739 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(14739,1,211779,0,0,0,1,'',0,0,0),
(14739,2,212160,0,0,0,1,'',0,0,0);
-- 14753 Illiyana Moonblaze: 14 items
DELETE FROM `npc_vendor` WHERE `entry`=14753 AND `type`=1 AND `item` IN (211498,211500,211856,211857,212580,212581,212582,212583,237814,237815,237817,237818,237819,237825);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(14753,1074,211498,0,0,0,1,'',0,0,0),
(14753,1075,211500,0,0,0,1,'',0,0,0),
(14753,1076,211856,0,0,0,1,'',0,0,0),
(14753,1077,211857,0,0,0,1,'',0,0,0),
(14753,1078,212580,0,0,0,1,'',0,0,0),
(14753,1079,212581,0,0,0,1,'',0,0,0),
(14753,1080,212582,0,0,0,1,'',0,0,0),
(14753,1081,212583,0,0,0,1,'',0,0,0),
(14753,1082,237814,0,0,0,1,'',0,0,0),
(14753,1083,237815,0,0,0,1,'',0,0,0),
(14753,1084,237817,0,0,0,1,'',0,0,0),
(14753,1085,237818,0,0,0,1,'',0,0,0),
(14753,1086,237819,0,0,0,1,'',0,0,0),
(14753,1087,237825,0,0,0,1,'',0,0,0);
-- 14754 Kelm Hargunth: 8 items
DELETE FROM `npc_vendor` WHERE `entry`=14754 AND `type`=1 AND `item` IN (211499,211500,211856,211857,212584,212585,212586,212587);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(14754,1074,211499,0,0,0,1,'',0,0,0),
(14754,1075,211500,0,0,0,1,'',0,0,0),
(14754,1076,211856,0,0,0,1,'',0,0,0),
(14754,1077,211857,0,0,0,1,'',0,0,0),
(14754,1078,212584,0,0,0,1,'',0,0,0),
(14754,1079,212585,0,0,0,1,'',0,0,0),
(14754,1080,212586,0,0,0,1,'',0,0,0),
(14754,1081,212587,0,0,0,1,'',0,0,0);
-- 14921 Rin'wosho the Trader: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=14921 AND `type`=1 AND `item` IN (232610);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(14921,1,232610,0,0,0,1,'',0,0,0);
-- 15078 Jang: 8 items
DELETE FROM `npc_vendor` WHERE `entry`=15078 AND `type`=1 AND `item` IN (274974,276272,276273,276274,276275,276278,276279,276280);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(15078,1,274974,0,0,11646,1,'',0,0,0),
(15078,2,276272,0,0,11642,1,'',0,0,0),
(15078,3,276273,0,0,11642,1,'',0,0,0),
(15078,4,276274,0,0,11642,1,'',0,0,0),
(15078,5,276275,0,0,11642,1,'',0,0,0),
(15078,6,276278,0,0,11643,1,'',0,0,0),
(15078,7,276279,0,0,11644,1,'',0,0,0),
(15078,8,276280,0,0,11645,1,'',0,0,0);
-- 15175 Khur Hornstriker: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=15175 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(15175,1,211779,0,0,0,1,'',0,0,0),
(15175,2,212160,0,0,0,1,'',0,0,0);
-- 15176 Vargus: 6 items
DELETE FROM `npc_vendor` WHERE `entry`=15176 AND `type`=1 AND `item` IN (275598,275599,275600,275601,275602,275603);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(15176,1,275598,0,0,0,1,'',0,0,0),
(15176,2,275599,0,0,0,1,'',0,0,0),
(15176,3,275600,0,0,0,1,'',0,0,0),
(15176,4,275601,0,0,0,1,'',0,0,0),
(15176,5,275602,0,0,0,1,'',0,0,0),
(15176,6,275603,0,0,0,1,'',0,0,0);
-- 15179 Mishta: 6 items
DELETE FROM `npc_vendor` WHERE `entry`=15179 AND `type`=1 AND `item` IN (275580,275581,275582,275583,275584,275585);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(15179,106,275580,0,0,0,1,'',0,0,0),
(15179,107,275581,0,0,0,1,'',0,0,0),
(15179,108,275582,0,0,0,1,'',0,0,0),
(15179,109,275583,0,0,0,1,'',0,0,0),
(15179,110,275584,0,0,0,1,'',0,0,0),
(15179,111,275585,0,0,0,1,'',0,0,0);
-- 15192 Anachronos: 35 items
DELETE FROM `npc_vendor` WHERE `entry`=15192 AND `type`=1 AND `item` IN (234016,234017,234018,234019,234020,234021,234022,234023,234024,234025,234026,234027,234028,234029,234030,234031,234032,234033,234034,234035,234198,234199,234200,234201,234202,234436,234437,234438,234439,234440,234964,234965,234966,234967,234968);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(15192,0,234016,0,0,9851,1,'',0,0,0),
(15192,1,234017,0,0,9871,1,'',0,0,0),
(15192,2,234018,0,0,9876,1,'',0,0,0),
(15192,3,234019,0,0,9866,1,'',0,0,0),
(15192,4,234020,0,0,9852,1,'',0,0,0),
(15192,5,234021,0,0,9872,1,'',0,0,0),
(15192,6,234022,0,0,9877,1,'',0,0,0),
(15192,7,234023,0,0,9867,1,'',0,0,0),
(15192,8,234024,0,0,9853,1,'',0,0,0),
(15192,9,234025,0,0,9868,1,'',0,0,0),
(15192,10,234026,0,0,9873,1,'',0,0,0),
(15192,11,234027,0,0,9878,1,'',0,0,0),
(15192,12,234028,0,0,9854,1,'',0,0,0),
(15192,13,234029,0,0,9869,1,'',0,0,0),
(15192,14,234030,0,0,9874,1,'',0,0,0),
(15192,15,234031,0,0,9879,1,'',0,0,0),
(15192,16,234032,0,0,9855,1,'',0,0,0),
(15192,17,234033,0,0,9870,1,'',0,0,0),
(15192,18,234034,0,0,9875,1,'',0,0,0),
(15192,19,234035,0,0,9880,1,'',0,0,0),
(15192,20,234198,0,0,9846,1,'',0,0,0),
(15192,21,234199,0,0,9847,1,'',0,0,0),
(15192,22,234200,0,0,9848,1,'',0,0,0),
(15192,23,234201,0,0,9849,1,'',0,0,0),
(15192,24,234202,0,0,9850,1,'',0,0,0),
(15192,25,234436,0,0,9865,1,'',0,0,0),
(15192,26,234437,0,0,9864,1,'',0,0,0),
(15192,27,234438,0,0,9863,1,'',0,0,0),
(15192,28,234439,0,0,9862,1,'',0,0,0),
(15192,29,234440,0,0,9861,1,'',0,0,0),
(15192,30,234964,0,0,9860,1,'',0,0,0),
(15192,31,234965,0,0,9859,1,'',0,0,0),
(15192,32,234966,0,0,9858,1,'',0,0,0),
(15192,33,234967,0,0,9857,1,'',0,0,0),
(15192,34,234968,0,0,9856,1,'',0,0,0);
-- 15282 Aurel Goldleaf: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=15282 AND `type`=1 AND `item` IN (233200,233250);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(15282,0,233200,0,0,9650,1,'',0,0,0),
(15282,1,233250,0,0,9651,1,'',0,0,0);
-- 15419 Kania: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=15419 AND `type`=1 AND `item` IN (247786,234271,234272);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(15419,1010,247786,0,0,0,1,'',0,0,0),
(15419,1011,234271,0,0,0,1,'',0,0,0),
(15419,1012,234272,0,0,0,1,'',0,0,0);
-- 16015 Vi'el: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=16015 AND `type`=1 AND `item` IN (211779,212160);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(16015,1,211779,0,0,0,1,'',0,0,0),
(16015,2,212160,0,0,0,1,'',0,0,0);
-- 17068 Chief Expeditionary Requisitioner Enkles: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=17068 AND `type`=1 AND `item` IN (232434,232437,232443);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(17068,0,232434,0,0,0,1,'',0,0,0),
(17068,1,232437,0,0,0,1,'',0,0,0),
(17068,2,232443,0,0,0,1,'',0,0,0);
-- 17070 Apothecary Quinard: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=17070 AND `type`=1 AND `item` IN (232434,232437,232443);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(17070,0,232434,0,0,0,1,'',0,0,0),
(17070,1,232437,0,0,0,1,'',0,0,0),
(17070,2,232443,0,0,0,1,'',0,0,0);
-- 28776 Elizabeth Ross: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=28776 AND `type`=1 AND `item` IN (285327);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(28776,0,285327,0,0,0,1,'',0,0,0);
-- 29547 Applebough: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=29547 AND `type`=1 AND `item` IN (285359);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(29547,0,285359,0,0,0,1,'',0,0,0);
-- 32287 Archmage Alvareaux: 9 items
DELETE FROM `npc_vendor` WHERE `entry`=32287 AND `type`=1 AND `item` IN (276984,276985,276986,276987,276988,276989,276990,276991,285327);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(32287,0,276984,0,0,0,1,'',0,0,0),
(32287,0,276985,0,0,0,1,'',0,0,0),
(32287,0,276986,0,0,0,1,'',0,0,0),
(32287,0,276987,0,0,0,1,'',0,0,0),
(32287,0,276988,0,0,0,1,'',0,0,0),
(32287,0,276989,0,0,0,1,'',0,0,0),
(32287,0,276990,0,0,0,1,'',0,0,0),
(32287,0,276991,0,0,0,1,'',0,0,0),
(32287,0,285327,0,0,0,1,'',0,0,0);
-- 32337 Christi Stockton: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=32337 AND `type`=1 AND `item` IN (260631,285362);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(32337,0,260631,0,0,0,1,'',0,0,0),
(32337,0,285362,0,0,0,1,'',0,0,0);
-- 230317 Mokvar: 144 items
DELETE FROM `npc_vendor` WHERE `entry`=230317 AND `type`=1 AND `item` IN (226772,226773,226774,226775,226776,226777,226778,226779,226780,226781,226782,226783,226784,226785,226786,226787,226788,226789,226790,226791,226792,226793,226794,226795,226796,226797,226798,226799,226801,226802,226803,226804,226825,226826,226827,226828,226829,226830,226831,226832,226857,226858,226859,226860,226861,226862,226863,226864,226865,226866,226867,226868,226869,226870,226871,226872,226881,226882,226883,226884,226885,226886,226887,226888,226905,226906,226907,226908,226909,226910,226911,226912,226929,226930,226931,226932,226933,226934,226935,226936,226945,226946,226947,226948,226949,226950,226951,226952,226953,226954,226955,226956,226957,226958,226959,226960,226969,226970,226971,226972,226973,226974,226975,226976,226977,226978,226979,226980,226981,226982,226983,226984,226985,226986,226987,226988,226989,226990,226991,226992,227001,227002,227003,227004,227005,227006,227007,227008,227009,227010,227011,227012,227013,227014,227015,227016,227017,227018,227019,227020,227021,227022,227023,227024);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(230317,0,226772,0,0,0,1,'',0,0,0),
(230317,1,226773,0,0,0,1,'',0,0,0),
(230317,2,226774,0,0,0,1,'',0,0,0),
(230317,3,226775,0,0,0,1,'',0,0,0),
(230317,4,226776,0,0,0,1,'',0,0,0),
(230317,5,226777,0,0,0,1,'',0,0,0),
(230317,6,226778,0,0,0,1,'',0,0,0),
(230317,7,226779,0,0,0,1,'',0,0,0),
(230317,8,226780,0,0,0,1,'',0,0,0),
(230317,9,226781,0,0,0,1,'',0,0,0),
(230317,10,226782,0,0,0,1,'',0,0,0),
(230317,11,226783,0,0,0,1,'',0,0,0),
(230317,12,226784,0,0,0,1,'',0,0,0),
(230317,13,226785,0,0,0,1,'',0,0,0),
(230317,14,226786,0,0,0,1,'',0,0,0),
(230317,15,226787,0,0,0,1,'',0,0,0),
(230317,16,226788,0,0,0,1,'',0,0,0),
(230317,17,226789,0,0,0,1,'',0,0,0),
(230317,18,226790,0,0,0,1,'',0,0,0),
(230317,19,226791,0,0,0,1,'',0,0,0),
(230317,20,226792,0,0,0,1,'',0,0,0),
(230317,21,226793,0,0,0,1,'',0,0,0),
(230317,22,226794,0,0,0,1,'',0,0,0),
(230317,23,226795,0,0,0,1,'',0,0,0),
(230317,24,226796,0,0,0,1,'',0,0,0),
(230317,25,226797,0,0,0,1,'',0,0,0),
(230317,26,226798,0,0,0,1,'',0,0,0),
(230317,27,226799,0,0,0,1,'',0,0,0),
(230317,28,226801,0,0,0,1,'',0,0,0),
(230317,29,226802,0,0,0,1,'',0,0,0),
(230317,30,226803,0,0,0,1,'',0,0,0),
(230317,31,226804,0,0,0,1,'',0,0,0),
(230317,32,226825,0,0,0,1,'',0,0,0),
(230317,33,226826,0,0,0,1,'',0,0,0),
(230317,34,226827,0,0,0,1,'',0,0,0),
(230317,35,226828,0,0,0,1,'',0,0,0),
(230317,36,226829,0,0,0,1,'',0,0,0),
(230317,37,226830,0,0,0,1,'',0,0,0),
(230317,38,226831,0,0,0,1,'',0,0,0),
(230317,39,226832,0,0,0,1,'',0,0,0),
(230317,40,226857,0,0,0,1,'',0,0,0),
(230317,41,226858,0,0,0,1,'',0,0,0),
(230317,42,226859,0,0,0,1,'',0,0,0),
(230317,43,226860,0,0,0,1,'',0,0,0),
(230317,44,226861,0,0,0,1,'',0,0,0),
(230317,45,226862,0,0,0,1,'',0,0,0),
(230317,46,226863,0,0,0,1,'',0,0,0),
(230317,47,226864,0,0,0,1,'',0,0,0),
(230317,48,226865,0,0,0,1,'',0,0,0),
(230317,49,226866,0,0,0,1,'',0,0,0),
(230317,50,226867,0,0,0,1,'',0,0,0),
(230317,51,226868,0,0,0,1,'',0,0,0),
(230317,52,226869,0,0,0,1,'',0,0,0),
(230317,53,226870,0,0,0,1,'',0,0,0),
(230317,54,226871,0,0,0,1,'',0,0,0),
(230317,55,226872,0,0,0,1,'',0,0,0),
(230317,56,226881,0,0,0,1,'',0,0,0),
(230317,57,226882,0,0,0,1,'',0,0,0),
(230317,58,226883,0,0,0,1,'',0,0,0),
(230317,59,226884,0,0,0,1,'',0,0,0),
(230317,60,226885,0,0,0,1,'',0,0,0),
(230317,61,226886,0,0,0,1,'',0,0,0),
(230317,62,226887,0,0,0,1,'',0,0,0),
(230317,63,226888,0,0,0,1,'',0,0,0),
(230317,64,226905,0,0,0,1,'',0,0,0),
(230317,65,226906,0,0,0,1,'',0,0,0),
(230317,66,226907,0,0,0,1,'',0,0,0),
(230317,67,226908,0,0,0,1,'',0,0,0),
(230317,68,226909,0,0,0,1,'',0,0,0),
(230317,69,226910,0,0,0,1,'',0,0,0),
(230317,70,226911,0,0,0,1,'',0,0,0),
(230317,71,226912,0,0,0,1,'',0,0,0),
(230317,72,226929,0,0,0,1,'',0,0,0),
(230317,73,226930,0,0,0,1,'',0,0,0),
(230317,74,226931,0,0,0,1,'',0,0,0),
(230317,75,226932,0,0,0,1,'',0,0,0),
(230317,76,226933,0,0,0,1,'',0,0,0),
(230317,77,226934,0,0,0,1,'',0,0,0),
(230317,78,226935,0,0,0,1,'',0,0,0),
(230317,79,226936,0,0,0,1,'',0,0,0),
(230317,80,226945,0,0,0,1,'',0,0,0),
(230317,81,226946,0,0,0,1,'',0,0,0),
(230317,82,226947,0,0,0,1,'',0,0,0),
(230317,83,226948,0,0,0,1,'',0,0,0),
(230317,84,226949,0,0,0,1,'',0,0,0),
(230317,85,226950,0,0,0,1,'',0,0,0),
(230317,86,226951,0,0,0,1,'',0,0,0),
(230317,87,226952,0,0,0,1,'',0,0,0),
(230317,88,226953,0,0,0,1,'',0,0,0),
(230317,89,226954,0,0,0,1,'',0,0,0),
(230317,90,226955,0,0,0,1,'',0,0,0),
(230317,91,226956,0,0,0,1,'',0,0,0),
(230317,92,226957,0,0,0,1,'',0,0,0),
(230317,93,226958,0,0,0,1,'',0,0,0),
(230317,94,226959,0,0,0,1,'',0,0,0),
(230317,95,226960,0,0,0,1,'',0,0,0),
(230317,96,226969,0,0,0,1,'',0,0,0),
(230317,97,226970,0,0,0,1,'',0,0,0),
(230317,98,226971,0,0,0,1,'',0,0,0),
(230317,99,226972,0,0,0,1,'',0,0,0),
(230317,100,226973,0,0,0,1,'',0,0,0),
(230317,101,226974,0,0,0,1,'',0,0,0),
(230317,102,226975,0,0,0,1,'',0,0,0),
(230317,103,226976,0,0,0,1,'',0,0,0),
(230317,104,226977,0,0,0,1,'',0,0,0),
(230317,105,226978,0,0,0,1,'',0,0,0),
(230317,106,226979,0,0,0,1,'',0,0,0),
(230317,107,226980,0,0,0,1,'',0,0,0),
(230317,108,226981,0,0,0,1,'',0,0,0),
(230317,109,226982,0,0,0,1,'',0,0,0),
(230317,110,226983,0,0,0,1,'',0,0,0),
(230317,111,226984,0,0,0,1,'',0,0,0),
(230317,112,226985,0,0,0,1,'',0,0,0),
(230317,113,226986,0,0,0,1,'',0,0,0),
(230317,114,226987,0,0,0,1,'',0,0,0),
(230317,115,226988,0,0,0,1,'',0,0,0),
(230317,116,226989,0,0,0,1,'',0,0,0),
(230317,117,226990,0,0,0,1,'',0,0,0),
(230317,118,226991,0,0,0,1,'',0,0,0),
(230317,119,226992,0,0,0,1,'',0,0,0),
(230317,120,227001,0,0,0,1,'',0,0,0),
(230317,121,227002,0,0,0,1,'',0,0,0),
(230317,122,227003,0,0,0,1,'',0,0,0),
(230317,123,227004,0,0,0,1,'',0,0,0),
(230317,124,227005,0,0,0,1,'',0,0,0),
(230317,125,227006,0,0,0,1,'',0,0,0),
(230317,126,227007,0,0,0,1,'',0,0,0),
(230317,127,227008,0,0,0,1,'',0,0,0),
(230317,128,227009,0,0,0,1,'',0,0,0),
(230317,129,227010,0,0,0,1,'',0,0,0),
(230317,130,227011,0,0,0,1,'',0,0,0),
(230317,131,227012,0,0,0,1,'',0,0,0),
(230317,132,227013,0,0,0,1,'',0,0,0),
(230317,133,227014,0,0,0,1,'',0,0,0),
(230317,134,227015,0,0,0,1,'',0,0,0),
(230317,135,227016,0,0,0,1,'',0,0,0),
(230317,136,227017,0,0,0,1,'',0,0,0),
(230317,137,227018,0,0,0,1,'',0,0,0),
(230317,138,227019,0,0,0,1,'',0,0,0),
(230317,139,227020,0,0,0,1,'',0,0,0),
(230317,140,227021,0,0,0,1,'',0,0,0),
(230317,141,227022,0,0,0,1,'',0,0,0),
(230317,142,227023,0,0,0,1,'',0,0,0),
(230317,143,227024,0,0,0,1,'',0,0,0);
-- 248200 Fizzlefuse: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=248200 AND `type`=1 AND `item` IN (264221,264222);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(248200,0,264221,0,0,0,1,'',0,0,0),
(248200,0,264222,0,0,0,1,'',0,0,0);
-- 251973 Dominique Stefano: 17 items
DELETE FROM `npc_vendor` WHERE `entry`=251973 AND `type`=1 AND `item` IN (2320,2321,2324,2325,2604,2605,4291,4340,4341,4342,6260,6261,8343,10290,14341,253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(251973,0,2320,0,0,0,1,'',0,0,0),
(251973,0,2321,0,0,0,1,'',0,0,0),
(251973,0,2324,0,0,0,1,'',0,0,0),
(251973,0,2325,0,0,0,1,'',0,0,0),
(251973,0,2604,0,0,0,1,'',0,0,0),
(251973,0,2605,0,0,0,1,'',0,0,0),
(251973,0,4291,0,0,0,1,'',0,0,0),
(251973,0,4340,0,0,0,1,'',0,0,0),
(251973,0,4341,0,0,0,1,'',0,0,0),
(251973,0,4342,0,0,0,1,'',0,0,0),
(251973,0,6260,0,0,0,1,'',0,0,0),
(251973,0,6261,0,0,0,1,'',0,0,0),
(251973,0,8343,0,0,0,1,'',0,0,0),
(251973,0,10290,0,0,0,1,'',0,0,0),
(251973,0,14341,0,0,0,1,'',0,0,0),
(251973,0,253665,0,0,0,1,'',0,0,0),
(251973,0,253668,0,0,0,1,'',0,0,0);
-- 251975 Harold Winston: 6 items
DELETE FROM `npc_vendor` WHERE `entry`=251975 AND `type`=1 AND `item` IN (7337,7338,7339,7340,7341,7342);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(251975,0,7337,0,0,0,1,'',0,0,0),
(251975,0,7338,0,0,0,1,'',0,0,0),
(251975,0,7339,0,0,0,1,'',0,0,0),
(251975,0,7340,0,0,0,1,'',0,0,0),
(251975,0,7341,0,0,0,1,'',0,0,0),
(251975,0,7342,0,0,0,1,'',0,0,0);
-- 251976 Tiffany Cartier: 6 items
DELETE FROM `npc_vendor` WHERE `entry`=251976 AND `type`=1 AND `item` IN (7337,7338,7339,7340,7341,7342);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(251976,0,7337,0,0,0,1,'',0,0,0),
(251976,0,7338,0,0,0,1,'',0,0,0),
(251976,0,7339,0,0,0,1,'',0,0,0),
(251976,0,7340,0,0,0,1,'',0,0,0),
(251976,0,7341,0,0,0,1,'',0,0,0),
(251976,0,7342,0,0,0,1,'',0,0,0);
-- 251980 Rueben Lauren: 14 items
DELETE FROM `npc_vendor` WHERE `entry`=251980 AND `type`=1 AND `item` IN (2429,2431,2432,2434,2435,2437,2438,2440,3587,3588,3593,3594,3889,3892);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(251980,0,2429,0,0,0,1,'',0,0,0),
(251980,0,2431,0,0,0,1,'',0,0,0),
(251980,0,2432,0,0,0,1,'',0,0,0),
(251980,0,2434,0,0,0,1,'',0,0,0),
(251980,0,2435,0,0,0,1,'',0,0,0),
(251980,0,2437,0,0,0,1,'',0,0,0),
(251980,0,2438,0,0,0,1,'',0,0,0),
(251980,0,2440,0,0,0,1,'',0,0,0),
(251980,0,3587,0,0,0,1,'',0,0,0),
(251980,0,3588,0,0,0,1,'',0,0,0),
(251980,0,3593,0,0,0,1,'',0,0,0),
(251980,0,3594,0,0,0,1,'',0,0,0),
(251980,0,3889,0,0,0,1,'',0,0,0),
(251980,0,3892,0,0,0,1,'',0,0,0);
-- 251981 Sheddle Glossgleam: 9 items
DELETE FROM `npc_vendor` WHERE `entry`=251981 AND `type`=1 AND `item` IN (202,792,840,2117,2149,2467,2959,2971,9743);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(251981,0,202,0,0,0,1,'',0,0,0),
(251981,0,792,0,0,0,1,'',0,0,0),
(251981,0,840,0,0,0,1,'',0,0,0),
(251981,0,2117,0,0,0,1,'',0,0,0),
(251981,0,2149,0,0,0,1,'',0,0,0),
(251981,0,2467,0,0,0,1,'',0,0,0),
(251981,0,2959,0,0,0,1,'',0,0,0),
(251981,0,2971,0,0,0,1,'',0,0,0),
(251981,0,9743,0,0,0,1,'',0,0,0);
-- 251997 Norvin Alderman: 5 items
DELETE FROM `npc_vendor` WHERE `entry`=251997 AND `type`=1 AND `item` IN (4662,4683,7087,7089,9754);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(251997,0,4662,0,0,0,1,'',0,0,0),
(251997,0,4683,0,0,0,1,'',0,0,0),
(251997,0,7087,0,0,0,1,'',0,0,0),
(251997,0,7089,0,0,0,1,'',0,0,0),
(251997,0,9754,0,0,0,1,'',0,0,0);
-- 252040 Hagatha Moorehead: 17 items
DELETE FROM `npc_vendor` WHERE `entry`=252040 AND `type`=1 AND `item` IN (5565,16583,17020,17021,17026,17028,17029,17030,17031,17032,17033,17034,17035,17036,17037,17038,21177);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(252040,0,5565,0,0,0,1,'',0,0,0),
(252040,0,16583,0,0,0,1,'',0,0,0),
(252040,0,17020,0,0,0,1,'',0,0,0),
(252040,0,17021,0,0,0,1,'',0,0,0),
(252040,0,17026,0,0,0,1,'',0,0,0),
(252040,0,17028,0,0,0,1,'',0,0,0),
(252040,0,17029,0,0,0,1,'',0,0,0),
(252040,0,17030,0,0,0,1,'',0,0,0),
(252040,0,17031,0,0,0,1,'',0,0,0),
(252040,0,17032,0,0,0,1,'',0,0,0),
(252040,0,17033,0,0,0,1,'',0,0,0),
(252040,0,17034,0,0,0,1,'',0,0,0),
(252040,0,17035,0,0,0,1,'',0,0,0),
(252040,0,17036,0,0,0,1,'',0,0,0),
(252040,0,17037,0,0,0,1,'',0,0,0),
(252040,0,17038,0,0,0,1,'',0,0,0),
(252040,0,21177,0,0,0,1,'',0,0,0);
-- 256372 Windle Sparkshine: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=256372 AND `type`=1 AND `item` IN (285104);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(256372,0,285104,0,0,0,1,'',0,0,0);
-- 256384 Gishah: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=256384 AND `type`=1 AND `item` IN (262764,270887,284664);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(256384,0,262764,0,0,0,1,'',0,0,0),
(256384,0,270887,0,0,0,1,'',0,0,0),
(256384,0,284664,0,0,0,1,'',0,0,0);
-- 256672 Kurvelk Shadowhoof: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=256672 AND `type`=1 AND `item` IN (262896,262902);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(256672,0,262896,0,0,0,1,'',0,0,0),
(256672,1,262902,0,0,0,1,'',0,0,0);
-- 258415 Angela Ward: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=258415 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(258415,0,253665,0,0,0,1,'',0,0,0),
(258415,0,253668,0,0,0,1,'',0,0,0);
-- 258463 Darah: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=258463 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(258463,0,253665,0,0,0,1,'',0,0,0),
(258463,0,253668,0,0,0,1,'',0,0,0);
-- 258568 Antonio Bolero: 2 items
DELETE FROM `npc_vendor` WHERE `entry`=258568 AND `type`=1 AND `item` IN (253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(258568,0,253665,0,0,0,1,'',0,0,0),
(258568,0,253668,0,0,0,1,'',0,0,0);
-- 265730 Ajay Green: 24 items
DELETE FROM `npc_vendor` WHERE `entry`=265730 AND `type`=1 AND `item` IN (159,414,422,1179,1205,1645,1707,1708,2070,3927,4536,4537,4538,4539,4540,4541,4542,4544,4601,4602,8766,8932,8950,8953);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(265730,0,159,0,0,0,1,'',0,0,0),
(265730,0,414,0,0,0,1,'',0,0,0),
(265730,0,422,0,0,0,1,'',0,0,0),
(265730,0,1179,0,0,0,1,'',0,0,0),
(265730,0,1205,0,0,0,1,'',0,0,0),
(265730,0,1645,0,0,0,1,'',0,0,0),
(265730,0,1707,0,0,0,1,'',0,0,0),
(265730,0,1708,0,0,0,1,'',0,0,0),
(265730,0,2070,0,0,0,1,'',0,0,0),
(265730,0,3927,0,0,0,1,'',0,0,0),
(265730,0,4536,0,0,0,1,'',0,0,0),
(265730,0,4537,0,0,0,1,'',0,0,0),
(265730,0,4538,0,0,0,1,'',0,0,0),
(265730,0,4539,0,0,0,1,'',0,0,0),
(265730,0,4540,0,0,0,1,'',0,0,0),
(265730,0,4541,0,0,0,1,'',0,0,0),
(265730,0,4542,0,0,0,1,'',0,0,0),
(265730,0,4544,0,0,0,1,'',0,0,0),
(265730,0,4601,0,0,0,1,'',0,0,0),
(265730,0,4602,0,0,0,1,'',0,0,0),
(265730,0,8766,0,0,0,1,'',0,0,0),
(265730,0,8932,0,0,0,1,'',0,0,0),
(265730,0,8950,0,0,0,1,'',0,0,0),
(265730,0,8953,0,0,0,1,'',0,0,0);
-- 267336 Brighid Stormflayer: 4 items
DELETE FROM `npc_vendor` WHERE `entry`=267336 AND `type`=1 AND `item` IN (2320,4289,7005,277114);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(267336,0,2320,0,0,0,1,'',0,0,0),
(267336,0,4289,0,0,0,1,'',0,0,0),
(267336,0,7005,0,0,0,1,'',0,0,0),
(267336,0,277114,0,0,0,1,'',0,0,0);
-- 267337 Sally Swiftwrench: 3 items
DELETE FROM `npc_vendor` WHERE `entry`=267337 AND `type`=1 AND `item` IN (2901,5956,277115);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(267337,0,2901,0,0,0,1,'',0,0,0),
(267337,0,5956,0,0,0,1,'',0,0,0),
(267337,0,277115,0,0,0,1,'',0,0,0);
-- 268745 Mayhoa Skyhoof: 1 items
DELETE FROM `npc_vendor` WHERE `entry`=268745 AND `type`=1 AND `item` IN (277508);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(268745,0,277508,0,0,0,1,'',0,0,0);
-- 272045 Brother Zendraas: 24 items
DELETE FROM `npc_vendor` WHERE `entry`=272045 AND `type`=1 AND `item` IN (277056,277057,277058,277059,277060,277061,277062,277063,277064,277065,277066,277067,277068,277069,277070,277071,277072,277073,277074,277075,277076,277077,277078,277079);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(272045,1,277056,0,0,11754,1,'',0,0,0),
(272045,2,277057,0,0,11752,1,'',0,0,0),
(272045,3,277058,0,0,11753,1,'',0,0,0),
(272045,4,277059,0,0,11752,1,'',0,0,0),
(272045,5,277060,0,0,11754,1,'',0,0,0),
(272045,6,277061,0,0,11753,1,'',0,0,0),
(272045,7,277062,0,0,11754,1,'',0,0,0),
(272045,8,277063,0,0,11752,1,'',0,0,0),
(272045,9,277064,0,0,11753,1,'',0,0,0),
(272045,10,277065,0,0,11752,1,'',0,0,0),
(272045,11,277066,0,0,11754,1,'',0,0,0),
(272045,12,277067,0,0,11753,1,'',0,0,0),
(272045,13,277068,0,0,11754,1,'',0,0,0),
(272045,14,277069,0,0,11752,1,'',0,0,0),
(272045,15,277070,0,0,11753,1,'',0,0,0),
(272045,16,277071,0,0,11752,1,'',0,0,0),
(272045,17,277072,0,0,11754,1,'',0,0,0),
(272045,18,277073,0,0,11753,1,'',0,0,0),
(272045,19,277074,0,0,11754,1,'',0,0,0),
(272045,20,277075,0,0,11752,1,'',0,0,0),
(272045,21,277076,0,0,11753,1,'',0,0,0),
(272045,22,277077,0,0,11752,1,'',0,0,0),
(272045,23,277078,0,0,11754,1,'',0,0,0),
(272045,24,277079,0,0,11753,1,'',0,0,0);
-- These NPCs sell the items above but had no vendor flag.
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=1440; -- Milton Sheaf
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=3605; -- Nadyia Maneweaver
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=4047; -- Zor Lonetree
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=11036; -- Leonid Barthalomew the Revered
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=13278; -- Duke Hydraxis
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=15078; -- Jang
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=15192; -- Anachronos
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=15282; -- Aurel Goldleaf
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=17068; -- Chief Expeditionary Requisitioner Enkles
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=17070; -- Apothecary Quinard
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=230317; -- Mokvar
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=256672; -- Kurvelk Shadowhoof
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=272045; -- Brother Zendraas
