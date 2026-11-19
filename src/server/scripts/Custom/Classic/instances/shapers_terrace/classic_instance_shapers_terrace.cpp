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
//     The last boss, on the Pillar of Assimilation.
//
// The panels (wow-everlake-world-data 2026_11_19_966): Cinder, Snowtalon, Vitrix and Bolt each appear when a player
// carrying 15 Power Crystals of one colour feeds them into that colour's Archival Panel (the panel offers nothing to a
// player without them), and the Titan Panel on the pillar brings Nanaya once all four are fed (Warcraft Tavern; lfcarry
// has the bosses killed first, Warcraft Tavern only the panels fed, which is what is done here). Which panel is which
// colour is INFERRED (Wowhead places none of them), as is the gossip line. A fed panel stays spent for the instance
// (saved with it), and its boss comes back after a restart until it is killed.
// Nanaya: Energize (1290506-1290509) draws on one of four crystals around her and Energized (1290510-1290513) keeps that
// colour; the client gives each pair the icon of one Qiraji crystal (red, blue, green, yellow). Each colour opens one
// spell: blue Blizzard and yellow Chain Lightning (Warcraft Tavern), red Blast Wave and green Poison Cloud (by their
// schools, INFERRED). Powerful Slam and Sonic Screech stay all fight. She changes colour every 25 s (INFERRED; gametruth
// ties it to each quarter of her health). The crystals are Crystal Triggers (11179, Un'Goro's own) 16 yards around her.

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
#include "GameObject.h"
#include "GameObjectAI.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "StringFormat.h"
#include "TemporarySummon.h"
#include <cmath>
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

// the Archival Panels: 15 crystals of one colour bring one boss (colours INFERRED)
struct CSTPanel
{
    uint32 GoEntry;
    uint32 ItemId;
    uint32 BossEntry;
    uint32 BossId;
    char const* Colour;
};

constexpr CSTPanel CSTPanels[] =
{
    { 650303, 11186, 261974, 5, "Red" },      // Cinder
    { 672255, 11184, 262297, 7, "Blue" },     // Snowtalon
    { 672256, 11185, 272561, 9, "Green" },    // Vitrix
    { 673520, 11188, 262081, 8, "Yellow" },   // Bolt
};

constexpr uint32 CST_CRYSTALS_NEEDED = 15;
constexpr uint32 CST_GO_TITAN_PANEL = 673851;
constexpr uint32 CST_NPC_NANAYA = 261809;
constexpr uint32 CST_BOSS_NANAYA = 10;
constexpr uint32 CST_NPC_CRYSTAL_TRIGGER = 11179;
constexpr uint32 CST_ALL_PANELS = (1u << std::size(CSTPanels)) - 1;
constexpr uint32 CST_TITAN_USED = 1u << 8;
constexpr Position CSTNanayaSpot = { -5854.2f, -1587.5f, 37.14f, 0.608f };

enum CSTData : uint32
{
    CST_DATA_PANELS = 1,        // GetData: the fed panels (bits 0-3) and the Titan Panel (bit 8)
    CST_DATA_FEED_PANEL = 2,    // SetData: panel index fed
    CST_DATA_USE_TITAN = 3,     // SetData: the Titan Panel was used
    CST_DATA_CRYSTAL = 4        // Nanaya's GetGUID: the crystal she draws on
};

// Nanaya's colours, in the order of her crystals: Energize, the aura it leaves, the spell it opens
struct CSTElement
{
    uint32 Energize;
    uint32 Energized;
    uint32 SpellId;
};

constexpr CSTElement CSTElements[] =
{
    { 1290506, 1290510, 1291176 },   // red: Blast Wave
    { 1290507, 1290511, 1291167 },   // blue: Blizzard
    { 1290508, 1290512, 1291274 },   // green: Poison Cloud
    { 1290509, 1290513, 1291380 },   // yellow: Chain Lightning
};

constexpr uint32 CST_EVENT_ENERGIZE = 900;
constexpr Milliseconds CST_ENERGIZE_FIRST = 6s;
constexpr Milliseconds CST_ENERGIZE_EVERY = 25s;
constexpr float CST_CRYSTAL_DISTANCE = 16.0f;

int32 CSTPanelIndex(uint32 goEntry)
{
    for (std::size_t i = 0; i < std::size(CSTPanels); ++i)
        if (CSTPanels[i].GoEntry == goEntry)
            return int32(i);
    return -1;
}

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
        PersistentInstanceScriptValue<uint32> _panels{ *this, "Panels", 0 };
        ObjectGuid _panelGuids[std::size(CSTPanels)];
        ObjectGuid _titanGuid;

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);
            if (go->GetEntry() == CST_GO_TITAN_PANEL)
            {
                _titanGuid = go->GetGUID();
                RefreshTitan(go);
                if ((_panels & CST_TITAN_USED) && GetBossState(CST_BOSS_NANAYA) != DONE && !go->FindNearestCreature(CST_NPC_NANAYA, 100.0f, true))
                    go->SummonCreature(CST_NPC_NANAYA, CSTNanayaSpot, TEMPSUMMON_MANUAL_DESPAWN);
                return;
            }
            int32 index = CSTPanelIndex(go->GetEntry());
            if (index < 0)
                return;
            _panelGuids[index] = go->GetGUID();
            if (!(_panels & (1u << index)))
                return;
            Spend(go);
            CSTPanel const& panel = CSTPanels[index];
            if (GetBossState(panel.BossId) != DONE && !go->FindNearestCreature(panel.BossEntry, 100.0f, true))
                SummonPanelBoss(go, panel);
        }

        uint32 GetData(uint32 type) const override
        {
            return type == CST_DATA_PANELS ? uint32(_panels) : 0;
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == CST_DATA_FEED_PANEL && data < std::size(CSTPanels) && !(_panels & (1u << data)))
            {
                _panels = _panels | (1u << data);
                if (GameObject* go = instance->GetGameObject(_panelGuids[data]))
                {
                    Spend(go);
                    SummonPanelBoss(go, CSTPanels[data]);
                }
                if (GameObject* titan = instance->GetGameObject(_titanGuid))
                    RefreshTitan(titan);
            }
            else if (type == CST_DATA_USE_TITAN && (_panels & CST_ALL_PANELS) == CST_ALL_PANELS && !(_panels & CST_TITAN_USED))
            {
                _panels = _panels | CST_TITAN_USED;
                if (GameObject* titan = instance->GetGameObject(_titanGuid))
                {
                    RefreshTitan(titan);
                    titan->SummonCreature(CST_NPC_NANAYA, CSTNanayaSpot, TEMPSUMMON_MANUAL_DESPAWN);
                }
            }
        }

        static void Spend(GameObject* go)
        {
            go->SetFlag(GO_FLAG_NOT_SELECTABLE);
            go->SetGoState(GO_STATE_ACTIVE);
        }

        // the Titan Panel answers once all four panels are fed, and only once
        void RefreshTitan(GameObject* titan) const
        {
            if ((_panels & CST_ALL_PANELS) == CST_ALL_PANELS && !(_panels & CST_TITAN_USED))
                titan->RemoveFlag(GO_FLAG_NOT_SELECTABLE);
            else
                titan->SetFlag(GO_FLAG_NOT_SELECTABLE);
        }

        // the boss steps out a few yards in front of its panel
        static void SummonPanelBoss(GameObject* go, CSTPanel const& panel)
        {
            Position pos = go->GetPosition();
            go->MovePositionToFirstCollision(pos, 5.0f, 0.0f);
            pos.SetOrientation(go->GetOrientation());
            go->SummonCreature(panel.BossEntry, pos, TEMPSUMMON_MANUAL_DESPAWN);
        }

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
    classic_boss_shapers_terrace(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();
        if (me->GetEntry() != CST_NPC_NANAYA || !_summons.empty())
            return;
        // her four crystals, red, blue, green and yellow, around where she stands
        for (std::size_t i = 0; i < std::size(CSTElements); ++i)
        {
            float angle = me->GetHomePosition().GetOrientation() + float(i) * float(M_PI) / 2.0f;
            Position pos = me->GetHomePosition();
            pos.Relocate(pos.GetPositionX() + CST_CRYSTAL_DISTANCE * std::cos(angle), pos.GetPositionY() + CST_CRYSTAL_DISTANCE * std::sin(angle), pos.GetPositionZ());
            if (TempSummon* crystal = me->SummonCreature(CST_NPC_CRYSTAL_TRIGGER, pos, TEMPSUMMON_MANUAL_DESPAWN))
                _crystals[i] = crystal->GetGUID();
        }
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _summons.DespawnAll();
    }

    ObjectGuid GetGUID(int32 id) const override
    {
        return id == int32(CST_DATA_CRYSTAL) && _element >= 0 ? _crystals[_element] : ObjectGuid::Empty;
    }

    void Reset() override
    {
        _events.Reset();
        _phase = 1;
        _element = -1;
        for (CSTElement const& element : CSTElements)
            me->RemoveAurasDueToSpell(element.Energized);
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
        if (me->GetEntry() == CST_NPC_NANAYA)
            _events.ScheduleEvent(CST_EVENT_ENERGIZE, CST_ENERGIZE_FIRST);

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
            if (ev == CST_EVENT_ENERGIZE)
            {
                Energize();
                _events.Repeat(CST_ENERGIZE_EVERY);
                return;
            }
            if (ev == 0 || ev > std::size(CSTAbilities))
                continue;
            CSTAbility const& ability = CSTAbilities[ev - 1];
            if (ability.Phase && ability.Phase != _phase)
            {
                _events.Repeat(Milliseconds(ability.MinMs));
                continue;
            }
            if (!ColourAllows(ability.SpellId))
            {
                _events.Repeat(2s);     // her colour does not have it yet: look again soon
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
    SummonList _summons;
    ObjectGuid _crystals[std::size(CSTElements)];
    int32 _element = -1;

    // a spell of one of Nanaya's colours waits until she holds that colour
    bool ColourAllows(uint32 spellId) const
    {
        for (CSTElement const& element : CSTElements)
            if (element.SpellId == spellId)
                return me->HasAura(element.Energized);
        return true;
    }

    // draw on another crystal: Energize at it (aimed by spell_shapers_nanaya_energize), then hold its colour
    void Energize()
    {
        int32 next = _element < 0 ? int32(urand(0, 3)) : int32((_element + urand(1, 3)) % 4);
        Creature* crystal = ObjectAccessor::GetCreature(*me, _crystals[next]);
        if (!crystal)
            return;
        _element = next;
        for (CSTElement const& element : CSTElements)
            me->RemoveAurasDueToSpell(element.Energized);
        DoCast(crystal, CSTElements[next].Energize);
        DoCastSelf(CSTElements[next].Energized, true);
    }

    CSTReveal const* FindReveal() const
    {
        for (CSTReveal const& reveal : CSTReveals)
            if (reveal.Boss == me->GetEntry())
                return &reveal;
        return nullptr;
    }

};

// An Archival Panel: a player carrying 15 Power Crystals of its colour may feed them in, which brings its boss.
struct go_shapers_archival_panel : public GameObjectAI
{
    go_shapers_archival_panel(GameObject* go) : GameObjectAI(go), _instance(go->GetInstanceScript()) { }

    bool OnGossipHello(Player* player) override
    {
        int32 index = CSTPanelIndex(me->GetEntry());
        if (!_instance || index < 0 || (_instance->GetData(CST_DATA_PANELS) & (1u << index)))
            return true;
        CSTPanel const& panel = CSTPanels[index];
        if (player->HasItemCount(panel.ItemId, CST_CRYSTALS_NEEDED))
            AddGossipItemFor(player, GossipOptionNpc::None, Trinity::StringFormat("Feed it {} {} Power Crystals.", CST_CRYSTALS_NEEDED, panel.Colour), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, me->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
    {
        uint32 action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
        CloseGossipMenuFor(player);
        int32 index = CSTPanelIndex(me->GetEntry());
        if (action != GOSSIP_ACTION_INFO_DEF + 1 || !_instance || index < 0 || (_instance->GetData(CST_DATA_PANELS) & (1u << index)))
            return true;
        CSTPanel const& panel = CSTPanels[index];
        if (!player->HasItemCount(panel.ItemId, CST_CRYSTALS_NEEDED))
            return true;
        player->DestroyItemCount(panel.ItemId, CST_CRYSTALS_NEEDED, true);
        _instance->SetData(CST_DATA_FEED_PANEL, uint32(index));
        return true;
    }

private:
    InstanceScript* _instance;
};

// The Titan Panel on the Pillar of Assimilation: selectable once the four panels are fed; using it brings Nanaya.
struct go_shapers_titan_panel : public GameObjectAI
{
    go_shapers_titan_panel(GameObject* go) : GameObjectAI(go), _instance(go->GetInstanceScript()) { }

    bool OnGossipHello(Player* /*player*/) override
    {
        if (_instance)
            _instance->SetData(CST_DATA_USE_TITAN, 1);
        return true;
    }

private:
    InstanceScript* _instance;
};

// Energize looks for the nearest Crystal Trigger (its target condition); this points it at the crystal Nanaya chose.
class spell_shapers_nanaya_energize : public SpellScript
{
    void SelectCrystal(WorldObject*& target)
    {
        Creature* caster = GetCaster() ? GetCaster()->ToCreature() : nullptr;
        if (!caster || !caster->AI())
            return;
        if (Creature* crystal = ObjectAccessor::GetCreature(*caster, caster->AI()->GetGUID(CST_DATA_CRYSTAL)))
            target = crystal;
    }

    void Register() override
    {
        OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_shapers_nanaya_energize::SelectCrystal, EFFECT_0, TARGET_UNIT_NEARBY_ENTRY);
    }
};

void AddSC_classic_instance_shapers_terrace()
{
    new classic_instance_shapers_terrace();
    RegisterCreatureAI(classic_boss_shapers_terrace);
    RegisterGameObjectAI(go_shapers_archival_panel);
    RegisterGameObjectAI(go_shapers_titan_panel);
    RegisterSpellScript(spell_shapers_nanaya_energize);
}
