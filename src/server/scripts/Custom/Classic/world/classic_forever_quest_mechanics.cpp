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

// Classic 1.60 (WoW Forever): nine new quests whose objective is a kill credit nothing on the realm gave. Their credit
// creatures are invisible markers live gives from its own scripts; no sniff, Wowhead page, QuestieDB entry or Icy Veins
// record says what triggers them. Each mechanic here follows the quest's own text and, where the quest hands out an
// item, that item's client spell (a dummy, a send-event, an aura on a nearby creature). Spawns and spell rows:
// sql/custom/world/2026_11_28_00_world_forever_quest_mechanics.sql. INFERRED throughout: a sniff should replace it.
//
//   92015 Area Denial Skunks (Johun "Punchy" Dillas, Mount Hyjal): "gently expel" 6 skunks. Talking to a skunk shoos it
//         off: it runs away from the player and is gone for two minutes. Credit 249845.
//   92328 Siegecraft (Kaylaena Springwhisper): "give those gears on both sides a strong turn, and connect the battery
//         cables". A Glaive Thrower stands beside her; its two gossip lines give the gear (267917) and cable (251340)
//         credits.
//   93567 Ends Meet (Veteran of the Third War 265375): Battle Memories (274795) sends event 104098; used near the
//         veteran, it gives "Veteran's story told" (255777). The broken cannon of the text is not on the realm.
//   93747 Violence Into Verdure (Ketharas): Toss Enchanted Seeds (1287099, a dummy around the caster) near one of the
//         three wrecks by the Loose Cog gives that machine's credit: ballista 262036, flying machine 266886, catapult
//         266887.
//   95602 Sickening Lights (Clubtoe, Riverglades): the Twilight Ritual Circles (262006, kill credit 272603 in their
//         template) stand among the Twilight Ritualists; they do not fight back.
//   95925 Mapping the Way Forward (Curator Thorius, The Shaper's Terrace): the Explorers' League Drawing Kit
//         (1289422) used within 30 yards of a landmark draws it. The Pillar of Assimilation is the Titan Panel (Nanaya's
//         pillar), the Achromatic Crystal the Archival Panel beside the Drained Crystal Fragment; the Western Gates, the
//         Regrowth Vestibule and the Unearthed Stone Watcher are the other three Archival Panels (westmost, the green
//         one, the high one).
//   96303 Memory Mist (Thisalee Crow): Memory of the Mist (1292804) puts its aura on a nearby Wisp (273458; a condition
//         picks them); the wisp is released (credit 264715) and drifts away. Nine wisps stand by the Ashen Soil.
//   97010 Blind Vengeance (Maerion Thaelemaches): an Explosive Runeshard (1298707) that hits a Doomguard Xarkul (267439)
//         gives "Explosive Runeshards detonated" (267462).
//   98252 A Void Path (Va'xug Firefure, Ashenvale): accepting the quest (or talking to Va'xug while on it, with no eye
//         around) brings an Eye of Kilrogg (271181) that follows the player; at the road (the Wandering Protector's
//         patrol, 165 yards west) it gives "Eye of Kilrogg guided to the road" (271182) and waits there for the
//         turn-in (the quest ends at the eye).

#include "ScriptMgr.h"
#include "Creature.h"
#include "CreatureAIImpl.h"
#include "GameObject.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "TemporarySummon.h"

namespace
{
bool OnQuest(Player const* player, uint32 questId)
{
    return player && player->GetQuestStatus(questId) == QUEST_STATUS_INCOMPLETE;
}
}

/*######
## 92015 Area Denial Skunks: Skunk 249476
######*/

enum AreaDenialSkunks
{
    QUEST_AREA_DENIAL_SKUNKS    = 92015,
    NPC_SKUNK_REPELLED_CREDIT   = 249845
};

struct classic_npc_forever_area_denial_skunk : public ScriptedAI
{
    classic_npc_forever_area_denial_skunk(Creature* creature) : ScriptedAI(creature), _shooed(false) { }

    void JustAppeared() override
    {
        _shooed = false;
    }

    bool OnGossipHello(Player* player) override
    {
        CloseGossipMenuFor(player);
        if (_shooed || !OnQuest(player, QUEST_AREA_DENIAL_SKUNKS))
            return true;

        _shooed = true;
        player->KilledMonsterCredit(NPC_SKUNK_REPELLED_CREDIT, me->GetGUID());

        // away from the player, out of the camp
        float angle = player->GetAbsoluteAngle(me);
        Position away = me->GetPosition();
        me->MovePosition(away, 20.0f, angle - me->GetOrientation());
        me->SetWalk(false);
        me->GetMotionMaster()->Clear();
        me->GetMotionMaster()->MovePoint(1, away);
        me->DespawnOrUnsummon(4s, 120s);
        return true;
    }

private:
    bool _shooed;
};

/*######
## 92328 Siegecraft: Glaive Thrower 35419 beside Kaylaena Springwhisper
######*/

enum Siegecraft
{
    QUEST_SIEGECRAFT            = 92328,
    NPC_BATTERY_CABLES_CREDIT   = 251340,
    NPC_GEARS_ADJUSTED_CREDIT   = 267917,

    ACTION_TURN_GEARS           = GOSSIP_ACTION_INFO_DEF + 1,
    ACTION_CONNECT_CABLES       = GOSSIP_ACTION_INFO_DEF + 2
};

struct classic_npc_forever_siegecraft_glaive_thrower : public ScriptedAI
{
    classic_npc_forever_siegecraft_glaive_thrower(Creature* creature) : ScriptedAI(creature) { }

    void JustAppeared() override
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetImmuneToAll(true);
    }

    void UpdateAI(uint32 /*diff*/) override { }

    static bool Done(Player* player, uint32 credit)
    {
        Quest const* quest = sObjectMgr->GetQuestTemplate(QUEST_SIEGECRAFT);
        if (!quest)
            return true;
        for (QuestObjective const& objective : quest->GetObjectives())
            if (objective.Type == QUEST_OBJECTIVE_MONSTER && uint32(objective.ObjectID) == credit)
                return player->GetQuestObjectiveData(objective) >= objective.Amount;
        return true;
    }

    bool OnGossipHello(Player* player) override
    {
        InitGossipMenuFor(player, 0);
        if (OnQuest(player, QUEST_SIEGECRAFT))
        {
            if (!Done(player, NPC_GEARS_ADJUSTED_CREDIT))
                AddGossipItemFor(player, GossipOptionNpc::None, "Give the gears on both sides a strong turn.", GOSSIP_SENDER_MAIN, ACTION_TURN_GEARS);
            if (!Done(player, NPC_BATTERY_CABLES_CREDIT))
                AddGossipItemFor(player, GossipOptionNpc::None, "Connect the battery cables to the positive and negative terminals.", GOSSIP_SENDER_MAIN, ACTION_CONNECT_CABLES);
        }
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, me->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
    {
        uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
        CloseGossipMenuFor(player);
        if (!OnQuest(player, QUEST_SIEGECRAFT))
            return true;

        if (action == ACTION_TURN_GEARS)
            player->KilledMonsterCredit(NPC_GEARS_ADJUSTED_CREDIT);
        else if (action == ACTION_CONNECT_CABLES)
            player->KilledMonsterCredit(NPC_BATTERY_CABLES_CREDIT);
        me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
        return true;
    }
};

/*######
## 93567 Ends Meet: Battle Memories 274795 (spell 1295298 sends event 104098)
######*/

enum EndsMeet
{
    QUEST_ENDS_MEET             = 93567,
    NPC_VETERAN_ENDS_MEET       = 265375,
    NPC_VETERANS_STORY_CREDIT   = 255777
};

class classic_event_forever_battle_memories : public EventScript
{
public:
    classic_event_forever_battle_memories() : EventScript("classic_event_forever_battle_memories") { }

    void OnTrigger(WorldObject* object, WorldObject* invoker, uint32 /*eventId*/) override
    {
        Player* player = invoker ? invoker->ToPlayer() : nullptr;
        if (!player && object)
            player = object->ToPlayer();
        if (!OnQuest(player, QUEST_ENDS_MEET))
            return;

        if (Creature* veteran = player->FindNearestCreature(NPC_VETERAN_ENDS_MEET, 50.0f))
            player->KilledMonsterCredit(NPC_VETERANS_STORY_CREDIT, veteran->GetGUID());
    }
};

/*######
## 93747 Violence Into Verdure: Toss Enchanted Seeds 1287099
######*/

struct ForeverVerdureWreck
{
    uint32 GameObjectEntry;
    uint32 Credit;
};

// the wrecks by the Loose Cog (sql/custom/world/2026_11_28_00): ballista, flying machine, catapult
constexpr ForeverVerdureWreck ForeverVerdureWrecks[] =
{
    { 188673, 262036 },     // New Hearthglen Ballista's model: "Ruined Ballista reclaimed"
    { 188019, 266886 },     // Crashed Flying Machine: "Ruined Flying Machine reclaimed"
    { 180744, 266887 },     // Catapult: "Ruined Catapult reclaimed"
};

constexpr uint32 QUEST_VIOLENCE_INTO_VERDURE = 93747;

class classic_spell_forever_toss_enchanted_seeds : public SpellScript
{
    void HandleAfterCast()
    {
        Player* player = GetCaster()->ToPlayer();
        if (!OnQuest(player, QUEST_VIOLENCE_INTO_VERDURE))
            return;

        for (ForeverVerdureWreck const& wreck : ForeverVerdureWrecks)
            if (GameObject* go = player->FindNearestGameObject(wreck.GameObjectEntry, 15.0f))
                player->KilledMonsterCredit(wreck.Credit, go->GetGUID());
    }

    void Register() override
    {
        AfterCast += SpellCastFn(classic_spell_forever_toss_enchanted_seeds::HandleAfterCast);
    }
};

/*######
## 95602 Sickening Lights: Twilight Ritual Circle 262006
######*/

struct classic_npc_forever_twilight_ritual_circle : public ScriptedAI
{
    classic_npc_forever_twilight_ritual_circle(Creature* creature) : ScriptedAI(creature) { }

    void JustAppeared() override
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetControlled(true, UNIT_STATE_ROOT);
    }

    void UpdateAI(uint32 /*diff*/) override { }
};

/*######
## 95925 Mapping the Way Forward: Explorers' League Drawing Kit 1289422
######*/

struct ForeverShapersLandmark
{
    uint32 GameObjectEntry;
    uint32 Credit;
};

constexpr ForeverShapersLandmark ForeverShapersLandmarks[] =
{
    { 673851, 263458 },     // Titan Panel, on Nanaya's pillar: "Pillar of Assimilation"
    { 673520, 263277 },     // Archival Panel beside the Drained Crystal Fragment: "The Achromatic Crystal"
    { 672255, 263461 },     // westmost Archival Panel: "The Western Gates"
    { 672256, 263460 },     // the green Archival Panel: "The Regrowth Vestibule"
    { 650303, 263462 },     // the high Archival Panel: "The Unearthed Stone Watcher"
};

constexpr uint32 QUEST_MAPPING_THE_WAY_FORWARD = 95925;

class classic_spell_forever_drawing_kit : public SpellScript
{
    void HandleAfterCast()
    {
        Player* player = GetCaster()->ToPlayer();
        if (!OnQuest(player, QUEST_MAPPING_THE_WAY_FORWARD))
            return;

        for (ForeverShapersLandmark const& landmark : ForeverShapersLandmarks)
            if (GameObject* go = player->FindNearestGameObject(landmark.GameObjectEntry, 30.0f))
                player->KilledMonsterCredit(landmark.Credit, go->GetGUID());
    }

    void Register() override
    {
        AfterCast += SpellCastFn(classic_spell_forever_drawing_kit::HandleAfterCast);
    }
};

/*######
## 96303 Memory Mist: Memory of the Mist 1292804 on a Wisp 273458
######*/

enum MemoryMist
{
    QUEST_MEMORY_MIST           = 96303,
    NPC_MEMORY_MIST_WISP        = 273458,
    NPC_WISP_RELEASED_CREDIT    = 264715
};

class classic_spell_forever_memory_of_the_mist : public SpellScript
{
    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        Player* player = GetCaster()->ToPlayer();
        Creature* wisp = GetHitCreature();
        if (!wisp || wisp->GetEntry() != NPC_MEMORY_MIST_WISP || !OnQuest(player, QUEST_MEMORY_MIST))
            return;

        player->KilledMonsterCredit(NPC_WISP_RELEASED_CREDIT, wisp->GetGUID());
        Position up = wisp->GetPosition();
        up.m_positionZ += 12.0f;
        wisp->SetDisableGravity(true);
        wisp->GetMotionMaster()->Clear();
        wisp->GetMotionMaster()->MovePoint(1, up);
        wisp->DespawnOrUnsummon(3s, 60s);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_forever_memory_of_the_mist::HandleHit, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

/*######
## 97010 Blind Vengeance: Explosive Runeshard 1298707
######*/

enum BlindVengeance
{
    QUEST_BLIND_VENGEANCE           = 97010,
    NPC_DOOMGUARD_XARKUL            = 267439,
    NPC_RUNESHARDS_DETONATED_CREDIT = 267462
};

class classic_spell_forever_explosive_runeshard : public SpellScript
{
    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        Player* player = GetCaster()->ToPlayer();
        Unit* target = GetHitUnit();
        if (!target || target->GetEntry() != NPC_DOOMGUARD_XARKUL || !OnQuest(player, QUEST_BLIND_VENGEANCE))
            return;

        player->KilledMonsterCredit(NPC_RUNESHARDS_DETONATED_CREDIT, target->GetGUID());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_forever_explosive_runeshard::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

/*######
## 98252 A Void Path: Va'xug Firefure 267214, Eye of Kilrogg 271181
######*/

enum AVoidPath
{
    QUEST_A_VOID_PATH           = 98252,
    NPC_VOID_PATH_EYE           = 271181,
    NPC_EYE_AT_ROAD_CREDIT      = 271182
};

// the road west of Va'xug: nodes 99-106 of the Wandering Protector's patrol (waypoint path 800323410)
constexpr Position ForeverVoidPathRoad[] =
{
    { 2224.25f, -852.01f, 101.14f }, { 2215.03f, -817.65f, 105.88f }, { 2217.62f, -785.36f, 105.71f },
    { 2210.36f, -758.43f, 105.39f }, { 2179.92f, -737.38f, 103.93f }, { 2159.69f, -715.18f, 103.71f },
    { 2137.76f, -690.52f, 104.02f }, { 2117.26f, -679.66f, 103.78f },
};

// one eye per player: a new one only when none of theirs is about
static void ForeverSummonVoidPathEye(Player* player)
{
    std::list<Creature*> eyes;
    player->GetCreatureListWithEntryInGrid(eyes, NPC_VOID_PATH_EYE, 100.0f);
    for (Creature* eye : eyes)
        if (TempSummon* summon = eye->ToTempSummon())
            if (summon->GetSummonerGUID() == player->GetGUID())
                return;

    Position pos = player->GetPosition();
    player->MovePosition(pos, 2.0f, float(M_PI) / 2);
    player->SummonCreature(NPC_VOID_PATH_EYE, pos, TEMPSUMMON_TIMED_DESPAWN, 20min);
}

struct classic_npc_forever_vaxug_firefure : public ScriptedAI
{
    classic_npc_forever_vaxug_firefure(Creature* creature) : ScriptedAI(creature) { }

    void OnQuestAccept(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_A_VOID_PATH)
            ForeverSummonVoidPathEye(player);
    }

    bool OnGossipHello(Player* player) override
    {
        QuestStatus status = player->GetQuestStatus(QUEST_A_VOID_PATH);
        if (status == QUEST_STATUS_INCOMPLETE || status == QUEST_STATUS_COMPLETE)
            ForeverSummonVoidPathEye(player);
        return false;
    }
};

struct classic_npc_forever_void_path_eye : public ScriptedAI
{
    classic_npc_forever_void_path_eye(Creature* creature) : ScriptedAI(creature), _checkTimer(1000), _arrived(false) { }

    void IsSummonedBy(WorldObject* summoner) override
    {
        me->SetFaction(35);
        me->SetImmuneToAll(true);
        me->SetReactState(REACT_PASSIVE);
        if (Player* player = summoner->ToPlayer())
        {
            _playerGuid = player->GetGUID();
            me->GetMotionMaster()->MoveFollow(player, 2.0f, float(M_PI));
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (_arrived)
            return;
        if (_checkTimer > diff)
        {
            _checkTimer -= diff;
            return;
        }
        _checkTimer = 1000;

        Player* player = ObjectAccessor::GetPlayer(*me, _playerGuid);
        if (!player)
        {
            me->DespawnOrUnsummon();
            return;
        }

        for (Position const& node : ForeverVoidPathRoad)
        {
            if (me->GetExactDist2d(node) > 15.0f)
                continue;
            _arrived = true;
            if (OnQuest(player, QUEST_A_VOID_PATH))
                player->KilledMonsterCredit(NPC_EYE_AT_ROAD_CREDIT, me->GetGUID());
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
            me->SetFacingToObject(player);
            me->DespawnOrUnsummon(5min);
            return;
        }
    }

private:
    ObjectGuid _playerGuid;
    uint32 _checkTimer;
    bool _arrived;
};

void AddSC_classic_forever_quest_mechanics()
{
    RegisterCreatureAI(classic_npc_forever_area_denial_skunk);
    RegisterCreatureAI(classic_npc_forever_siegecraft_glaive_thrower);
    new classic_event_forever_battle_memories();
    RegisterSpellScript(classic_spell_forever_toss_enchanted_seeds);
    RegisterCreatureAI(classic_npc_forever_twilight_ritual_circle);
    RegisterSpellScript(classic_spell_forever_drawing_kit);
    RegisterSpellScript(classic_spell_forever_memory_of_the_mist);
    RegisterSpellScript(classic_spell_forever_explosive_runeshard);
    RegisterCreatureAI(classic_npc_forever_vaxug_firefure);
    RegisterCreatureAI(classic_npc_forever_void_path_eye);
}
