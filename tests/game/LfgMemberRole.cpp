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

#include "../../src/modules/PlayerbotV2/LfgRoleGap.h"

using namespace Playerbot::V2;

namespace
{
constexpr uint8 Warrior = 1, Paladin = 2, Rogue = 4, Priest = 5, Druid = 11;
}

TEST_CASE("A Shadow priest player counts as damage, so the bots bring a healer", "[LfgMemberRole]")
{
    REQUIRE(LfgMemberRole(Priest, 0, 0, kLfgRoleDamage) == kLfgRoleDamage);
    uint8 const members[] = { LfgMemberRole(Warrior, 0, kLfgRoleTank, 0), LfgMemberRole(Priest, 0, 0, kLfgRoleDamage) };
    REQUIRE(ComputeLfgRoleGap(members).healer == 1);
}

TEST_CASE("A Holy paladin player counts as the healer, so no second healer comes", "[LfgMemberRole]")
{
    REQUIRE(LfgMemberRole(Paladin, 0, 0, kLfgRoleHealer) == kLfgRoleHealer);
}

TEST_CASE("The group's role and the leader's pick come before the talents", "[LfgMemberRole]")
{
    REQUIRE(LfgMemberRole(Druid, kLfgRoleTank, 0, kLfgRoleHealer) == kLfgRoleTank);
    REQUIRE(LfgMemberRole(Druid, 0, kLfgRoleTank, kLfgRoleHealer) == kLfgRoleTank);
}

TEST_CASE("A player with no talents bought counts by class, as before", "[LfgMemberRole]")
{
    REQUIRE(LfgMemberRole(Warrior, 0, 0, 0) == kLfgRoleTank);
    REQUIRE(LfgMemberRole(Priest, 0, 0, 0) == kLfgRoleHealer);
    REQUIRE(LfgMemberRole(Rogue, 0, 0, 0) == kLfgRoleDamage);
}

TEST_CASE("A role the class cannot play is never counted", "[LfgMemberRole]")
{
    REQUIRE(LfgMemberRole(Rogue, kLfgRoleTank, kLfgRoleHealer, kLfgRoleTank) == kLfgRoleDamage);
}
