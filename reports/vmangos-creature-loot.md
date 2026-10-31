# Creature loot: ours vs VMaNGOS 1.12

Fix file: `sql/custom/world/2026_10_24_10_world_classic_vmangos_creature_loot.sql`.

## Why the drops felt bad

The world baseline (`2026_09_27_00_world_forever_baseline_01/02`) holds a correct copy of the VMaNGOS 1.12 loot
(VMaNGOS core 13b49dc of 2026-09-06; VMaNGOS has no loot change after it). A later file,
`2026_10_01_04_world_forever_sniff_npc.sql` (the sniff import), takes every quest item that the Forever creature
query lists, deletes the database row for it and inserts it again at a flat 40% with the comment
"quest item of the creature query (drop not seen in the sniffs)". That runs after the baseline, so it replaced the
vanilla chances for vanilla creatures too: Tough Wolf Meat 80% -> 40%, Red Burlap Bandana 80% -> 40%,
Garrick's Head 100% -> 40%, and so on for 254 rows on 215 loot tables. The live server's drop rates are all 1
(server-bot `worldserver.conf`, conf.d has no Rate.Drop line), the loot code is stock TrinityCore, so the data
was the cause.

The Discord report from Northshire, checked against the data:

| Report | Before (live data) | VMaNGOS / after the fix |
|---|---|---|
| 38 wolves for 8 meats | Tough Wolf Meat 750 on Young Wolf 299 and Timber Wolf 69: 40% quest | 80% quest |
| Bandanas slow | Red Burlap Bandana 752 on Defias Thug 38: 40% quest | 80% quest |
| Garrick's head on the third kill | Head of Garrick Padfoot 182 on Garrick 103: 40% quest | 100% quest |
| Zero linen | Linen Cloth 2589 only from Defias Cutpurse 94 (30%, 8 spawns); Thugs and kobolds have none | same as VMaNGOS, unchanged |
| 19 vermin before the first quest book | Forever item 247834 (starts quest 91741) on Kobold Vermin 6: 6.25% (sniff: 2 of 32 loots) | Forever-only, kept; needs more sniffs |

Quest order and the mining trainer and its quest are not loot; they are only noted here.

## What the fix does

- Creatures in both databases: 10380. For each one the loot, skinning and pickpocket tables are compared with the VMaNGOS rows converted the same way as the baseline (negative chance -> QuestRequired 1, negative mincountOrRef -> reference ItemType 1, patch 10 rows).
- Loot tables that differ and are replaced: 215 creature loot, 0 skinning, 0 pickpocket, 0 reference. Differences by kind: 40% placeholder from the sniff import 254, missing in ours 16, extra in ours 1.
- Rows of Forever-only items on those tables, and Forever quest drops of vanilla items that the VMaNGOS table does not have, are kept as they are (they belong to Forever quests; listed below as needing sniffs).
- Items the 70532 client lacks (Item.db2 of 70532): 0. Every VMaNGOS loot item exists in 70532.
- LootID, SkinLootID and PickPocketLootID of the 3160 shared creatures whose difficulty 0 row comes from the TDB base (not in our SQL) are set to the VMaNGOS ids, so the tables above are the ones they use. Rows the repo SQL already sets match VMaNGOS.
- Forever-only creatures, zones and instances are not touched.
- Checked on a local MariaDB: our loot tables rebuilt from every repo SQL file in updater order, the fix applied twice, then compared again: 0 differences left.

## Starter zones

- Northshire Valley: 41 shared creatures spawned there, 4 loot tables fixed (Defias Thug 38, Timber Wolf 69, Garrick Padfoot 103, Young Wolf 299).
- Coldridge Valley: 37 shared creatures spawned there, 3 loot tables fixed (Ragged Timber Wolf 704, Ragged Young Wolf 705, Frostmane Novice 946).
- Deathknell: 39 shared creatures spawned there, 9 loot tables fixed (Scarlet Convert 1506, Scarlet Initiate 1507, Young Scavenger 1508, Ragged Scavenger 1509, Duskbat 1512, Mangy Duskbat 1513, Meven Korgal 1667, Rattlecage Skeleton 1890, Samuel Fipps 1919).
- Shadowglen: 37 shared creatures spawned there, 3 loot tables fixed (Grell 1988, Grellkin 1989, Strigid Owl 1995).
- Valley of Trials: 55 shared creatures spawned there, 4 loot tables fixed (Dreadmaw Crocolisk 3110, Scorpid Worker 3124, Zhevra Runner 3242, Sarkoth 3281).
- Camp Narache: 32 shared creatures spawned there, 3 loot tables fixed (Plainstrider 2955, Adult Plainstrider 2956, Mountain Cougar 2961).

## Every replaced creature loot table

| Table | Creatures | Item | Ours (before) | VMaNGOS (after) |
|---|---|---|---|---|
| 2955 | Plainstrider 2955 | Plainstrider Meat 4739 | 40% quest | 80% quest |
| 2955 | Plainstrider 2955 | Plainstrider Feather 4740 | 40% quest | 80% quest |
| 2956 | Adult Plainstrider 2956 | Plainstrider Talon 4759 | 40% quest | 80% quest |
| 2956 | Adult Plainstrider 2956 | Plainstrider Scale 4806 | 40% quest | 15% quest |
| 2961 | Mountain Cougar 2961 | Mountain Cougar Pelt 4742 | 40% quest | 80% quest |
| 704 | Ragged Timber Wolf 704 | Tough Wolf Meat 750 | 40% quest | 80% quest |
| 705 | Ragged Young Wolf 705 | Tough Wolf Meat 750 | 40% quest | 80% quest |
| 946 | Frostmane Novice 946 | Feather Charm 6753 | 40% quest | 80% quest |
| 1506 | Scarlet Convert 1506 | Scarlet Armband 3266 | 40% quest | 80% quest |
| 1507 | Scarlet Initiate 1507 | Scarlet Armband 3266 | 40% quest | 80% quest |
| 1508 | Young Scavenger 1508 | Scavenger Paw 3265 | 40% quest | 75% quest |
| 1509 | Ragged Scavenger 1509 | Scavenger Paw 3265 | 40% quest | 75% quest |
| 1512 | Duskbat 1512 | Duskbat Wing 3264 | 40% quest | 75% quest |
| 1513 | Mangy Duskbat 1513 | Duskbat Wing 3264 | 40% quest | 75% quest |
| 1667 | Meven Korgal 1667 | Scarlet Crusade Documents 2885 | 40% quest | 100% quest |
| 1667 | Meven Korgal 1667 | Scarlet Armband 3266 | 40% quest | 80% quest |
| 1890 | Rattlecage Skeleton 1890 | Rattlecage Skull 6281 | 40% quest | 80% quest |
| 1919 | Samuel Fipps 1919 | Samuel's Remains 16333 | 40% quest | 100% quest |
| 38 | Defias Thug 38 | Red Burlap Bandana 752 | 40% quest | 80% quest |
| 69 | Timber Wolf 69 | Tough Wolf Meat 750 | 40% quest | 80% quest |
| 103 | Garrick Padfoot 103 | Garrick's Head 182 | 40% quest | 100% quest |
| 299 | Young Wolf 299 | Tough Wolf Meat 750 | 40% quest | 80% quest |
| 1988 | Grell 1988 | Fel Moss 3297 | 40% quest | 80% quest |
| 1988 | Grell 1988 | Hyacinth Mushroom 10639 | 40% quest | 80% quest |
| 1989 | Grellkin 1989 | Fel Moss 3297 | 40% quest | 80% quest |
| 1989 | Grellkin 1989 | Hyacinth Mushroom 10639 | 40% quest | 80% quest |
| 1995 | Strigid Owl 1995 | Strigid Owl Feather 3411 | 40% quest | 80% quest |
| 3110 | Dreadmaw Crocolisk 3110 | Kron's Amulet 4891 | 40% quest | 7% quest |
| 3124 | Scorpid Worker 3124 | Scorpid Worker Tail 4862 | 40% quest | 80% quest |
| 3242 | Zhevra Runner 3242 | Fresh Zhevra Carcass 10338 | 40% quest | 100% quest |
| 3281 | Sarkoth 3281 | Scorpid Worker Tail 4862 | 40% quest | 80% quest |
| 3281 | Sarkoth 3281 | Sarkoth's Mangled Claw 4905 | 40% quest | 100% quest |
| 48 | Skeletal Warrior 48 | Skeleton Finger 2378 | 40% quest | 80% quest |
| 95 | Defias Smuggler 95 | Red Leather Bandana 829 | 40% quest | 80% quest |
| 121 | Defias Pathstalker 121 | Red Leather Bandana 829 | 40% quest | 80% quest |
| 122 | Defias Highwayman 122 | Red Leather Bandana 829 | 40% quest | 80% quest |
| 123 | Riverpaw Mongrel 123 | Gnoll Paw 725 | 40% quest | 80% quest |
| 203 | Skeletal Mage 203 | Skeleton Finger 2378 | 40% quest | 80% quest |
| 232 | Farmer Ray 232 | Forever item 1645 | - | 2.72418% |
| 232 | Farmer Ray 232 | Forever item 3928 | - | 0.945895% |
| 232 | Farmer Ray 232 | Forever item 4419 | - | 0.0756716% |
| 232 | Farmer Ray 232 | Forever item 4421 | - | 0.567537% |
| 232 | Farmer Ray 232 | Forever item 4422 | - | 0.0378358% |
| 232 | Farmer Ray 232 | Forever item 4424 | - | 0.0756716% |
| 232 | Farmer Ray 232 | Forever item 4599 | - | 4.76731% |
| 232 | Farmer Ray 232 | Forever item 6149 | - | 0.756716% |
| 232 | Farmer Ray 232 | reference 30048 | - | 2.5% |
| 285 | Murloc 285 | Crystal Kelp Frond 1256 | 40% quest | 33% quest |
| 426 | Redridge Brute 426 | Iron Rivet 1013 | 40% quest | 80% quest |
| 426 | Redridge Brute 426 | Iron Pike 2856 | 40% quest | 80% quest |
| 430 | Redridge Mystic 430 | Iron Rivet 1013 | 40% quest | 80% quest |
| 430 | Redridge Mystic 430 | Iron Pike 2856 | 40% quest | 80% quest |
| 449 | Defias Knuckleduster 449 | Red Leather Bandana 829 | 40% quest | 80% quest |
| 476 | Kobold Geomancer 476 | Large Candle 772 | 40% quest | 66% quest |
| 476 | Kobold Geomancer 476 | Gold Dust 773 | 40% quest | 50% quest |
| 504 | Defias Trapper 504 | Red Leather Bandana 829 | 40% quest | 80% quest |
| 539 | Pygmy Venom Web Spider 539 | Vial of Spider Venom 1130 | 40% quest | 80% quest |
| 589 | Defias Pillager 589 | Red Leather Bandana 829 | 40% quest | 80% quest |
| 590 | Defias Looter 590 | Red Leather Bandana 829 | 40% quest | 80% quest |
| 735 | Murloc Streamrunner 735 | Crystal Kelp Frond 1256 | 40% quest | 33% quest |
| 808 | Grik'nir the Cold 808 | Grelin Whitebeard's Journal 2004 | 40% quest | 100% quest |
| 1128 | Young Black Bear 1128 | Thick Bear Fur 6952 | 40% quest | 80% quest |
| 1134 | Young Wendigo 1134 | Wendigo Mane 2671 | 40% quest | 80% quest |
| 1135 | Wendigo 1135 | Wendigo Mane 2671 | 40% quest | 80% quest |
| 1161 | Stonesplinter Trogg 1161 | Trogg Stone Tooth 2536 | 40% quest | 80% quest |
| 1162 | Stonesplinter Scout 1162 | Trogg Stone Tooth 2536 | 40% quest | 80% quest |
| 1163 | Stonesplinter Skullthumper 1163 | Trogg Stone Tooth 2536 | 40% quest | 80% quest |
| 1164 | Stonesplinter Bonesnapper 1164 | Trogg Stone Tooth 2536 | 40% quest | 80% quest |
| 1166 | Stonesplinter Seer 1166 | Trogg Stone Tooth 2536 | 40% quest | 80% quest |
| 1178 | Mo'grosh Ogre 1178 | Mo'grosh Crystal 2607 | 100% quest | 19% quest |
| 1179 | Mo'grosh Enforcer 1179 | Mo'grosh Crystal 2607 | 100% quest | 29% quest |
| 1180 | Mo'grosh Brute 1180 | Mo'grosh Crystal 2607 | 100% quest | 23% quest |
| 1196 | Ice Claw Bear 1196 | Thick Bear Fur 6952 | 40% quest | 80% quest |
| 1197 | Stonesplinter Shaman 1197 | Trogg Stone Tooth 2536 | 40% quest | 80% quest |
| 1211 | Leper Gnome 1211 | Restabilization Cog 3083 | 40% quest | 80% quest |
| 1211 | Leper Gnome 1211 | Gyromechanic Gear 3084 | 40% quest | 80% quest |
| 1525 | Rotting Dead 1525 | Putrid Claw 2855 | 40% quest | 33% quest |
| 1526 | Ravaged Corpse 1526 | Putrid Claw 2855 | 40% quest | 33% quest |
| 1547 | Decrepit Darkhound 1547 | Darkhound Blood 2858 | 40% quest | 35% quest |
| 1548 | Cursed Darkhound 1548 | Darkhound Blood 2858 | 40% quest | 35% quest |
| 1549 | Ravenous Darkhound 1549 | Darkhound Blood 2858 | 40% quest | 35% quest |
| 1553 | Greater Duskbat 1553 | Duskbat Pelt 2876 | 40% quest | 33% quest |
| 1554 | Vampiric Duskbat 1554 | Duskbat Pelt 2876 | 40% quest | 33% quest |
| 1555 | Vicious Night Web Spider 1555 | Vicious Night Web Spider Venom 2872 | 40% quest | 50% quest |
| 1654 | Gregor Agamand 1654 | Gregor's Remains 2829 | 40% quest | 100% quest |
| 1655 | Nissa Agamand 1655 | Nissa's Remains 2828 | 40% quest | 100% quest |
| 1656 | Thurman Agamand 1656 | Thurman's Remains 2830 | 40% quest | 100% quest |
| 1657 | Devlin Agamand 1657 | Devlin's Remains 2831 | 40% quest | 100% quest |
| 1707 | Defias Captive 1707 | Red Wool Bandana 2909 | 100% quest | 80% quest |
| 1765 | Worg 1765 | Discolored Worg Heart 3164 | 40% quest | 38.9156% |
| 1766 | Mottled Worg 1766 | Discolored Worg Heart 3164 | 40% quest | 39.1822% |
| 1767 | Vile Fin Shredder 1767 | Hardened Tumor 3258 | 40% quest | 5% quest |
| 1768 | Vile Fin Tidehunter 1768 | Hardened Tumor 3258 | 40% quest | 5% quest |
| 1778 | Ferocious Grizzled Bear 1778 | Grizzled Bear Heart 3253 | 40% quest | 80% quest |
| 1779 | Moonrage Glutton 1779 | Glutton Shackle 3156 | 40% quest | 80% quest |
| 1782 | Moonrage Darksoul 1782 | Darksoul Shackle 3157 | 40% quest | 80% quest |
| 1797 | Giant Grizzled Bear 1797 | Grizzled Bear Heart 3253 | 40% quest | 80% quest |
| 1867 | Dalaran Apprentice 1867 | Dalaran Mana Gem 7293 | 40% quest | 80% quest |
| 1888 | Dalaran Watcher 1888 | Dalaran Mana Gem 7293 | 40% quest | 80% quest |
| 1889 | Dalaran Wizard 1889 | Dalaran Mana Gem 7293 | 40% quest | 80% quest |
| 1891 | Pyrewood Watcher 1891 | Pyrewood Shackle 3218 | 100% quest | 80% quest |
| 1894 | Pyrewood Sentry 1894 | Pyrewood Shackle 3218 | 100% quest | 80% quest |
| 1895 | Pyrewood Elder 1895 | Pyrewood Shackle 3218 | 100% quest | 80% quest |
| 1912 | Dalaran Protector 1912 | Dalaran Pendant 3354 | 40% quest | 80% quest |
| 1912 | Dalaran Protector 1912 | Dalaran Mana Gem 7293 | 40% quest | 80% quest |
| 1923 | Bloodsnout Worg 1923 | Discolored Worg Heart 3164 | 40% quest | 46.3814% |
| 1939 | Rot Hide Brute 1939 | Rot Hide Ichor 3236 | 40% quest | 30% quest |
| 1953 | Lake Skulker 1953 | Lake Skulker Moss 3256 | 40% quest | 50% quest |
| 1954 | Elder Lake Skulker 1954 | Lake Skulker Moss 3256 | 40% quest | 50% quest |
| 1955 | Lake Creeper 1955 | Lake Creeper Moss 3257 | 40% quest | 50% quest |
| 1998 | Webwood Lurker 1998 | Webwood Spider Silk 3412 | 40% quest | 80% quest |
| 2042 | Nightsaber 2042 | Nightsaber Fang 3409 | 40% quest | 80% quest |
| 2069 | Moonstalker 2069 | Moonstalker Fang 5413 | 40% quest | 20% quest |
| 2070 | Moonstalker Runt 2070 | Moonstalker Fang 5413 | 40% quest | 20% quest |
| 2187 | Elder Darkshore Thresher 2187 | Thresher Eye 5412 | 40% quest | 10% quest |
| 2201 | Greymist Raider 2201 | Middle of Gelkak's Key 7499 | 40% quest | 1% quest |
| 2202 | Greymist Coastrunner 2202 | Middle of Gelkak's Key 7499 | 40% quest | 1% quest |
| 2203 | Greymist Seer 2203 | Middle of Gelkak's Key 7499 | 40% quest | 1% quest |
| 2204 | Greymist Netter 2204 | Middle of Gelkak's Key 7499 | 40% quest | 1% quest |
| 2205 | Greymist Warrior 2205 | Middle of Gelkak's Key 7499 | 40% quest | 1% quest |
| 2206 | Greymist Hunter 2206 | Middle of Gelkak's Key 7499 | 40% quest | 1% quest |
| 2207 | Greymist Oracle 2207 | Middle of Gelkak's Key 7499 | 40% quest | 10% quest |
| 2208 | Greymist Tidehunter 2208 | Middle of Gelkak's Key 7499 | 40% quest | 10% quest |
| 2231 | Pygmy Tide Crawler 2231 | Crawler Leg 5385 | 40% quest | 80% quest |
| 2232 | Tide Crawler 2232 | Crawler Leg 5385 | 40% quest | 80% quest |
| 2233 | Encrusted Tide Crawler 2233 | Crawler Leg 5385 | 40% quest | 80% quest |
| 2233 | Encrusted Tide Crawler 2233 | Bottom of Gelkak's Key 7500 | 40% quest | 5% quest |
| 2234 | Young Reef Crawler 2234 | Crawler Leg 5385 | 40% quest | 80% quest |
| 2235 | Reef Crawler 2235 | Crawler Leg 5385 | 40% quest | 80% quest |
| 2236 | Raging Reef Crawler 2236 | Crawler Leg 5385 | 40% quest | 100% quest |
| 2236 | Raging Reef Crawler 2236 | Bottom of Gelkak's Key 7500 | 40% quest | 20% quest |
| 2248 | Cave Yeti 2248 | Helcular's Rod 3708 | 40% quest | 4% quest |
| 2248 | Cave Yeti 2248 | Yeti Fur 3720 | 40% quest | 80% quest |
| 2249 | Ferocious Yeti 2249 | Helcular's Rod 3708 | 40% quest | 4% quest |
| 2249 | Ferocious Yeti 2249 | Yeti Fur 3720 | 40% quest | 80% quest |
| 2250 | Mountain Yeti 2250 | Helcular's Rod 3708 | 40% quest | 2% quest |
| 2250 | Mountain Yeti 2250 | Yeti Fur 3720 | 40% quest | 80% quest |
| 2251 | Giant Yeti 2251 | Helcular's Rod 3708 | 40% quest | 2% quest |
| 2251 | Giant Yeti 2251 | Yeti Fur 3720 | 40% quest | 80% quest |
| 2260 | Syndicate Rogue 2260 | Hillsbrad Human Skull 3692 | 40% quest | 80% quest |
| 2261 | Syndicate Watchman 2261 | Hillsbrad Human Skull 3692 | 40% quest | 80% quest |
| 2271 | Dalaran Shield Guard 2271 | Worn Stone Token 3714 | 40% quest | 80% quest |
| 2336 | Dark Strand Fanatic 2336 | Worn Parchment 5348 | 40% quest | 45% quest |
| 2349 | Giant Moss Creeper 2349 | Creeper Ichor 3477 | 40% quest | 15% quest |
| 2350 | Forest Moss Creeper 2350 | Creeper Ichor 3477 | 40% quest | 15% quest |
| 2351 | Gray Bear 2351 | Gray Bear Tongue 3476 | 40% quest | 80% quest |
| 2354 | Vicious Gray Bear 2354 | Gray Bear Tongue 3476 | 40% quest | 80% quest |
| 2358 | Dalaran Summoner 2358 | Worn Stone Token 3714 | 40% quest | 80% quest |
| 2359 | Elemental Slave 2359 | Bracers of Earth Binding 3715 | 40% quest | 80% quest |
| 2374 | Torn Fin Muckdweller 2374 | Torn Fin Eye 3510 | 40% quest | 80% quest |
| 2374 | Torn Fin Muckdweller 2374 | Murloc Head 3716 | 40% quest | 20% quest |
| 2384 | Starving Mountain Lion 2384 | Mountain Lion Blood 3496 | 40% quest | 80% quest |
| 2384 | Starving Mountain Lion 2384 | Fresh Carcass 5810 | 40% quest | 100% quest |
| 2406 | Mountain Lion 2406 | Mountain Lion Blood 3496 | 40% quest | 80% quest |
| 2406 | Mountain Lion 2406 | Fresh Carcass 5810 | 40% quest | 100% quest |
| 2407 | Hulking Mountain Lion 2407 | Mountain Lion Blood 3496 | 40% quest | 80% quest |
| 2407 | Hulking Mountain Lion 2407 | Fresh Carcass 5810 | 40% quest | 100% quest |
| 2957 | Elder Plainstrider 2957 | Plainstrider Talon 4759 | 40% quest | 80% quest |
| 2957 | Elder Plainstrider 2957 | Plainstrider Scale 4806 | 40% quest | 15% quest |
| 2959 | Prairie Stalker 2959 | Prairie Wolf Paw 4758 | 40% quest | 30% quest |
| 2959 | Prairie Stalker 2959 | Stalker Claws 4801 | 40% quest | 50% quest |
| 2959 | Prairie Stalker 2959 | Prairie Wolf Heart 4804 | 40% quest | 20% quest |
| 2960 | Prairie Wolf Alpha 2960 | Prairie Wolf Paw 4758 | 40% quest | 30% quest |
| 2960 | Prairie Wolf Alpha 2960 | Prairie Alpha Tooth 4803 | 40% quest | 35% quest |
| 2960 | Prairie Wolf Alpha 2960 | Prairie Wolf Heart 4804 | 40% quest | 20% quest |
| 2964 | Windfury Sorceress 2964 | Azure Feather 4752 | 40% quest | 65% quest |
| 2965 | Windfury Matriarch 2965 | Bronze Feather 4753 | 40% quest | 65% quest |
| 2970 | Swoop 2970 | Trophy Swoop Quill 4769 | 40% quest | 100% quest |
| 2970 | Swoop 2970 | Swoop Gizzard 4807 | 40% quest | 15% quest |
| 2971 | Taloned Swoop 2971 | Trophy Swoop Quill 4769 | 40% quest | 100% quest |
| 2971 | Taloned Swoop 2971 | Swoop Gizzard 4807 | 40% quest | 15% quest |
| 3035 | Flatland Cougar 3035 | Cougar Claws 4802 | 40% quest | 50% quest |
| 3035 | Flatland Cougar 3035 | Flatland Cougar Femur 4805 | 40% quest | 20% quest |
| 3058 | Arra'chea 3058 | Horn of Arra'chea 4841 | 40% quest | 100% quest |
| 3105 | Makrura Snapclaw 3105 | Intact Makrura Eye 4887 | 40% quest | 80% quest |
| 3107 | Surf Crawler 3107 | Crawler Mucus 4888 | 40% quest | 80% quest |
| 3108 | Encrusted Surf Crawler 3108 | Crawler Mucus 4888 | 40% quest | 80% quest |
| 3195 | Burning Blade Thug 3195 | Searing Collar 4871 | 40% quest | 80% quest |
| 3197 | Burning Blade Fanatic 3197 | Searing Collar 4871 | 40% quest | 80% quest |
| 3197 | Burning Blade Fanatic 3197 | Lieutenant's Insignia 14544 | 40% quest | 20% quest |
| 3198 | Burning Blade Apprentice 3198 | Searing Collar 4871 | 40% quest | 80% quest |
| 3198 | Burning Blade Apprentice 3198 | Lieutenant's Insignia 14544 | 40% quest | 20% quest |
| 3231 | Corrupted Dreadmaw Crocolisk 3231 | Kron's Amulet 4891 | 40% quest | 7% quest |
| 3234 | Lost Barrens Kodo 3234 | Kodo Liver 4896 | 40% quest | 80% quest |
| 3234 | Lost Barrens Kodo 3234 | Kodo Horn 15852 | 40% quest | 80% quest |
| 3239 | Thunderhead 3239 | Thunder Lizard Horn 4895 | 40% quest | 100% quest |
| 3239 | Thunderhead 3239 | Thunder Lizard Blood 5143 | 40% quest | 80% quest |
| 3240 | Stormsnout 3240 | Thunder Lizard Horn 4895 | 40% quest | 100% quest |
| 3240 | Stormsnout 3240 | Thunder Lizard Blood 5143 | 40% quest | 80% quest |
| 3241 | Savannah Patriarch 3241 | Savannah Lion Tusk 4893 | 40% quest | 55% quest |
| 3243 | Savannah Highmane 3243 | Savannah Lion Tusk 4893 | 40% quest | 55% quest |
| 3244 | Greater Plainstrider 3244 | Plainstrider Kidney 4894 | 40% quest | 80% quest |
| 3244 | Greater Plainstrider 3244 | Plainstrider Beak 5087 | 40% quest | 80% quest |
| 3245 | Ornery Plainstrider 3245 | Plainstrider Kidney 4894 | 40% quest | 80% quest |
| 3245 | Ornery Plainstrider 3245 | Plainstrider Beak 5087 | 40% quest | 80% quest |
| 3246 | Fleeting Plainstrider 3246 | Plainstrider Kidney 4894 | 40% quest | 80% quest |
| 3246 | Fleeting Plainstrider 3246 | Plainstrider Beak 5087 | 40% quest | 80% quest |
| 3247 | Thunderhawk Hatchling 3247 | Thunderhawk Wings 5164 | 40% quest | 100% quest |
| 3254 | Sunscale Lashtail 3254 | Raptor Head 5062 | 40% quest | 80% quest |
| 3255 | Sunscale Screecher 3255 | Raptor Head 5062 | 40% quest | 80% quest |
| 3256 | Sunscale Scytheclaw 3256 | Intact Raptor Horn 5055 | 40% quest | 80% quest |
| 3256 | Sunscale Scytheclaw 3256 | Raptor Head 5062 | 40% quest | 80% quest |
| 3258 | Bristleback Hunter 3258 | Bristleback Quilboar Tusk 5085 | 40% quest | 80% quest x1-2 |
| 3260 | Bristleback Water Seeker 3260 | Bristleback Quilboar Tusk 5085 | 40% quest | 80% quest x1-2 |
| 3261 | Bristleback Thornweaver 3261 | Bristleback Quilboar Tusk 5085 | 40% quest | 80% quest x1-2 |
| 3263 | Bristleback Geomancer 3263 | Bristleback Quilboar Tusk 5085 | 40% quest | 80% quest x1-2 |
| 3267 | Razormane Water Seeker 3267 | Fire Tar 5026 | 40% quest | 25% quest |
| 3268 | Razormane Thornweaver 3268 | Fire Tar 5026 | 40% quest | 25% quest |
| 3269 | Razormane Geomancer 3269 | Fire Tar 5026 | 40% quest | 25% quest |
| 3272 | Kolkar Wrangler 3272 | Centaur Bracers 5030 | 40% quest | 80% quest |
| 3273 | Kolkar Stormer 3273 | Centaur Bracers 5030 | 40% quest | 80% quest |
| 3275 | Kolkar Marauder 3275 | Centaur Bracers 5030 | 40% quest | 80% quest |
| 3283 | Venture Co. Enforcer 3283 | Cats Eye Emerald 5097 | 40% quest | 5% quest |
| 3283 | Venture Co. Enforcer 3283 | Samophlange Manual Page 11148 | 40% quest | 20% quest |
| 3286 | Venture Co. Overseer 3286 | Cats Eye Emerald 5097 | 40% quest | 5% quest |
| 3286 | Venture Co. Overseer 3286 | Samophlange Manual Page 11148 | 40% quest | 20% quest |
| 3382 | Southsea Cannoneer 3382 | reference 30040 | - | 2.5% |
| 3382 | Southsea Cannoneer 3382 | reference 30041 | 2.5% | - |
| 3393 | Captain Fairmount 3393 | Theramore Medal 5078 | 40% quest | 80% quest |
| 3396 | Hezrul Bloodmark 3396 | Hezrul's Head 5025 | 40% quest | 100% quest |
| 3396 | Hezrul Bloodmark 3396 | Centaur Bracers 5030 | 40% quest | 80% quest |
| 3397 | Kolkar Bloodcharger 3397 | Centaur Bracers 5030 | 40% quest | 80% quest |
| 3415 | Savannah Huntress 3415 | Savannah Lion Tusk 4893 | 40% quest | 55% quest |
| 3416 | Savannah Matriarch 3416 | Savannah Lion Tusk 4893 | 40% quest | 55% quest |
| 3425 | Savannah Prowler 3425 | Savannah Lion Tusk 4893 | 40% quest | 55% quest |
| 3425 | Savannah Prowler 3425 | Prowler Claws 5096 | 40% quest | 80% quest |
| 3426 | Zhevra Charger 3426 | Fresh Zhevra Carcass 10338 | 40% quest | 100% quest |
| 3454 | Cannoneer Smythe 3454 | Theramore Medal 5078 | 40% quest | 80% quest |
| 3455 | Cannoneer Whessan 3455 | Theramore Medal 5078 | 40% quest | 80% quest |
| 3461 | Oasis Snapjaw 3461 | Altered Snapjaw Shell 5098 | 40% quest | 100% quest |
| 3474 | Lakota'mani 3474 | Kodo Liver 4896 | 40% quest | 80% quest |
| 3530 | Pyrewood Tailor 3530 | Pyrewood Shackle 3218 | 100% quest | 80% quest |
| 3631 | Deviate Stinglash 3631 | Deviate Hide 6443 | 100% quest | 80% quest |
| 3632 | Deviate Creeper 3632 | Deviate Hide 6443 | 100% quest | 80% quest |
| 3633 | Deviate Slayer 3633 | Deviate Hide 6443 | 100% quest | 80% quest |
| 3660 | Athrikus Narassin 3660 | Athrikus Narassin's Head 5383 | 40% quest | 100% quest |
| 3711 | Wrathtail Myrmidon 3711 | Wrathtail Head 5490 | 40% quest | 100% quest |
| 3715 | Wrathtail Sea Witch 3715 | Wrathtail Head 5490 | 40% quest | 100% quest |
| 3762 | Felmusk Felsworn 3762 | Satyr Horns 5481 | 40% quest | 45% quest |
| 3762 | Felmusk Felsworn 3762 | Uncloven Satyr Hoof 7128 | 40% quest | 80% quest |
| 3943 | Ruuzel 3943 | Ring of Zoram 5445 | 40% quest | 100% quest |
| 3944 | Wrathtail Priestess 3944 | Wrathtail Head 5490 | 40% quest | 100% quest |
| 4001 | Windshear Tunnel Rat 4001 | Smoky Iron Ingot 7126 | 40% quest | 80% quest |
| 4003 | Windshear Geomancer 4003 | Smoky Iron Ingot 7126 | 40% quest | 80% quest |
| 4012 | Pridewing Wyvern 4012 | Pridewing Venom Sac 5808 | 40% quest | 35% quest |
| 4013 | Pridewing Skyhunter 4013 | Pridewing Venom Sac 5808 | 40% quest | 35% quest |
| 4014 | Pridewing Consort 4014 | Pridewing Venom Sac 5808 | 40% quest | 35% quest |
| 4015 | Pridewing Patriarch 4015 | Pridewing Venom Sac 5808 | 100% quest | 15% quest |
| 4017 | Wily Fey Dragon 4017 | Fey Dragon Scale 5583 | 40% quest | 80% quest |
| 4018 | Antlered Courser 4018 | Courser Eye 5585 | 40% quest | 80% quest x2-2 |
| 4021 | Corrosive Sap Beast 4021 | Corrosive Sap 5681 | 40% quest | 100% quest |
| 4036 | Rogue Flame Spirit 4036 | Smoldering Embers 5659 | 40% quest | 7% quest |
| 4036 | Rogue Flame Spirit 4036 | Incendrites 16312 | 40% quest | 80% quest |
| 4044 | Blackened Basilisk 4044 | Crystalized Scales 5675 | 40% quest | 20% quest |
| 4248 | Pesterhide Hyena 4248 | Spotted Hyena Pelt 11507 | 40% quest | 80% quest |
| 4525 | Razorfen Earthbreaker 4525 | Treshala's Pendant 5825 | 100% quest | 10% quest |
| 6123 | Dark Iron Spy 6123 | Dark Iron Script 6847 | 40% quest | 100% quest |
| 6497 | Astor Hadren 6497 | Astor's Letter of Introduction 7231 | 40% quest | 100% quest |
| 7288 | Grand Foreman Puzik Gallywix 7288 | Forever item 8073 | - | 100% quest |
| 8503 | Gibblewilt 8503 | Restabilization Cog 3083 | 100% quest | 80% quest |
| 8503 | Gibblewilt 8503 | Gyromechanic Gear 3084 | 100% quest | 80% quest |
| 9524 | Kolkar Invader 9524 | Centaur Bracers 5030 | 40% quest | 80% quest |
| 11322 | Searing Blade Cultist 11322 | Spells of Shadow 14395 | 100% quest | 5% quest |
| 11322 | Searing Blade Cultist 11322 | Incantations from the Nether 14396 | 100% quest | 5% quest |
| 11324 | Searing Blade Warlock 11324 | Spells of Shadow 14395 | 100% quest | 5% quest |
| 11324 | Searing Blade Warlock 11324 | Incantations from the Nether 14396 | 100% quest | 5% quest |
| 11441 | Gordok Brute 11441 | Forever item 18266 | - | 0.22% |
| 11444 | Gordok Mage-Lord 11444 | Forever item 18266 | - | 0.14% |
| 13022 | Whip Lasher 13022 | Forever item 18266 | - | 0.02% |
| 13036 | Gordok Mastiff 13036 | Forever item 18266 | - | 0.02% |
| 15623 | Xandivious 15623 | Forever item 21145 | - | 100% quest |

## Forever drops on vanilla creatures that need sniffs (kept, not changed)

| Creature loot | Item | Chance | Note |
|---|---|---|---|
| 6 | Forever item 247834 | 6.25% | starts quest 91741 (sniff: 2 of 32 loots) |
| 6 | Forever item 247839 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 38 | Red Burlap Bandana 752 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 48 | Skeleton Finger 2378 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 69 | Tough Wolf Meat 750 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 80 | Forever item 247839 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 95 | Red Leather Bandana 829 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 103 | Garrick's Head 182 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 113 | Forever item 286215 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 114 | Forever item 255010 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 118 | Forever item 247877 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 121 | Red Leather Bandana 829 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 122 | Red Leather Bandana 829 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 123 | Gnoll Paw 725 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 126 | Forever item 254548 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 127 | Forever item 254548 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 171 | Forever item 254548 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 203 | Skeleton Finger 2378 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 213 | Forever item 210053 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 257 | Forever item 247839 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 285 | Crystal Kelp Frond 1256 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 299 | Tough Wolf Meat 750 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 426 | Iron Rivet 1013 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 426 | Iron Pike 2856 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 430 | Iron Rivet 1013 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 430 | Iron Pike 2856 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 449 | Red Leather Bandana 829 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 476 | Large Candle 772 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 476 | Gold Dust 773 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 504 | Red Leather Bandana 829 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 517 | Forever item 254548 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 539 | Vial of Spider Venom 1130 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 565 | Forever item 210053 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 589 | Red Leather Bandana 829 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 590 | Red Leather Bandana 829 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 704 | Tough Wolf Meat 750 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 705 | Tough Wolf Meat 750 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 706 | Forever item 264356 | 66% quest | Frostmane Troll Whelp - Frostmane Bear Pendant (Call of Earth 94373, sniff 2 of 3 kills on the quest) |
| 735 | Crystal Kelp Frond 1256 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 808 | Grelin Whitebeard's Journal 2004 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 822 | Forever item 286215 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 946 | Feather Charm 6753 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 946 | Forever item 264356 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1128 | Thick Bear Fur 6952 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1134 | Wendigo Mane 2671 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1135 | Wendigo Mane 2671 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1161 | Trogg Stone Tooth 2536 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1162 | Trogg Stone Tooth 2536 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1163 | Trogg Stone Tooth 2536 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1164 | Trogg Stone Tooth 2536 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1166 | Trogg Stone Tooth 2536 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1166 | Reagent Pouch 6652 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1178 | Mo'grosh Crystal 2607 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1179 | Mo'grosh Crystal 2607 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1180 | Mo'grosh Crystal 2607 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1196 | Thick Bear Fur 6952 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1197 | Trogg Stone Tooth 2536 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1211 | Restabilization Cog 3083 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1211 | Gyromechanic Gear 3084 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1506 | Scarlet Armband 3266 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1507 | Scarlet Armband 3266 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1508 | Scavenger Paw 3265 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1509 | Scavenger Paw 3265 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1512 | Duskbat Wing 3264 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1513 | Duskbat Wing 3264 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1520 | Notched Rib 3162 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1522 | Blackened Skull 3163 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1523 | Notched Rib 3162 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1525 | Putrid Claw 2855 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1526 | Putrid Claw 2855 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1535 | Scarlet Insignia Ring 2875 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1536 | Scarlet Insignia Ring 2875 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1537 | Scarlet Insignia Ring 2875 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1537 | Forever item 264693 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1538 | Scarlet Insignia Ring 2875 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1538 | Forever item 264693 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1543 | Vile Fin Scale 2859 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1544 | Vile Fin Scale 2859 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1544 | Forever item 278244 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1545 | Vile Fin Scale 2859 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1545 | Forever item 278244 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1547 | Darkhound Blood 2858 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1547 | Forever item 278243 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1548 | Darkhound Blood 2858 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1548 | Forever item 278243 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1549 | Darkhound Blood 2858 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1553 | Duskbat Pelt 2876 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1553 | Forever item 278242 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1554 | Duskbat Pelt 2876 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1554 | Forever item 278242 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1555 | Vicious Night Web Spider Venom 2872 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1654 | Gregor's Remains 2829 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1655 | Nissa's Remains 2828 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1656 | Thurman's Remains 2830 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1657 | Devlin's Remains 2831 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1660 | Scarlet Insignia Ring 2875 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1662 | Scarlet Insignia Ring 2875 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1664 | Scarlet Insignia Ring 2875 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1665 | Scarlet Insignia Ring 2875 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1667 | Scarlet Crusade Documents 2885 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1667 | Scarlet Armband 3266 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1674 | Embalming Ichor 2834 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1675 | Embalming Ichor 2834 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1707 | Red Wool Bandana 2909 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1765 | Discolored Worg Heart 3164 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1766 | Discolored Worg Heart 3164 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1767 | Hardened Tumor 3258 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1768 | Hardened Tumor 3258 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1778 | Grizzled Bear Heart 3253 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1779 | Glutton Shackle 3156 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1782 | Darksoul Shackle 3157 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1797 | Grizzled Bear Heart 3253 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1867 | Dalaran Mana Gem 7293 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1888 | Dalaran Mana Gem 7293 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1889 | Dalaran Mana Gem 7293 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1890 | Rattlecage Skull 6281 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1891 | Pyrewood Shackle 3218 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1894 | Pyrewood Shackle 3218 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1895 | Pyrewood Shackle 3218 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1912 | Dalaran Pendant 3354 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1912 | Dalaran Mana Gem 7293 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1919 | Samuel's Remains 16333 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1923 | Discolored Worg Heart 3164 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1924 | Forever item 280375 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1939 | Rot Hide Ichor 3236 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1941 | Embalming Ichor 2834 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1953 | Lake Skulker Moss 3256 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1954 | Lake Skulker Moss 3256 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1955 | Lake Creeper Moss 3257 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1973 | Forever item 271350 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1974 | Forever item 271350 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1988 | Fel Moss 3297 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1988 | Hyacinth Mushroom 10639 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1989 | Fel Moss 3297 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1989 | Hyacinth Mushroom 10639 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1995 | Strigid Owl Feather 3411 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 1998 | Webwood Spider Silk 3412 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2042 | Nightsaber Fang 3409 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2042 | Forever item 280087 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2069 | Moonstalker Fang 5413 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2070 | Moonstalker Fang 5413 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2185 | Thresher Eye 5412 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2187 | Thresher Eye 5412 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2201 | Middle of Gelkak's Key 7499 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2202 | Middle of Gelkak's Key 7499 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2203 | Middle of Gelkak's Key 7499 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2204 | Middle of Gelkak's Key 7499 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2205 | Middle of Gelkak's Key 7499 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2206 | Middle of Gelkak's Key 7499 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2207 | Middle of Gelkak's Key 7499 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2208 | Middle of Gelkak's Key 7499 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2231 | Crawler Leg 5385 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2232 | Crawler Leg 5385 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2233 | Crawler Leg 5385 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2233 | Bottom of Gelkak's Key 7500 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2233 | Fine Crab Chunks 12237 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2234 | Crawler Leg 5385 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2235 | Crawler Leg 5385 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2235 | Fine Crab Chunks 12237 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2236 | Crawler Leg 5385 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2236 | Bottom of Gelkak's Key 7500 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2248 | Helcular's Rod 3708 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2248 | Yeti Fur 3720 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2249 | Helcular's Rod 3708 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2249 | Yeti Fur 3720 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2250 | Helcular's Rod 3708 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2250 | Yeti Fur 3720 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2251 | Helcular's Rod 3708 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2251 | Yeti Fur 3720 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2260 | Hillsbrad Human Skull 3692 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2261 | Hillsbrad Human Skull 3692 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2271 | Worn Stone Token 3714 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2336 | Worn Parchment 5348 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2349 | Creeper Ichor 3477 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2350 | Creeper Ichor 3477 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2351 | Gray Bear Tongue 3476 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2354 | Gray Bear Tongue 3476 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2358 | Worn Stone Token 3714 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2359 | Bracers of Earth Binding 3715 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2374 | Torn Fin Eye 3510 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2374 | Murloc Head 3716 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2384 | Mountain Lion Blood 3496 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2384 | Fresh Carcass 5810 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2406 | Mountain Lion Blood 3496 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2406 | Fresh Carcass 5810 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2407 | Mountain Lion Blood 3496 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2407 | Fresh Carcass 5810 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2955 | Plainstrider Meat 4739 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2955 | Plainstrider Feather 4740 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2956 | Plainstrider Talon 4759 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2956 | Plainstrider Scale 4806 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2956 | Forever item 287505 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2957 | Plainstrider Talon 4759 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2957 | Plainstrider Scale 4806 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2957 | Forever item 287505 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2959 | Prairie Wolf Paw 4758 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2959 | Stalker Claws 4801 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2959 | Prairie Wolf Heart 4804 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2960 | Prairie Wolf Paw 4758 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2960 | Prairie Alpha Tooth 4803 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2960 | Prairie Wolf Heart 4804 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2961 | Mountain Cougar Pelt 4742 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2964 | Azure Feather 4752 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2965 | Bronze Feather 4753 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2970 | Trophy Swoop Quill 4769 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2970 | Swoop Gizzard 4807 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2971 | Trophy Swoop Quill 4769 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 2971 | Swoop Gizzard 4807 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3035 | Cougar Claws 4802 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3035 | Flatland Cougar Femur 4805 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3058 | Horn of Arra'chea 4841 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3105 | Intact Makrura Eye 4887 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3107 | Crawler Mucus 4888 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3108 | Crawler Mucus 4888 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3110 | Kron's Amulet 4891 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3124 | Scorpid Worker Tail 4862 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3127 | Venomtail Poison Sac 4886 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3195 | Searing Collar 4871 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3197 | Searing Collar 4871 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3197 | Lieutenant's Insignia 14544 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3198 | Searing Collar 4871 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3198 | Lieutenant's Insignia 14544 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3226 | Venomtail Poison Sac 4886 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3231 | Kron's Amulet 4891 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3234 | Kodo Liver 4896 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3234 | Kodo Horn 15852 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3239 | Thunder Lizard Horn 4895 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3239 | Thunder Lizard Blood 5143 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3240 | Thunder Lizard Horn 4895 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3240 | Thunder Lizard Blood 5143 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3241 | Savannah Lion Tusk 4893 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3241 | Forever item 269715 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3242 | Zhevra Hooves 5086 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3242 | Fresh Zhevra Carcass 10338 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3243 | Savannah Lion Tusk 4893 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3244 | Plainstrider Kidney 4894 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3244 | Plainstrider Beak 5087 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3245 | Plainstrider Kidney 4894 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3245 | Plainstrider Beak 5087 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3246 | Plainstrider Kidney 4894 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3246 | Plainstrider Beak 5087 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3247 | Thunderhawk Wings 5164 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3254 | Raptor Head 5062 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3255 | Raptor Head 5062 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3256 | Intact Raptor Horn 5055 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3256 | Raptor Head 5062 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3258 | Bristleback Quilboar Tusk 5085 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3260 | Bristleback Quilboar Tusk 5085 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3261 | Bristleback Quilboar Tusk 5085 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3263 | Bristleback Quilboar Tusk 5085 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3267 | Fire Tar 5026 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3268 | Fire Tar 5026 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3269 | Fire Tar 5026 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3272 | Centaur Bracers 5030 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3273 | Centaur Bracers 5030 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3275 | Centaur Bracers 5030 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3281 | Scorpid Worker Tail 4862 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3281 | Sarkoth's Mangled Claw 4905 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3283 | Cats Eye Emerald 5097 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3283 | Samophlange Manual Page 11148 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3286 | Cats Eye Emerald 5097 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3286 | Samophlange Manual Page 11148 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3393 | Theramore Medal 5078 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3396 | Hezrul's Head 5025 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3396 | Centaur Bracers 5030 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3397 | Centaur Bracers 5030 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3415 | Savannah Lion Tusk 4893 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3416 | Savannah Lion Tusk 4893 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3416 | Forever item 269715 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3425 | Savannah Lion Tusk 4893 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3425 | Prowler Claws 5096 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3426 | Zhevra Hooves 5086 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3426 | Fresh Zhevra Carcass 10338 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3454 | Theramore Medal 5078 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3455 | Theramore Medal 5078 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3461 | Altered Snapjaw Shell 5098 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3474 | Kodo Liver 4896 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3530 | Pyrewood Shackle 3218 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3566 | Flatland Prowler Claw 5203 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3631 | Deviate Hide 6443 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3632 | Deviate Hide 6443 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3633 | Deviate Hide 6443 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3660 | Athrikus Narassin's Head 5383 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3711 | Wrathtail Head 5490 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3715 | Wrathtail Head 5490 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3762 | Satyr Horns 5481 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3762 | Uncloven Satyr Hoof 7128 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3943 | Ring of Zoram 5445 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3944 | Wrathtail Head 5490 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 3983 | Heart of Zeal 5805 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4001 | Smoky Iron Ingot 7126 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4003 | Smoky Iron Ingot 7126 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4012 | Pridewing Venom Sac 5808 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4012 | Forever item 277917 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4012 | Forever item 277917 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4013 | Pridewing Venom Sac 5808 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4013 | Forever item 277917 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4013 | Forever item 277917 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4014 | Pridewing Venom Sac 5808 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4014 | Forever item 277917 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4014 | Forever item 277917 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4015 | Pridewing Venom Sac 5808 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4015 | Forever item 277917 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4015 | Forever item 277917 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4017 | Fey Dragon Scale 5583 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4018 | Courser Eye 5585 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4021 | Corrosive Sap 5681 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4022 | Forever item 277936 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4023 | Forever item 277936 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4024 | Forever item 277936 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4025 | Forever item 277936 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4036 | Smoldering Embers 5659 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4036 | Incendrites 16312 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4044 | Crystalized Scales 5675 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4248 | Spotted Hyena Pelt 11507 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 4525 | Treshala's Pendant 5825 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 6123 | Dark Iron Script 6847 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 6497 | Astor's Letter of Introduction 7231 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 8503 | Restabilization Cog 3083 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 8503 | Gyromechanic Gear 3084 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 9524 | Centaur Bracers 5030 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 10716 | Duskbat Wing 3264 | 40% quest | quest item of the creature query (drop not seen in the sniffs) |
| 10882 | Arikara Serpent Skin 12925 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 11322 | Spells of Shadow 14395 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 11322 | Incantations from the Nether 14396 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 11324 | Spells of Shadow 14395 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 11324 | Incantations from the Nether 14396 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 11520 | Taragaman the Hungerer's Heart 14540 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |
| 12865 | Ambassador Malcin's Head 17009 | 100% quest | quest item of the creature query (drop not seen in the sniffs) |

## Forever-only creatures with spawns (633): loot needs sniffs

- map 0: 201 creatures: Afadra Dunwall 264943, Ainderu Summerleaf 29512, Ajay Green 265730, Alan Sneeks 257282, Alfina Nightgaze 270459, Amera Sky 32745, Ander Solliden 246394, Angela Ward 258415, Angelique Butler 251977, Angus Hammerhand 276067, Animated Broom 256317, Animated Hammer 256309, Animated Tome 256340, Animated Tome 256343, Animated Tome 256352, Antonio Bolero 258568, Anya Rince 276795, Applebough 29547, Aramis Hammerhand 244808, Arcane Sentry 275164, Arcanist Braedin 275398, Arcanist Laurain 256306, Archmage Alvareaux 32287, Archmage Celindra 252085, Archmage Modera 276235, Bakor the Gangly 32744, Bandarion Keep Paladin 260102, Bareth Dawnstone 275954, Barrelmaker Ishtar 274853, Belanaa Windveil 276170, Black Skeletal Horse 267354, Blightsculler 271080, Blue Skeletal Horse 267358, Breton Samuels 246349, Brighid Stormflayer 267336, Brown Skeletal Horse 267364, Bub 274854, Buddy 252425, Cadoc Winterheart 267279, Calder Gray 270038, Camp Tent 263398, Chadsworth 273084, Charles Worth 251972, Clarence Gillian 267323, Coldrasp 274300, Credit 270575, Dalaran Citizen 32451, Dalaran Citizen 32453, Dalaran Conjuror 256362, Dalaran Wizard 256359, Daniel 247229, Danitha Morr 246378, Dark Enforcer 275437, Dark Neophyte 267006, Darkspear Emissary 268048, Deathguard Baldren 259611, Deathguard Billmuth 257655, Deathguard Kristof 251001, Deathguard Lizabetha 272101, Deathguard Veteran 275103 ...
- map 1: 109 creatures: Aeigelyges 271919, Aggor the Young 275666, Alaana Stormwalker 259119, Alodan the Hopeful 246344, An'drak 274833, Apothecary Durelle 248196, Axle Smoothslice 277055, Aza'bek 248198, Bainham 267309, Basket of Textile Supplies 256575, Beneris 248199, Black Riding Wolf 267302, Boarton Shadetotem 205729, Boramu 258466, Borook Gallfist 263647, Brix Xizzix 262502, Brog 268683, Brown Riding Wolf 267299, Camp Tent 263398, Cat 273004, Cordy 274960, Corswyn Aseril 255679, Crate of Alchemy Goods 256570, Crate of Blacksmithing Goods 256571, Crate of Enchanting Supplies 256573, Darah 258463, Darkspear Elite 269454, Darkspear Emissary 268048, Dire Riding Wolf 267300, Dokimi 256386, Earthen Ring Shaman 262504, Emerald Riding Raptor 267291, Evermore 274834, Eylah Sunhorn 269068, Fizzlefuse 248200, Galestrider 262523, Galestrider Handler 264287, Garan Sunstrider 267332, Gishah 256384, Gor'mak 248197, Gragtharr 271034, Gruga Bloodblade 263645, Gur'ak 267310, Hana Lighthoof 262560, Herak the Pillager 275767, Isaac Pearson 185334, Jim'bek 248202, Jornah 256388, Jungle Boa 271915, Karne Grayhoof 267321, Kihea Ragetotem 274864, Kitzy Werkblaster 274740, Kurvelk Shadowhoof 256672, Lasher Sproutling 275703, Malah Longwind 275789, Mayena Earthseeker 263445, Mayhoa Skyhoof 268745, Mazu'kon 264074, Migi 268682, Mogra 268685 ...
- map 2991: 280 creatures: "Badwind" Bennic 255534, Aamelia Windfield 252800, Aarnor Galestrike 254082, Aedi Thriceforged 251913, Aetheen of the Gales 251366, Ailee Farheart 251362, Akeri Duskblade 251389, Al'Aketh Ambusher 251451, Al'Aketh Assassin 254626, Al'Aketh Attacker 253782, Al'Aketh Attacker 253787, Al'Aketh Blademaster 252765, Al'Aketh Brawler 270201, Al'Aketh Brute 251145, Al'Aketh Convert 251160, Al'Aketh Footsoldier 252665, Al'Aketh Guardian 252762, Al'Aketh Healer 254596, Al'Aketh Honor Guard 252767, Al'Aketh Neophyte 251448, Al'Aketh Pillager 253511, Al'Aketh Preacher 253195, Al'Aketh Skypriest 252764, Al'Aketh Spiritcaller 252763, Al'Aketh Stormcaller 252068, Al'Aketh Stormchaser 252664, Al'Aketh Warrior 256996, Alvarion Windfield 252448, Amandriel 274934, Anathamaas Aetherwind 252373, Antelariaa Cloudgaze 252390, Arnorea Shadowfoot 258295, Ayessa Dawnsinger 251968, Ayessa Dawnsinger 253813, Ayessa Dawnsinger 253849, Baelann Favorbreeze 257036, Baelann Swiftcurrent 257008, Baeo Sharpstrike 258289, Ban'aethal Refugee 259011, Bandit Highwayman 252820, Belandiel Farflight 254360, Belann Windwood 256507, Belarysa Moonveil 274907, Belathaan Brightwish 256247, Beyaa Gustbellow 258279, Blademaster Ren 251964, Brazier of Eternal Flame 268679, Brazier of Offering 268762, Brother Zendraas 272045, Bryaes Galechaser 258277, Camp Tent 263398, Captured Bandit 256930, Cirrusfly Queen 251404, Cirrusfly Soldier 251402, Cloudrunner 271712, Cloudrunner Matriarch 271710, Commander Belguilos 252666, Commander Cyclas 251966, Commander Haalien 253622, Constable Aonda 251523 ...
- map 2999: 35 creatures: Bjork 256097, Broodling 250625, Broodwidow 250619, Captain Truman 265701, Deep Widow 256040, Edward Heartweaver 250842, Fallen Berserker 250656, Fallen Necromancer 255964, Flesh Golem 255109, Ghostly Citizen 250654, Ghoul 250627, Living Monstrosity 250689, Mangled Cadaver 250623, Mindless Undead 250649, Plague Ghoul 250630, Ragged Ghoul 250622, Rath'mael 250657, Shrieking Banshee 250617, Shrieking Banshee 250620, Skeletal Mage 250624, Skeletal Soldier 250626, Skeleton 250618, Spectral Cat 255266, Spectral Citizen 250653, Spectral Horse 255250, Spider 250484, Spider 250741, Stalker 255159, Stone Watcher 250629, Tarantula 250488, The Baron 250660, Vengeful Citizen 250651, Venom Lurker 250735, Wailing Banshee 250650, Witherfang 250483
- map 3065: 13 creatures: Bloodhound Runt 263470, Dark Iron Engineer 263397, Dark Iron Looter 263396, Dark Iron Summoner 263438, Durgen Dirgehammer 261319, Enraged Apparition 263389, Faldrim Anvilmar 261306, Ghostly Attendant 265002, Lesser Stone Golem 263466, Magmatus 261316, Plunder 261311, Seaforium Blasting Powder 263980, Tormented Soul 263390

## How it lives with the SQL updater

- TrinityCore's updater applies new files of `sql/updates/world` and `sql/custom/world` in name order and records each file's
  hash in `updates`. This file sorts after every loot file we have, so on the next start it runs once, after them.
- `Updates.Redundancy = 1` and `Updates.AllowRehash = 1`: when an already applied file changes (for example a regenerated sniff
  import merged from advocaite's `forever` branch), that file runs again on its own and would put the 40% rows back, while this file
  (unchanged) would not run again. After any merge that changes `2026_10_01_04_world_forever_sniff_npc.sql` or the baseline loot
  sections, this file has to run again: regenerate it with tools/vmangos_loot (README there) or add a new dated copy, and check the Northshire
  rows below on the PC.
- The sniff file itself is left alone on purpose: editing it makes it run again, and it rewrites creature_template_difficulty rows
  that later files (2026_10_05_00 skinning and others) corrected. The real fix belongs in advocaite's sniff importer
  (do not replace an existing database row for a quest item the sniffs never saw drop); it is held for the next big push.
- The loot conditions of 2026_10_11_17 (VMaNGOS condition_id) key on table entry and item, so they keep working on the re-inserted rows.

## PC check after the build installs it

```sql
SELECT Entry, Item, Chance, QuestRequired FROM creature_loot_template WHERE (Entry, Item) IN ((299,750),(69,750),(38,752),(103,182));
-- expect 80, 80, 80, 100 with QuestRequired 1 (second query: only the Forever drops listed above)
SELECT COUNT(*) FROM creature_loot_template WHERE Comment LIKE 'quest item of the creature query%'
  AND Entry IN (SELECT LootID FROM creature_template_difficulty WHERE Entry < 250000);
```
