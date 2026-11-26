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

// Classic 1.60 (Forever): Alcaz Prison (map 2994). Encounters from DungeonEncounter.db2: 3403 Overseer Wrex, 3410 Tidemistress Ca'zass, 3418 Katerina the Cleaner, 3415 The Questioner, 3409 Blazeroar.
// The creatures, their spawns and loot are in the world data (wow-everlake-world-data 2026_11_19_960, 962 and 964).
//
// No sniff of this dungeon exists. Each boss casts the spells Wowhead's Forever page lists under its Abilities, all of
// them in the client and cast with the client's own values; whom a spell goes at is read from the client (its targets
// and range: the caster's surroundings, the tank, or someone at random). Timers are INFERRED (melee spells every 6-10 s,
// ranged ones 8-12 s, the ones around the boss 15-20 s, summons 25-30 s), so a sniff of the fights should replace them.
// What the public guides add (Warcraft Tavern, WoW Handbook, Zockify):
//   Overseer Wrex (255391): Battle Shout 9128; Mortal Strike 16856.
//     The guides say pulling him wakes the side cells: their creatures are placed near and join by their own aggro.
//   Tidemistress Ca'zass (255997): Frostbolt Volley 8398; Frost Nova 15532; Blizzard 1271375.
//     Two Strashaz Enchantresses stand with her and join. The guides' Polymorph is the Enchantresses'; her Blizzard leaves a frost zone to step out of.
//   Katerina the Cleaner (257016): Deadly Poison 3583; Grievous Garrote 1271761.
//     Two Alcaz Chaplains stand with her and join. The guides say she steps behind players and backstabs: not scripted (no spell for it on her page).
//   The Questioner (256236): Rend 12054; Drain Life 17620.
//     The guides give him adds; his page lists none, so none come.
//   Blazeroar (255702): Thrash 3391; Flame Breath 9573; Fireball 12466; Enrage 15716; Flamestrike 18399; Fear 1271593; Searing Scales 1271604.
//     Fights as Zarla Ober (her Illusion, a fire mage: Fireball, Flamestrike) until 30% health, then Reveal Form (heals him in full) and the dragon: Flame Breath, Thrash, Fear, Searing Scales, Enrage.
//
// The Perfumed Note (gameobject 630604, a quest giver; client object data and Icy Veins) lies on the ground where Blazeroar
// died (Wowhead comment on the quests: "Note spawns on the ground after killing final boss"). It ends The Secret Prison
// (95262, Alliance) and The Honor of the Kor'kron (95454, Horde) and starts Somber News (95263) and Bad News for Folkar
// (96369). Their second objective, KC Creature 264861 ("Learn what became of Varian Wrynn" / "Read the note on the
// ground"), is credited when the player opens the note; no client spell gives that credit, so the note's script does.
// The instance puts the note back at the same spot whenever Blazeroar is done and the note is missing (a restart, or its
// grid unloaded), at his spawn point when the death spot is not known.

#include "ScriptMgr.h"
#include "Creature.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "PhasingHandler.h"
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
constexpr uint32 CAP_MAP_ID = 2994;
constexpr uint32 CAP_BOSS_BLAZEROAR = 4;
constexpr uint32 CAP_NPC_BLAZEROAR = 255702;
constexpr uint32 CAP_GO_PERFUMED_NOTE = 630604;
constexpr uint32 CAP_NPC_KC_READ_NOTE = 264861;
constexpr uint32 CAP_QUESTS_READ_NOTE[] = { 95262, 95454 };   // The Secret Prison, The Honor of the Kor'kron
// Blazeroar's spawn (world data guid 974001021): where the note goes when the instance does not know his death spot
constexpr float CAP_NOTE_FALLBACK[4] = { -8867.0f, 2967.0f, 5.8f, 3.789f };
constexpr uint32 CAP_NOTE_CHECK_MS = 5000;

enum CAPTarget : uint8
{
    CAP_T_SELF = 0,        // around the boss (the spell picks its own targets)
    CAP_T_VICTIM = 1,      // the tank
    CAP_T_RANDOM = 2,      // someone of the group at random
    CAP_T_NOT_TANK = 3     // someone at random but the tank
};

struct CAPAbility
{
    uint32 Entry;
    uint32 SpellId;
    uint8 Target;
    uint32 FirstMs;
    uint32 MinMs;
    uint32 MaxMs;
    uint8 Phase;        // 0 all fight, 1 before the boss shows its true form, 2 after
};

constexpr CAPAbility CAPAbilities[] =
{
    { 255391, 9128, CAP_T_SELF, 11000, 15000, 20000, 0 },   // Overseer Wrex: Battle Shout (self)
    { 255391, 16856, CAP_T_VICTIM, 6500, 6000, 10000, 0 },   // Overseer Wrex: Mortal Strike (victim)
    { 255997, 8398, CAP_T_SELF, 11000, 15000, 20000, 0 },   // Tidemistress Ca'zass: Frostbolt Volley (self)
    { 255997, 15532, CAP_T_SELF, 12500, 15000, 20000, 0 },   // Tidemistress Ca'zass: Frost Nova (self)
    { 255997, 1271375, CAP_T_RANDOM, 10000, 8000, 12000, 0 },   // Tidemistress Ca'zass: Blizzard (random)
    { 257016, 3583, CAP_T_VICTIM, 5000, 6000, 10000, 0 },   // Katerina the Cleaner: Deadly Poison (victim)
    { 257016, 1271761, CAP_T_VICTIM, 6500, 6000, 10000, 0 },   // Katerina the Cleaner: Grievous Garrote (victim)
    { 256236, 12054, CAP_T_VICTIM, 5000, 6000, 10000, 0 },   // The Questioner: Rend (victim)
    { 256236, 17620, CAP_T_RANDOM, 8500, 8000, 12000, 0 },   // The Questioner: Drain Life (random)
    { 255702, 3391, CAP_T_SELF, 11000, 15000, 20000, 2 },   // Blazeroar: Thrash (self, phase 2)
    { 255702, 9573, CAP_T_SELF, 12500, 15000, 20000, 2 },   // Blazeroar: Flame Breath (self, phase 2)
    { 255702, 12466, CAP_T_RANDOM, 10000, 8000, 12000, 1 },   // Blazeroar: Fireball (random, phase 1)
    { 255702, 15716, CAP_T_SELF, 15500, 15000, 20000, 2 },   // Blazeroar: Enrage (self, phase 2)
    { 255702, 18399, CAP_T_RANDOM, 13000, 8000, 12000, 1 },   // Blazeroar: Flamestrike (random, phase 1)
    { 255702, 1271593, CAP_T_SELF, 18500, 15000, 20000, 2 },   // Blazeroar: Fear (self, phase 2)
    { 255702, 1271604, CAP_T_SELF, 20000, 15000, 20000, 2 },   // Blazeroar: Searing Scales (self, phase 2)
};

// creatures that join a boss when it is engaged (within the range given)
struct CAPEscort
{
    uint32 Boss;
    uint32 Entry;
    float Range;
};

constexpr CAPEscort CAPEscorts[] =
{
    { 255997, 255373, 30.0f },
    { 257016, 255262, 30.0f },
};

// a boss that fights in disguise first: below Pct health it casts Reveal, drops the Illusion aura and, where the realm's
// client data has it, shows its true model
struct CAPReveal
{
    uint32 Boss;
    uint32 IllusionSpell;
    uint32 RevealSpell;
    uint8 Pct;
    uint32 DisplayId;
};

constexpr CAPReveal CAPReveals[] =
{
    { 255702, 1267176, 1275847, 30, 149885 },
};

constexpr ClassicDungeonBossEntry CAPBossEntries[] =
{
    { 0, 255391 },   // Overseer Wrex
    { 1, 255997 },   // Tidemistress Ca'zass
    { 2, 257016 },   // Katerina the Cleaner
    { 3, 256236 },   // The Questioner
    { 4, 255702 },   // Blazeroar
};
}

class classic_instance_alcaz_prison : public InstanceMapScript
{
public:
    classic_instance_alcaz_prison() : InstanceMapScript("classic_instance_alcaz_prison", CAP_MAP_ID) { }

    struct classic_instance_alcaz_prison_InstanceScript : public InstanceScript
    {
        classic_instance_alcaz_prison_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CAP");
            SetBossNumber(5);
            static constexpr DungeonEncounterData encounters[] =
            {
                { 0, {{ 3403 }} },
                { 1, {{ 3410 }} },
                { 2, {{ 3418 }} },
                { 3, {{ 3415 }} },
                { 4, {{ 3409 }} }
            };
            LoadDungeonEncounterData(encounters);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, CAPBossEntries };

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
            if (unit->GetTypeId() == TYPEID_UNIT && unit->GetEntry() == CAP_NPC_BLAZEROAR)
            {
                _notePos.Relocate(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ(), unit->GetOrientation());
                SpawnNote();
            }
        }

        void Update(uint32 diff) override
        {
            _encounterTracker.Update(diff);

            _noteCheck += diff;
            if (_noteCheck < CAP_NOTE_CHECK_MS)
                return;
            _noteCheck = 0;
            if (GetBossState(CAP_BOSS_BLAZEROAR) == DONE && instance->IsGridLoaded(_notePos)
                && (_noteGuid.IsEmpty() || !instance->GetGameObject(_noteGuid)))
                SpawnNote();
        }

    private:
        ObjectGuid _noteGuid;
        Position _notePos{ CAP_NOTE_FALLBACK[0], CAP_NOTE_FALLBACK[1], CAP_NOTE_FALLBACK[2], CAP_NOTE_FALLBACK[3] };
        uint32 _noteCheck = 0;

        // The note belongs to the instance, not to Blazeroar: it stays after his corpse is gone and never despawns on a timer.
        void SpawnNote()
        {
            if (!_noteGuid.IsEmpty())
                if (GameObject* old = instance->GetGameObject(_noteGuid))
                    old->Delete();
            _noteGuid.Clear();

            GameObject* note = GameObject::CreateGameObject(CAP_GO_PERFUMED_NOTE, instance, _notePos,
                QuaternionData::fromEulerAnglesZYX(_notePos.GetOrientation(), 0.0f, 0.0f), InitialPhaseShift(), 255, GO_STATE_READY);
            if (!note)
                return;
            note->SetRespawnTime(0);
            note->SetSpawnedByDefault(false);
            if (!instance->AddToMap(note))
            {
                delete note;
                return;
            }
            _noteGuid = note->GetGUID();
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new classic_instance_alcaz_prison_InstanceScript(map);
    }
};

// Every boss of the dungeon: its row of CAPAbilities on timers, its escorts join it.
struct classic_boss_alcaz_prison : public ScriptedAI
{
    classic_boss_alcaz_prison(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _events.Reset();
        _phase = 1;
        if (CAPReveal const* reveal = FindReveal())
        {
            me->DeMorph();
            if (reveal->IllusionSpell && sSpellMgr->GetSpellInfo(reveal->IllusionSpell, DIFFICULTY_NONE))
                DoCastSelf(reveal->IllusionSpell, true);
        }

    }

    void JustEngagedWith(Unit* who) override
    {
        for (CAPEscort const& escort : CAPEscorts)
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
        for (CAPAbility const& ability : CAPAbilities)
        {
            ++index;
            if (ability.Entry == me->GetEntry())
                _events.ScheduleEvent(index, Milliseconds(ability.FirstMs));
        }

    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellInfo const* /*spellInfo*/) override
    {
        CAPReveal const* reveal = FindReveal();
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
            if (ev == 0 || ev > std::size(CAPAbilities))
                continue;
            CAPAbility const& ability = CAPAbilities[ev - 1];
            if (ability.Phase && ability.Phase != _phase)
            {
                _events.Repeat(Milliseconds(ability.MinMs));
                continue;
            }
            switch (ability.Target)
            {
                case CAP_T_VICTIM:
                    DoCastVictim(ability.SpellId);
                    break;
                case CAP_T_RANDOM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 45.0f, true))
                        DoCast(target, ability.SpellId);
                    break;
                case CAP_T_NOT_TANK:
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

    CAPReveal const* FindReveal() const
    {
        for (CAPReveal const& reveal : CAPReveals)
            if (reveal.Boss == me->GetEntry())
                return &reveal;
        return nullptr;
    }

};

// The Perfumed Note: opening it reads it. Players on 95262 or 95454 who have Blazeroar's credit get the "read the note"
// credit first, so the quest list the note then shows offers the turn-in.
struct classic_go_alcaz_perfumed_note : public GameObjectAI
{
    classic_go_alcaz_perfumed_note(GameObject* go) : GameObjectAI(go) { }

    bool OnGossipHello(Player* player) override
    {
        for (uint32 questId : CAP_QUESTS_READ_NOTE)
            if (player->GetQuestStatus(questId) == QUEST_STATUS_INCOMPLETE)
            {
                player->KilledMonsterCredit(CAP_NPC_KC_READ_NOTE);
                break;
            }
        return false;
    }
};

void AddSC_classic_instance_alcaz_prison()
{
    new classic_instance_alcaz_prison();
    RegisterCreatureAI(classic_boss_alcaz_prison);
    RegisterGameObjectAI(classic_go_alcaz_perfumed_note);
}
