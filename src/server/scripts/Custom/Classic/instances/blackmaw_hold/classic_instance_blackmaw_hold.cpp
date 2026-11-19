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

// Classic 1.60 (Forever): Blackmaw Hold (map 2974, levels 55-60). Encounters from DungeonEncounter.db2: 3315 Withermaw,
// 3316 Impaan the Imprisoner, 3327 Elder Shaman Bloodmane, 3322 Bonesnout the Unbroken, 3334 Varrox Bleakhoof,
// 3323 Blackmaw Behemoth, 3336 Unbound Spirit. The creatures, their spawns and loot are in the world data
// (wow-everlake-world-data 2026_11_18_960-962).
//
// No sniff of this dungeon exists. Every spell below is one the client ships, cast with the client's own values (the
// damage ones are a share of the target's health, effect 165); which boss uses which comes from Wowhead's Forever
// pages (each creature's Abilities tab) and what each fight does from the public dungeon guides (Warcraft Tavern, WoW
// Handbook, Zockify). Timers and thresholds are INFERRED, so a sniff of the fights should replace them.
//
//  * Withermaw: Maul on the tank, Intimidating Roar (fear), and Flesh Maggots crawling out of the Writhing Mass.
//  * Bonesnout: each living Legashi Ritualist around him takes a quarter off the damage he takes (Profane Bulwark,
//    -25% each: four make him untouchable); Stomp and Trample.
//  * Impaan: a random Shadowbolt of his nineteen ("Improvised", "Impressive", "Impossible"...) and "Imps!!".
//  * Bloodmane: Chain Lightning, Purge, two Feral Spirits; his Blackmaw Devotees join him.
//  * Unbound Spirit: Profane Protection keeps it untouchable until Elder Bramblesnap's ritual (talk to him): three
//    waves of corrupted spiders, wolves and a bear, then Bramblesnap's Purify lifts the protection.
//  * Blackmaw Behemoth with Clawbert: Clawbert casts Lightning Bolt and Restore (heals the Behemoth to full); the
//    Behemoth roars (Bestial Roar), whirls, and at a quarter of its health eats Clawbert and turns to Thunder Roar.
//  * Varrox Bleakhoof: Shadow Bolt Volley, Fear, and Crimson Wrest: a player is seized and, a few seconds later,
//    Nightmare Detonation bursts around them.

#include "ScriptMgr.h"
#include "Creature.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"
#include "classic_dungeon_encounter_tracker.h"
#include <algorithm>
#include <array>
#include <list>

namespace
{
constexpr uint32 CLASSIC_BMH_MAP_ID = 2974;

enum ClassicBlackmawHoldBosses : uint32
{
    CBMH_ENC_WITHERMAW = 0,
    CBMH_ENC_IMPAAN = 1,
    CBMH_ENC_BLOODMANE = 2,
    CBMH_ENC_BONESNOUT = 3,
    CBMH_ENC_VARROX = 4,
    CBMH_ENC_BEHEMOTH = 5,
    CBMH_ENC_SPIRIT = 6,
    CBMH_ENC_MAX
};

enum ClassicBlackmawHoldCreatures : uint32
{
    NPC_BMH_WITHERMAW = 247195,
    NPC_BMH_BONESNOUT = 247198,
    NPC_BMH_IMPAAN = 247206,
    NPC_BMH_BEHEMOTH = 247207,
    NPC_BMH_BLOODMANE = 247209,
    NPC_BMH_SPIRIT = 247231,
    NPC_BMH_VARROX = 247234,
    NPC_BMH_IMP = 247432,
    NPC_BMH_CLAWBERT = 247996,
    NPC_BMH_FERAL_SPIRIT = 248216,
    NPC_BMH_BRAMBLESNAP = 248765,
    NPC_BMH_ETHEREAL_WOLF = 249061,
    NPC_BMH_ETHEREAL_SPIDER = 249064,
    NPC_BMH_ETHEREAL_BEAR = 249065,
    NPC_BMH_RITUALIST = 258668,
    NPC_BMH_FLESH_MAGGOT = 268878,
    NPC_BMH_DEVOTEE = 277474
};

enum ClassicBlackmawHoldSpells : uint32
{
    // all present in the client
    SPELL_BMH_INTIMIDATING_ROAR = 1242884,  // fear
    SPELL_BMH_MAUL = 1242907,
    SPELL_BMH_TRAMPLE = 5568,
    SPELL_BMH_STOMP = 1244416,              // damage + stun around the caster
    SPELL_BMH_PROFANE_BULWARK = 1277406,    // -25% damage taken (the Ritualists' shield)
    SPELL_BMH_CHAIN_LIGHTNING = 1245324,
    SPELL_BMH_PURGE = 1245883,
    SPELL_BMH_PROFANE_PROTECTION = 1247237, // immune to all schools (the Unbound Spirit before the ritual)
    SPELL_BMH_PURIFY = 1247252,             // Bramblesnap: removes Profane Protection
    SPELL_BMH_FIRE_NOVA = 1248008,
    SPELL_BMH_FIREBALL = 1248131,
    SPELL_BMH_BESTIAL_ROAR = 1245119,
    SPELL_BMH_THUNDER_ROAR = 1245154,       // stun
    SPELL_BMH_WHIRLWIND = 1244484,
    SPELL_BMH_RESTORE = 1244951,            // Clawbert: heals 100%
    SPELL_BMH_CLAWBERT_BOLT = 1244981,
    SPELL_BMH_SHADOW_BOLT_VOLLEY = 9081,
    SPELL_BMH_FEAR = 1247087,
    SPELL_BMH_CRIMSON_WREST = 1246456,      // fear + slow on the one seized
    SPELL_BMH_NIGHTMARE_DETONATION = 1246364
};

// Impaan's nineteen Shadowbolts: one at random each time
constexpr std::array<uint32, 19> BmhImpaanBolts =
{
    1243064, 1243067, 1243068, 1243070, 1243071, 1243072, 1243073, 1243074, 1243076, 1243077,
    1243079, 1243080, 1243081, 1243082, 1243083, 1243084, 1243088, 1243089, 1243090
};

constexpr ClassicDungeonBossEntry ClassicBlackmawHoldBossEntries[] =
{
    { CBMH_ENC_WITHERMAW, NPC_BMH_WITHERMAW },
    { CBMH_ENC_IMPAAN, NPC_BMH_IMPAAN },
    { CBMH_ENC_BLOODMANE, NPC_BMH_BLOODMANE },
    { CBMH_ENC_BONESNOUT, NPC_BMH_BONESNOUT },
    { CBMH_ENC_VARROX, NPC_BMH_VARROX },
    { CBMH_ENC_BEHEMOTH, NPC_BMH_BEHEMOTH },
    { CBMH_ENC_BEHEMOTH, NPC_BMH_CLAWBERT, CLASSIC_DUNGEON_BOSS_ENGAGE_ONLY },
    { CBMH_ENC_SPIRIT, NPC_BMH_SPIRIT }
};

// the ones standing near a boss join its fight
void BmhCallNear(Creature* me, uint32 entry, float range, Unit* who)
{
    std::list<Creature*> near;
    me->GetCreatureListWithEntryInGrid(near, entry, range);
    for (Creature* c : near)
        if (c->IsAlive() && !c->IsEngaged() && who)
            c->AI()->AttackStart(who);
}

// a creature summoned for a fight goes at someone of the group
void BmhAddJoins(Creature* me, Creature* add)
{
    if (!add || !me->GetAI())
        return;
    if (Unit* target = me->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
        add->AI()->AttackStart(target);
}

uint32 BmhAlive(Creature* me, uint32 entry, float range)
{
    std::list<Creature*> near;
    me->GetCreatureListWithEntryInGrid(near, entry, range);
    uint32 n = 0;
    for (Creature* c : near)
        if (c->IsAlive())
            ++n;
    return n;
}
}

class classic_instance_blackmaw_hold : public InstanceMapScript
{
public:
    classic_instance_blackmaw_hold() : InstanceMapScript("classic_instance_blackmaw_hold", CLASSIC_BMH_MAP_ID) { }

    struct classic_instance_blackmaw_hold_InstanceScript : public InstanceScript
    {
        classic_instance_blackmaw_hold_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CBMH");
            SetBossNumber(CBMH_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CBMH_ENC_WITHERMAW, {{ 3315 }} },
                { CBMH_ENC_IMPAAN, {{ 3316 }} },
                { CBMH_ENC_BLOODMANE, {{ 3327 }} },
                { CBMH_ENC_BONESNOUT, {{ 3322 }} },
                { CBMH_ENC_VARROX, {{ 3334 }} },
                { CBMH_ENC_BEHEMOTH, {{ 3323 }} },
                { CBMH_ENC_SPIRIT, {{ 3336 }} }
            };
            LoadDungeonEncounterData(encounters);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicBlackmawHoldBossEntries };

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
        return new classic_instance_blackmaw_hold_InstanceScript(map);
    }
};

// ---------------------------------------------------------------------------------------------------------------------
// Withermaw (the Festering Grotto): Maul on the tank, Intimidating Roar, and Flesh Maggots out of the Writhing Mass
// that the tank has to pick up.
struct classic_boss_bmh_withermaw : public ScriptedAI
{
    classic_boss_bmh_withermaw(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    enum : uint32 { EV_MAUL = 1, EV_ROAR, EV_MAGGOTS };

    void Reset() override
    {
        _events.Reset();
        _summons.DespawnAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_MAUL, 5s);              // INFERRED timers
        _events.ScheduleEvent(EV_MAGGOTS, 8s);
        _events.ScheduleEvent(EV_ROAR, 18s);
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
        BmhAddJoins(me, summon);
    }

    void JustDied(Unit* /*killer*/) override { _summons.DespawnAll(); }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_MAUL: DoCastVictim(SPELL_BMH_MAUL); _events.Repeat(8s, 11s); break;
                case EV_ROAR: DoCastSelf(SPELL_BMH_INTIMIDATING_ROAR); _events.Repeat(22s, 28s); break;
                case EV_MAGGOTS:
                    for (uint8 i = 0; i < 2; ++i)
                        me->SummonCreature(NPC_BMH_FLESH_MAGGOT, me->GetRandomNearPosition(6.0f), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10s);
                    _events.Repeat(12s, 15s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    SummonList _summons;
};

// Bonesnout the Unbroken (Bonesnout's Thicket): every living Legashi Ritualist near him takes 25% off the damage he
// takes, so all four make him untouchable (the guides: kill them first). Stomp and Trample.
struct classic_boss_bmh_bonesnout : public ScriptedAI
{
    classic_boss_bmh_bonesnout(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_STOMP = 1, EV_TRAMPLE, EV_BULWARK };
    static constexpr float RitualistRange = 50.0f;

    void Reset() override
    {
        _events.Reset();
        _ritualists = BmhAlive(me, NPC_BMH_RITUALIST, RitualistRange);
        UpdateBulwark();
    }

    void JustEngagedWith(Unit* who) override
    {
        BmhCallNear(me, NPC_BMH_RITUALIST, RitualistRange, who);
        _events.ScheduleEvent(EV_BULWARK, 1s);
        _events.ScheduleEvent(EV_TRAMPLE, 7s);           // INFERRED timers
        _events.ScheduleEvent(EV_STOMP, 14s);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellInfo const* /*spellInfo*/) override
    {
        uint32 const shield = std::min<uint32>(_ritualists, 4);
        damage = damage * (4 - shield) / 4;
    }

    void UpdateBulwark()
    {
        if (_ritualists && !me->HasAura(SPELL_BMH_PROFANE_BULWARK))
            DoCastSelf(SPELL_BMH_PROFANE_BULWARK, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
        else if (!_ritualists)
            me->RemoveAurasDueToSpell(SPELL_BMH_PROFANE_BULWARK);
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
            switch (ev)
            {
                case EV_BULWARK:
                    _ritualists = BmhAlive(me, NPC_BMH_RITUALIST, RitualistRange);
                    UpdateBulwark();
                    _events.Repeat(1s);
                    break;
                case EV_TRAMPLE: DoCastSelf(SPELL_BMH_TRAMPLE); _events.Repeat(9s, 12s); break;
                case EV_STOMP: DoCastSelf(SPELL_BMH_STOMP); _events.Repeat(16s, 20s); break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    uint32 _ritualists = 0;
};

// Impaan the Imprisoner (the Defiled Peak): one of his nineteen Shadowbolts at someone, and now and then "Imps!!".
struct classic_boss_bmh_impaan : public ScriptedAI
{
    classic_boss_bmh_impaan(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    enum : uint32 { EV_BOLT = 1, EV_IMPS };

    void Reset() override
    {
        _events.Reset();
        _summons.DespawnAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_BOLT, 3s);              // INFERRED timers
        _events.ScheduleEvent(EV_IMPS, 15s);
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
        BmhAddJoins(me, summon);
    }

    void JustDied(Unit* /*killer*/) override { _summons.DespawnAll(); }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_BOLT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        DoCast(target, BmhImpaanBolts[urand(0, uint32(BmhImpaanBolts.size() - 1))]);
                    _events.Repeat(4s, 6s);
                    break;
                case EV_IMPS:
                    me->Yell("Imps!!", LANG_UNIVERSAL);
                    for (uint8 i = 0; i < 3; ++i)
                        me->SummonCreature(NPC_BMH_IMP, me->GetRandomNearPosition(8.0f), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10s);
                    _events.Repeat(25s, 30s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    SummonList _summons;
};

// Elder Shaman Bloodmane (the wide low chamber): Chain Lightning (interruptible), Purge, two Feral Spirits; the
// Blackmaw Devotees around him join in.
struct classic_boss_bmh_bloodmane : public ScriptedAI
{
    classic_boss_bmh_bloodmane(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    enum : uint32 { EV_CHAIN = 1, EV_PURGE, EV_SPIRITS };

    void Reset() override
    {
        _events.Reset();
        _summons.DespawnAll();
    }

    void JustEngagedWith(Unit* who) override
    {
        BmhCallNear(me, NPC_BMH_DEVOTEE, 30.0f, who);
        _events.ScheduleEvent(EV_SPIRITS, 4s);           // INFERRED timers
        _events.ScheduleEvent(EV_CHAIN, 8s);
        _events.ScheduleEvent(EV_PURGE, 15s);
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
        BmhAddJoins(me, summon);
    }

    void JustDied(Unit* /*killer*/) override { _summons.DespawnAll(); }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_CHAIN:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        DoCast(target, SPELL_BMH_CHAIN_LIGHTNING);
                    _events.Repeat(9s, 12s);
                    break;
                case EV_PURGE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true))
                        DoCast(target, SPELL_BMH_PURGE);
                    _events.Repeat(14s, 18s);
                    break;
                case EV_SPIRITS:
                    for (uint8 i = 0; i < 2; ++i)
                        me->SummonCreature(NPC_BMH_FERAL_SPIRIT, me->GetRandomNearPosition(5.0f), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10s);
                    _events.Repeat(30s, 35s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    SummonList _summons;
};

// Unbound Spirit (the clearing): untouchable (Profane Protection) and still until Elder Bramblesnap's ritual has run:
// three waves of corrupted spiders, wolves and a bear, then Bramblesnap's Purify lifts the protection. Fire Nova and
// Fireball once it fights.
struct classic_boss_bmh_unbound_spirit : public ScriptedAI
{
    classic_boss_bmh_unbound_spirit(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    enum : uint32 { EV_WAVE = 1, EV_CHECK, EV_NOVA, EV_FIREBALL };
    enum : int32 { ACTION_START_RITUAL = 1 };

    void Reset() override
    {
        _events.Reset();
        _summons.DespawnAll();
        _wave = 0;
        _ritual = false;
        Protect(true);
    }

    void Protect(bool on)
    {
        if (on)
            DoCastSelf(SPELL_BMH_PROFANE_PROTECTION, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
        else
            me->RemoveAurasDueToSpell(SPELL_BMH_PROFANE_PROTECTION);
        me->SetImmuneToPC(on);
        me->SetReactState(on ? REACT_PASSIVE : REACT_AGGRESSIVE);
    }

    void DoAction(int32 action) override
    {
        if (action != ACTION_START_RITUAL || _ritual || !me->IsAlive())
            return;
        _ritual = true;
        _wave = 0;
        _events.ScheduleEvent(EV_WAVE, 3s);
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
        if (Player* player = me->SelectNearestPlayer(60.0f))
            summon->AI()->AttackStart(player);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_FIREBALL, 3s);          // INFERRED timers
        _events.ScheduleEvent(EV_NOVA, 10s);
    }

    void JustDied(Unit* /*killer*/) override { _summons.DespawnAll(); }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        // the ritual runs before the fight: waves until all three are down, then the protection goes
        while (_ritual && me->IsImmuneToPC())
        {
            uint32 ev = _events.ExecuteEvent();
            if (!ev)
                return;
            if (ev == EV_WAVE)
            {
                ++_wave;
                uint32 const entry = _wave == 1 ? NPC_BMH_ETHEREAL_SPIDER : _wave == 2 ? NPC_BMH_ETHEREAL_WOLF : NPC_BMH_ETHEREAL_BEAR;
                uint8 const count = _wave == 3 ? 1 : 3;
                for (uint8 i = 0; i < count; ++i)
                    me->SummonCreature(entry, me->GetRandomNearPosition(12.0f), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10s);
                _events.ScheduleEvent(EV_CHECK, 2s);
            }
            else if (ev == EV_CHECK)
            {
                bool alive = false;
                for (ObjectGuid const& guid : _summons)
                    if (Creature* add = ObjectAccessor::GetCreature(*me, guid))
                        if (add->IsAlive())
                            alive = true;
                if (alive)
                    _events.ScheduleEvent(EV_CHECK, 2s);
                else if (_wave < 3)
                    _events.ScheduleEvent(EV_WAVE, 4s);
                else
                {
                    if (Creature* elder = me->FindNearestCreature(NPC_BMH_BRAMBLESNAP, 60.0f))
                        elder->CastSpell(me, SPELL_BMH_PURIFY, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                    Protect(false);
                    if (Player* player = me->SelectNearestPlayer(60.0f))
                        AttackStart(player);
                }
            }
        }

        if (!UpdateVictim())
            return;
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_FIREBALL:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        DoCast(target, SPELL_BMH_FIREBALL);
                    _events.Repeat(5s, 7s);
                    break;
                case EV_NOVA: DoCastSelf(SPELL_BMH_FIRE_NOVA); _events.Repeat(14s, 18s); break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    SummonList _summons;
    uint8 _wave = 0;
    bool _ritual = false;
};

// Elder Bramblesnap (friendly, by the Unbound Spirit): talking to him starts the ritual.
struct classic_npc_bmh_bramblesnap : public ScriptedAI
{
    classic_npc_bmh_bramblesnap(Creature* creature) : ScriptedAI(creature) { }

    bool OnGossipHello(Player* player) override
    {
        CloseGossipMenuFor(player);
        if (Creature* spirit = me->FindNearestCreature(NPC_BMH_SPIRIT, 60.0f))
            if (spirit->AI())
                spirit->AI()->DoAction(classic_boss_bmh_unbound_spirit::ACTION_START_RITUAL);
        return true;
    }
};

// Clawbert (beside the Behemoth): Lightning Bolt, and Restore on the Behemoth (back to full health) unless stopped.
struct classic_npc_bmh_clawbert : public ScriptedAI
{
    classic_npc_bmh_clawbert(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_BOLT = 1, EV_RESTORE };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* who) override
    {
        if (Creature* behemoth = me->FindNearestCreature(NPC_BMH_BEHEMOTH, 40.0f))
            if (!behemoth->IsEngaged())
                behemoth->AI()->AttackStart(who);
        _events.ScheduleEvent(EV_BOLT, 2s);              // INFERRED timers
        _events.ScheduleEvent(EV_RESTORE, 20s);
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
            switch (ev)
            {
                case EV_BOLT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        DoCast(target, SPELL_BMH_CLAWBERT_BOLT);
                    _events.Repeat(4s, 6s);
                    break;
                case EV_RESTORE:
                    if (Creature* behemoth = me->FindNearestCreature(NPC_BMH_BEHEMOTH, 40.0f))
                        if (behemoth->IsAlive() && behemoth->HealthBelowPct(80))
                            DoCast(behemoth, SPELL_BMH_RESTORE);
                    _events.Repeat(25s, 30s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Blackmaw Behemoth (the room past the ramp): Bestial Roar and Whirlwind; at a quarter of its health it eats Clawbert
// (if he is still alive) and from then on Thunder Roar.
struct classic_boss_bmh_behemoth : public ScriptedAI
{
    classic_boss_bmh_behemoth(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_ROAR = 1, EV_WHIRL, EV_THUNDER };

    void Reset() override
    {
        _events.Reset();
        _ate = false;
    }

    void JustEngagedWith(Unit* who) override
    {
        BmhCallNear(me, NPC_BMH_CLAWBERT, 40.0f, who);
        _events.ScheduleEvent(EV_ROAR, 10s);             // INFERRED timers
        _events.ScheduleEvent(EV_WHIRL, 16s);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellInfo const* /*spellInfo*/) override
    {
        if (_ate || !me->HealthBelowPctDamaged(25, damage))
            return;
        _ate = true;
        if (Creature* clawbert = me->FindNearestCreature(NPC_BMH_CLAWBERT, 60.0f))
            if (clawbert->IsAlive())
                clawbert->KillSelf();
        _events.CancelEvent(EV_WHIRL);
        _events.ScheduleEvent(EV_THUNDER, 2s);
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
            switch (ev)
            {
                case EV_ROAR: DoCastSelf(SPELL_BMH_BESTIAL_ROAR); _events.Repeat(18s, 22s); break;
                case EV_WHIRL: DoCastSelf(SPELL_BMH_WHIRLWIND); _events.Repeat(20s, 25s); break;
                case EV_THUNDER: DoCastSelf(SPELL_BMH_THUNDER_ROAR); _events.Repeat(14s, 18s); break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    bool _ate = false;
};

// Varrox Bleakhoof (the cave under the pool, the last boss): Shadow Bolt Volley, Fear, and Crimson Wrest: someone is
// seized, and four seconds later Nightmare Detonation bursts where they stand (the tank should move him off it).
struct classic_boss_bmh_varrox : public ScriptedAI
{
    classic_boss_bmh_varrox(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_VOLLEY = 1, EV_FEAR, EV_WREST, EV_DETONATE };

    void Reset() override
    {
        _events.Reset();
        _wrested.Clear();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_VOLLEY, 6s);            // INFERRED timers
        _events.ScheduleEvent(EV_WREST, 12s);
        _events.ScheduleEvent(EV_FEAR, 20s);
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
            switch (ev)
            {
                case EV_VOLLEY: DoCastSelf(SPELL_BMH_SHADOW_BOLT_VOLLEY); _events.Repeat(10s, 13s); break;
                case EV_FEAR:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 20.0f, true))
                        DoCast(target, SPELL_BMH_FEAR);
                    _events.Repeat(22s, 28s);
                    break;
                case EV_WREST:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 40.0f, true))
                    {
                        DoCast(target, SPELL_BMH_CRIMSON_WREST, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                        _wrested = target->GetGUID();
                        _events.ScheduleEvent(EV_DETONATE, 4s);
                    }
                    _events.Repeat(18s, 22s);
                    break;
                case EV_DETONATE:
                    if (Unit* target = ObjectAccessor::GetUnit(*me, _wrested))
                        if (target->IsAlive())
                            me->CastSpell(target, SPELL_BMH_NIGHTMARE_DETONATION, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                    _wrested.Clear();
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    ObjectGuid _wrested;
};

void AddSC_classic_instance_blackmaw_hold()
{
    new classic_instance_blackmaw_hold();
    RegisterCreatureAI(classic_boss_bmh_withermaw);
    RegisterCreatureAI(classic_boss_bmh_bonesnout);
    RegisterCreatureAI(classic_boss_bmh_impaan);
    RegisterCreatureAI(classic_boss_bmh_bloodmane);
    RegisterCreatureAI(classic_boss_bmh_unbound_spirit);
    RegisterCreatureAI(classic_npc_bmh_bramblesnap);
    RegisterCreatureAI(classic_npc_bmh_clawbert);
    RegisterCreatureAI(classic_boss_bmh_behemoth);
    RegisterCreatureAI(classic_boss_bmh_varrox);
}
