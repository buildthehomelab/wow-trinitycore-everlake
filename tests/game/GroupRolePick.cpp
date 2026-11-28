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
#include "tc_catch2.h"

#include "../../src/modules/PlayerbotV2/Fleet/GroupRolePick.h"

using namespace Playerbot::V2::Fleet;

namespace
{
constexpr uint8 Warrior = 1, Paladin = 2, Rogue = 4, Priest = 5, Shaman = 7, Mage = 8, Druid = 11;
GroupRoleCandidate Bot(uint8 cls, uint8 specRole = kGroupDps) { return { cls, specRole }; }
}

TEST_CASE("Tank and healer places go to bots whose spec plays the role, not the first free bots", "[GroupRolePick]")
{
    // The first three free bots are damage dealers; the Protection warrior and Holy priest come later in the registry.
    std::vector<GroupRoleCandidate> const pool{ Bot(Mage), Bot(Rogue), Bot(Mage), Bot(Warrior, kGroupTank), Bot(Priest, kGroupHealer), Bot(Rogue) };
    std::vector<size_t> const picked = PickGroupRoles(pool, 1, 1, 3, 5);
    REQUIRE(picked == std::vector<size_t>{ 3, 4, 0, 1, 2 });
}

TEST_CASE("A healer spec of a weaker healing class comes before a better class in a damage spec", "[GroupRolePick]")
{
    std::vector<GroupRoleCandidate> const pool{ Bot(Priest), Bot(Shaman, kGroupHealer), Bot(Mage) };
    std::vector<size_t> const picked = PickGroupRoles(pool, 0, 1, 0, 1);
    REQUIRE(picked == std::vector<size_t>{ 1 });
}

TEST_CASE("With no fitting spec the best class takes the place", "[GroupRolePick]")
{
    std::vector<GroupRoleCandidate> const pool{ Bot(Druid), Bot(Paladin), Bot(Warrior), Bot(Priest), Bot(Shaman) };
    std::vector<size_t> const picked = PickGroupRoles(pool, 1, 1, 0, 2);
    REQUIRE(picked == std::vector<size_t>{ 2, 3 });
}

TEST_CASE("A class that cannot play the role never takes its place; the backfill fills the group", "[GroupRolePick]")
{
    std::vector<GroupRoleCandidate> const pool{ Bot(Mage), Bot(Rogue), Bot(Mage) };
    std::vector<size_t> const picked = PickGroupRoles(pool, 1, 1, 0, 3);
    REQUIRE(picked == std::vector<size_t>{ 0, 1, 2 });
}

TEST_CASE("Damage places prefer damage specs over spare tanks and healers", "[GroupRolePick]")
{
    std::vector<GroupRoleCandidate> const pool{ Bot(Warrior, kGroupTank), Bot(Warrior, kGroupTank), Bot(Priest, kGroupHealer), Bot(Mage) };
    std::vector<size_t> const picked = PickGroupRoles(pool, 1, 1, 1, 3);
    REQUIRE(picked == std::vector<size_t>{ 0, 2, 3 });
}

TEST_CASE("The pick stops at the room left (a leader already taken)", "[GroupRolePick]")
{
    std::vector<GroupRoleCandidate> const pool{ Bot(Warrior, kGroupTank), Bot(Priest, kGroupHealer), Bot(Mage), Bot(Mage) };
    REQUIRE(PickGroupRoles(pool, 1, 1, 3, 2).size() == 2);
}
