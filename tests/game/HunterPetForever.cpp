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
#include "HunterPetForever.h"

// Worked examples from the Classic Hunter Lodge wiki, Pet-Stat-Mechanics and Pet-Fundamentals.

TEST_CASE("Pet attack power is 10% of the higher of the hunter's ranged and melee attack power", "[HunterPetForever]")
{
    HunterPetForever::HunterStats hunter;
    hunter.RangedAttackPower = 1400.0f;
    hunter.MeleeAttackPower = 900.0f;
    CHECK(HunterPetForever::AttackPower(hunter) == Catch::Approx(140.0f));  // the wiki's example: 1,400 RAP and 900 MAP give 140

    hunter.MeleeAttackPower = 1600.0f;                                      // a melee set makes MAP the source
    CHECK(HunterPetForever::AttackPower(hunter) == Catch::Approx(160.0f));

    hunter.RangedAttackPower = 1500.0f;
    hunter.MeleeAttackPower = 1500.0f;                                      // not added together
    CHECK(HunterPetForever::AttackPower(hunter) == Catch::Approx(150.0f));
}

TEST_CASE("Pet health, armor and crit from the hunter follow the wiki's examples", "[HunterPetForever]")
{
    HunterPetForever::HunterStats hunter;
    hunter.Stamina = 100.0f;
    hunter.Armor = 2000.0f;
    hunter.RangedCrit = 25.0f;
    hunter.MeleeCrit = 18.0f;

    CHECK(HunterPetForever::MaxHealth(hunter) == Catch::Approx(200.0f));    // 100 Stamina -> 200 health
    CHECK(HunterPetForever::Armor(hunter) == Catch::Approx(600.0f));        // 2,000 armor -> 600
    CHECK(HunterPetForever::Crit(hunter) == Catch::Approx(25.0f));          // 25% ranged, 18% melee -> 25%, not 43%

    // the wiki's test deltas: +10 Stamina = +20 health, +100 armor = +30 armor
    hunter.Stamina += 10.0f;
    hunter.Armor += 100.0f;
    CHECK(HunterPetForever::MaxHealth(hunter) == Catch::Approx(220.0f));
    CHECK(HunterPetForever::Armor(hunter) == Catch::Approx(630.0f));
}

TEST_CASE("Pet hit is the higher of the hunter's ranged and melee hit", "[HunterPetForever]")
{
    HunterPetForever::HunterStats hunter;
    hunter.RangedHit = 3.0f;
    hunter.MeleeHit = 1.0f;
    CHECK(HunterPetForever::Hit(hunter) == Catch::Approx(3.0f));
}

TEST_CASE("Inherited amounts never go below zero", "[HunterPetForever]")
{
    HunterPetForever::HunterStats hunter;
    hunter.RangedAttackPower = -50.0f;
    hunter.MeleeAttackPower = -20.0f;
    hunter.Armor = -100.0f;
    hunter.RangedHit = -1.0f;
    hunter.MeleeHit = -2.0f;
    CHECK(HunterPetForever::AttackPower(hunter) == 0.0f);
    CHECK(HunterPetForever::Armor(hunter) == 0.0f);
    CHECK(HunterPetForever::Hit(hunter) == 0.0f);
}

TEST_CASE("A pet level needs 20% of the hunter's XP for that level", "[HunterPetForever]")
{
    CHECK(HunterPetForever::NextLevelXp(100000) == 20000u);                 // the wiki's example
    CHECK(HunterPetForever::NextLevelXp(400) == 80u);                       // level 1 (vanilla needed 20)
    CHECK(HunterPetForever::NextLevelXp(0) == 0u);
}

TEST_CASE("Focus comes back at 10 per second", "[HunterPetForever]")
{
    CHECK(HunterPetForever::FocusPerTick(10.0f, 1000) == Catch::Approx(10.0f));
    CHECK(HunterPetForever::FocusPerTick(10.0f, 4000) == Catch::Approx(40.0f));
    CHECK(HunterPetForever::FocusPerTick(HunterPetForever::FocusPerSecondFallback, 1000) == Catch::Approx(10.0f));
}
