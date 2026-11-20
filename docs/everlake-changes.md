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

## Bots swim under the surface while they move (`WaterRouteAdjust`), PTR report 2026-11-19

A bot's route over deep water runs at its swim depth (`Swim::SwimZ`, head out, body under) instead of on the navmesh's
water polygons, which lie on the surface. Before it, a moving or following bot swam on top of the water and only sank
in once it stood still. The core's `PathGenerator` calls an optional hook for every finished route whose corridor
crosses water polygons; the bot module lowers each deep-water point above the swim z to it. Dives and points on the
lake bed keep their depth, the bot's own start point is never moved, and only bots are touched.

| Hook | Where | What breaks if it goes |
|---|---|---|
| `SetWaterRouteAdjust` / `AdjustWaterRoute()` | `src/server/game/Movement/PathGenerator.h` / `.cpp`, called at both exits of `CalculatePath` | **Silent:** bots swim on top of the water again while they move |
| `BotSwimRouteDepth` + its registration | `src/modules/PlayerbotV2/PlayerbotV2Scripts.cpp`, `AddSC_playerbot_v2` | Build fails if the core hook goes; **silent** if only the registration goes |
| `Swim::RoutePointNeedsLowering` | `src/modules/PlayerbotV2/Api/BotSwim.h` | Build fails |
| Tests | `tests/game/BotSwimRoute.cpp` | Rule changes go unnoticed |

Check after a merge:

```bash
grep -n "AdjustWaterRoute()" src/server/game/Movement/PathGenerator.cpp
grep -n "SetWaterRouteAdjust" src/modules/PlayerbotV2/PlayerbotV2Scripts.cpp
```
