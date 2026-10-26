-- Loot: Forever items that dropped nowhere here (Waylaid Crates, Forever recipes, the leather helms of the dungeon bosses,
-- Forever quest drops). Chances are Wowhead Forever's drop counts (kills/drops in each comment), as the AnoCore v10 world lists them.
-- Each row is its own roll (GroupId 0). Creatures without a loot id get their own entry as loot id.
UPDATE `creature_template_difficulty` SET `LootID`=`Entry` WHERE `DifficultyID`=0 AND `LootID`=0 AND `Entry` IN (11053,259388,259394,260396,276108);
DELETE FROM `creature_loot_template` WHERE `Entry`=48 AND `ItemType`=0 AND `Item` IN (251336);
DELETE FROM `creature_loot_template` WHERE `Entry`=100 AND `ItemType`=0 AND `Item` IN (281993);
DELETE FROM `creature_loot_template` WHERE `Entry`=114 AND `ItemType`=0 AND `Item` IN (248707,262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=115 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=117 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=122 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=157 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=171 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=203 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=205 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=299 AND `ItemType`=0 AND `Item` IN (3471,7280);
DELETE FROM `creature_loot_template` WHERE `Entry`=423 AND `ItemType`=0 AND `Item` IN (7809);
DELETE FROM `creature_loot_template` WHERE `Entry`=424 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=428 AND `ItemType`=0 AND `Item` IN (250188);
DELETE FROM `creature_loot_template` WHERE `Entry`=432 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=433 AND `ItemType`=0 AND `Item` IN (251338);
DELETE FROM `creature_loot_template` WHERE `Entry`=440 AND `ItemType`=0 AND `Item` IN (251526);
DELETE FROM `creature_loot_template` WHERE `Entry`=441 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=442 AND `ItemType`=0 AND `Item` IN (251526);
DELETE FROM `creature_loot_template` WHERE `Entry`=454 AND `ItemType`=0 AND `Item` IN (248707,262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=476 AND `ItemType`=0 AND `Item` IN (250976);
DELETE FROM `creature_loot_template` WHERE `Entry`=480 AND `ItemType`=0 AND `Item` IN (255154);
DELETE FROM `creature_loot_template` WHERE `Entry`=504 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=513 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=517 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=547 AND `ItemType`=0 AND `Item` IN (251526);
DELETE FROM `creature_loot_template` WHERE `Entry`=578 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=589 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=590 AND `ItemType`=0 AND `Item` IN (248707,262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=642 AND `ItemType`=0 AND `Item` IN (285292);
DELETE FROM `creature_loot_template` WHERE `Entry`=644 AND `ItemType`=0 AND `Item` IN (273289);
DELETE FROM `creature_loot_template` WHERE `Entry`=645 AND `ItemType`=0 AND `Item` IN (273102,273298);
DELETE FROM `creature_loot_template` WHERE `Entry`=646 AND `ItemType`=0 AND `Item` IN (284715);
DELETE FROM `creature_loot_template` WHERE `Entry`=712 AND `ItemType`=0 AND `Item` IN (251526);
DELETE FROM `creature_loot_template` WHERE `Entry`=757 AND `ItemType`=0 AND `Item` IN (258530);
DELETE FROM `creature_loot_template` WHERE `Entry`=830 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=1020 AND `ItemType`=0 AND `Item` IN (250187);
DELETE FROM `creature_loot_template` WHERE `Entry`=1116 AND `ItemType`=0 AND `Item` IN (267415);
DELETE FROM `creature_loot_template` WHERE `Entry`=1118 AND `ItemType`=0 AND `Item` IN (267415);
DELETE FROM `creature_loot_template` WHERE `Entry`=1134 AND `ItemType`=0 AND `Item` IN (250375);
DELETE FROM `creature_loot_template` WHERE `Entry`=1184 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=1197 AND `ItemType`=0 AND `Item` IN (2267);
DELETE FROM `creature_loot_template` WHERE `Entry`=1236 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=1393 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=1397 AND `ItemType`=0 AND `Item` IN (249879);
DELETE FROM `creature_loot_template` WHERE `Entry`=1426 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=1663 AND `ItemType`=0 AND `Item` IN (252512,252515,273817,273819,273820);
DELETE FROM `creature_loot_template` WHERE `Entry`=1665 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=1666 AND `ItemType`=0 AND `Item` IN (252513,252515,273807,273808);
DELETE FROM `creature_loot_template` WHERE `Entry`=1696 AND `ItemType`=0 AND `Item` IN (273804,273805,273806);
DELETE FROM `creature_loot_template` WHERE `Entry`=1706 AND `ItemType`=0 AND `Item` IN (274092);
DELETE FROM `creature_loot_template` WHERE `Entry`=1707 AND `ItemType`=0 AND `Item` IN (274092);
DELETE FROM `creature_loot_template` WHERE `Entry`=1708 AND `ItemType`=0 AND `Item` IN (274092);
DELETE FROM `creature_loot_template` WHERE `Entry`=1711 AND `ItemType`=0 AND `Item` IN (274092);
DELETE FROM `creature_loot_template` WHERE `Entry`=1715 AND `ItemType`=0 AND `Item` IN (274092);
DELETE FROM `creature_loot_template` WHERE `Entry`=1716 AND `ItemType`=0 AND `Item` IN (252455,252515,273824,273825,273827,273829);
DELETE FROM `creature_loot_template` WHERE `Entry`=1717 AND `ItemType`=0 AND `Item` IN (252512,252513,273809,273810,273811);
DELETE FROM `creature_loot_template` WHERE `Entry`=1763 AND `ItemType`=0 AND `Item` IN (273086,273297);
DELETE FROM `creature_loot_template` WHERE `Entry`=1768 AND `ItemType`=0 AND `Item` IN (248707,249474);
DELETE FROM `creature_loot_template` WHERE `Entry`=1781 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=1782 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=1815 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=1816 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=1817 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=1821 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=1824 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=1867 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=1914 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=1934 AND `ItemType`=0 AND `Item` IN (250988);
DELETE FROM `creature_loot_template` WHERE `Entry`=1939 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=1943 AND `ItemType`=0 AND `Item` IN (250983);
DELETE FROM `creature_loot_template` WHERE `Entry`=1973 AND `ItemType`=0 AND `Item` IN (271343);
DELETE FROM `creature_loot_template` WHERE `Entry`=1974 AND `ItemType`=0 AND `Item` IN (271343);
DELETE FROM `creature_loot_template` WHERE `Entry`=1994 AND `ItemType`=0 AND `Item` IN (277190);
DELETE FROM `creature_loot_template` WHERE `Entry`=2007 AND `ItemType`=0 AND `Item` IN (250380);
DELETE FROM `creature_loot_template` WHERE `Entry`=2102 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2103 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=2165 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2169 AND `ItemType`=0 AND `Item` IN (250977);
DELETE FROM `creature_loot_template` WHERE `Entry`=2172 AND `ItemType`=0 AND `Item` IN (284176);
DELETE FROM `creature_loot_template` WHERE `Entry`=2177 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2180 AND `ItemType`=0 AND `Item` IN (250989);
DELETE FROM `creature_loot_template` WHERE `Entry`=2181 AND `ItemType`=0 AND `Item` IN (262888,279276);
DELETE FROM `creature_loot_template` WHERE `Entry`=2182 AND `ItemType`=0 AND `Item` IN (279276);
DELETE FROM `creature_loot_template` WHERE `Entry`=2183 AND `ItemType`=0 AND `Item` IN (279276);
DELETE FROM `creature_loot_template` WHERE `Entry`=2190 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2235 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=2237 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2258 AND `ItemType`=0 AND `Item` IN (283254);
DELETE FROM `creature_loot_template` WHERE `Entry`=2261 AND `ItemType`=0 AND `Item` IN (251335,262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2318 AND `ItemType`=0 AND `Item` IN (213421);
DELETE FROM `creature_loot_template` WHERE `Entry`=2319 AND `ItemType`=0 AND `Item` IN (213421);
DELETE FROM `creature_loot_template` WHERE `Entry`=2321 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2336 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2339 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2351 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2354 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=2554 AND `ItemType`=0 AND `Item` IN (216483);
DELETE FROM `creature_loot_template` WHERE `Entry`=2555 AND `ItemType`=0 AND `Item` IN (216483);
DELETE FROM `creature_loot_template` WHERE `Entry`=2556 AND `ItemType`=0 AND `Item` IN (216483);
DELETE FROM `creature_loot_template` WHERE `Entry`=2563 AND `ItemType`=0 AND `Item` IN (278225);
DELETE FROM `creature_loot_template` WHERE `Entry`=2564 AND `ItemType`=0 AND `Item` IN (213422);
DELETE FROM `creature_loot_template` WHERE `Entry`=2566 AND `ItemType`=0 AND `Item` IN (213422);
DELETE FROM `creature_loot_template` WHERE `Entry`=2569 AND `ItemType`=0 AND `Item` IN (213422);
DELETE FROM `creature_loot_template` WHERE `Entry`=2570 AND `ItemType`=0 AND `Item` IN (213422);
DELETE FROM `creature_loot_template` WHERE `Entry`=2571 AND `ItemType`=0 AND `Item` IN (213422);
DELETE FROM `creature_loot_template` WHERE `Entry`=2701 AND `ItemType`=0 AND `Item` IN (211269);
DELETE FROM `creature_loot_template` WHERE `Entry`=2715 AND `ItemType`=0 AND `Item` IN (211269);
DELETE FROM `creature_loot_template` WHERE `Entry`=2716 AND `ItemType`=0 AND `Item` IN (211269);
DELETE FROM `creature_loot_template` WHERE `Entry`=2717 AND `ItemType`=0 AND `Item` IN (211269);
DELETE FROM `creature_loot_template` WHERE `Entry`=2893 AND `ItemType`=0 AND `Item` IN (211269);
DELETE FROM `creature_loot_template` WHERE `Entry`=2894 AND `ItemType`=0 AND `Item` IN (211269);
DELETE FROM `creature_loot_template` WHERE `Entry`=2906 AND `ItemType`=0 AND `Item` IN (211269);
DELETE FROM `creature_loot_template` WHERE `Entry`=2962 AND `ItemType`=0 AND `Item` IN (249865);
DELETE FROM `creature_loot_template` WHERE `Entry`=2975 AND `ItemType`=0 AND `Item` IN (250375);
DELETE FROM `creature_loot_template` WHERE `Entry`=3115 AND `ItemType`=0 AND `Item` IN (250976);
DELETE FROM `creature_loot_template` WHERE `Entry`=3128 AND `ItemType`=0 AND `Item` IN (250380);
DELETE FROM `creature_loot_template` WHERE `Entry`=3242 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3244 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3245 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=3246 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3253 AND `ItemType`=0 AND `Item` IN (286534);
DELETE FROM `creature_loot_template` WHERE `Entry`=3255 AND `ItemType`=0 AND `Item` IN (250187,262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3256 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3269 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3272 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3276 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3277 AND `ItemType`=0 AND `Item` IN (248707,262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3280 AND `ItemType`=0 AND `Item` IN (250977);
DELETE FROM `creature_loot_template` WHERE `Entry`=3283 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3295 AND `ItemType`=0 AND `Item` IN (286535);
DELETE FROM `creature_loot_template` WHERE `Entry`=3384 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3385 AND `ItemType`=0 AND `Item` IN (248707,262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3386 AND `ItemType`=0 AND `Item` IN (250989,262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3425 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3454 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=3455 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=3459 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=3461 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3467 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3535 AND `ItemType`=0 AND `Item` IN (284167);
DELETE FROM `creature_loot_template` WHERE `Entry`=3653 AND `ItemType`=0 AND `Item` IN (273084);
DELETE FROM `creature_loot_template` WHERE `Entry`=3670 AND `ItemType`=0 AND `Item` IN (273089);
DELETE FROM `creature_loot_template` WHERE `Entry`=3671 AND `ItemType`=0 AND `Item` IN (273088,273098);
DELETE FROM `creature_loot_template` WHERE `Entry`=3673 AND `ItemType`=0 AND `Item` IN (273087);
DELETE FROM `creature_loot_template` WHERE `Entry`=3674 AND `ItemType`=0 AND `Item` IN (273137);
DELETE FROM `creature_loot_template` WHERE `Entry`=3757 AND `ItemType`=0 AND `Item` IN (250368);
DELETE FROM `creature_loot_template` WHERE `Entry`=3809 AND `ItemType`=0 AND `Item` IN (250182,262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3817 AND `ItemType`=0 AND `Item` IN (252804);
DELETE FROM `creature_loot_template` WHERE `Entry`=3886 AND `ItemType`=0 AND `Item` IN (273096);
DELETE FROM `creature_loot_template` WHERE `Entry`=3887 AND `ItemType`=0 AND `Item` IN (273637);
DELETE FROM `creature_loot_template` WHERE `Entry`=3914 AND `ItemType`=0 AND `Item` IN (273456,273457);
DELETE FROM `creature_loot_template` WHERE `Entry`=3927 AND `ItemType`=0 AND `Item` IN (273647);
DELETE FROM `creature_loot_template` WHERE `Entry`=3943 AND `ItemType`=0 AND `Item` IN (262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=3974 AND `ItemType`=0 AND `Item` IN (273109);
DELETE FROM `creature_loot_template` WHERE `Entry`=3983 AND `ItemType`=0 AND `Item` IN (252455,274290);
DELETE FROM `creature_loot_template` WHERE `Entry`=3988 AND `ItemType`=0 AND `Item` IN (210188);
DELETE FROM `creature_loot_template` WHERE `Entry`=3989 AND `ItemType`=0 AND `Item` IN (210188);
DELETE FROM `creature_loot_template` WHERE `Entry`=3991 AND `ItemType`=0 AND `Item` IN (210187);
DELETE FROM `creature_loot_template` WHERE `Entry`=4003 AND `ItemType`=0 AND `Item` IN (249880);
DELETE FROM `creature_loot_template` WHERE `Entry`=4127 AND `ItemType`=0 AND `Item` IN (248707);
DELETE FROM `creature_loot_template` WHERE `Entry`=4274 AND `ItemType`=0 AND `Item` IN (273646);
DELETE FROM `creature_loot_template` WHERE `Entry`=4278 AND `ItemType`=0 AND `Item` IN (273105,273643);
DELETE FROM `creature_loot_template` WHERE `Entry`=4279 AND `ItemType`=0 AND `Item` IN (273645);
DELETE FROM `creature_loot_template` WHERE `Entry`=4283 AND `ItemType`=0 AND `Item` IN (215376);
DELETE FROM `creature_loot_template` WHERE `Entry`=4287 AND `ItemType`=0 AND `Item` IN (215374,215375,215376);
DELETE FROM `creature_loot_template` WHERE `Entry`=4288 AND `ItemType`=0 AND `Item` IN (215374);
DELETE FROM `creature_loot_template` WHERE `Entry`=4296 AND `ItemType`=0 AND `Item` IN (215374);
DELETE FROM `creature_loot_template` WHERE `Entry`=4306 AND `ItemType`=0 AND `Item` IN (215374,215375,215376);
DELETE FROM `creature_loot_template` WHERE `Entry`=4308 AND `ItemType`=0 AND `Item` IN (262889);
DELETE FROM `creature_loot_template` WHERE `Entry`=4420 AND `ItemType`=0 AND `Item` IN (252515,274161);
DELETE FROM `creature_loot_template` WHERE `Entry`=4421 AND `ItemType`=0 AND `Item` IN (252455,252456,252512,252515);
DELETE FROM `creature_loot_template` WHERE `Entry`=4422 AND `ItemType`=0 AND `Item` IN (252455);
DELETE FROM `creature_loot_template` WHERE `Entry`=4424 AND `ItemType`=0 AND `Item` IN (252512,252515,274158,274159);
DELETE FROM `creature_loot_template` WHERE `Entry`=4829 AND `ItemType`=0 AND `Item` IN (252456,252512);
DELETE FROM `creature_loot_template` WHERE `Entry`=4832 AND `ItemType`=0 AND `Item` IN (252455,252456,252513,252514,252515,273846);
DELETE FROM `creature_loot_template` WHERE `Entry`=4887 AND `ItemType`=0 AND `Item` IN (273839);
DELETE FROM `creature_loot_template` WHERE `Entry`=5356 AND `ItemType`=0 AND `Item` IN (285043);
DELETE FROM `creature_loot_template` WHERE `Entry`=5471 AND `ItemType`=0 AND `Item` IN (278186);
DELETE FROM `creature_loot_template` WHERE `Entry`=5472 AND `ItemType`=0 AND `Item` IN (278186);
DELETE FROM `creature_loot_template` WHERE `Entry`=5473 AND `ItemType`=0 AND `Item` IN (278186);
DELETE FROM `creature_loot_template` WHERE `Entry`=5474 AND `ItemType`=0 AND `Item` IN (278186);
DELETE FROM `creature_loot_template` WHERE `Entry`=5475 AND `ItemType`=0 AND `Item` IN (278186);
DELETE FROM `creature_loot_template` WHERE `Entry`=5787 AND `ItemType`=0 AND `Item` IN (284361);
DELETE FROM `creature_loot_template` WHERE `Entry`=5797 AND `ItemType`=0 AND `Item` IN (285347);
DELETE FROM `creature_loot_template` WHERE `Entry`=5798 AND `ItemType`=0 AND `Item` IN (285346);
DELETE FROM `creature_loot_template` WHERE `Entry`=5799 AND `ItemType`=0 AND `Item` IN (285348);
DELETE FROM `creature_loot_template` WHERE `Entry`=5800 AND `ItemType`=0 AND `Item` IN (285350);
DELETE FROM `creature_loot_template` WHERE `Entry`=5808 AND `ItemType`=0 AND `Item` IN (284321);
DELETE FROM `creature_loot_template` WHERE `Entry`=5809 AND `ItemType`=0 AND `Item` IN (284322);
DELETE FROM `creature_loot_template` WHERE `Entry`=5822 AND `ItemType`=0 AND `Item` IN (284287);
DELETE FROM `creature_loot_template` WHERE `Entry`=5823 AND `ItemType`=0 AND `Item` IN (284320);
DELETE FROM `creature_loot_template` WHERE `Entry`=5824 AND `ItemType`=0 AND `Item` IN (284286);
DELETE FROM `creature_loot_template` WHERE `Entry`=5826 AND `ItemType`=0 AND `Item` IN (284323);
DELETE FROM `creature_loot_template` WHERE `Entry`=5827 AND `ItemType`=0 AND `Item` IN (285338);
DELETE FROM `creature_loot_template` WHERE `Entry`=5829 AND `ItemType`=0 AND `Item` IN (286536);
DELETE FROM `creature_loot_template` WHERE `Entry`=5830 AND `ItemType`=0 AND `Item` IN (285345);
DELETE FROM `creature_loot_template` WHERE `Entry`=5831 AND `ItemType`=0 AND `Item` IN (285330);
DELETE FROM `creature_loot_template` WHERE `Entry`=5832 AND `ItemType`=0 AND `Item` IN (286537);
DELETE FROM `creature_loot_template` WHERE `Entry`=5835 AND `ItemType`=0 AND `Item` IN (285351);
DELETE FROM `creature_loot_template` WHERE `Entry`=5836 AND `ItemType`=0 AND `Item` IN (285366);
DELETE FROM `creature_loot_template` WHERE `Entry`=5841 AND `ItemType`=0 AND `Item` IN (285339);
DELETE FROM `creature_loot_template` WHERE `Entry`=5842 AND `ItemType`=0 AND `Item` IN (285329);
DELETE FROM `creature_loot_template` WHERE `Entry`=5859 AND `ItemType`=0 AND `Item` IN (285328);
DELETE FROM `creature_loot_template` WHERE `Entry`=5865 AND `ItemType`=0 AND `Item` IN (286533);
DELETE FROM `creature_loot_template` WHERE `Entry`=6073 AND `ItemType`=0 AND `Item` IN (209779);
DELETE FROM `creature_loot_template` WHERE `Entry`=6115 AND `ItemType`=0 AND `Item` IN (209779);
DELETE FROM `creature_loot_template` WHERE `Entry`=6168 AND `ItemType`=0 AND `Item` IN (274149,274152,274155);
DELETE FROM `creature_loot_template` WHERE `Entry`=6229 AND `ItemType`=0 AND `Item` IN (274068);
DELETE FROM `creature_loot_template` WHERE `Entry`=6243 AND `ItemType`=0 AND `Item` IN (252456,252512,273141,273840);
DELETE FROM `creature_loot_template` WHERE `Entry`=6490 AND `ItemType`=0 AND `Item` IN (252512);
DELETE FROM `creature_loot_template` WHERE `Entry`=7017 AND `ItemType`=0 AND `Item` IN (14146,284177);
DELETE FROM `creature_loot_template` WHERE `Entry`=7235 AND `ItemType`=0 AND `Item` IN (250988);
DELETE FROM `creature_loot_template` WHERE `Entry`=7800 AND `ItemType`=0 AND `Item` IN (7192);
DELETE FROM `creature_loot_template` WHERE `Entry`=8596 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=8597 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=8598 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=8600 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=8601 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=8602 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=8603 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=8605 AND `ItemType`=0 AND `Item` IN (241652);
DELETE FROM `creature_loot_template` WHERE `Entry`=10184 AND `ItemType`=0 AND `Item` IN (21106);
DELETE FROM `creature_loot_template` WHERE `Entry`=10356 AND `ItemType`=0 AND `Item` IN (283462);
DELETE FROM `creature_loot_template` WHERE `Entry`=10357 AND `ItemType`=0 AND `Item` IN (283473);
DELETE FROM `creature_loot_template` WHERE `Entry`=10358 AND `ItemType`=0 AND `Item` IN (283471);
DELETE FROM `creature_loot_template` WHERE `Entry`=10359 AND `ItemType`=0 AND `Item` IN (283480);
DELETE FROM `creature_loot_template` WHERE `Entry`=10363 AND `ItemType`=0 AND `Item` IN (272017);
DELETE FROM `creature_loot_template` WHERE `Entry`=10374 AND `ItemType`=0 AND `Item` IN (140);
DELETE FROM `creature_loot_template` WHERE `Entry`=10429 AND `ItemType`=0 AND `Item` IN (227911);
DELETE FROM `creature_loot_template` WHERE `Entry`=10643 AND `ItemType`=0 AND `Item` IN (284702);
DELETE FROM `creature_loot_template` WHERE `Entry`=11053 AND `ItemType`=0 AND `Item` IN (3841);
DELETE FROM `creature_loot_template` WHERE `Entry`=11517 AND `ItemType`=0 AND `Item` IN (272996,272998,272999);
DELETE FROM `creature_loot_template` WHERE `Entry`=11519 AND `ItemType`=0 AND `Item` IN (273003,273005,273007);
DELETE FROM `creature_loot_template` WHERE `Entry`=11559 AND `ItemType`=0 AND `Item` IN (260347);
DELETE FROM `creature_loot_template` WHERE `Entry`=11680 AND `ItemType`=0 AND `Item` IN (279507);
DELETE FROM `creature_loot_template` WHERE `Entry`=11682 AND `ItemType`=0 AND `Item` IN (279505);
DELETE FROM `creature_loot_template` WHERE `Entry`=11697 AND `ItemType`=0 AND `Item` IN (209779);
DELETE FROM `creature_loot_template` WHERE `Entry`=11915 AND `ItemType`=0 AND `Item` IN (251454,262888);
DELETE FROM `creature_loot_template` WHERE `Entry`=12431 AND `ItemType`=0 AND `Item` IN (283361);
DELETE FROM `creature_loot_template` WHERE `Entry`=12432 AND `ItemType`=0 AND `Item` IN (283259);
DELETE FROM `creature_loot_template` WHERE `Entry`=12902 AND `ItemType`=0 AND `Item` IN (252455,252512,273841,273842,273843);
DELETE FROM `creature_loot_template` WHERE `Entry`=14267 AND `ItemType`=0 AND `Item` IN (282639);
DELETE FROM `creature_loot_template` WHERE `Entry`=14277 AND `ItemType`=0 AND `Item` IN (282711);
DELETE FROM `creature_loot_template` WHERE `Entry`=14326 AND `ItemType`=0 AND `Item` IN (245675);
DELETE FROM `creature_loot_template` WHERE `Entry`=14429 AND `ItemType`=0 AND `Item` IN (284166);
DELETE FROM `creature_loot_template` WHERE `Entry`=14430 AND `ItemType`=0 AND `Item` IN (284165);
DELETE FROM `creature_loot_template` WHERE `Entry`=246016 AND `ItemType`=0 AND `Item` IN (273043,273044,273045);
DELETE FROM `creature_loot_template` WHERE `Entry`=250283 AND `ItemType`=0 AND `Item` IN (250366);
DELETE FROM `creature_loot_template` WHERE `Entry`=259385 AND `ItemType`=0 AND `Item` IN (263015,263016,263017);
DELETE FROM `creature_loot_template` WHERE `Entry`=259388 AND `ItemType`=0 AND `Item` IN (285228);
DELETE FROM `creature_loot_template` WHERE `Entry`=259394 AND `ItemType`=0 AND `Item` IN (285264,285269);
DELETE FROM `creature_loot_template` WHERE `Entry`=260325 AND `ItemType`=0 AND `Item` IN (271100,273025,273026,273027,273106);
DELETE FROM `creature_loot_template` WHERE `Entry`=260326 AND `ItemType`=0 AND `Item` IN (270865,273028,273029,273030,273097);
DELETE FROM `creature_loot_template` WHERE `Entry`=260396 AND `ItemType`=0 AND `Item` IN (268812);
DELETE FROM `creature_loot_template` WHERE `Entry`=260800 AND `ItemType`=0 AND `Item` IN (271100);
DELETE FROM `creature_loot_template` WHERE `Entry`=260801 AND `ItemType`=0 AND `Item` IN (271100);
DELETE FROM `creature_loot_template` WHERE `Entry`=264082 AND `ItemType`=0 AND `Item` IN (273658);
DELETE FROM `creature_loot_template` WHERE `Entry`=271080 AND `ItemType`=0 AND `Item` IN (283460);
DELETE FROM `creature_loot_template` WHERE `Entry`=271903 AND `ItemType`=0 AND `Item` IN (279276);
DELETE FROM `creature_loot_template` WHERE `Entry`=272034 AND `ItemType`=0 AND `Item` IN (250982);
DELETE FROM `creature_loot_template` WHERE `Entry`=276061 AND `ItemType`=0 AND `Item` IN (255154);
DELETE FROM `creature_loot_template` WHERE `Entry`=276108 AND `ItemType`=0 AND `Item` IN (286752);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(48,0,251336,0.004,0,1,0,1,1,'Skeletal Warrior: Wowhead Forever drop 2/48060'),
(100,0,281993,1.009,0,1,0,1,1,'Gruff Swiftbite: Gnoll Hide Boots - Wowhead Forever 9/892'),
(114,0,248707,0.001,0,1,0,1,1,'Harvest Watcher: Wowhead Forever drop 2/166872'),
(114,0,262888,0.001,0,1,0,1,1,'Harvest Watcher: Wowhead Forever drop 2/166872'),
(115,0,262888,0.043,0,1,0,1,1,'Harvest Reaper: Wowhead Forever drop 3/6972'),
(117,0,262888,0.004,0,1,0,1,1,'Riverpaw Gnoll: Wowhead Forever drop 2/53098'),
(122,0,262888,0.024,0,1,0,1,1,'Defias Highwayman: Wowhead Forever drop 13/53206'),
(157,0,262888,0.006,0,1,0,1,1,'Goretusk: Wowhead Forever drop 5/81903'),
(171,0,248707,0.01,0,1,0,1,1,'Murloc Warrior: Wowhead Forever drop 3/30371'),
(203,0,248707,0.006,0,1,0,1,1,'Skeletal Mage: Wowhead Forever drop 2/35828'),
(205,0,262888,0.003,0,1,0,1,1,'Nightbane Dark Runner: Wowhead Forever drop 1/29824'),
(299,0,3471,0.02,0,1,0,1,1,'Young Wolf: Copper Chain Vest'),
(299,0,7280,0.02,0,1,0,1,1,'Young Wolf: Rugged Leather Pants'),
(423,0,7809,0.384986,0,1,0,1,1,'Redridge Mongrel: Easter Dress'),
(424,0,262888,0.007,0,1,0,1,1,'Redridge Poacher: Wowhead Forever drop 2/28366'),
(428,0,250188,0.066,0,1,0,1,1,'Dire Condor: Wowhead Forever drop 78/117312'),
(432,0,248707,0.004,0,1,0,1,1,'Shadowhide Brute: Wowhead Forever drop 1/27620'),
(433,0,251338,0.032,0,1,0,1,1,'Shadowhide Gnoll: Wowhead Forever drop 6/18764'),
(440,0,251526,0.003,0,1,0,1,1,'Blackrock Grunt: Wowhead Forever drop 1/35672'),
(441,0,262888,0.001,0,1,0,1,1,'Black Dragon Whelp: Wowhead Forever drop 1/74559'),
(442,0,251526,0.001,0,1,0,1,1,'Tarantula: Wowhead Forever drop 1/73110'),
(454,0,248707,0.001,0,1,0,1,1,'Young Goretusk: Wowhead Forever drop 2/171940'),
(454,0,262888,0.002,0,1,0,1,1,'Young Goretusk: Wowhead Forever drop 3/171940'),
(476,0,250976,0.206,0,1,0,1,1,'Kobold Geomancer: Wowhead Forever drop 36/17516'),
(480,0,255154,2.383,0,1,0,1,1,'Rusty Harvest Golem: Ruined Gyrostabilizer - Wowhead Forever 1011/42420'),
(504,0,248707,0.001,0,1,0,1,1,'Defias Trapper: Wowhead Forever drop 2/172401'),
(513,0,248707,0.016,0,1,0,1,1,'Murloc Netter: Wowhead Forever drop 2/12422'),
(517,0,248707,0.007,0,1,0,1,1,'Murloc Oracle: Wowhead Forever drop 2/28928'),
(547,0,251526,0.002,0,1,0,1,1,'Great Goretusk: Wowhead Forever drop 3/163009'),
(578,0,248707,0.005,0,1,0,1,1,'Murloc Scout: Wowhead Forever drop 2/42736'),
(589,0,262888,0.006,0,1,0,1,1,'Defias Pillager: Wowhead Forever drop 5/83133'),
(590,0,248707,0.002,0,1,0,1,1,'Defias Looter: Wowhead Forever drop 2/109104'),
(590,0,262888,0.002,0,1,0,1,1,'Defias Looter: Wowhead Forever drop 2/109104'),
(642,0,285292,1.819,0,1,0,1,1,'Sneed''s Shredder: Dull Sawblade - Wowhead Forever 240/13196'),
(644,0,273289,1.558,0,1,0,1,1,'Rhahk''Zor: Ogre Loincloth - Wowhead Forever 170/10908'),
(645,0,273102,0.119,0,1,0,1,1,'Cookie: Cookie - Wowhead Forever 17/14273 (refreshed 1106)'),
(645,0,273298,1.045,0,1,0,1,1,'Cookie: Lookie''s Spyglass - Wowhead Forever 154/14738'),
(646,0,284715,1.01,0,1,0,1,1,'Mr. Smite: First Mate Band - Wowhead Forever 158/15640'),
(712,0,251526,0.004,0,1,0,1,1,'Redridge Thrasher: Wowhead Forever drop 1/25089'),
(757,0,258530,1.014,0,1,0,1,1,'Lost One Fisherman: Lucky Lure - Wowhead Forever 57/5621'),
(830,0,262888,0.02,0,1,0,1,1,'Sand Crawler: Wowhead Forever drop 3/15235'),
(1020,0,250187,0.008,0,1,0,1,1,'Mottled Raptor: Wowhead Forever drop 6/72578'),
(1116,0,267415,48,1,1,0,1,1,'Rockjaw Ambusher: Wowhead Forever drop 761/9171 x1.84 floor 48.0 (quest item, INFERRED)'),
(1118,0,267415,48,1,1,0,1,1,'Rockjaw Backbreaker: Wowhead Forever drop 109/1783 x1.84 floor 48.0 (quest item, INFERRED)'),
(1134,0,250375,0.073,0,1,0,1,1,'Young Wendigo: Wowhead Forever drop 28/38538'),
(1184,0,262888,0.01,0,1,0,1,1,'Cliff Lurker: Wowhead Forever drop 2/20558'),
(1197,0,2267,3,0,1,0,1,1,'Stonesplinter Shaman: Stonesplinter Mace'),
(1236,0,262888,0.027,0,1,0,1,1,'Kobold Digger: Wowhead Forever drop 3/11097'),
(1393,0,262888,0.026,0,1,0,1,1,'Berserk Trogg: Wowhead Forever drop 3/11510'),
(1397,0,249879,0.338,0,1,0,1,1,'Frostmane Seer: Wowhead Forever drop 103/30481'),
(1426,0,262888,0.024,0,1,0,1,1,'Riverpaw Miner: Wowhead Forever drop 3/12525'),
(1663,0,252512,0.029,0,1,0,1,1,'Dextren Ward: Brawler''s Leather Helm - Wowhead Forever 3/10287'),
(1663,0,252515,0.029,0,1,0,1,1,'Dextren Ward: Wisdom''s Leather Helm - Wowhead Forever 3/10287'),
(1663,0,273817,2.003,0,1,0,1,1,'Dextren Ward: Graverobber''s Shovel - Wowhead Forever 206/10287'),
(1663,0,273819,1.76,0,1,0,1,1,'Dextren Ward: Boneslicer - Wowhead Forever 181/10287'),
(1663,0,273820,1.361,0,1,0,1,1,'Dextren Ward: Nightskulker Ring - Wowhead Forever 140/10287'),
(1665,0,248707,0.107,0,1,0,1,1,'Captain Melrache: Wowhead Forever drop 2/1870'),
(1666,0,252513,0.038,0,1,0,1,1,'Kam Deepfury: Trapper''s Leather Helm - Wowhead Forever 3/7984'),
(1666,0,252515,0.05,0,1,0,1,1,'Kam Deepfury: Wisdom''s Leather Helm - Wowhead Forever 4/7984'),
(1666,0,273807,2.192,0,1,0,1,1,'Kam Deepfury: Demolition Girdle - Wowhead Forever 175/7984'),
(1666,0,273808,1.829,0,1,0,1,1,'Kam Deepfury: Bridgebreaker Bindings - Wowhead Forever 146/7984'),
(1696,0,273804,1.504,0,1,0,1,1,'Targorr the Dread: Executioner Mantle - Wowhead Forever 189/12563'),
(1696,0,273805,1.703,0,1,0,1,1,'Targorr the Dread: Blackrock Harness - Wowhead Forever 214/12563'),
(1696,0,273806,1.68,0,1,0,1,1,'Targorr the Dread: Dark Horde Band - Wowhead Forever 211/12563'),
(1706,0,274092,0.029,0,1,0,1,1,'Defias Prisoner: Sharpened Cutlery - Wowhead Forever 45/157375'),
(1707,0,274092,0.024,0,1,0,1,1,'Defias Captive: Sharpened Cutlery - Wowhead Forever 38/158154'),
(1708,0,274092,0.041,0,1,0,1,1,'Defias Inmate: Sharpened Cutlery - Wowhead Forever 86/208092'),
(1711,0,274092,0.025,0,1,0,1,1,'Defias Convict: Sharpened Cutlery - Wowhead Forever 18/71216'),
(1715,0,274092,0.036,0,1,0,1,1,'Defias Insurgent: Sharpened Cutlery - Wowhead Forever 41/112885'),
(1716,0,252455,0.044,0,1,0,1,1,'Bazil Thredd: Defender''s Leather Helm - Wowhead Forever 5/11384'),
(1716,0,252515,0.044,0,1,0,1,1,'Bazil Thredd: Wisdom''s Leather Helm - Wowhead Forever 5/11384'),
(1716,0,273824,0.984,0,1,0,1,1,'Bazil Thredd: Defias Jailbreakers - Wowhead Forever 112/11384'),
(1716,0,273825,0.922,0,1,0,1,1,'Bazil Thredd: Red Wool Cloak - Wowhead Forever 105/11384'),
(1716,0,273827,1.23,0,1,0,1,1,'Bazil Thredd: Debt Collector - Wowhead Forever 140/11384'),
(1716,0,273829,0.94,0,1,0,1,1,'Bazil Thredd: Concealed Hand Crossbow - Wowhead Forever 107/11384'),
(1717,0,252512,0.075,0,1,0,1,1,'Hamhock: Brawler''s Leather Helm - Wowhead Forever 6/7952'),
(1717,0,252513,0.063,0,1,0,1,1,'Hamhock: Trapper''s Leather Helm - Wowhead Forever 5/7952'),
(1717,0,273809,1.748,0,1,0,1,1,'Hamhock: Hamhock''s Cleaver - Wowhead Forever 139/7952'),
(1717,0,273810,1.471,0,1,0,1,1,'Hamhock: Ogre Grips - Wowhead Forever 117/7952'),
(1717,0,273811,1.786,0,1,0,1,1,'Hamhock: Repurposed Rack - Wowhead Forever 142/7952'),
(1763,0,273086,0.155,0,1,0,1,1,'Gilnid: Gilnid - Wowhead Forever 22/14186 (refreshed 1106)'),
(1763,0,273297,1.305,0,1,0,1,1,'Gilnid: Goblin Hammer - Wowhead Forever 191/14638'),
(1768,0,248707,0.046,0,1,0,1,1,'Vile Fin Tidehunter: Wowhead Forever drop 2/4371'),
(1768,0,249474,0.206,0,1,0,1,1,'Vile Fin Tidehunter: Wowhead Forever drop 9/4371'),
(1781,0,262888,0.016,0,1,0,1,1,'Mist Creeper: Wowhead Forever drop 3/18316'),
(1782,0,262888,0.014,0,1,0,1,1,'Moonrage Darksoul: Wowhead Forever drop 3/21412'),
(1815,0,241652,5.285,0,1,0,1,1,'Diseased Black Bear: Diseased Black Bear - Wowhead Forever drop (1034)'),
(1816,0,241652,3.854,0,1,0,1,1,'Diseased Grizzly: Diseased Grizzly - Wowhead Forever drop (1034)'),
(1817,0,241652,4.945,0,1,0,1,1,'Diseased Wolf: Diseased Wolf - Wowhead Forever drop (1034)'),
(1821,0,241652,4.179,0,1,0,1,1,'Carrion Lurker: Carrion Lurker - Wowhead Forever drop (1034)'),
(1824,0,241652,6.897,0,1,0,1,1,'Plague Lurker: Plague Lurker - Wowhead Forever drop (1034)'),
(1867,0,248707,0.009,0,1,0,1,1,'Dalaran Apprentice: Wowhead Forever drop 2/23267'),
(1914,0,262888,0.033,0,1,0,1,1,'Dalaran Mage: Wowhead Forever drop 6/18432'),
(1934,0,250988,0.061,0,1,0,1,1,'Tirisfal Farmer: Wowhead Forever drop 9/14678'),
(1939,0,262888,0.003,0,1,0,1,1,'Rot Hide Brute: Wowhead Forever drop 1/32779'),
(1943,0,250983,0.084,0,1,0,1,1,'Raging Rot Hide: Wowhead Forever drop 7/8377'),
(1973,0,271343,0.445,0,1,0,1,1,'Ravenclaw Guardian: Wowhead Forever drop 39/8761'),
(1974,0,271343,0.481,0,1,0,1,1,'Ravenclaw Drudger: Wowhead Forever drop 47/9781'),
(1994,0,277190,4.937,0,1,0,1,1,'Githyiss the Vile: Wowhead Forever drop 235/4760'),
(2007,0,250380,0.217,0,1,0,1,1,'Gnarlpine Gardener: Wowhead Forever drop 12/5532'),
(2102,0,262888,0.01,0,1,0,1,1,'Dragonmaw Grunt: Wowhead Forever drop 1/10237'),
(2103,0,248707,0.012,0,1,0,1,1,'Dragonmaw Scout: Wowhead Forever drop 2/17043'),
(2165,0,262888,0.006,0,1,0,1,1,'Grizzled Thistle Bear: Wowhead Forever drop 3/46922'),
(2169,0,250977,0.019,0,1,0,1,1,'Blackwood Totemic: Wowhead Forever drop 2/10309'),
(2172,0,284176,0.675,0,1,0,1,1,'Strider Clutchmother: Tallstrider Hatchling - Wowhead Forever 6/889'),
(2177,0,262888,0.005,0,1,0,1,1,'Writhing Highborne: Wowhead Forever drop 2/40141'),
(2180,0,250989,0.047,0,1,0,1,1,'Stormscale Siren: Wowhead Forever drop 8/17089'),
(2181,0,262888,0.007,0,1,0,1,1,'Stormscale Myrmidon: Wowhead Forever drop 1/14286'),
(2181,0,279276,3.44,0,1,0,1,1,'Stormscale Myrmidon: Stormscale Myrmidon - Wowhead Forever drop (724)'),
(2182,0,279276,3.017,0,1,0,1,1,'Stormscale Sorceress: Stormscale Sorceress - Wowhead Forever drop (724)'),
(2183,0,279276,2.37,0,1,0,1,1,'Stormscale Warrior: Stormscale Warrior - Wowhead Forever drop (724)'),
(2190,0,262888,0.004,0,1,0,1,1,'Wild Grell: Wowhead Forever drop 2/48049'),
(2235,0,248707,0.006,0,1,0,1,1,'Reef Crawler: Wowhead Forever drop 3/52584'),
(2237,0,262888,0.006,0,1,0,1,1,'Moonstalker Sire: Wowhead Forever drop 2/36223'),
(2258,0,283254,0.468,0,1,0,1,1,'Stone Fury: Heart of Alterac - Wowhead Forever 3/641'),
(2261,0,251335,0.013,0,1,0,1,1,'Syndicate Watchman: Wowhead Forever drop 8/61097'),
(2261,0,262888,0.002,0,1,0,1,1,'Syndicate Watchman: Wowhead Forever drop 1/61097'),
(2318,0,213421,0.051,0,1,0,1,1,'Argus Shadow Mage: Singed Note - Wowhead Forever 4/7869'),
(2319,0,213421,0.023,0,1,0,1,1,'Syndicate Wizard: Singed Note - Wowhead Forever 4/17642'),
(2321,0,262888,0.004,0,1,0,1,1,'Foreststrider Fledgling: Wowhead Forever drop 2/53477'),
(2336,0,262888,0.005,0,1,0,1,1,'Dark Strand Fanatic: Wowhead Forever drop 2/42883'),
(2339,0,262888,0.033,0,1,0,1,1,'Twilight Thug: Wowhead Forever drop 6/18270'),
(2351,0,262888,0.004,0,1,0,1,1,'Gray Bear: Wowhead Forever drop 3/67950'),
(2354,0,262888,0.002,0,1,0,1,1,'Vicious Gray Bear: Wowhead Forever drop 2/83711'),
(2554,0,216483,0.043,0,1,0,1,1,'Witherbark Axe Thrower: Witherbark Mallet - Wowhead Forever 20/46252'),
(2555,0,216483,0.009,0,1,0,1,1,'Witherbark Witch Doctor: Witherbark Mallet - Wowhead Forever 5/52783'),
(2556,0,216483,0.012,0,1,0,1,1,'Witherbark Headhunter: Witherbark Mallet - Wowhead Forever 7/57297'),
(2563,0,278225,0.198,0,1,0,1,1,'Plains Creeper: Surgical Spidersilk - Wowhead Forever 73/36936'),
(2564,0,213422,0.017,0,1,0,1,1,'Boulderfist Enforcer: Illegible Recipe - Wowhead Forever 3/17980'),
(2566,0,213422,0.021,0,1,0,1,1,'Boulderfist Brute: Illegible Recipe - Wowhead Forever 5/23442'),
(2569,0,213422,0.057,0,1,0,1,1,'Boulderfist Mauler: Illegible Recipe - Wowhead Forever 5/8741'),
(2570,0,213422,0.172,0,1,0,1,1,'Boulderfist Shaman: Illegible Recipe - Wowhead Forever 21/12203'),
(2571,0,213422,0.232,0,1,0,1,1,'Boulderfist Lord: Illegible Recipe - Wowhead Forever 16/6883'),
(2701,0,211269,0.15,0,1,0,1,1,'Dustbelcher Ogre: Primitive Drawing - Wowhead Forever 7/4676'),
(2715,0,211269,0.21,0,1,0,1,1,'Dustbelcher Brute: Primitive Drawing - Wowhead Forever 5/2382'),
(2716,0,211269,0.036,0,1,0,1,1,'Dustbelcher Wyrmhunter: Primitive Drawing - Wowhead Forever 5/13906'),
(2717,0,211269,0.026,0,1,0,1,1,'Dustbelcher Mauler: Primitive Drawing - Wowhead Forever 4/15379'),
(2893,0,211269,0.032,0,1,0,1,1,'Stonevault Bonesnapper: Primitive Drawing - Wowhead Forever 20/62968'),
(2894,0,211269,0.016,0,1,0,1,1,'Stonevault Shaman: Primitive Drawing - Wowhead Forever 3/18844'),
(2906,0,211269,0.034,0,1,0,1,1,'Dustbelcher Warrior: Primitive Drawing - Wowhead Forever 3/8698'),
(2962,0,249865,0.816,0,1,0,1,1,'Windfury Harpy: Peace Tea - Wowhead Forever 278/34051'),
(2975,0,250375,0.021,0,1,0,1,1,'Venture Co. Hireling: Wowhead Forever drop 2/9333'),
(3115,0,250976,0.011,0,1,0,1,1,'Dustwind Harpy: Wowhead Forever drop 4/36628'),
(3128,0,250380,0.063,0,1,0,1,1,'Kul Tiras Sailor: Wowhead Forever drop 48/75802'),
(3242,0,262888,0.004,0,1,0,1,1,'Zhevra Runner: Wowhead Forever drop 4/110141'),
(3244,0,262888,0.003,0,1,0,1,1,'Greater Plainstrider: Wowhead Forever drop 7/200866'),
(3245,0,248707,0.002,0,1,0,1,1,'Ornery Plainstrider: Wowhead Forever drop 2/87093'),
(3246,0,262888,0.006,0,1,0,1,1,'Fleeting Plainstrider: Wowhead Forever drop 5/80296'),
(3253,0,286534,0.713,0,1,0,1,1,'Silithid Harvester: Silithid Piercer - Wowhead Forever 3/421'),
(3255,0,250187,0.204,0,1,0,1,1,'Sunscale Screecher: Wowhead Forever drop 232/113979'),
(3255,0,262888,0.004,0,1,0,1,1,'Sunscale Screecher: Wowhead Forever drop 5/113979'),
(3256,0,262888,0.001,0,1,0,1,1,'Sunscale Scytheclaw: Wowhead Forever drop 2/154779'),
(3269,0,262888,0.006,0,1,0,1,1,'Razormane Geomancer: Wowhead Forever drop 2/35710'),
(3272,0,262888,0.002,0,1,0,1,1,'Kolkar Wrangler: Wowhead Forever drop 2/126078'),
(3276,0,262888,0.005,0,1,0,1,1,'Witchwing Harpy: Wowhead Forever drop 4/77258'),
(3277,0,248707,0.004,0,1,0,1,1,'Witchwing Roguefeather: Wowhead Forever drop 3/70882'),
(3277,0,262888,0.008,0,1,0,1,1,'Witchwing Roguefeather: Wowhead Forever drop 6/70882'),
(3280,0,250977,0.033,0,1,0,1,1,'Witchwing Windcaller: Wowhead Forever drop 11/33255'),
(3283,0,262888,0.002,0,1,0,1,1,'Venture Co. Enforcer: Wowhead Forever drop 1/55374'),
(3295,0,286535,0.641,0,1,0,1,1,'Sludge Beast: Sludge-Stained Band - Wowhead Forever 4/624'),
(3384,0,262888,0.018,0,1,0,1,1,'Southsea Privateer: Wowhead Forever drop 1/5470'),
(3385,0,248707,0.003,0,1,0,1,1,'Theramore Marine: Wowhead Forever drop 4/114451'),
(3385,0,262888,0.002,0,1,0,1,1,'Theramore Marine: Wowhead Forever drop 2/114451'),
(3386,0,250989,0.083,0,1,0,1,1,'Theramore Preserver: Wowhead Forever drop 18/21751'),
(3386,0,262888,0.014,0,1,0,1,1,'Theramore Preserver: Wowhead Forever drop 3/21751'),
(3425,0,262888,0.008,0,1,0,1,1,'Savannah Prowler: Wowhead Forever drop 8/103424'),
(3454,0,248707,0.087,0,1,0,1,1,'Cannoneer Smythe: Wowhead Forever drop 2/2303'),
(3455,0,248707,0.146,0,1,0,1,1,'Cannoneer Whessan: Wowhead Forever drop 3/2050'),
(3459,0,248707,0.004,0,1,0,1,1,'Razormane Warfrenzy: Wowhead Forever drop 1/27767'),
(3461,0,262888,0.002,0,1,0,1,1,'Oasis Snapjaw: Wowhead Forever drop 2/85461'),
(3467,0,262888,0.009,0,1,0,1,1,'Baron Longshore: Wowhead Forever drop 1/11151'),
(3535,0,284167,0.524,0,1,0,1,1,'Blackmoss the Fetid: Blackmoss Robes - Wowhead Forever 6/1146'),
(3653,0,273084,1.168,0,1,0,1,1,'Kresh: Cloak of Hermitic Bliss - Wowhead Forever 89/7618'),
(3670,0,273089,1.711,0,1,0,1,1,'Lord Pythas: Slither Cord - Wowhead Forever 167/9760'),
(3671,0,273088,2.04,0,1,0,1,1,'Lady Anacondra: Snake Eye Kaleidoscope - Wowhead Forever 177/8676'),
(3671,0,273098,0.257,0,1,0,1,1,'Lady Anacondra: Lady Anacondra - Wowhead Forever 21/8167 (refreshed 1106)'),
(3673,0,273087,0.273,0,1,0,1,1,'Lord Serpentis: Lord Serpentis - Wowhead Forever 25/9169 (refreshed 1106)'),
(3674,0,273137,2.631,0,1,0,1,1,'Skum: Skum''s Bucket - Wowhead Forever 242/9197'),
(3757,0,250368,0.021,0,1,0,1,1,'Xavian Hellcaller: Xavian Hellcaller - Wowhead Forever 2/9553'),
(3809,0,250182,0.036,0,1,0,1,1,'Ashenvale Bear: Wowhead Forever drop 15/41099'),
(3809,0,262888,0.002,0,1,0,1,1,'Ashenvale Bear: Wowhead Forever drop 1/41099'),
(3817,0,252804,0.047,0,1,0,1,1,'Shadowhorn Stag: Wowhead Forever drop 3/6440'),
(3886,0,273096,0.216,0,1,0,1,1,'Razorclaw the Butcher: Razorclaw the Butcher - Wowhead Forever 36/16677 (refreshed 1106)'),
(3887,0,273637,1.721,0,1,0,1,1,'Baron Silverlaine: Blade of Silverlaine - Wowhead Forever 295/17141'),
(3914,0,273456,1.677,0,1,0,1,1,'Rethilgore: Cell Keeper''s Claws - Wowhead Forever 193/11507'),
(3914,0,273457,2.094,0,1,0,1,1,'Rethilgore: Sorcerer Collar - Wowhead Forever 241/11507'),
(3927,0,273647,1.754,0,1,0,1,1,'Wolf Master Nandos: Worgpelt Leggings - Wowhead Forever 220/12546'),
(3943,0,262888,0.039,0,1,0,1,1,'Ruuzel: Wowhead Forever drop 1/2576'),
(3974,0,273109,0.022,0,1,0,1,1,'Houndmaster Loksey: Houndmaster Loksey - Wowhead Forever 4/18253 (1387)'),
(3983,0,252455,0.021,0,1,0,1,1,'Interrogator Vishas: Defender''s Leather Helm - Wowhead Forever 3/14477'),
(3983,0,274290,1.25,0,1,0,1,1,'Interrogator Vishas: Painwalker Buckler - Wowhead Forever 181/14477'),
(3988,0,210188,0.065,0,1,0,1,1,'Venture Co. Operator: Shredded Work Order - Wowhead Forever 17/26315'),
(3989,0,210188,0.012,0,1,0,1,1,'Venture Co. Logger: Shredded Work Order - Wowhead Forever 8/67559'),
(3991,0,210187,0.022,0,1,0,1,1,'Venture Co. Deforester: Venture Co. Work Order - Wowhead Forever 6/26746'),
(4003,0,249880,0.009,0,1,0,1,1,'Windshear Geomancer: Wowhead Forever drop 1/10996'),
(4127,0,248707,0.006,0,1,0,1,1,'Hecklefang Hyena: Wowhead Forever drop 3/49715'),
(4274,0,273646,1.988,0,1,0,1,1,'Fenrus the Devourer: Half-Eaten Boots - Wowhead Forever 293/14739'),
(4278,0,273105,0.238,0,1,0,1,1,'Commander Springvale: Commander Springvale - Wowhead Forever 38/15943 (refreshed 1106)'),
(4278,0,273643,1.67,0,1,0,1,1,'Commander Springvale: Worgenbane Talisman - Wowhead Forever 274/16406'),
(4279,0,273645,1.721,0,1,0,1,1,'Odo the Blindwatcher: Blindwatcher''s Sight - Wowhead Forever 271/15749'),
(4283,0,215376,0.023,0,1,0,1,1,'Scarlet Sentry: Crusader''s Mace - Wowhead Forever 5/21350'),
(4287,0,215374,0.002,0,1,0,1,1,'Scarlet Gallant: Ancestral Sword - Wowhead Forever 3/120887'),
(4287,0,215375,0.002,0,1,0,1,1,'Scarlet Gallant: Tactician''s Staff - Wowhead Forever 3/120887'),
(4287,0,215376,0.003,0,1,0,1,1,'Scarlet Gallant: Crusader''s Mace - Wowhead Forever 4/120887'),
(4288,0,215374,0.014,0,1,0,1,1,'Scarlet Beastmaster: Ancestral Sword - Wowhead Forever 3/22165'),
(4296,0,215374,0.012,0,1,0,1,1,'Scarlet Adept: Ancestral Sword - Wowhead Forever 3/25707'),
(4306,0,215374,0.012,0,1,0,1,1,'Scarlet Torturer: Ancestral Sword - Wowhead Forever 7/60686'),
(4306,0,215375,0.01,0,1,0,1,1,'Scarlet Torturer: Tactician''s Staff - Wowhead Forever 6/60686'),
(4306,0,215376,0.012,0,1,0,1,1,'Scarlet Torturer: Crusader''s Mace - Wowhead Forever 7/60686'),
(4308,0,262889,0.005,0,1,0,1,1,'Unfettered Spirit: Sealed Expert''s Writ - Wowhead Forever 6/126620'),
(4420,0,252515,0.052,0,1,0,1,1,'Overlord Ramtusk: Wisdom''s Leather Helm - Wowhead Forever 3/5767'),
(4420,0,274161,2.376,0,1,0,1,1,'Overlord Ramtusk: Quillord Mail Leggings - Wowhead Forever 137/5767'),
(4421,0,252455,0.044,0,1,0,1,1,'Charlga Razorflank: Defender''s Leather Helm - Wowhead Forever 3/6878'),
(4421,0,252456,0.044,0,1,0,1,1,'Charlga Razorflank: Totemic Leather Helm - Wowhead Forever 3/6878'),
(4421,0,252512,0.058,0,1,0,1,1,'Charlga Razorflank: Brawler''s Leather Helm - Wowhead Forever 4/6878'),
(4421,0,252515,0.058,0,1,0,1,1,'Charlga Razorflank: Wisdom''s Leather Helm - Wowhead Forever 4/6878'),
(4422,0,252455,0.07,0,1,0,1,1,'Agathelos the Raging: Defender''s Leather Helm - Wowhead Forever 4/5726'),
(4424,0,252512,0.134,0,1,0,1,1,'Aggem Thorncurse: Brawler''s Leather Helm - Wowhead Forever 4/2992'),
(4424,0,252515,0.167,0,1,0,1,1,'Aggem Thorncurse: Wisdom''s Leather Helm - Wowhead Forever 5/2992'),
(4424,0,274158,4.144,0,1,0,1,1,'Aggem Thorncurse: Death Prophet Spine - Wowhead Forever 124/2992'),
(4424,0,274159,4.512,0,1,0,1,1,'Aggem Thorncurse: Thorncursed Grips - Wowhead Forever 135/2992'),
(4829,0,252456,0.048,0,1,0,1,1,'Aku''mai: Totemic Leather Helm - Wowhead Forever 3/6263'),
(4829,0,252512,0.096,0,1,0,1,1,'Aku''mai: Brawler''s Leather Helm - Wowhead Forever 6/6263'),
(4832,0,252455,0.048,0,1,0,1,1,'Twilight Lord Kelris: Defender''s Leather Helm - Wowhead Forever 4/8313'),
(4832,0,252456,0.036,0,1,0,1,1,'Twilight Lord Kelris: Totemic Leather Helm - Wowhead Forever 3/8313'),
(4832,0,252513,0.036,0,1,0,1,1,'Twilight Lord Kelris: Trapper''s Leather Helm - Wowhead Forever 3/8313'),
(4832,0,252514,0.036,0,1,0,1,1,'Twilight Lord Kelris: Stormrider''s Leather Helm - Wowhead Forever 3/8313'),
(4832,0,252515,0.048,0,1,0,1,1,'Twilight Lord Kelris: Wisdom''s Leather Helm - Wowhead Forever 4/8313'),
(4832,0,273846,3.152,0,1,0,1,1,'Twilight Lord Kelris: Twilight Lord Girdle - Wowhead Forever 262/8313'),
(4887,0,273839,4.186,0,1,0,1,1,'Ghamoo-ra: Spiked Shell Band - Wowhead Forever 298/7119'),
(5356,0,285043,0.763,0,1,0,1,1,'Snarler: Snarling Fang - Wowhead Forever 3/393'),
(5471,0,278186,0.012,0,1,0,1,1,'Dunemaul Ogre: Wowhead Forever drop 1/8085'),
(5472,0,278186,0.003,0,1,0,1,1,'Dunemaul Enforcer: Wowhead Forever drop 1/37462'),
(5473,0,278186,0.012,0,1,0,1,1,'Dunemaul Ogre Mage: Wowhead Forever drop 1/8255'),
(5474,0,278186,0.003,0,1,0,1,1,'Dunemaul Brute: Wowhead Forever drop 1/37973'),
(5475,0,278186,0.012,0,1,0,1,1,'Dunemaul Warlock: Wowhead Forever drop 1/8116'),
(5787,0,284361,2.2,0,1,0,1,1,'Enforcer Emilgund: Venture Company Legguards - Wowhead Forever 13/591'),
(5797,0,285347,4.794,0,1,0,1,1,'Aean Swiftriver: Alliance Outrunner Bow - Wowhead Forever 64/1335'),
(5798,0,285346,7.261,0,1,0,1,1,'Thora Feathermoon: Alliance Outrunner''s Sword - Wowhead Forever 79/1088'),
(5799,0,285348,12.475,0,1,0,1,1,'Hannah Bladeleaf: Alliance Outrunner Healing Rod - Wowhead Forever 63/505'),
(5800,0,285350,11.632,0,1,0,1,1,'Marcus Bel: Alliance Outrunner Staff - Wowhead Forever 62/533'),
(5808,0,284321,0.939,0,1,0,1,1,'Warlord Kolkanis: Centaur Raider''s Axe - Wowhead Forever 10/1065'),
(5809,0,284322,0.833,0,1,0,1,1,'Watch Commander Zalaphil: Invading Marine''s Shield - Wowhead Forever 8/960'),
(5822,0,284287,1.442,0,1,0,1,1,'Felweaver Scornn: Felweaver Scornn - Wowhead Forever drop (724)'),
(5823,0,284320,0.701,0,1,0,1,1,'Death Flayer: Flayed Scorpid Bands - Wowhead Forever 3/428'),
(5824,0,284286,4.71,0,1,0,1,1,'Captain Flat Tusk: Battleguard Captain''s Sticker - Wowhead Forever 26/552'),
(5826,0,284323,1.458,0,1,0,1,1,'Geolord Mottle: Geolord''s Mitts - Wowhead Forever 19/1303'),
(5827,0,285338,4.24,0,1,0,1,1,'Brontus: Kodohide Legguards - Wowhead Forever 12/283'),
(5829,0,286536,1.415,0,1,0,1,1,'Snort the Heckler: Heckler''s Hide - Wowhead Forever 9/636'),
(5830,0,285345,0.884,0,1,0,1,1,'Sister Rathtalon: Feather Padded Treads - Wowhead Forever 8/905'),
(5831,0,285330,5.405,0,1,0,1,1,'Swiftmane: Signet of the Zhevra - Wowhead Forever 28/518'),
(5832,0,286537,0.675,0,1,0,1,1,'Thunderstomp: Thunderstomp''s Horn - Wowhead Forever 4/593'),
(5835,0,285351,0.636,0,1,0,1,1,'Foreman Grills: Foreman''s Enforcers - Wowhead Forever 4/629'),
(5836,0,285366,2.483,0,1,0,1,1,'Engineer Whirleygig: Whirleygig''s Supply Stash - Wowhead Forever 15/604'),
(5841,0,285339,3.279,0,1,0,1,1,'Rocklance: Centaur War Chain - Wowhead Forever 24/732'),
(5842,0,285329,5.869,0,1,0,1,1,'Takk the Leaper: Raptor Hide Cloak - Wowhead Forever 25/426'),
(5859,0,285328,0.704,0,1,0,1,1,'Hagg Taurenbane: Taurenbane''s Family Cleaver - Wowhead Forever 3/426'),
(5865,0,286533,2.03,0,1,0,1,1,'Dishu: Cheetah Hide Grips - Wowhead Forever 11/542'),
(6073,0,209779,1.942,0,1,0,1,2,'Searing Infernal: Mote of Mannoroth - Wowhead Forever 41/2111'),
(6115,0,209779,2.765,0,1,0,1,1,'Felguard: Mote of Mannoroth - Wowhead Forever 37/1338'),
(6168,0,274149,2.725,0,1,0,1,1,'Roogug: Thornweaver Drape - Wowhead Forever 36/1321'),
(6168,0,274152,2.952,0,1,0,1,1,'Roogug: Roogug''s Severed Head - Wowhead Forever 39/1321'),
(6168,0,274155,3.255,0,1,0,1,1,'Roogug: Geomancer Headdress - Wowhead Forever 43/1321'),
(6229,0,274068,0.97,0,1,0,1,1,'Crowd Pummeler 9-60: Thermaplugg Medal of Honor - Wowhead Forever 82/8455'),
(6243,0,252456,0.097,0,1,0,1,1,'Gelihast: Totemic Leather Helm - Wowhead Forever 6/6169'),
(6243,0,252512,0.097,0,1,0,1,1,'Gelihast: Brawler''s Leather Helm - Wowhead Forever 6/6169'),
(6243,0,273141,0.773,0,1,0,1,1,'Gelihast: Gelihast - Wowhead Forever 44/5689 (refreshed 1106)'),
(6243,0,273840,4.328,0,1,0,1,1,'Gelihast: Cursed Murloc Eye - Wowhead Forever 267/6169'),
(6490,0,252512,0.111,0,1,0,1,1,'Azshir the Sleepless: Brawler''s Leather Helm - Wowhead Forever 3/2701'),
(7017,0,14146,0.03,0,1,0,1,1,'Lord Sinslayer: Gloves of Spell Mastery'),
(7017,0,284177,0.722,0,1,0,1,1,'Lord Sinslayer: Sinslayer''s Smasher - Wowhead Forever 4/554'),
(7235,0,250988,0.084,0,1,0,1,1,'Gnarlpine Mystic: Wowhead Forever drop 13/15532'),
(7800,0,7192,0.449,0,1,0,1,1,'Mekgineer Thermaplugg: Schematic: Goblin Rocket Boots - Wowhead Forever 27/6007'),
(8596,0,241652,5.787,0,1,0,1,1,'Plaguehound Runt: Plaguehound Runt - Wowhead Forever drop (1034)'),
(8597,0,241652,4.985,0,1,0,1,1,'Plaguehound: Plaguehound - Wowhead Forever drop (1034)'),
(8598,0,241652,5.088,0,1,0,1,1,'Frenzied Plaguehound: Frenzied Plaguehound - Wowhead Forever drop (1034)'),
(8600,0,241652,5.014,0,1,0,1,1,'Plaguebat: Plaguebat - Wowhead Forever drop (1034)'),
(8601,0,241652,5.034,0,1,0,1,1,'Noxious Plaguebat: Noxious Plaguebat - Wowhead Forever drop (1034)'),
(8602,0,241652,4.938,0,1,0,1,1,'Monstrous Plaguebat: Monstrous Plaguebat - Wowhead Forever drop (1034)'),
(8603,0,241652,5.401,0,1,0,1,1,'Carrion Grub: Carrion Grub - Wowhead Forever drop (1034)'),
(8605,0,241652,3.48,0,1,0,1,1,'Carrion Devourer: Carrion Devourer - Wowhead Forever drop (1034)'),
(10184,0,21106,1.198,0,1,0,1,1,'Onyxia: Draconic for Dummies - Wowhead Forever 453/37824'),
(10356,0,283462,1.908,0,1,0,1,1,'Bayne: Bayne''s Bite - Wowhead Forever 15/786'),
(10357,0,283473,1.085,0,1,0,1,1,'Ressan the Needler: Batwing Bindings - Wowhead Forever 5/461'),
(10358,0,283471,1.002,0,1,0,1,1,'Fellicent''s Shade: Fellicent''s Bindings - Wowhead Forever 14/1397'),
(10359,0,283480,4.587,0,1,0,1,1,'Sri''skulk: Cracked Carapace Hauberk - Wowhead Forever 15/327'),
(10363,0,272017,0.019,0,1,0,1,1,'General Drakkisath: Wowhead Forever drop 1/5179'),
(10374,0,140,0.48,0,1,0,1,1,'Spire Spider: Brawler''s Boots'),
(10429,0,227911,0.205,0,1,0,1,1,'Warchief Rend Blackhand: Head of Rend Blackhand - Wowhead Forever 12/5866'),
(10643,0,284702,1,0,1,0,1,1,'Mugglefin: Slimy Sword - Wowhead Forever 3/300'),
(11053,0,3841,5.4,0,1,0,1,1,'High Priestess MacDonnell: Golden Scale Shoulders'),
(11517,0,272996,3.223,0,1,0,1,1,'Oggleflint: Trogg Scepter - Wowhead Forever 152/4716'),
(11517,0,272998,2.651,0,1,0,1,1,'Oggleflint: Bone Knuckles - Wowhead Forever 125/4716'),
(11517,0,272999,2.926,0,1,0,1,1,'Oggleflint: Barbaric Crossbow - Wowhead Forever 138/4716'),
(11519,0,273003,2.836,0,1,0,1,1,'Bazzalan: Searing Dagger - Wowhead Forever 164/5783'),
(11519,0,273005,2.888,0,1,0,1,1,'Bazzalan: Satyrskin Cloak - Wowhead Forever 167/5783'),
(11519,0,273007,2.819,0,1,0,1,1,'Bazzalan: Chasm Walkers - Wowhead Forever 163/5783'),
(11559,0,260347,0.211,0,1,0,1,1,'Outcast Necromancer: Tattered Journal - Wowhead Forever 8/3788'),
(11680,0,279507,0.067,0,1,0,1,1,'Horde Scout: Wowhead Forever drop 1/1498'),
(11682,0,279505,0.386,0,1,0,1,1,'Horde Grunt: Wowhead Forever drop 1/259'),
(11697,0,209779,2.796,0,1,0,1,2,'Mannoroc Lasher: Mote of Mannoroth - Wowhead Forever 25/894'),
(11915,0,251454,0.005,0,1,0,1,1,'Gogger Rock Keeper: Wowhead Forever drop 1/20483'),
(11915,0,262888,0.005,0,1,0,1,1,'Gogger Rock Keeper: Wowhead Forever drop 1/20483'),
(12431,0,283361,0.484,0,1,0,1,1,'Gorefang: Gorefang''s Runners - Wowhead Forever 5/1032'),
(12432,0,283259,0.919,0,1,0,1,1,'Old Vicejaw: Bearhide Vicegrips - Wowhead Forever 7/762'),
(12902,0,252455,0.252,0,1,0,1,1,'Lorgus Jett: Defender''s Leather Helm - Wowhead Forever 4/1586'),
(12902,0,252512,0.315,0,1,0,1,1,'Lorgus Jett: Brawler''s Leather Helm - Wowhead Forever 5/1586'),
(12902,0,273841,13.997,0,1,0,1,1,'Lorgus Jett: Twilight Maul - Wowhead Forever 222/1586'),
(12902,0,273842,9.899,0,1,0,1,1,'Lorgus Jett: Treacherous Treads - Wowhead Forever 157/1586'),
(12902,0,273843,9.962,0,1,0,1,1,'Lorgus Jett: Fallenroot Longbow - Wowhead Forever 158/1586'),
(14267,0,282639,0.527,0,1,0,1,1,'Emogg the Crusher: Emogg''s "Crusher" - Wowhead Forever 3/569'),
(14277,0,282711,1.008,0,1,0,1,1,'Lady Zephris: Naga Maiden''s Gown - Wowhead Forever 4/397'),
(14326,0,245675,16.667,0,1,0,1,1,'Guard Mol''dar: Guard Mol''dar - Wowhead Forever drop (1034)'),
(14429,0,284166,1.213,0,1,0,1,1,'Grimmaw: Grimmaw - Wowhead Forever drop (724)'),
(14430,0,284165,1.505,0,1,0,1,1,'Duskstalker: Duskstalker''s Hide - Wowhead Forever 9/598'),
(246016,0,273043,29.2453,0,1,0,1,1,'Arcanic Enigma: Wand of Mana Concentration - Wowhead Forever 31/106 (1291)'),
(246016,0,273044,34.9057,0,1,0,1,1,'Arcanic Enigma: Violet Sorcerer''s Robes - Wowhead Forever 37/106 (1291)'),
(246016,0,273045,35.8491,0,1,0,1,1,'Arcanic Enigma: Drape of Shifting Energy - Wowhead Forever 38/106 (1291)'),
(250283,0,250366,1.393,0,1,0,1,1,'Vile Fin Attacker: Wowhead Forever drop 16/1149'),
(259385,0,263015,15.385,0,1,0,1,1,'Tel''daeor the Stormspeaker: Wowhead Forever drop 6/39'),
(259385,0,263016,20.513,0,1,0,1,1,'Tel''daeor the Stormspeaker: Wowhead Forever drop 8/39'),
(259385,0,263017,12.821,0,1,0,1,1,'Tel''daeor the Stormspeaker: Wowhead Forever drop 5/39'),
(259388,0,285228,18.75,0,1,0,1,1,'Mystmane: Mystmane: Mystmane''s Pelt (Wowhead Forever 3/16)'),
(259394,0,285264,50,0,1,0,1,1,'Snapbeak the Quick: Wowhead Forever drop 2/4'),
(259394,0,285269,50,0,1,0,1,1,'Snapbeak the Quick: Wowhead Forever drop 2/4'),
(260325,0,271100,9.1,1,1,0,1,1,'Shadetooth: Thicket Raptor Meat (975)'),
(260325,0,273025,27.0833,0,1,0,1,1,'Shadetooth: Raptorclaw Greaves - Wowhead Forever 91/336 (1317)'),
(260325,0,273026,32.4405,0,1,0,1,1,'Shadetooth: Garb of Florid Feathers - Wowhead Forever 109/336 (1317)'),
(260325,0,273027,33.631,0,1,0,1,1,'Shadetooth: Raptor''s Gaze - Wowhead Forever 113/336 (1317)'),
(260325,0,273106,6.854,0,1,0,1,1,'Shadetooth: Shadetooth - Wowhead Forever 22/321 (refreshed 1106)'),
(260326,0,270865,100,0,1,0,1,1,'Relic Guardian: Titan Relic (Alliance) (975)'),
(260326,0,273028,33.6299,0,1,0,1,1,'Relic Guardian: Reliquary Mantle - Wowhead Forever 189/562 (1317)'),
(260326,0,273029,33.452,0,1,0,1,1,'Relic Guardian: Golemsight Long Gun - Wowhead Forever 188/562 (1317)'),
(260326,0,273030,27.9359,0,1,0,1,1,'Relic Guardian: Ring of Power Regulation - Wowhead Forever 157/562 (1317)'),
(260326,0,273097,7.664,0,1,0,1,1,'Relic Guardian: Relic Guardian - Wowhead Forever 41/535 (refreshed 1106)'),
(260396,0,268812,100,1,1,0,1,1,'Whispering Horror: Wowhead Forever drop 85/85 x1.84 floor 48.0 (quest item, INFERRED, 1328)'),
(260800,0,271100,48,1,1,0,1,1,'Thicket Lurker: Wowhead Forever drop 189/1002 x1.84 floor 48.0 (quest item, INFERRED, 1328)'),
(260801,0,271100,48,1,1,0,1,1,'Thicket Hunter: Wowhead Forever drop 188/940 x1.84 floor 48.0 (quest item, INFERRED, 1328)'),
(264082,0,273658,97.938,0,1,0,1,1,'Broodmother Valraxx: Bloody Parchment - Wowhead Forever 95/97'),
(271080,0,283460,24.194,0,1,0,1,1,'Blightsculler: Wowhead Forever drop 15/62'),
(271903,0,279276,58.824,0,1,0,1,1,'Stormscale Beastmistress: Wowhead Forever drop 10/17'),
(272034,0,250982,0.971,0,1,0,1,1,'Hatescreech: Wowhead Forever drop 2/206'),
(276061,0,255154,7.692,0,1,0,1,1,'Decrepit Harvester: Wowhead Forever drop 4/52'),
(276108,0,286752,25,0,1,0,1,1,'Thornstarter Igleg: Wowhead Forever drop 4/16');
