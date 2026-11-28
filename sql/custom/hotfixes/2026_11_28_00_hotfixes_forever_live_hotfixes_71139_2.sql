-- WoW Forever: Blizzard's hotfixes of 27 November 2026 over client build 1.60.1.71139.
-- Records from the Everlake tracker (its checkout of step 71139+2), Blizzard's values unchanged. Only the 25 records that are new
-- since step 71139+1 (2026_11_26_00), compared row by row with that step's checkout on 28 November.
-- What they bring:
--   Vilerend Slicer 11603 (item_sparse, item_search_name): the server's 71091 files lack the record, so The Behemoth's drop in
--     Blackrock Depths (reference loot 30223) could not be given.
--   23 spell_misc records gain SpellAttr5 0x2 (no reagent cost with an aura): every rank of the rogue poisons (Instant, Deadly,
--     Crippling, Mind-numbing, Wound), Instant Toxin 6651 (its row was not on the realm at all) and Vanish 1856/1857.
-- Layouts: the server's 71091 files. hotfix_data ids 2117500-2117524. Safe to run again.

DELETE FROM `item_sparse` WHERE `ID` = 11603;
INSERT INTO `item_sparse` (`ID`,`Description`,`Display3`,`Display2`,`Display1`,`Display`,`ExpansionID`,`DmgVariance`,`LimitCategory`,`DurationInInventory`,`QualityModifier`,`BagFamily`,`StartQuestID`,`LanguageID`,`ItemRange`,`StatPercentageOfSocket1`,`StatPercentageOfSocket2`,`StatPercentageOfSocket3`,`StatPercentageOfSocket4`,`StatPercentageOfSocket5`,`StatPercentageOfSocket6`,`StatPercentageOfSocket7`,`StatPercentageOfSocket8`,`StatPercentageOfSocket9`,`StatPercentageOfSocket10`,`StatPercentEditor1`,`StatPercentEditor2`,`StatPercentEditor3`,`StatPercentEditor4`,`StatPercentEditor5`,`StatPercentEditor6`,`StatPercentEditor7`,`StatPercentEditor8`,`StatPercentEditor9`,`StatPercentEditor10`,`StatModifierBonusStat1`,`StatModifierBonusStat2`,`StatModifierBonusStat3`,`StatModifierBonusStat4`,`StatModifierBonusStat5`,`StatModifierBonusStat6`,`StatModifierBonusStat7`,`StatModifierBonusStat8`,`StatModifierBonusStat9`,`StatModifierBonusStat10`,`Stackable`,`MaxCount`,`MinReputation`,`RequiredAbility`,`AllowableRace1`,`AllowableRace2`,`SellPrice`,`BuyPrice`,`VendorStackCount`,`PriceVariance`,`PriceRandomValue`,`Flags1`,`Flags2`,`Flags3`,`Flags4`,`Flags5`,`FactionRelated`,`ModifiedCraftingReagentItemID`,`ContentTuningID`,`PlayerLevelToItemLevelCurveID`,`ItemLevelOffsetCurveID`,`ItemLevelOffsetItemLevel`,`ItemSquishEraID`,`ItemNameDescriptionID`,`RequiredTransmogHoliday`,`RequiredHoliday`,`GemProperties`,`SocketMatchEnchantmentId`,`TotemCategoryID`,`InstanceBound`,`ZoneBound1`,`ZoneBound2`,`ItemSet`,`LockID`,`PageID`,`ItemDelay`,`MinFactionID`,`RequiredSkillRank`,`RequiredSkill`,`ItemLevel`,`AllowableClass`,`ArtifactID`,`SpellWeight`,`SpellWeightCategory`,`SocketType1`,`SocketType2`,`SocketType3`,`SheatheType`,`Material`,`PageMaterialID`,`Bonding`,`DamageDamageType`,`ContainerSlots`,`RequiredPVPMedal`,`RequiredPVPRank`,`RequiredLevel`,`InventoryType`,`OverallQualityID`,`AmmunitionType`,`VerifiedBuild`) VALUES
(11603,'','','','','Vilerend Slicer',0,0.6000000238418579,0,0,0.0,0,0,0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,30656,153283,1,1.0,1.0,0,16388,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1400,0,0,0,51,-1,0,0,0,0,0,0,7,1,0,2,0,0,0,0,46,21,3,0,71091);

DELETE FROM `item_search_name` WHERE `ID` = 11603;
INSERT INTO `item_search_name` (`ID`,`Display`,`OverallQualityID`,`ExpansionID`,`MinFactionID`,`MinReputation`,`AllowableClass`,`RequiredLevel`,`RequiredSkill`,`RequiredSkillRank`,`RequiredAbility`,`ItemLevel`,`Flags1`,`Flags2`,`Flags3`,`Flags4`,`Flags5`,`AllowableRace1`,`AllowableRace2`,`VerifiedBuild`) VALUES
(11603,'Vilerend Slicer',3,0,0,0,-1,46,0,0,0,51,0,16388,0,0,0,-1,-1,71091);

DELETE FROM `spell_misc` WHERE `ID` IN (315567,315867,316115,316273,316807,316808,318899,319241,319906,320577,320654,320989,322508,322516,322766,323457,323534,323992,324197,324262,324279,324807,333246);
INSERT INTO `spell_misc` (`ID`,`Attributes1`,`Attributes2`,`Attributes3`,`Attributes4`,`Attributes5`,`Attributes6`,`Attributes7`,`Attributes8`,`Attributes9`,`Attributes10`,`Attributes11`,`Attributes12`,`Attributes13`,`Attributes14`,`Attributes15`,`Attributes16`,`Attributes17`,`DifficultyID`,`CastingTimeIndex`,`DurationIndex`,`PvPDurationIndex`,`RangeIndex`,`SchoolMask`,`Speed`,`LaunchDelay`,`MinDuration`,`SpellIconFileDataID`,`ActiveIconFileDataID`,`ContentTuningID`,`ShowFutureSpellPlayerConditionID`,`SpellVisualScript`,`ActiveSpellVisualScript`,`SpellID`,`VerifiedBuild`) VALUES
(315567,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132290,0,0,0,0,0,2837,71091),
(315867,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132290,0,0,0,0,0,2835,71091),
(316115,135594000,32,2,0,0,2,0,0,0,0,0,0,0,0,64,8192,0,0,1,0,0,1,1,0.0,0.0,0.0,132331,136047,0,0,0,0,1856,71091),
(316273,135594000,32,2,0,0,2,0,0,0,0,0,0,0,0,64,8192,0,0,1,0,0,1,1,0.0,0.0,0.0,132331,136047,0,0,0,0,1857,71091),
(316807,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132274,0,0,0,0,0,3420,71091),
(316808,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132274,0,0,0,0,0,3421,71091),
(318899,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,136066,0,0,0,0,0,5763,71091),
(319241,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,134743,0,0,0,0,0,6651,71091),
(319906,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132273,0,0,0,0,0,8681,71091),
(320577,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132273,0,0,0,0,0,8691,71091),
(320654,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,136066,0,0,0,0,0,8694,71091),
(320989,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132273,0,0,0,0,0,8687,71091),
(322508,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132273,0,0,0,0,0,11342,71091),
(322516,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132273,0,0,0,0,0,11341,71091),
(322766,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132273,0,0,0,0,0,11343,71091),
(323457,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132290,0,0,0,0,0,11358,71091),
(323534,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132290,0,0,0,0,0,11357,71091),
(323992,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,134197,0,0,0,0,0,13229,71091),
(324197,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,136066,0,0,0,0,0,11400,71091),
(324262,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,134197,0,0,0,0,0,13228,71091),
(324279,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,134197,0,0,0,0,0,13230,71091),
(324807,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,134197,0,0,0,0,0,13220,71091),
(333246,65568,0,0,0,0,2,0,0,0,0,0,0,0,32,64,8192,0,0,14,0,0,1,1,0.0,0.0,0.0,132290,0,0,0,0,0,25347,71091);

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 2117500 AND 2117524;
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(2117500,1397837500,2442913102,11603,1,71139),
(2117501,1397837501,428746933,11603,1,71139),
(2117502,1397837502,3322146344,315567,1,71139),
(2117503,1397837503,3322146344,315867,1,71139),
(2117504,1397837504,3322146344,316115,1,71139),
(2117505,1397837505,3322146344,316273,1,71139),
(2117506,1397837506,3322146344,316807,1,71139),
(2117507,1397837507,3322146344,316808,1,71139),
(2117508,1397837508,3322146344,318899,1,71139),
(2117509,1397837509,3322146344,319241,1,71139),
(2117510,1397837510,3322146344,319906,1,71139),
(2117511,1397837511,3322146344,320577,1,71139),
(2117512,1397837512,3322146344,320654,1,71139),
(2117513,1397837513,3322146344,320989,1,71139),
(2117514,1397837514,3322146344,322508,1,71139),
(2117515,1397837515,3322146344,322516,1,71139),
(2117516,1397837516,3322146344,322766,1,71139),
(2117517,1397837517,3322146344,323457,1,71139),
(2117518,1397837518,3322146344,323534,1,71139),
(2117519,1397837519,3322146344,323992,1,71139),
(2117520,1397837520,3322146344,324197,1,71139),
(2117521,1397837521,3322146344,324262,1,71139),
(2117522,1397837522,3322146344,324279,1,71139),
(2117523,1397837523,3322146344,324807,1,71139),
(2117524,1397837524,3322146344,333246,1,71139);
