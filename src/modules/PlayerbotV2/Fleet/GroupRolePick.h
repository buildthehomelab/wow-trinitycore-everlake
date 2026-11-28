// GroupRolePick.h - which free bots BotGroupBuilder takes for the tank, healer and damage places of a group it forms.
//
// The builder used to order the bots by their archetype's role_affinity, but every archetype has the same {0.10, 0.10, 0.80}, so
// the tank and healer passes took nobody and every group was simply the first free bots of the level range. A Group Finder bot
// group then listed a Shadow priest as its healer and nobody healed (2026-11-27). This goes by what the bot plays: a place goes
// first to a bot whose spec plays that role, then to a bot whose class can play it (best class first: the warrior tanks, the
// priest heals), and never to a class that cannot. Damage places prefer damage specs. Places nobody fits are left to the backfill,
// which takes the remaining bots in their original order.
// Pure: no game types (class ids as the game numbers them), tested in tests/game/GroupRolePick.cpp.
#pragma once

#include "Define.h"

#include <algorithm>
#include <span>
#include <vector>

namespace Playerbot::V2::Fleet {

enum GroupRoleSlot : uint8 { kGroupTank = 0, kGroupHealer = 1, kGroupDps = 2 };

struct GroupRoleCandidate
{
    uint8 cls = 0;
    uint8 specRole = kGroupDps;   // the role the bot's spec plays now
};

// How well a class plays a role, 0 = cannot. 1 warrior, 2 paladin, 5 priest, 6 death knight, 7 shaman, 10 monk, 11 druid,
// 12 demon hunter, 13 evoker.
inline uint8 GroupClassFit(uint8 cls, uint8 slot)
{
    if (slot == kGroupTank)
        switch (cls)
        {
            case 1:  return 3;
            case 2:  return 2;
            case 6: case 10: case 11: case 12: return 1;
            default: return 0;
        }
    if (slot == kGroupHealer)
        switch (cls)
        {
            case 5:  return 3;
            case 2: case 11: return 2;
            case 7: case 10: case 13: return 1;
            default: return 0;
        }
    return 1;
}

// The order of preference for one place, 0 = never.
inline int GroupRoleScore(GroupRoleCandidate const& c, uint8 slot)
{
    if (slot == kGroupDps)
        return c.specRole == kGroupDps ? 2 : 1;
    uint8 const fit = GroupClassFit(c.cls, slot);
    if (!fit)
        return 0;
    return (c.specRole == slot ? 10 : 0) + fit;
}

// The pool indices taken, in the order taken: the tank places, the healer places, the damage places, then the backfill in pool order
// until `room` bots are taken.
inline std::vector<size_t> PickGroupRoles(std::span<GroupRoleCandidate const> pool, uint8 tanks, uint8 healers, uint8 dps, size_t room)
{
    std::vector<size_t> picked;
    std::vector<bool> taken(pool.size(), false);
    auto fill = [&](uint8 slot, uint8 want)
    {
        std::vector<size_t> order;
        for (size_t i = 0; i < pool.size(); ++i)
            if (!taken[i] && GroupRoleScore(pool[i], slot) > 0)
                order.push_back(i);
        std::stable_sort(order.begin(), order.end(),
                         [&](size_t a, size_t b) { return GroupRoleScore(pool[a], slot) > GroupRoleScore(pool[b], slot); });
        for (size_t i = 0; i < order.size() && want && picked.size() < room; ++i, --want)
        {
            picked.push_back(order[i]);
            taken[order[i]] = true;
        }
    };
    fill(kGroupTank, tanks);
    fill(kGroupHealer, healers);
    fill(kGroupDps, dps);
    for (size_t i = 0; i < pool.size() && picked.size() < room; ++i)
        if (!taken[i])
        {
            picked.push_back(i);
            taken[i] = true;
        }
    return picked;
}

}  // namespace Playerbot::V2::Fleet
