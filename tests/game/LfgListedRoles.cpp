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
// Class fits as LfgBotFill gives them (TankFit / HealerFit).
ListedMember Warrior(uint8 spec = kLfgRoleDamage) { return { 3, 0, spec }; }
ListedMember Paladin(uint8 spec = kLfgRoleDamage) { return { 2, 2, spec }; }
ListedMember Priest(uint8 spec = kLfgRoleDamage)  { return { 0, 3, spec }; }
ListedMember Shaman(uint8 spec = kLfgRoleDamage)  { return { 0, 1, spec }; }
ListedMember Mage()                               { return { 0, 0, kLfgRoleDamage }; }
}

TEST_CASE("A healer place goes to the bot whose spec heals before a better healing class in a damage spec", "[LfgListedRoles]")
{
    // A Shadow priest and a Holy paladin: the old class-only rule listed the priest as the healer and nobody healed.
    std::vector<ListedMember> const m{ Warrior(), Priest(kLfgRoleDamage), Paladin(kLfgRoleHealer), Mage() };
    std::vector<uint8> const r = PlanListedRoles(m, 1, 1);
    REQUIRE(r == std::vector<uint8>{ kLfgRoleTank, kLfgRoleDamage, kLfgRoleHealer, kLfgRoleDamage });
}

TEST_CASE("A tank-spec paladin takes the tank place before a Fury warrior", "[LfgListedRoles]")
{
    std::vector<ListedMember> const m{ Warrior(kLfgRoleDamage), Paladin(kLfgRoleTank), Priest(kLfgRoleHealer) };
    std::vector<uint8> const r = PlanListedRoles(m, 1, 1);
    REQUIRE(r == std::vector<uint8>{ kLfgRoleDamage, kLfgRoleTank, kLfgRoleHealer });
}

TEST_CASE("With no spec that fits, the class decides (the bot is switched to the role's spec after)", "[LfgListedRoles]")
{
    std::vector<ListedMember> const m{ Shaman(), Priest(), Warrior(), Mage() };
    std::vector<uint8> const r = PlanListedRoles(m, 1, 1);
    REQUIRE(r == std::vector<uint8>{ kLfgRoleDamage, kLfgRoleHealer, kLfgRoleTank, kLfgRoleDamage });
}

TEST_CASE("A class that cannot play a role never gets its place, even with nobody else", "[LfgListedRoles]")
{
    std::vector<ListedMember> const m{ Mage(), Mage(), Priest() };
    std::vector<uint8> const r = PlanListedRoles(m, 1, 1);
    REQUIRE(r == std::vector<uint8>{ kLfgRoleDamage, kLfgRoleDamage, kLfgRoleHealer });
}

TEST_CASE("A member takes one place only: a tank-spec paladin is not also counted as the healer", "[LfgListedRoles]")
{
    std::vector<ListedMember> const m{ Paladin(kLfgRoleTank), Mage() };
    std::vector<uint8> const r = PlanListedRoles(m, 1, 1);
    REQUIRE(r == std::vector<uint8>{ kLfgRoleTank, kLfgRoleDamage });
}
