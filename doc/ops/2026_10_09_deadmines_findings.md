# Deadmines playtests 2026-10-09: findings so far (trunk df95bc3cd3ef)

Status: investigation stopped before the PC-side data arrived. Nothing here is a confirmed root cause unless marked CONFIRMED.

## Reports (chris, level 21 party, bots Armastio tank, Tilia, Damona, Minevelah mage)
1. Wipe 1: the Defias Evoker's Flamestrike killed two members (546 damage seen) while the mage stood 1.5 y from it.
2. Wipe 2 (20:10Z, trunk df95bc3c): Karrzz (rogue, 656 HP) was killed by a Defias Evoker's Flamestrike while standing beside the lock, during "pull back" (Armastio: "Pull back: pulling Defias Miner to you"). Chris suspected his own team; the recap names the Evoker.
3. Wipe 3 (20:13Z): bots "running around crazy". No logs reviewed.
4. Earlier: release at a graveyard dropped the player under the map (double repop during the first teleport is the hypothesis; HandleRepopRequest now logs teleporting/map/xyz and returns while teleporting).

## Facts read from the repo
- Defias Evoker (creature 1729): smart AI casts Flamestrike 11829 on its victim (target type 2, combat-move flag 32, repeat 3-17 s), Frost Armor-type buff 12544, Fire Shield 4979. Source: sql/custom/world/2026_09_28_15_world_vanilla_smartai.sql (VMaNGOS spell list 17290).
- creature_classic multipliers for 1729: damage 1.6, health 3, armor 1.55 (2026_10_05_14_world_classic_creature_multipliers.sql, from VMaNGOS 1.12). In TC the creature damage modifier does not scale spell damage, so a 546 hit is not explained by this row.
- The mage bot has no Flamestrike in its classic rotation; no friendly fire exists, so a party member is not the source. CONFIRMED by grep, not by log.
- DeadminesScript (Bot/Dungeon/Scripts/DeadminesScript.cpp) lists Evoker 1729 as high-priority kill and CC target and Flamestrike 11829 as a mandatory interrupt.

## Open questions (need PC read-only data)
- Spell 11829 in the 70291 client data: effects, radius, base points, aura, range. If it is a retail-reworked spell it may be much stronger than vanilla; compare with the VMaNGOS 1.12 values. Query: hotfixes spell_effect/spell_misc/spell_cast_times for 11829, controls 12544 and 4979.
- creature_template_difficulty and creature_template rows for 1729 in the live world DB.
- Why the Evoker was in range: whether pull back dragged a second pack or the Evoker simply casts from max range (Flamestrike range) across the doorway; whether anyone interrupted or killed it first.
- Playerbot.log / Server.log 20:10-20:13Z: [raid_pull], [pull], [move_lock], [release], Flamestrike, Armastio.

## Delivered earlier today on trunk
.learn all mylevel; release-spirit guard; healer callout fix; healer efficiency rules in instances; Power Word: Shield on the tank; mage CC prefers the kill focus (Bot/CcPick.h); instance caster step-out (Bot/CasterStepOut.h, under Playerbot.Behavior.RaidSpacing); Escape Artist rule (Bot/RacialRules.h). Tests: ClassicCcPick, ClassicCasterStepOut, ClassicRacialRules (need a cmake reconfigure; verified only standalone with a Catch2 stand-in).

## Not done
Spell-data check, pull-back range check, bot movement trace, a Deadmines scripted test. No fix exists yet for the Flamestrike deaths beyond the CC/step-out rules above, which did not prevent wipe 2.

## PC data received 2026-10-09 20:13Z (from the live DB and logs)
- Spell 11829 has no hotfix rows (12544 and 4979 neither): its data is the client DB2 only. The bot_death log lines show spell_data eff0 type=2 bp=479.4519 radius=5.
- Creature 1729: Elite, unit_class 8, level 17-18 (creature_classic_level), HealthModifier 3, ManaModifier 0.7264, ArmorModifier 1.55, DamageModifier 1.6, ContentTuningID 0; spells 4979, 11829, 12544; SmartAI: OOC self-buff 12544, in combat 11829 on its victim every 3-17 s, flees at 15% HP.
- All six deaths of the session were this Flamestrike: hits of 477, 491, 480, 94, 446 and 465 against players/bots of about 650 HP. The first was Karrzz at the pull-back return point, 27.3 y from the Evoker.
- Pull back: Armastio pulled a Defias Miner from 21 y, was refused the pull spot twice ("path refused 2x"), pulled from 27 y where it stood, then "unreachable -> back to return point". The Evoker came with the pull and Flamestrike landed on the return point where the owner stood.
- Minevelah stepped out of the Flamestrike area ([raid_hazard]); Tilia's [facing] was skipped while moving; pvecoord kill_focus=12.

## Reading of the data
- About 480 per hit at level 17-18 is 3-4 times vanilla. Whether the 479 base points are a modern-scaled number in the 70291 DB2 (needs the vanilla 1.12 value for this spell from VMaNGOS, and a check that creature DamageModifier 1.6 is not applied to spells here) is the next thing to settle. Not settled.
- Unchecked: Server.log mentions three SQL files (2023_10_17_14, 2025_01_02_10, 2026_08_07_07 world_evoker.sql) applied but missing from the update directory. By name they are probably the Dracthyr Evoker class data, unrelated to the Defias Evoker; not read.
- The pull-back path refusals and the pull from 27 y are a bot-side cause of the Evoker reaching the group; the pull rule does not weigh a nearby caster pack.

## Fix for the Flamestrike damage (branch vanilla-creature-spells, 2026-10-09)
- Vanilla 1.12 Flamestrike 11829 (VMaNGOS spell_template): effect 1 school damage 75 + 1d13 = 76..88, effect 2 burning ground 15 + 1 = 16 per 2 s. The client data has 479.45 for effect 1 (about 5.8 times vanilla). Molten Giant Smash 18944 (809 + 1d181 = 810..990) matches the client data, which is why the earlier flat-base-points rule looked right.
- Creature DamageModifier reaches melee only (StatSystem.cpp:1276); a creature's spell damage takes only the Rate.Creature.SpellDamage.* config (default 1.0). So 479 is the client spell data, not a multiplier.
- Fix: table classic_spell_value (3226 damage / heal / absorb effects of the 1.12 spell_template, generated by tools/classic_spell_values/gen_spell_values.py) loaded by SpellMgr::LoadClassicSpellValues; SpellEffectInfo::CalcBaseValue / CalcValue take the vanilla mean, spread and points per level for a creature no player controls (not players, pets, totems or charmed units; not spell ids from 1,000,000). A row whose effect or aura does not match the client's at that index is ignored. Tests: ClassicSpellValue (pure rules); the SQL needs applying to the world DB.
- Not covered: weapon-damage effects, non-damage auras, spells at or above id 1,000,000, and spells with no vanilla row. Whether other creature spells differ from vanilla in the client data is unknown without a dump of SpellEffect.db2 against the table.
