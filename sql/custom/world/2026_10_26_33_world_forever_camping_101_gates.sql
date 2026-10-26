-- Camping 101 in Durotar (Brakk), Mulgore (Kaga Wildhoof) and Teldrassil (Lyreena Duskblade), added in 2026_10_26_32 from the
-- AnoCore data, had no objective and no gate: every hub quest was offered to everyone at once and completed by just talking
-- to the trainer. The other four hubs (sniffed) ask to raise the profession to 20 through a "Camp Training" criteria tree
-- and are only offered after The Great Outdoors to characters who know the profession, Cooking after The Great Outdoors.
-- Same here: one objective per quest on the hub's own tree from the 70532 CriteriaTree.db2 (Durotar 231021-231054,
-- Mulgore 231088-231106, Teldrassil 231110-231128; the core maps one objective per tree), copied from the Elwynn quest
-- of the same profession, plus the gates.
-- INFERRED: the Cooking trees (any unused "Learn cooking" tree: Durotar 231025 in its block, Mulgore 227879, Teldrassil
-- 227868), and The Great Outdoors following The Adventurer of the hub (whose turn-in is the hub's adventurer), as in
-- the other four hubs. Mulgore Engineering (97930) is on the Forever list but in neither database; it waits for its page.

-- Durotar
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`) VALUES (96604,96652) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`); -- The Great Outdoors
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (96102,96604,197,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Tailoring
DELETE FROM `quest_objectives` WHERE `QuestID`=96655;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=96626;
UPDATE `tmp_campo` SET `ID`=9665500, `QuestID`=96655, `ObjectID`=231025, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (96655,96604,0,0) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Cooking
DELETE FROM `quest_objectives` WHERE `QuestID`=97899;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97915;
UPDATE `tmp_campo` SET `ID`=9789900, `QuestID`=97899, `ObjectID`=231021, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97899,96604,171,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Alchemy
DELETE FROM `quest_objectives` WHERE `QuestID`=97900;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97916;
UPDATE `tmp_campo` SET `ID`=9790000, `QuestID`=97900, `ObjectID`=231023, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97900,96604,164,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Blacksmithing
DELETE FROM `quest_objectives` WHERE `QuestID`=97901;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97917;
UPDATE `tmp_campo` SET `ID`=9790100, `QuestID`=97901, `ObjectID`=231027, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97901,96604,333,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Enchanting
DELETE FROM `quest_objectives` WHERE `QuestID`=97902;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97918;
UPDATE `tmp_campo` SET `ID`=9790200, `QuestID`=97902, `ObjectID`=231029, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97902,96604,202,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Engineering
DELETE FROM `quest_objectives` WHERE `QuestID`=97903;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97919;
UPDATE `tmp_campo` SET `ID`=9790300, `QuestID`=97903, `ObjectID`=231031, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97903,96604,129,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: First Aid
DELETE FROM `quest_objectives` WHERE `QuestID`=97904;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97920;
UPDATE `tmp_campo` SET `ID`=9790400, `QuestID`=97904, `ObjectID`=231033, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97904,96604,356,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Fishing
DELETE FROM `quest_objectives` WHERE `QuestID`=97905;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97921;
UPDATE `tmp_campo` SET `ID`=9790500, `QuestID`=97905, `ObjectID`=231035, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97905,96604,182,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Herbalism
DELETE FROM `quest_objectives` WHERE `QuestID`=97906;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97922;
UPDATE `tmp_campo` SET `ID`=9790600, `QuestID`=97906, `ObjectID`=231050, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97906,96604,165,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Leatherworking
DELETE FROM `quest_objectives` WHERE `QuestID`=97907;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97923;
UPDATE `tmp_campo` SET `ID`=9790700, `QuestID`=97907, `ObjectID`=231052, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97907,96604,186,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Mining
DELETE FROM `quest_objectives` WHERE `QuestID`=97908;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97924;
UPDATE `tmp_campo` SET `ID`=9790800, `QuestID`=97908, `ObjectID`=231054, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97908,96604,393,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Skinning

-- Mulgore
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`) VALUES (96605,96659) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`); -- The Great Outdoors
DELETE FROM `quest_objectives` WHERE `QuestID`=96661;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=96626;
UPDATE `tmp_campo` SET `ID`=9666100, `QuestID`=96661, `ObjectID`=227879, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (96661,96605,0,0) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Cooking
DELETE FROM `quest_objectives` WHERE `QuestID`=97927;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97915;
UPDATE `tmp_campo` SET `ID`=9792700, `QuestID`=97927, `ObjectID`=231088, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97927,96605,171,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Alchemy
DELETE FROM `quest_objectives` WHERE `QuestID`=97928;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97916;
UPDATE `tmp_campo` SET `ID`=9792800, `QuestID`=97928, `ObjectID`=231090, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97928,96605,164,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Blacksmithing
DELETE FROM `quest_objectives` WHERE `QuestID`=97929;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97917;
UPDATE `tmp_campo` SET `ID`=9792900, `QuestID`=97929, `ObjectID`=231092, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97929,96605,333,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Enchanting
DELETE FROM `quest_objectives` WHERE `QuestID`=97931;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97919;
UPDATE `tmp_campo` SET `ID`=9793100, `QuestID`=97931, `ObjectID`=231096, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97931,96605,129,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: First Aid
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97932,96605,356,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Fishing
DELETE FROM `quest_objectives` WHERE `QuestID`=97933;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97921;
UPDATE `tmp_campo` SET `ID`=9793300, `QuestID`=97933, `ObjectID`=231100, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97933,96605,182,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Herbalism
DELETE FROM `quest_objectives` WHERE `QuestID`=97934;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97922;
UPDATE `tmp_campo` SET `ID`=9793400, `QuestID`=97934, `ObjectID`=231102, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97934,96605,165,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Leatherworking
DELETE FROM `quest_objectives` WHERE `QuestID`=97935;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97923;
UPDATE `tmp_campo` SET `ID`=9793500, `QuestID`=97935, `ObjectID`=231104, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97935,96605,186,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Mining
DELETE FROM `quest_objectives` WHERE `QuestID`=97936;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97924;
UPDATE `tmp_campo` SET `ID`=9793600, `QuestID`=97936, `ObjectID`=231106, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97936,96605,393,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Skinning
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97937,96605,197,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Tailoring

-- Teldrassil
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`) VALUES (96606,96630) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`); -- The Great Outdoors
DELETE FROM `quest_objectives` WHERE `QuestID`=96634;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=96626;
UPDATE `tmp_campo` SET `ID`=9663400, `QuestID`=96634, `ObjectID`=227868, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (96634,96606,0,0) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Cooking
DELETE FROM `quest_objectives` WHERE `QuestID`=97938;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97915;
UPDATE `tmp_campo` SET `ID`=9793800, `QuestID`=97938, `ObjectID`=231110, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97938,96606,171,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Alchemy
DELETE FROM `quest_objectives` WHERE `QuestID`=97939;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97916;
UPDATE `tmp_campo` SET `ID`=9793900, `QuestID`=97939, `ObjectID`=231112, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97939,96606,164,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Blacksmithing
DELETE FROM `quest_objectives` WHERE `QuestID`=97940;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97917;
UPDATE `tmp_campo` SET `ID`=9794000, `QuestID`=97940, `ObjectID`=231114, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97940,96606,333,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Enchanting
DELETE FROM `quest_objectives` WHERE `QuestID`=97941;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97918;
UPDATE `tmp_campo` SET `ID`=9794100, `QuestID`=97941, `ObjectID`=231116, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97941,96606,202,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Engineering
DELETE FROM `quest_objectives` WHERE `QuestID`=97942;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97919;
UPDATE `tmp_campo` SET `ID`=9794200, `QuestID`=97942, `ObjectID`=231118, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97942,96606,129,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: First Aid
DELETE FROM `quest_objectives` WHERE `QuestID`=97943;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97920;
UPDATE `tmp_campo` SET `ID`=9794300, `QuestID`=97943, `ObjectID`=231120, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97943,96606,356,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Fishing
DELETE FROM `quest_objectives` WHERE `QuestID`=97944;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97921;
UPDATE `tmp_campo` SET `ID`=9794400, `QuestID`=97944, `ObjectID`=231122, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97944,96606,182,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Herbalism
DELETE FROM `quest_objectives` WHERE `QuestID`=97946;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97922;
UPDATE `tmp_campo` SET `ID`=9794600, `QuestID`=97946, `ObjectID`=231124, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97946,96606,165,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Leatherworking
DELETE FROM `quest_objectives` WHERE `QuestID`=97948;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97923;
UPDATE `tmp_campo` SET `ID`=9794800, `QuestID`=97948, `ObjectID`=231126, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97948,96606,186,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Mining
DELETE FROM `quest_objectives` WHERE `QuestID`=97949;
CREATE TEMPORARY TABLE `tmp_campo` AS SELECT * FROM `quest_objectives` WHERE `QuestID`=97924;
UPDATE `tmp_campo` SET `ID`=9794900, `QuestID`=97949, `ObjectID`=231128, `VerifiedBuild`=0;
INSERT INTO `quest_objectives` SELECT * FROM `tmp_campo`;
DROP TEMPORARY TABLE `tmp_campo`;
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97949,96606,393,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Skinning
INSERT INTO `quest_template_addon` (`ID`,`PrevQuestID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (97950,96606,197,1) ON DUPLICATE KEY UPDATE `PrevQuestID`=VALUES(`PrevQuestID`), `RequiredSkillID`=VALUES(`RequiredSkillID`), `RequiredSkillPoints`=VALUES(`RequiredSkillPoints`); -- Camping 101: Tailoring
