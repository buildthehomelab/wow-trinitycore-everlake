# Bot scenario tests (`.playerbot scenario`)

Bots drive a piece of content with no client logged in; the server judges the run. Goal: a build reaches chris only after its scenarios pass, and a bug shows up as a failing line with a reason instead of a death in a playtest.

## Use
Worldserver console or a GM in game:

    .playerbot scenario list
    .playerbot scenario run deadmines_rhahkzor
    .playerbot scenario status      (while it runs)
    .playerbot scenario result      (last verdict)
    .playerbot scenario abort

The verdict is logged as `[scenario] result=PASS|FAIL name=... run_s=... goal=... failures=N`, then one `[scenario] fail kind=... bot=... at_s=... <reason>` line per failure, in Playerbot.log and appended to `Scenario.log` in the logs directory. A script scrapes `[scenario] result=`.

## What a run does
1. Stage: makes the squad's characters on first use (`Scnwarrior`, `Scnpriest`, `Scnmage`, `Scnrogue`, `Scnhunter`; reused afterwards, pool account, kick-protected), logs them in, takes them out of any old instance and group, revives, levels, runs the setup pipeline (spells, gear, talents), pins the role (`ApplyCompanionRole`), fills health and mana. One step a second; never loops setup on the world thread. Gives up after 8 minutes.
2. Group: tank leads; a squad over 5 becomes a raid.
3. Enter: teleports the squad to the scenario's start point on its map (90 s to arrive). The bots are grouped inside an instance, which arms dungeon-run mode by itself (State_Idle, `lfg_auto`), so nothing else tells them what to do.
4. Run: once a second the squad is sampled and judged. Ends on the goal, a wipe, a stall, or the timeout (20 min for Deadmines). The squad is then grouped out and sent back to Stormwind.

## Failure reasons (Diagnostics/ScenarioMonitor.h, tested in tests/game/ClassicScenarioMonitor.cpp)
| kind | fires when |
|---|---|
| idle | alive, not in a fight, not casting, not recovering (health under 60% or mana under 40%), stood still 45 s while another bot was walking |
| stray | over 70 y from the live tank for 20 s |
| out_of_bounds | under the floor or outside the scenario's box |
| wrong_map | not on the scenario's map once sent in |
| healer_oom | a healer under 10% mana for 10 s |
| death | any member died: killer, spell, damage, position and the rule that was firing, from the same data as `[bot_death]`. The first death ends the run (`max_deaths`, 1): what follows it (release, graveyard on another map) is noise |
| group_stalled | nobody moved 8 y or fought for 120 s (ends the run) |
| wipe | everyone dead (ends the run) |
| timeout | goal not met in time (also "aborted") |
| setup_failed | squad could not be made, logged in, or arrive |

Any failure makes the run FAIL, including deaths on the way to a boss that is later killed. The goal is `KillCreature` (Deadmines: Rhahk'Zor, 644), set from the death hook.

## Adding a scenario
An entry in `ScenarioCatalogue()` (Diagnostics/ScenarioDefs.h): squad, level, map, start point, goal, timeout, limits. Names must be letters only and unique across the catalogue (a test checks it).

## Status
- Written in the cloud, which has no boost/mysql and no client data: the monitor and catalogue compile and pass their tests standalone (a Catch2 stand-in); the runner, the command and the three hooks in PlayerbotV2.cpp are uncompiled and have never run. The PC build compiles them; the first scenario run is the first test of the runner itself.
- New files: needs a cmake reconfigure (`build-server.ps1 -Configure`). Tests: `ctest --test-dir build -C RelWithDebInfo -L scenariomonitor`.
- The start point (-14.57, -385.48, 62.46) is the Deadmines entrance areatrigger target (areatrigger_teleport 1100078), checked against the repo data; Rhahk.Zor (644) is spawned at (-191.7, -453.2, 54.6) inside the box; the box (x -420..100, y -900..-340, z 0..110) is wide on purpose. Check both on the first run; a bad box shows as out_of_bounds at second 1.
- Not built yet: WSG game scenario (needs bot-only queue fill and a match-end goal) and MC boss scenario (needs a raid roster and its pre-spawned instance). Both are catalogue entries plus a goal kind; the runner already makes the group a raid above 5 members.

## Every dungeon (runall)
`kDungeons` in Diagnostics/ScenarioDefs.h is one row per vanilla 5-man: entrance point and facing (the Classic areatrigger_teleport target), level, first boss entry and name, timeout. A row becomes a scenario with the shared five-bot party (`StandardParty`: warrior tank, priest healer, mage, rogue, dwarf hunter; the same five characters are re-levelled for each dungeon) and a box of 600 y / 300 z around the entrance (Deadmines keeps its tighter one). Adding a dungeon is adding a row.

    .playerbot scenario runall            every dungeon in turn
    .playerbot scenario runall rfk        only names containing "rfk"
    .playerbot scenario summary           one line per finished dungeon: "<name> PASS in 412 s" / "<name> FAIL <first reason>"
    scripts\run-scenario.ps1 -All [-Match rfk]    the same over SOAP, one line per dungeon, exit code 0 only if all passed

Rows now: Ragefire Chasm, Wailing Caverns, Deadmines, Shadowfang Keep, Blackfathom Deeps, Stockade, Gnomeregan, Razorfen Kraul, Scarlet Monastery Graveyard, Razorfen Downs, Uldaman, Zul'Farrak, Blackrock Depths (to Lord Roccor). Not yet: Maraudon, Sunken Temple, Dire Maul, Stratholme, Scholomance, Blackrock Spire (several entrances, or a first boss that is not on the way in).

A scenario whose goal creature id is not in this world's creature_template does not start (it is a FAIL line "cannot start: the scenario's data is wrong"), so a wrong id is found in seconds, not after the timeout. A name that differs from the DB's is logged as a warning only.

Status of the data: the entrances come from the repo's areatrigger SQL; the boss ids are the first-boss ids of the vanilla data (five confirmed against the DungeonScripts: Oggleflint, Rethilgore, Ghamoo-ra, Aggem Thorncurse, Rhahk'Zor; the rest from memory, guarded by the creature_template check). Levels are the usual dungeon ranges, a little above the floor. None of the non-Deadmines rows has run.

The run also logs, on a failed run, the last 25 rule changes of every bot (`[scenario] trace Scnpriest t=12s <rule>`), and fails `group_broken` if a bot's group is not the whole party.

## Molten Core (mc_garr, mc_lucifron, mc_magmadar, mc_gehennas)
A 40-bot raid at level 60: 4 tanks (3 warriors, 1 bear), 12 healers (5 priests, 4 paladins, 3 druids), 24 DPS (5 mages, 5 warlocks for Banish, 4 rogues, 4 hunters, 3 warriors, 1 ret paladin, 2 shadow priests). All Alliance, 40 characters named Mc<class><letter> (`kMcRaid` in ScenarioDefs.h is the roster, `kMcBosses` the boss rows). One boss per scenario; Garr first, then Lucifron, Magmadar, Gehennas.

    .playerbot scenario run mc_garr
    scripts\run-scenario.ps1 -Name mc_garr          (the default 40 minute wait covers staging a raid for the first time)
    .playerbot scenario runall mc                    all four, one after another; `runall` with no filter runs the dungeons only

Flow: stage (4 bots a step: create, log in, pin the role, level 60, gear, spells, talents; the first run makes 40 characters), reset the squad's instance locks for map 409, raid group (leader = the first tank), everybody to the Molten Core entrance, then to a floor spot 28-40 y from the boss's first spawn in the creature table, in sight of him (nothing is hardcoded about the room; a spot with no floor in sight fails the run with the spawn coordinates). The encounter is pre-spawned, so the boss and his adds are already there. The squad holds position (a Hold order) for 20 s, then the main tank gets what the owner's Attack gives: start_attack plus an Engage order on the boss. A bot-led raid has no human Attack to wait for, so the DPS go when the tank opens. The raid layer does the rest.

Raid rules added to the monitor (ScenarioLimits, pure, tested):
| kind | fires when |
|---|---|
| death | the sixth death (`tolerated_deaths` 5: the first five are listed as `[scenario] note` lines, not failures); the sixth also ends the run (`max_deaths` 6) |
| wipe | every member dead, or every tank dead (`tanks_dead_is_wipe`) |
| boss_reset | the boss was seen in combat, then out of combat for 5 s or evading; ends the run |
| dps_hold | a DPS bot sat in combat:threat_hold / combat:threat_wait_tank / raid:threat_hold for 20 s while the raid fought (the rule name, not the mark: there is no "marked target" signal in the snapshot, the threat rules are what hold DPS) |
All the dungeon rules still apply (idle, stray at 120 y, out_of_bounds, healer_oom, group_broken at 40, group_stalled at 120 s - which is also what "the tank never pulled" looks like).

A failed raid run logs the trace (last 25 rule changes) of the 4 tanks, the first 3 healers and 3 DPS by name, and every bot named in a failure; a death adds a DIED line. Timeout 15 minutes from the start of the run.

Staging changes that also apply to the dungeon scenarios:
- The squad is marked as a scenario squad (`Pool::MarkScenarioBot`): held like an owner's bots, so their gear is the raid tier at 60 and the world gear scrub / reroll no longer touches them mid-run (the earlier "gear reroll of Scnpriest mid-run").
- The role is pinned before the setup pipeline, so gear and talents follow it (before, the pipeline rolled its own role first).
- A character set up for another level has its pipeline reset, so the shared dungeon party gets the spells and gear of each row's level, not the level number only. The dungeon rows are ordered by level (a character is only levelled up).
- Instance locks are reset before a run, so a boss killed by the last run is alive again. A lock still held by a loaded map is logged as such; if the boss is dead anyway the run fails at the attack with "not alive within 400 y".

## Deadmines run 3 fixes (2026-10-09)
Run 3 (99cfe84b) failed at 88 s: healer out of mana, warrior killed by Miners, eight mobs on the tank, the priest without line of sight to the tank 16 times, rogue and hunter idle in threat hold for 20 s. Changes:
- Staging stocks food and drink for the level (vanilla ids, logged by name as `[scenario] <bot> stocked ...`): the upkeep drinks only from what the bags hold.
- A party's DPS no longer sits in the over-threat hold for more than 3 s per target (`[party_threat]`), and trash the tank already holds gets the short 2 s opening wait in a party as in a raid.
- The tank's hazard step-out in a 5-man party takes the shortest way out of the zone; the raid-front / raid-centroid filter (a raid concern) left it standing in Flamestrike.
- The healer / caster LoS step falls back to a step along the navmesh path to the tank when no straight bearing is walkable (`[raid_los] ... follows the path`).

## deadmines_full
The standard five (level 21, bot-led) from the entrance to Edwin VanCleef (639): Rhahk'Zor, Sneed, Gilnid, the door and cannon, Mr. Smite, Greenskin, VanCleef, in the DeadminesScript's order. Whole-instance box (x -420..100, y -900..-340), 45 minutes, the first death ends the run. `scenario run deadmines_full`; `run-scenario.ps1 -Name deadmines_full -WaitMinutes 60`. Left out of `runall` with no filter (`runall full` runs it). Not yet: a rogue standing in for chris as a player-led follower; this run tests the bot-led autopilot, which is what has to hold first.

## deadmines_player
`deadmines_full` with the rogue (Scnrogue) played like chris's character: when the run begins its AI is taken off (`Scheduler`/`Snapshots`/`Registry` unregister, as `.playerbot self off` does) and the runner drives it once a second - it attacks the main tank's victim (else whatever attacks it) and otherwise follows the tank (`MoveFollow`, 3 y). Its identity mark stays, so the group is still bot-led and the tank's autopilot leads; a real human-led run (bots following the player) is not reproduced. The stand-in is logged out when the run ends and gets a fresh AI at the next staging. Log line: `[scenario] deadmines_player plays Scnrogue like a player`.

## Run 4 follow-ups (monitor)
- `[scenario] context <kind> <bot> t=Ns <rule>` lines: for every failure, the failing bot's rule changes from the 90 s before it (and the rule in force when the window opens), so an early idle failure is no longer lost behind the last 25 changes of a long run.
- A squad standing while a healer is below the tank's pull-ready mana (75%) out of a fight is waiting, not idle. A healer that stays under it for 90 s out of a fight fails as `healer_no_rest` (it is not drinking back), so the cause is reported on the healer.

## Deadmines route walk (deadmines_full)
From classic_instance_deadmines.cpp and the world data: Rhahk'Zor's death opens door 13965, Sneed's (643, who comes out of the Shredder 642) opens 16400, Gilnid's opens 16399 - those need nothing from the bots, but the fights have to be finished (Sneed is a separate creature after the Shredder dies). The Iron Clad Door 16397 (-100.5,-668.8,7.4) in front of the ship opens only when the Defias Cannon 16398 (-107.6,-659.7,7.2) is used. It was not authored in the DeadminesScript, so the tank would have walked up to a shut door; `use_go_entries = { 16398 }` now has the tank use it once (the existing gate-lever rule: within 35 y, walks up, uses, steps onto it). Unverified: the cannon's lock (Data0 83) and whether a bot's `use_game_object` triggers the goober; a stall at the door with `idle:dungeon_approach_gate_lever` repeating is that case.
