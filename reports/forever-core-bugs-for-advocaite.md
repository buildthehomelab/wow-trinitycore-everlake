# Forever core bugs found while testing bots (Classic 1.60, client 70205)

Three bugs in the Forever core (advocaite/TrinityCore `forever`), independent of the bot module. Each one hits
any two real players too. Fixes are on Karrz1/wow-foverver `playerbot-v2-trial`; the diffs are small and apply to
`forever` as is.

## Status after forever dbcbaa93 (2026-10-06)

advocaite's dbcbaa93 ("two-player fixes") fixes #1 and #2 from official sniffs, and our branch now uses his
versions (playerbot-v2-trial, upstream folded in on 2026-10-06):
- #1 and the follow-up 12 bytes (our b094f782 + bb7ca962): same fix as his (all four fields around CurrentAreaID
  owner only). Ours dropped, his kept.
- #2 (our ee65f907): his sniffed layout is 6 bit name, 9 bit surname, 4 bit command, 6 bit result, plus the
  surname string. It also explains the crash we saw (the client read a 6 bit name length first). Ours dropped,
  his kept; invites need a re-check in game on 70205.
- Party member fields between players (our 2fd91311) and party member phase flags as 1 byte (our 31985d26): same
  as his. His kept.
- #3 (our ada25e5d) is NOT in his commit: `forever` still maps 0x450010 to CMSG_LATENCY_REPORT. We keep ours.
  His update-field fix makes names and gear right in the create packet, but the client still asks for names with
  0x450010 and nobody answers it upstream.
- `m_pingRestriction` initialisation (86570ffa): still ours only.

## 1. Another player's create packet is 2 bytes too long ("Invalid Option ID 512 / 589824")

`UnitData::WriteCreate` writes an empty guid right after `CurrentAreaID` for every viewer. The 1.60 client
reads that guid only in the owner's own create (it is Classic Era's owner-only ComboTarget; WowPacketParser
V5_5_0 `UpdateFieldsHandler1158.cs` has the same visibility). For anyone else the rest of the block is read 2
bytes late, and the client logs "Invalid Option ID 512 / 589824" for the customization choices of every other
player it sees.

Fix (commit b094f782): write it only when `fieldVisibilityFlags.HasFlag(UpdateFieldFlag::Owner)`.
Confirmed in game: the warning is gone.

## 2. SMSG_PARTY_COMMAND_RESULT field order: client crash on every /invite

Retail writes Name length (9 bits), Command (4), Result (6). The 1.60 client reads a 6 bit field first, so it
takes the name length from bits 6-14. Inviting "Testwar" gave 7 << 5 = 448 and the client asserted
`BC_ASSERT(n < N) n=448 N=257` (fatal) right after this packet:

    S>C SMSG_PARTY_COMMAND_RESULT 03 80 00 00 00 00 00 00 00 54 65 73 74 77 61 72

Fix (commit ee65f907): `Bits<6>(Result)`, then `SizedString::BitsSize<9>(Name)`, then `Bits<4>(Command)`.
Confirmed in game: invites work. (Result first is certain from the crash; Command after the name is inferred.)

## 3. Client opcode 0x450010 is CMSG_QUERY_PLAYER_NAMES, not LATENCY_REPORT (every other player is "Unknown")

`ClassicClientOpcodes.inc` maps client 0x450010 to CMSG_LATENCY_REPORT and 0x450011 to CMSG_QUERY_PLAYER_NAMES.
The client sends 0x450010 right after another player's create, with `uint32 count = 1` plus that player's packed
guid, and the server logs "not handled CMSG_LATENCY_REPORT". Nobody answers, so every other player's name shows
as "Unknown" (nameplate, party frame, target frame).

Fix (commit ada25e5d): `{ 0x450010, 0x440010 }` and drop the 0x450011 override (indices match retail again from
there, so it falls to the default mapping). Confirmed in game: names show.

## 4. Classic graveyard team conditions have SourceGroup and SourceEntry swapped (every team-only graveyard is open to both factions)

`sql/custom/world/2026_09_30_01_world_classic_graveyards.sql` writes its `conditions` rows for
CONDITION_SOURCE_TYPE_GRAVEYARD (27) as `(27, <graveyard id>, <zone>, ...)`, e.g. `(27, 34, 215, ...)` for
"Graveyard 34 (Mulgore) - Horde only". TrinityCore keys these as SourceGroup = zone (`graveyard_zone.GhostZone`)
and SourceEntry = graveyard id (`graveyard_zone.ID`): ConditionMgr checks `FindGraveyardData(SourceEntry,
SourceGroup)` and `ObjectMgr::AddGraveyardLink` writes zone into SourceGroup. Swapped, no row matches a link, so
the faction condition never applies (the file's own `DELETE ... WHERE SourceEntry IN (<zones>)` has the same swap).
All 63 rows match a `(ID, GhostZone)` pair of the same file's `graveyard_zone` insert with the columns flipped.

Fix (our commit b8a7e301): a follow-up custom world update,
`sql/custom/world/2026_10_06_90_world_classic_graveyard_conditions_fix.sql`, deletes the swapped rows and inserts
them as `(27, <zone>, <graveyard id>, ...)`. The cleaner fix upstream is to swap the two columns in the original
file (and its DELETE to `SourceGroup IN (<zones>)` or a `(SourceGroup, SourceEntry)` pair list).

## 5. Legacy creature spells are scaled as if their base points were percentages (Molten Giant Smash hits for 8-26k)

`SpellEffectInfo::CalcBaseValue` (`SpellInfo.cpp`) reads the base points of every creature spell whose effect has an
expected-stat type (direct damage and heals, periodic damage and heals, damage shields, mana burn and drain, absorbs,
damage-taken and stat or attack-power modifiers; see `GetScalingExpectedStat`) as a percentage of
`ExpectedStat` at the caster's level, with expansion -2 (the current curve). Only players and what they control are
exempt (`UsesClassicFlatBasePoints`). That is right for the spells new to Forever, whose DB2 rows carry percentages
(Living Storm Shock 1259652: 10, on the official beta 16-18 damage). It is wrong for every vanilla and Classic Era
spell, whose rows in the 1.60.1.70205 `SpellEffect.db2` still carry the vanilla flat values:

| Spell | DB2 row (70205, no hotfix rows) | Vanilla | Observed on Forever |
|---|---|---|---|
| Molten Giant Smash 18944 | SCHOOL_DAMAGE 900, variance 0.2, 10 yd | 810-990 | 7,754-25,748 (36 raid deaths in one pull) |
| Firesworn Blast Wave 20229 | SCHOOL_DAMAGE 750, variance 0.149, 10 yd | 638-862 | not yet observed |

So every vanilla or Classic Era creature spell with one of those effect types is multiplied by ExpectedStat / 100 at
the caster's level: about 9-29x for the level 60-63 raid creatures (Smash, after armor and variance), less, and at low
levels possibly below 1x, in the open world. That covers the damage, heal and mana-burn spells of the raid trash and bosses in Molten Core, Onyxia,
Blackwing Lair, AQ and Naxxramas, and of every dungeon and open-world creature. Only the effect types decide it, so
any creature spell id below the Forever range with a direct or periodic damage or heal effect is affected. Inferno
19698 has base 1 and takes its damage from script and aura stacking, so it is affected much less.

Fix (our commit, see `UsesClassicFlatBasePoints` on the raid branch): legacy spells use flat base points by spell
id. Every spell new to Forever sits in the modern id range (the Forever creature scripts in `sql/custom` cast
1250053-1317755 for new content), while vanilla and Classic Era spells stay below 1,000,000 (the same scripts use
< 415,000 for the rest), so ids below 1,000,000 take the flat value and keep the vanilla per-level points. If
Forever ever reworks a vanilla spell id with percentage data, that spell needs to be named explicitly (a list, or a
DB2/hotfix marker) instead of the id cut.

Data check behind the cut (70205 `SpellEffect.db2`, 42,409 of 43,670 rows decoded, encrypted rows skipped):
`Coefficient` and `ScalingClass` are 0 on every row (both columns hold only 0), and below id 1,000,000 the 2,370
SCHOOL_DAMAGE rows all carry flat vanilla-scale values.

Caveat for the Forever spells themselves (not changed by us): at or above id 1,000,000 the 610 SCHOOL_DAMAGE rows are
mixed. About 64% have base points 1-300, which reads like expected-stat percentages, but about 32% are above 300 (up to
99,999,904, many fractional, often with `EffectBonusCoefficient` 1). Reading all of them as percentages of
`ExpectedStat` may over-scale part of Forever's own new content in the same way; those rows are worth checking against
the official beta numbers.

## Also seen (not fixed, for reference)

- `Group` constructor leaves `m_pingRestriction` uninitialised (garbage 0xA7500000 in party updates); we
  initialise it to `RestrictPingsTo::None` (86570ffa).
- Party member phase flags are written as uint32; the 70205 sniff and SMSG_PHASE_SHIFT_CHANGE use 1 byte
  (31985d26). Not the crash cause, but matches the official layout.
- Client opcode 0x4401B2 (empty payload) arrives twice at login and is unknown to the server.
- Molten Giant Knock Away (11658) and Molten Destroyer Knockdown (11659) should also cut the victim's threat by 30%
  (VMaNGOS EventAI 1165802 / 1165901: `SCRIPT_COMMAND_MODIFY_THREAT` -30%). In
  `sql/custom/world/2026_09_28_15_world_vanilla_smartai.sql` the linked `SMART_ACTION_THREAT_SINGLE_PCT` (14, 0, 30)
  rows use target type 1 (`SMART_TARGET_SELF`), so the creature modifies its threat on itself and nothing happens;
  1.12 behaviour needs target 2 (`SMART_TARGET_VICTIM`). Not changed by us: it makes MC trash easier, chris decides.
- Lava Spawn (12265, Firelord / Ragnaros adds) has no AI rows in Forever. In VMaNGOS it casts Split 19569 every 10 s
  (EventAI 1226502; 1226503 casts Split 19570 and despawns), so the adds multiply until killed; in Forever
  they never split. The instance script's 18-spawn cap (`CLASSIC_MC_MAX_LAVA_SPAWNS`) is already there for it.
- Demon Portal (14081, summoned by Blackwing Warlocks 12459 in BWL through Demon Portal 22372) has no AI rows or
  script in Forever, so the portal stands there and never summons the demons it should for its 35 s.
- Warrior stance changes keep all rage. In 1.12 a stance switch keeps at most 5 rage per Tactical Mastery point
  (0 without the talent). `AuraEffect::HandleAuraModShapeshift` has no rage handling, and the only rage reset
  (`Unit.cpp`, on a power-type change) doesn't apply to stances. Not changed by us; chris decides.
