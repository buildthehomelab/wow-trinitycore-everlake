/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// Classic 1.60 (Forever): The Shaper's Terrace (map 3001). Encounters from DungeonEncounter.db2: 3498 Titanosaur, 3499 Tor'Rel + Izha'Rel, 3500 Thunderhoof, 3501 Venomridge, 3507 Direhorn Matriarch, 3503 Cinder, 3504 King Op, 3597 Snowtalon, 3505 Bolt, 3600 Vitrix, 3502 Nanaya.
// The creatures, their spawns and loot are in the world data (wow-everlake-world-data 2026_11_19_961, 963 and 965).
//
// No sniff of this dungeon exists. Each boss casts the spells Wowhead's Forever page lists under its Abilities, all of
// them in the client and cast with the client's own values; whom a spell goes at is read from the client (its targets
// and range: the caster's surroundings, the tank, or someone at random). Timers are INFERRED (melee spells every 6-10 s,
// ranged ones 8-12 s, the ones around the boss 15-20 s, summons 25-30 s), so a sniff of the fights should replace them.
// What the public guides add (Warcraft Tavern):
//   Titanosaur (253201): Mighty Blow 1294312; Terrifying Roar 1294313.
//     The guides have him patrol the paved central road; here he stands on it.
//   Tor'Rel (261811): Berserk 1287747; Fiery Talons 1287756.
//     Tor'Rel and Izha'Rel are one encounter (Ravasaur Hunters): pulling one brings the other, both must die.
//   Izha'Rel (253218): Chilled 6136; Frost Shock 15089.
//   Thunderhoof (261812): Lightning Cloud 6535; Thunderclap 8078; Shock 12553; Chain Lightning 1310513.
//   Venomridge (261813): Tendon Rip 3604; Poison Bolt Volley 1310365.
//   Direhorn Matriarch (262127): Tail Lash 1287872; Trihorn Charge 1287876; Puncture 1287886.
//     Trihorn Charge rushes a random player.
//   Cinder (261974): Roar 1310251; Radiating Heat 1310267; Conflagration 1310512.
//   King Op (261993): Shock 12553.
//   Snowtalon (262297): Frost Nova 1310354; Howling Blast 1310514.
//   Bolt (262081): Thunderclap 15588; Chain Lightning 1310513.
//   Vitrix (272561): Leech Poison 1312869; Poison Shock 1312870.
//   Nanaya (261809): Powerful Slam 1290463; Sonic Screech 1290464; Blizzard 1291167; Blast Wave 1291176; Poison Cloud 1291274; Chain Lightning 1291380.
//     The last boss. Her Energize spells (1290506-1290513) power her from the four Archival Panels, which are not in Wowhead's pages yet: left out, so she casts her whole set on timers. The panels and crystals that summon her and Cinder, Snowtalon, Bolt and Vitrix are not scripted either: those bosses stand at their panels.

#include "ScriptMgr.h"
#include "Creature.h"
#include "InstanceScript.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "DB2Stores.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "classic_dungeon_encounter_tracker.h"
#include <iterator>
#include <list>

namespace
{
constexpr uint32 CST_MAP_ID = 3001;

enum CSTTarget : uint8
{
    CST_T_SELF = 0,        // around the boss (the spell picks its own targets)
    CST_T_VICTIM = 1,      // the tank
    CST_T_RANDOM = 2,      // someone of the group at random
    CST_T_NOT_TANK = 3     // someone at random but the tank
};

struct CSTAbility
{
    uint32 Entry;
    uint32 SpellId;
    uint8 Target;
    uint32 FirstMs;
    uint32 MinMs;
    uint32 MaxMs;
    uint8 Phase;        // 0 all fight, 1 before the boss shows its true form, 2 after
};

constexpr CSTAbility CSTAbilities[] =
{
    { 253201, 1294312, CST_T_RANDOM, 7000, 8000, 12000, 0 },   // Titanosaur: Mighty Blow (random)
    { 253201, 1294313, CST_T_SELF, 12500, 15000, 20000, 0 },   // Titanosaur: Terrifying Roar (self)
    { 261811, 1287747, CST_T_SELF, 11000, 15000, 20000, 0 },   // Tor'Rel: Berserk (self)
    { 261811, 1287756, CST_T_RANDOM, 8500, 8000, 12000, 0 },   // Tor'Rel: Fiery Talons (random)
    { 253218, 6136, CST_T_RANDOM, 7000, 8000, 12000, 0 },   // Izha'Rel: Chilled (random)
    { 253218, 15089, CST_T_RANDOM, 8500, 8000, 12000, 0 },   // Izha'Rel: Frost Shock (random)
    { 261812, 6535, CST_T_RANDOM, 7000, 8000, 12000, 0 },   // Thunderhoof: Lightning Cloud (random)
    { 261812, 8078, CST_T_SELF, 12500, 15000, 20000, 0 },   // Thunderhoof: Thunderclap (self)
    { 261812, 12553, CST_T_RANDOM, 10000, 8000, 12000, 0 },   // Thunderhoof: Shock (random)
    { 261812, 1310513, CST_T_RANDOM, 11500, 8000, 12000, 0 },   // Thunderhoof: Chain Lightning (random)
    { 261813, 3604, CST_T_VICTIM, 5000, 6000, 10000, 0 },   // Venomridge: Tendon Rip (victim)
    { 261813, 1310365, CST_T_SELF, 12500, 15000, 20000, 0 },   // Venomridge: Poison Bolt Volley (self)
    { 262127, 1287872, CST_T_SELF, 11000, 15000, 20000, 0 },   // Direhorn Matriarch: Tail Lash (self)
    { 262127, 1287876, CST_T_RANDOM, 8500, 8000, 12000, 0 },   // Direhorn Matriarch: Trihorn Charge (random)
    { 262127, 1287886, CST_T_VICTIM, 8000, 6000, 10000, 0 },   // Direhorn Matriarch: Puncture (victim)
    { 261974, 1310251, CST_T_SELF, 11000, 15000, 20000, 0 },   // Cinder: Roar (self)
    { 261974, 1310267, CST_T_SELF, 12500, 15000, 20000, 0 },   // Cinder: Radiating Heat (self)
    { 261974, 1310512, CST_T_RANDOM, 10000, 8000, 12000, 0 },   // Cinder: Conflagration (random)
    { 261993, 12553, CST_T_RANDOM, 7000, 8000, 12000, 0 },   // King Op: Shock (random)
    { 262297, 1310354, CST_T_SELF, 11000, 15000, 20000, 0 },   // Snowtalon: Frost Nova (self)
    { 262297, 1310514, CST_T_RANDOM, 8500, 8000, 12000, 0 },   // Snowtalon: Howling Blast (random)
    { 262081, 15588, CST_T_SELF, 11000, 15000, 20000, 0 },   // Bolt: Thunderclap (self)
    { 262081, 1310513, CST_T_RANDOM, 8500, 8000, 12000, 0 },   // Bolt: Chain Lightning (random)
    { 272561, 1312869, CST_T_RANDOM, 7000, 8000, 12000, 0 },   // Vitrix: Leech Poison (random)
    { 272561, 1312870, CST_T_RANDOM, 8500, 8000, 12000, 0 },   // Vitrix: Poison Shock (random)
    { 261809, 1290463, CST_T_SELF, 11000, 15000, 20000, 0 },   // Nanaya: Powerful Slam (self)
    { 261809, 1290464, CST_T_SELF, 12500, 15000, 20000, 0 },   // Nanaya: Sonic Screech (self)
    { 261809, 1291167, CST_T_RANDOM, 10000, 8000, 12000, 0 },   // Nanaya: Blizzard (random)
    { 261809, 1291176, CST_T_SELF, 15500, 15000, 20000, 0 },   // Nanaya: Blast Wave (self)
    { 261809, 1291274, CST_T_SELF, 17000, 15000, 20000, 0 },   // Nanaya: Poison Cloud (self)
    { 261809, 1291380, CST_T_RANDOM, 14500, 8000, 12000, 0 },   // Nanaya: Chain Lightning (random)
};

// creatures that join a boss when it is engaged (within the range given)
struct CSTEscort
{
    uint32 Boss;
    uint32 Entry;
    float Range;
};

constexpr CSTEscort CSTEscorts[] =
{
    { 261811, 253218, 40.0f },
    { 253218, 261811, 40.0f },
};

// a boss that fights in disguise first: below Pct health it casts Reveal, drops the Illusion aura and, where the realm's
// client data has it, shows its true model
struct CSTReveal
{
    uint32 Boss;
    uint32 IllusionSpell;
    uint32 RevealSpell;
    uint8 Pct;
    uint32 DisplayId;
};

constexpr CSTReveal CSTReveals[] =
{
    { 0, 0, 0, 0, 0 }
};

constexpr ClassicDungeonBossEntry CSTBossEntries[] =
{
    { 0, 253201 },   // Titanosaur
    { 1, 261811 },   // Tor'Rel
    { 1, 253218 },   // Izha'Rel
    { 2, 261812 },   // Thunderhoof
    { 3, 261813 },   // Venomridge
    { 4, 262127 },   // Direhorn Matriarch
    { 5, 261974 },   // Cinder
    { 6, 261993 },   // King Op
    { 7, 262297 },   // Snowtalon
    { 8, 262081 },   // Bolt
    { 9, 272561 },   // Vitrix
    { 10, 261809 },   // Nanaya
};
}

class classic_instance_shapers_terrace : public InstanceMapScript
{
public:
    classic_instance_shapers_terrace() : InstanceMapScript("classic_instance_shapers_terrace", CST_MAP_ID) { }

    struct classic_instance_shapers_terrace_InstanceScript : public InstanceScript
    {
        classic_instance_shapers_terrace_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CST");
            SetBossNumber(11);
            static constexpr DungeonEncounterData encounters[] =
            {
                { 0, {{ 3498 }} },
                { 1, {{ 3499 }} },
                { 2, {{ 3500 }} },
                { 3, {{ 3501 }} },
                { 4, {{ 3507 }} },
                { 5, {{ 3503 }} },
                { 6, {{ 3504 }} },
                { 7, {{ 3597 }} },
                { 8, {{ 3505 }} },
                { 9, {{ 3600 }} },
                { 10, {{ 3502 }} }
            };
            LoadDungeonEncounterData(encounters);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, CSTBossEntries };

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);
            _encounterTracker.OnCreatureCreate(creature);
        }

        void OnCreatureRemove(Creature* creature) override
        {
            InstanceScript::OnCreatureRemove(creature);
            _encounterTracker.OnCreatureRemove(creature);
        }

        void OnUnitDeath(Unit* unit) override
        {
            _encounterTracker.OnUnitDeath(unit);
        }

        void Update(uint32 diff) override
        {
            _encounterTracker.Update(diff);
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new classic_instance_shapers_terrace_InstanceScript(map);
    }
};

// Every boss of the dungeon: its row of CSTAbilities on timers, its escorts join it.
struct classic_boss_shapers_terrace : public ScriptedAI
{
    classic_boss_shapers_terrace(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _events.Reset();
        _phase = 1;
        if (CSTReveal const* reveal = FindReveal())
        {
            me->DeMorph();
            if (reveal->IllusionSpell && sSpellMgr->GetSpellInfo(reveal->IllusionSpell, DIFFICULTY_NONE))
                DoCastSelf(reveal->IllusionSpell, true);
        }

    }

    void JustEngagedWith(Unit* who) override
    {
        for (CSTEscort const& escort : CSTEscorts)
        {
            if (escort.Boss != me->GetEntry())
                continue;
            std::list<Creature*> near;
            me->GetCreatureListWithEntryInGrid(near, escort.Entry, escort.Range);
            for (Creature* c : near)
                if (c->IsAlive() && !c->IsEngaged() && who && c->AI())
                    c->AI()->AttackStart(who);
        }
        uint32 index = 0;
        for (CSTAbility const& ability : CSTAbilities)
        {
            ++index;
            if (ability.Entry == me->GetEntry())
                _events.ScheduleEvent(index, Milliseconds(ability.FirstMs));
        }

    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellInfo const* /*spellInfo*/) override
    {
        CSTReveal const* reveal = FindReveal();
        if (!reveal || _phase != 1 || !me->HealthBelowPctDamaged(reveal->Pct, damage))
            return;
        _phase = 2;
        me->InterruptNonMeleeSpells(false);
        DoCastSelf(reveal->RevealSpell, true);
        if (reveal->IllusionSpell)
            me->RemoveAurasDueToSpell(reveal->IllusionSpell);
        if (reveal->DisplayId && sCreatureDisplayInfoStore.LookupEntry(reveal->DisplayId))
            me->SetDisplayId(reveal->DisplayId);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            if (ev == 0 || ev > std::size(CSTAbilities))
                continue;
            CSTAbility const& ability = CSTAbilities[ev - 1];
            if (ability.Phase && ability.Phase != _phase)
            {
                _events.Repeat(Milliseconds(ability.MinMs));
                continue;
            }
            switch (ability.Target)
            {
                case CST_T_VICTIM:
                    DoCastVictim(ability.SpellId);
                    break;
                case CST_T_RANDOM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 45.0f, true))
                        DoCast(target, ability.SpellId);
                    break;
                case CST_T_NOT_TANK:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 45.0f, true))
                        DoCast(target, ability.SpellId);
                    else
                        DoCastVictim(ability.SpellId);
                    break;
                default:
                    DoCastSelf(ability.SpellId);
                    break;
            }
            _events.Repeat(Milliseconds(urand(ability.MinMs, ability.MaxMs)));
        }
    }

private:
    EventMap _events;
    uint8 _phase = 1;

    CSTReveal const* FindReveal() const
    {
        for (CSTReveal const& reveal : CSTReveals)
            if (reveal.Boss == me->GetEntry())
                return &reveal;
        return nullptr;
    }

};

void AddSC_classic_instance_shapers_terrace()
{
    new classic_instance_shapers_terrace();
    RegisterCreatureAI(classic_boss_shapers_terrace);
}
