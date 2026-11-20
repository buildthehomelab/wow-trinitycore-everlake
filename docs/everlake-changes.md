# Everlake's own changes: keep these on every update

Features that exist only in `everlake`, not in advocaite's `forever`, Karrz's `forever-bots` or TrinityCore. Upstream
doesn't know about them, so a merge that takes "theirs" in a conflict, or a file upstream rewrites, can drop them
without a build error. After every upstream merge or Karrz release port (`docs/upstream-prs.md`,
`docs/karrz-releases.md`), go down this list and check each hook is still there before opening the pull request.

Add a section here whenever a new Everlake-only feature lands.

## Bigger item stacks (`StackSize.*`), fork PR #87

Evermore's mod-stack-size rules in the core. Trade goods and spell reagents stack to 999 and consumables to 200; groups
only raise stacks and only for items that already stack. `StackSize.Items` and `StackSize.Exclude` set single items. The
changed `ItemSparse` rows go to the client as hotfixes, so bags, tooltips and the split dialog agree with the server.
Decided 2026-11-17: on for everyone, not a Legacy perk.

| Hook | Where | What breaks if it goes |
|---|---|---|
| The code | `src/server/game/Entities/Item/ItemStackSize.h` / `.cpp` | Build fails (the two callers below) |
| `ItemStackSize::Apply()` | `src/server/game/World/World.cpp`, `SetInitialWorldSettings`, just before `LoadItemTemplates()` | **Silent:** stacks go back to stock. It has to run after the DB2 stores and hotfixes load and before `ItemTemplate`s are built from `ItemSparse` |
| AH bot stock size | `src/server/game/AuctionHouseBot/AuctionHouseBotSeller.cpp`, `GetStackSizeForItem`: `urand(1, ItemStackSize::GetStockMaxStackSize(...))` | **Silent:** the bot posts stacks of up to 999 |
| Config block | `src/server/worldserver/worldserver.conf.dist`, `StackSize.*` after `Rate.Talent` | Defaults still apply (they're in the code), but the options are no longer documented |
| Tests | `tests/game/ItemStackSize.cpp` | Rule changes go unnoticed |

Things to watch in upstream changes:

- `ItemTemplate::GetMaxStackSize()` must keep reading `ExtendedData->Stackable`. If upstream caches the stack size
  somewhere else, or builds item templates before `Apply()` runs, the new sizes stop reaching the server.
- `DB2HotfixGeneratorBase::AddClientHotfix` and `ItemSparseEntry::Stackable` / `MaxCount`: a rename breaks the build,
  which is the safe kind of break.
- A new client build that changes item classes: spell reagents are class 15 subclass 1 and class 5 on the Forever
  client (`GetGroup`).

Check after a merge:

```bash
grep -n "ItemStackSize::Apply" src/server/game/World/World.cpp
grep -n "GetStockMaxStackSize" src/server/game/AuctionHouseBot/AuctionHouseBotSeller.cpp
grep -n "^StackSize.Enable" src/server/worldserver/worldserver.conf.dist
```

On the PTR, the worldserver log shows `>> Item stack sizes: changed N items` (about 1,700 with the defaults) and a
stack of Linen Cloth goes past 20.

## Forever mechanics audit fixes (2026-11-19)

Places where TrinityCore's retail or Wrath rules leaked through and we now follow live WoW Forever (or vanilla where Forever
kept it). Report: everlake-reports/mechanics-audit-2026-11-19. An upstream merge that takes "theirs" in these spots brings
the retail rule back without a build error.

| Rule | Where | What breaks if it goes |
|---|---|---|
| Grouped kills leave one shared corpse in the open world too | `Unit.cpp`, `sharedCorpse` in `Unit::Kill` (no `IsDungeon()` test) | **Silent:** every group member gets their own loot table and money roll outside dungeons |
| Reputation discount: 10% from Honored, nothing below | `VendorPrice.h` `ReputationDiscount`, called from `Player::GetReputationPriceDiscount` | **Silent:** retail 5% per rank (20% at Exalted) on vendors, trainers, flights and repairs |
| No dungeon kill XP when the party has someone 12+ levels above the enemy | `DungeonCarryRule.h`, `KillRewarder::_RewardXP`, `Classic.DungeonCarryXpBlock` | **Silent:** level 60s carry low characters through dungeons for XP |
| No gold for quest XP at level 60 | `Rate.Quest.Money.Max.Level.Reward` default 0 (`World.cpp`, conf) | **Silent:** quests pay the vanilla gold bonus at the cap |
| Quest log 40 | `Quests.LogSize` default 40 | **Silent:** quest log full at 35 |
| Breath 1 minute | `Player::GetMirrorTimerMaxValue` | **Silent:** 3 minutes (12 for Undead) |
| Daze from behind: vanilla 20%, real defense | `ClassicAttackTable::DazeChance`, used in `Unit::DealMeleeDamage` | **Silent:** TC's `* 0.16` (3.2% at 60) |
| In-combat regen auras take a share of the Spirit regen | `Player::RegenerateHealth` | **Silent:** Troll Regeneration gives a fraction of 1 health per tick in combat |
| No cap on pushback hits | `Spell::Delayed`, `Spell::DelayedChannel` (no `IsDelayableNoMore`) | **Silent:** pushback stops after 2 hits |
| Legacy Points earned per account, 16 spendable | `Player::_LoadAccountLegacyAchievements` (login query `CHAR_SEL_ACCOUNT_ACHIEVEMENTS`), `Player::HasAchievedOnAccount` in `UpdateClassicLegacyUnlock` and `TraitMgr` `FillOwnedCurrenciesMap` (plus the `SourcedMax` clamp there) | **Silent:** every alt starts at 0 Legacy Points, or more than 16 can be spent |
| Meeting stones don't summon | `GameObject::Use`, `GAMEOBJECT_TYPE_MEETINGSTONE` | Stones try the Wrath spell 59782 (not in the client) |
| Dungeon kill XP at live's 60% of Classic Era | `Rate.XP.DungeonKill` default 0.6 | Dungeon kills give 1.8x (about 3x live) |
| Faction auction houses, goblin houses cross-faction | `AllowTwoSide.Interaction.Auction` default 0 | One shared house everywhere at 5% / 5% |
| Riding 100g / 1,000g at Friendly | `sql/custom/world/2026_11_19_81_world_forever_riding_prices.sql` | Prices back to 90g / 900g (the Honored price) |

Check after a merge:

```bash
grep -n "IsDelayableNoMore" src/server/game/Spells/Spell.h   # must print nothing
grep -n "ReputationDiscount" src/server/game/Entities/Player/Player.cpp
grep -n "BlocksDungeonCarry" src/server/game/Entities/Player/KillRewarder.cpp
grep -n "DazeChance" src/server/game/Entities/Unit/Unit.cpp
grep -n "HasAchievedOnAccount" src/server/game/Spells/TraitMgr.cpp src/server/game/Entities/Player/Player.cpp
```

Everlake choices that differ from live Forever or have no Forever source (decided 2026-11-19, keep them):

- **No debuff cap.** The official realm probably caps debuffs per target (Era: 16); Everlake keeps no cap (`MAX_AURAS`).
- **Open-world raid tagging is vanilla:** with a raid on the tap list, every raid member near the looter can roll, tagged
  or not. Keep it until Forever says otherwise.
- **Rated 2v2 / 3v3 arenas** (Mak'gora Arena in Hyjal Crater, Ring of Law in Blackrock Depths;
  `sql/custom/world/2026_11_02_50_world_arena_makgora.sql`, `2026_11_08_70_world_arena_ring_of_law.sql`). Forever has not
  announced arenas; Everlake keeps them.
- **Every vanilla raid stays open:** Molten Core, Blackwing Lair, Zul'Gurub, both Ahn'Qiraj raids and Naxxramas, which Forever
  doesn't have, and Onyxia before Forever's 2026-12-09 release. No `disables` rows for them.
