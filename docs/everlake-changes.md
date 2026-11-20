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

## Timed world buffs (`Classic.WorldBuffs.*`)

Everlake does not offer the raid head turn-ins, so their world buffs go out on a timer instead, ported from Evermore's
mod-world-buff-bots. Every 30 to 150 minutes (rolled each cycle) a made-up player "returns the head of Onyxia":
Rallying Cry of the Dragonslayer (22888) goes to the Alliance in Stormwind and the Horde in Orgrimmar at the same
moment. Spirit of Zandalar (24425) follows 10 minutes later in Stranglethorn Vale for both factions. Each faction gets
a system message 10 minutes before each buff, naming the realm time it drops, and another when it lands. Alive, non-GM
players of that faction in the zone get the aura added straight on (not cast, since the spells also reach nearby allies),
bots included. The timer is not saved; a restart rolls a new first
cycle. Rend's head (Warchief's Blessing, Might of Stormwind) is left to players, since Upper Blackrock Spire stays open.

Live Forever (checked 2026-11-19): the buffs come only from turn-ins. Live has no timer and no Chronoboon for sale.
Rallying Cry needs Onyxia (live from 2026-12-09) and Zul'Gurub is not on live, so this is an Everlake extra. Buff
lengths are the client's (2 hours each). Rallying Cry's dummy auras are made real in `SpellMgr.cpp`
(`ApplySpellFix({ 22888 }`); Spirit of Zandalar is already real in the client.

| Hook | Where | What breaks if it goes |
|---|---|---|
| The timing | `src/server/game/World/WorldBuffCycle.h` | Build fails (the script below) |
| The script | `src/server/scripts/Custom/Classic/world/classic_world_buffs.cpp` | **Silent:** no buffs go out |
| Script loader | `src/server/scripts/Custom/Classic/classic_script_loader.cpp`, `AddSC_classic_world_buffs()` | **Silent:** no buffs go out |
| Rallying Cry auras | `src/server/game/Spells/SpellMgr.cpp`, `ApplySpellFix({ 22888 }` | **Silent:** the buff shows but does nothing |
| Config block | `src/server/worldserver/worldserver.conf.dist`, `Classic.WorldBuffs.*` after `Classic.CreatureHealth.Raids` | Defaults still apply (they're in the code), but the options are no longer documented |
| Tests | `tests/game/WorldBuffCycle.cpp` | Timing changes go unnoticed |

Check after a merge:

```bash
grep -n "AddSC_classic_world_buffs" src/server/scripts/Custom/Classic/classic_script_loader.cpp
grep -n "ApplySpellFix({ 22888 }" src/server/game/Spells/SpellMgr.cpp
grep -n "^Classic.WorldBuffs.Enable" src/server/worldserver/worldserver.conf.dist
```

On the PTR, the worldserver log shows `Classic.WorldBuffs: next Rallying Cry of the Dragonslayer in N min` at start-up. To test quickly,
set `FirstMinMinutes`, `FirstMaxMinutes`, `MinMinutes` and `MaxMinutes` to 15 and stand in Stormwind or Orgrimmar.
