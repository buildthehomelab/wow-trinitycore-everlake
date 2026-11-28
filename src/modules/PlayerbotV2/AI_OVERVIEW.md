# PlayerbotV2 bot AI: how a bot decides what to do

A map of the decision path, written to find out why bots joining a group sometimes do not take their role, or stand still. Paths are
relative to `src/modules/PlayerbotV2/`. Line numbers are as of late November 2026 and will drift; the function names will not.

## 1. One tick, end to end

```
world thread, every frame (PlayerbotV2Scripts OnBeforeMapsUpdate -> Module::OnWorldUpdate, PlayerbotV2.cpp)
  1. coordinators: BG, PvE (PveCoordinator), RaidBrain, boss warnings
  2. snapshots: pick the bots due (TickScheduler) -> build a BotSnapshot per bot, in parallel per map
     -> group snapshots (50 ms cache) -> publish
  3. BG ports, LFG accepts, dungeon finder tick, Group Finder fill (LfgTick)
  4. DrainIntents: run the intents the bots queued last frame (Bot/BotIntentExecutor.cpp)
  5. session, population (companion setups, upkeep), guild, craft ticks
  6. TickScheduler::on_world_tick -> AiWorkerPool::schedule_ticks

worker threads (Threading/AiWorkerPool.cpp, up to 24)
  run_one: latest snapshot + group snapshot -> BotAI::tick(view, group, emitter)
           -> intents pushed into the bot's queue, executed on the world thread next frame
```

So a bot thinks one frame behind what it sees, and its actions land one frame later still. Bot logic never touches `Player*`:
it reads the immutable snapshot and emits intents.

**Tick rate** (`Bot/BotActivityTier.h`): Combat 100 ms, Active 150 ms (moving, swimming or grouped), Idle 500 ms, Cruise 600 ms,
parked 2000 ms after a run of idle ticks. Each bot has its own phase in the period.

**Inside `BotAI::tick`** (`Bot/BotAI.cpp`), in order:

1. Movement watchdog credit, pet react/taunt upkeep, transport and zone bookkeeping.
2. `update_group_fight`: for a group led by a human, decide the GroupFight mode (Fight, Stop, Flee, Fallback, PullBack, Stay,
   Follow) from the leader's combat, members fighting near the leader and the owner's last order (`Bot/GroupFight.h`).
3. State transitions (below).
4. Map-change reset, dungeon autopilot hold.
5. Early outs: an owner step sequence, `HonorFollowDrop`.
6. `dispatch_primary`: the current state's dispatcher.
7. `dispatch_layers`: duel and trade answers, bag room, gift gear, then **`DispatchInGroup`** when grouped, then chat.

Several of these can emit in the same tick (a combat cast plus an InGroup follow, say). There is no arbitration step: whatever
fires pushes its intents.

## 2. The snapshot

`BotSnapshotBuilder::Build` (`Bot/BotSnapshotBuilder.cpp`) fills `BotSnapshot` (`Bot/BotSnapshot.h`). What the decisions read most:

- **identity**: class, `spec = Classic::EffectiveSpecId(p)`: the retail spec when the character has one, else the virtual spec
  override (`SetSpecOverride`), else the spec read from the talents and signature spells (`Api/ClassicSpec.cpp`). On Classic every
  class has one spec row, so the override is what makes a bot a Holy priest or a Protection paladin.
- **`group.my_role`**: `infer_role(class, spec)`. Purely class and spec; no LFG bits, no role override.
- vitals, auras, cooldowns, own cast, spellbook;
- group and owner: `owner_in_group`, `led_by_player`/`controller_guid`, stances (`no_fight`), holds;
- combat: victim, `attackers`, 40 yd `nearby_enemies`/`nearby_friends` scans with threat context (`victim_kind`, LoS, reach);
- coordinator orders: `pve_order` (heal focus, main tank, kill focus, CC) and `raid_order`.

The **group snapshot** (`Group/GroupSnapshotBuilder.cpp`) has one summary per member. A member's `role` comes from the main-tank flag,
then the group's LFG role bits, then spec inference (`TranslateRole`).

## 3. States and rules

Only three states are live: **Idle**, **InCombat**, **Dead** (`Bot/BotTypes.h`; the others are stubs in `State_Stubs.cpp`).
**InGroup is a layer**, not a state: it runs after the state dispatcher whenever the bot is grouped.

Transitions (`BotAI.cpp`, pure reactions to the snapshot):

| From | To | When |
|---|---|---|
| any | Dead | not alive |
| Dead, LoggingIn | Idle | alive |
| Idle | InCombat | in combat, or any attacker, or raid tank on duty, or `group_fight()` |
| InCombat | Idle | none of those (a fight over 1.5 s counts as a kill) |

### Idle: a priority list, first match wins

`DispatchIdle` (`Bot/States/State_Idle.cpp`) runs a fixed prologue (dead, taxi, spawner walks, run-mode arming) and then the
**idle rule registry** (`Bot/IdleRule.*`). Every rule is `{name, priority, gate, fire, min_interval}`; rules are sorted by
priority and the first whose gate is true and whose fire emits wins. A fire that returns false falls through. The registry is
walked twice (priority 700 and up first, then the rest).

The rule families, highest first (files in `Bot/States/Rules/`):

| Priority | Family | Examples |
|---|---|---|
| 990-1001 | owner orders, transport, the opener | `fallback`, `pull_back`, `combat:opener`, `owner_following`, `holding`, `stay` |
| 991-993 | Classic upkeep and healer upkeep | buffs, auras, `ooc_rez`, **`ooc_heal`**, raid pre-pull |
| 840-900 | survival and group flow | flee liquid/hazard, invites, `lfg_proposal_accept`, `rejoin_group_instance` |
| 690-735 | pets, talents, gear, quests | `starter_talents`, `auto_equip`, `quest_turnin` |
| 720 / 718 | `dungeon_dispatch`, `bg_dispatch` | the whole dungeon and battleground cascades |
| 200-500 | errands | vendor, mail, AH, gather, bank, guild, trainer, `dual_spec_switch` |
| 50-144 | world life | kind heal/rez, ambient emotes, `autoact_dispatch` (questing, travel, wander) |

World errands are skipped for a bot led by a player, so a companion only does group work.

A rule watchdog (`BotAI.cpp`) notices one rule firing 60 times in 30 s and lets `idle:watchdog_escape` take over.

### InCombat: a fixed cascade, then the rotation

`DispatchInCombat` (`Bot/States/State_InCombat.cpp`) is a hand-ordered list of early-return steps: Passive, idle watchdog,
fallback/pull back, flee, dismount, raid orders and hazards, solo flee, help runners, the group's target pick (`GroupFightPick`),
disengages, tank and healer positioning, target acquisition, the cancel-overheal check, **return while casting**, threat hold,
the pre-emptive tank heal, then **the class rotation (APL)**, then a raid healer hold, then a fallback auto-attack.

### Intents

The emitter (`Bot/BotIntentEmitter.*`) refuses some intents outright: a Passive stance, a raid keep-out, and for casts the mana
break, school blocks, owner CC denies, focus-heal lists, Loatheb's lock, the same spell within 1.5 s, or a GCD just started. The
executor (`Bot/BotIntentExecutor.cpp`) runs at most 64 intents per bot and 4096 per frame within 30 ms. It calls `PlayerbotAPI`,
which does the real known/target/range/LoS checks. Persistent rejects back the spell off for 10 s.

## 4. Rotations (APLs)

An APL (`Combat/ApRotation.h`) is an ordered array of `{predicate, action, name}`. The first predicate that is true *and* emits
wins; there are no scores. `Combat::GetRotation(class, spec)` (`Combat/ApRegistry.cpp`) picks it.

**The rotation is chosen by spec, not by role.** In `DispatchInCombat`, `rotation_spec` is:

- the snapshot spec;
- spec 0 (the baseline kit) below level 10, except a Classic healer, who keeps the healer spec so it can heal from level 1;
- the class's damage spec for a tank-spec bot the raid's tank roster does not need;
- **the class's damage spec for any bot not in a group** (a lone healer grinding kills faster as damage).

Classic mapping: priest 0/256/257 heal and 258 is Shadow; druid 105 heals; paladin 65 heals and 66 tanks; shaman 264 heals;
warrior 73 tanks. So a bot heals in combat only when its **spec** (usually the virtual spec override) is a healer spec.

## 5. Roles: where they come from and how they are pinned

There are three role readings, and they can disagree:

1. `BotAI::role_override_`: set by `setrole`, `DeclareRole`, `ApplyCompanionRole`. `effective_role()` returns it when set.
2. snapshot `my_role`: class + spec.
3. group member `role`: main-tank flag, then the group's LFG bits, then spec.

For a **companion** (a bot owned by a player's account) the role is settled by `BotPopulationManager::ApplyCompanionRole`, through
the pure rule `Fleet/CompanionRole.h` `ChooseCompanionRole`:

- the role asked for now (`.bot add priest healer`, the Group Finder fill, the raid quota fill), else the role stored with the
  companion: **declared**, pinned (role override + virtual spec) and stored;
- otherwise the role read from the talents: used but not stored (the talents may not be bought yet), except a paladin or druid
  whose talents read as tank, which heals until the raid fill says otherwise.

It runs at setup (`FinishCompanionSetup`), login, `.bot save` and the 5-minute upkeep (`CompanionUpkeep`), so a pinned role is put
back if anything moved it. Pinning sets the spec override, so the rotation, `my_role` and the role override agree.

**How a companion joins:**

- Group Finder fill (`LfgBotFill.cpp` `FillGap`) and `.bot dungeon` (`DungeonFinder.cpp`, through `LfgFillToSize`) ->
  `AddCompanionForOwner` -> `AddCompanionFor` (`Commands/cs_playerbot_v2.cpp`): always a **new** bot (a loan on a hired-bots
  realm), a warrior tank, priest healer or a random mage/rogue/hunter/warlock, queued with that role.
- `.bot add <class> [role]`: on a hired-bots realm an idle hired companion of the account comes instead (`IdleHiredCompanion`),
  which only matches a companion whose **stored** role equals the one asked for, then goes through `CallCompanions`.
- `.bot call` / `.bot summon` (`CallCompanions`): queued with no role, so the stored role (or the talent reading) applies.

Every path ends in `QueueCompanionSetup` -> `DrainCompanionSetups` (waits for the bot to be in the world with its bot logic) ->
`FinishCompanionSetup`: level to the owner, trainer spells, **role**, talents, gear, teleport, join the group.

The **party frame role icon** is set by the bot itself: `DispatchInGroup` compares the group slot's LFG role with
`effective_role` and calls `Group::SetLfgRoles` when they differ (`ingroup:set_role_no_lfg`). So whatever the bot plays is what the
frame shows within a tick or so; nothing else needs to set it.

**World bots in a listed bot group** (the Group Finder's own bot groups, `ListNewBotGroup`) are not companions: nobody pins their
role. See section 8.

## 6. The healer

In combat a Classic healer runs its class's `kHealerRules` (`Combat/Apl/Apl_Classic_Priest.cpp` and the druid, paladin and shaman
files). Priest order: Desperate Prayer, shields, Renew on the tank, Inner Focus, Flash Heal under about 40 %, emergency heal, Fade,
Psychic Scream, Prayer of Healing (3+ hurt), big heal under about 65 %, dispel, buffs, Renew, rez, shackle, then damage fillers.

**Target**: `ClassicHeal::PickPatient` (`Combat/Apl/ApClassicHeal.h`): group members (and itself) online, alive, on the map, within
40 yd; out of LoS only if a tank or under 35 %; health projected through the swings landing on them; tanks score higher, the
coordinator's heal focus +20, a member another healer is already healing -30. Inside a 5-man or raid on Classic the mana rules
apply (opening hold, mana stand-down, leave a topped tank to the assigned healers, subgroup triage).

**Cast**: `EmitHeal` -> `PlanHeal` sizes the rank to the deficit; it skips at low mana for a top-up, on overheal, on an
unaffordable rank or when an in-flight heal already covers the patient.

**What must hold for a heal to go out in combat:**

- the bot is in the InCombat state (itself in combat, attacked, or its group's fight is on);
- it is **grouped** (else the damage rotation) and its **spec** is a healer spec;
- no earlier step of the cascade returned (raid orders, hazards, moving to the tank, threat hold, already casting);
- a patient below the rule's threshold in range and sight; the spell known and ready; mana and the rank plan pass;
- not stunned, silenced, feared; not inside the emitter's spell or GCD lockouts.

Out of combat `idle:ooc_heal` (priority 993) heals a member under 80 %, but only for `effective_role == Healer`, grouped, not
casting, and with mana to spare unless the member is under 35 %.

## 7. Where a bot ends up doing nothing

Scheduler and worker: not due, a tick already in flight, no snapshot yet, a stale snapshot (older than min(3 periods, 1 s)), an
exception in the tick (swallowed).

Idle: dead, on a taxi, or **no rule gates and fires**: a led bot skips the world errands, the per-rule throttles hold, and the
group work has nothing to do.

InGroup layer (`State_InGroup.cpp`): returns before the follow/assist part when the bot is in combat, the leader is the bot itself,
**the leader is offline or on another map**, or on a flight or a ship. A companion on another map than its leader (a door refused
it, a teleport failed) does nothing in this layer; the owner catch-up on the world thread (`Fleet/OwnerCatchUp.h`,
`Playerbot.Behavior.CatchUpToOwner`, on by default) brings it to him after 15 s once both are alive and out of combat, through
`BringToOwner` and its instance door checks.

InCombat: Passive (`no_fight`), flee or hold orders, still casting, a threat hold waiting for the tank, a rotation with no
predicate that both matches and emits, a raid healer with nothing to cast (`combat:raid_healer_hold`), the fallback attack finding
no target or refusing a mob that is not fighting the group.

Healer only: no valid patient (everyone above 90 % projected, out of 40 yd or sight), the raid mana rules, an unaffordable rank,
or crowd control.

Emitter and executor: queue full, Passive, keep-out, cast lockouts, the `/wait` pause, the per-frame budget.

The bot says why in the logs: `[dps_idle_reason]` / `[heal_idle_reason]` after 3 s idle in combat, `/whyidle` for the idle
registry, `last_rule_fired` in the inspector.

## 8. Findings: bots that join and do not play their role

**Confirmed: the Group Finder's listed bot groups list roles by class and never give the bots those roles.**

`ListNewBotGroup` builds the group with `BotGroupBuilder::BuildGroup`. Its tank and healer passes order the free bots by the
archetype's `role_affinity`, which is `{0.10, 0.10, 0.80}` for every archetype, so the "real lean" test fails at once and the
group is simply the first free bots of the level range. `AssignListedRoles` then gave tank and healer by class alone (warrior >
paladin > druid; priest > paladin = druid > shaman) and set only the group's LFG bits. No spec, no role override. Each bot then:

- played its own spec: the "healer" priest was often Shadow, the "tank" warrior often Fury;
- reset its party role to its spec's on its next tick (`set_role_no_lfg`), so the icons the player saw at the join changed.

A player who joined such a group got a healer that never healed, or a tank that did not tank. This matches "do not take their
role", and "stand there" for a healer, which out of combat has nothing to do and in combat runs a damage rotation.

Fix (this change): `PlanListedRoles` (`LfgRoleGap.h`, tested in `tests/game/LfgListedRoles.cpp`) gives a place first to a bot whose
spec already plays it, then by class. `PlayListedRole` switches any listed world bot given a role its spec does not play to that
role's spec (virtual spec override + talent build, as the dungeon queue's role tags already do). Logged as
`[lfg] listed bot ... takes the healer place: spec X -> Y`.

**Confirmed, smaller: a companion setup dropped after 60 s.** `DrainCompanionSetups` gave up on a bot that was not in the world
60 s after it was queued, even while its login was still loading. The bot then came in unlevelled, ungrouped and with no role,
and stood where it was created. Now a login still in flight is waited for up to 5 minutes, and the owner is told when it is given
up (`[Companion] bot ... did not enter the world within Ns (login still in flight)`).

**Checked and not the cause:**

- `FillGap` not calling `SetLfgRoles`: the bot sets its own party role on its first grouped tick (`set_role_no_lfg`), and the gap
  count falls back to the class (warrior tank, priest healer), which is what the fill brings anyway.
- The hire path losing the requested role: `IdleHiredCompanion` only returns a companion whose stored role equals the one asked
  for, and `CallCompanions` then pins that stored role. A requested role can only be *refused* (no idle companion stored with it),
  never swapped.
- The Group Finder fill and `.bot dungeon` bring new bots with the role passed in, pinned as declared. Their spec override makes the
  rotation agree.

**Not confirmed (needs `Playerbot.log`):** whether a specific report was a listed bot group, a companion setup drop, or a companion
standing on another map than its leader. The worldserver console in the log viewer carries none of the bot lines; they are only in
`Playerbot.log`. To check a case, grep there for the bot's name with `[lfg]`, `[role]`, `[Companion]`, `[heal_idle_reason]`.

## 9. Improvements since the first findings

Each was its own pull request; none is deployed yet.

1. **Role-aware group building** (PR #181). `BotGroupBuilder` now fills tank and healer places with bots whose spec plays the role,
   then with the best class for it (`Fleet/GroupRolePick.h`), instead of the flat archetype affinity that took nobody. The respec in
   `PlayListedRole` is then rarely needed, and the gear fits the role.
2. **One role source in combat** (PR #182). The snapshot's `my_role` is now the bot's pinned role when it has one, else its spec's
   role, the same rule as `effective_role`. The healer follow-tank and gap-close moves, the area-attack step-out, the threat checks,
   the interrupt rule and the paladin seals and blessings now agree with the heal rules. The spec-only reading is kept as `spec_role`
   for `idle:dual_spec_switch`.
3. **Gap count by what members play** (PR #183). The fill counts a member with no group role by the leader's pick, else by the role
   they play (a bot's pinned role or spec, a player's bought talents through the new `Classic::TalentSpecId`), else by class. A
   Shadow priest player no longer stops a healer bot from coming.
4. **Healers say why they are not healing** (PR #184). The healer idle probe now runs for any grouped healer, not only in raids. When a
   member under 60 % gets no heal for 4 s for a reason the player can fix, the healer says it in party chat: "I can't see <name> from
   here to heal.", "<name> is too far away for my heals." or "I'm out of mana, I can't heal." At most one line per 30 s.
   `Playerbot.Behavior.HealerSaysWhy` turns it off.
5. **`highest_threat_attacker()` renamed to `top_attacker()`** (PR #185). It never ranked by threat: it returns the first fightable
   attacker, mobs on the bot first and then the biggest. Its three callers want exactly that for self-defence, so only the name and
   comments changed.

Checked and dropped: "a companion on another map does nothing". The InGroup layer does skip it, but the owner catch-up above
already brings it after 15 s.
