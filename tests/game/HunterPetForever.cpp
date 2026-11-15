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

TEST_CASE("A loyalty rank needs 5% of the hunter's level XP and the rank's time", "[HunterPetForever]")
{
    using namespace HunterPetForever;
    uint32 const levelXp = 10100;                                           // hunter XP for level 12
    uint32 const xp = LoyaltyXpForRank(levelXp);
    CHECK(xp == 505u);

    // rank 2 (Unruly) needs no time
    CHECK(CanRankUp(1, xp, 0, levelXp));
    CHECK_FALSE(CanRankUp(1, xp - 1, 0, levelXp));

    // ranks 3 to 6 need 30, 45, 60 and 90 minutes as well
    for (auto [rank, minutes] : { std::pair{ 2, 30u }, { 3, 45u }, { 4, 60u }, { 5, 90u } })
    {
        INFO("Rank: " << rank);
        CHECK(CanRankUp(uint8(rank), xp, minutes * 60, levelXp));
        CHECK_FALSE(CanRankUp(uint8(rank), xp, minutes * 60 - 1, levelXp));  // the XP alone is not enough
        CHECK_FALSE(CanRankUp(uint8(rank), xp - 1, 24 * 3600, levelXp));     // nor is the time alone
    }

    CHECK_FALSE(CanRankUp(6, xp, 24 * 3600, levelXp));                      // Best Friend is the top
}

// Attack speed: the ten Faster Attack / Slower Attack passives of the 1.60.1.70790 client (SpellEffect: Mod Attack Speed).

TEST_CASE("A Faster Attack passive shortens the 2.0 sec swing to the beast's vanilla speed", "[HunterPetForever]")
{
    CHECK(HunterPetForever::AttackTimeMs(0) == 2000u);      // no passive: every hunter pet swings once in 2.0 sec
    CHECK(HunterPetForever::AttackTimeMs(17) == 1709u);     // Faster Attack I, Wowhead: 1.70 (Mangy Wolf)
    CHECK(HunterPetForever::AttackTimeMs(25) == 1600u);     // Faster Attack II, Wowhead: 1.60 (Mystmane)
    CHECK(HunterPetForever::AttackTimeMs(33) == 1504u);     // Faster Attack III, Wowhead: 1.50 (Prowler)
    CHECK(HunterPetForever::AttackTimeMs(43) == 1399u);     // Faster Attack IV
    CHECK(HunterPetForever::AttackTimeMs(54) == 1299u);     // Faster Attack V
    CHECK(HunterPetForever::AttackTimeMs(67) == 1198u);     // Faster Attack VI
    CHECK(HunterPetForever::AttackTimeMs(100) == 1000u);    // Faster Attack VII (Broken Tooth)
}

TEST_CASE("A Slower Attack passive lengthens the swing the way a slow does", "[HunterPetForever]")
{
    // Unit::ApplyAttackTimePercentMod multiplies the swing by 1 + percent for a negative amount
    CHECK(HunterPetForever::AttackTimeMs(-17) == 2340u);    // Slower Attack I
    CHECK(HunterPetForever::AttackTimeMs(-20) == 2400u);    // Slower Attack II
    CHECK(HunterPetForever::AttackTimeMs(-26) == 2520u);    // Slower Attack III
}

TEST_CASE("Pets of every attack speed do the same damage per second", "[HunterPetForever]")
{
    // Pet-Attack-Formulas: Auto Attack = (Base Pet DPS + Pet AP / 14) x Swing Speed. 85.45 DPS is the wiki's level 60 example.
    float const dps = 85.45f;
    float const swingAtBaseSpeed = dps * 2.0f;
    for (int32 percent : { 0, 17, 25, 33, 43, 54, 67, 100, -17, -20, -26 })
    {
        float swing = swingAtBaseSpeed * HunterPetForever::SwingShare(percent);
        float seconds = 2.0f * HunterPetForever::SwingShare(percent);
        CHECK(swing / seconds == Catch::Approx(dps));
    }

    CHECK(HunterPetForever::SwingShare(0) == Catch::Approx(1.0f));
    CHECK(HunterPetForever::SwingShare(25) == Catch::Approx(0.8f));     // Mystmane hits for 80% of a 2.0 sec beast's swing
    CHECK(HunterPetForever::SwingShare(100) == Catch::Approx(0.5f));    // Broken Tooth: half the swing, twice as often
    CHECK(HunterPetForever::SwingShare(-20) == Catch::Approx(1.2f));
}

TEST_CASE("Only the ten Faster Attack and Slower Attack spells are attack speed passives", "[HunterPetForever]")
{
    CHECK(HunterPetForever::IsAttackSpeedPassive(1263099));     // Faster Attack I
    CHECK(HunterPetForever::IsAttackSpeedPassive(1263100));     // Faster Attack II
    CHECK(HunterPetForever::IsAttackSpeedPassive(1263110));     // Faster Attack VII
    CHECK(HunterPetForever::IsAttackSpeedPassive(1263111));     // Slower Attack I
    CHECK(HunterPetForever::IsAttackSpeedPassive(1263114));     // Slower Attack III
    CHECK_FALSE(HunterPetForever::IsAttackSpeedPassive(0));
    CHECK_FALSE(HunterPetForever::IsAttackSpeedPassive(1263101));
    CHECK_FALSE(HunterPetForever::IsAttackSpeedPassive(1264494));   // Swipe
    CHECK_FALSE(HunterPetForever::IsAttackSpeedPassive(17253));     // Bite Rank 1
}

// Pet food: Item.ItemPetFoodID and CreatureFamily.PetFoodMask of the 1.60.1.70790 client.

TEST_CASE("An item's pet food type is the client's, and item_template_addon only fills a gap", "[HunterPetForever]")
{
    CHECK(HunterPetForever::FoodType(1, 0) == 1u);      // Raging Raptor Ribs 250073: Meat in the client, no addon row
    CHECK(HunterPetForever::FoodType(2, 4) == 2u);      // Crab Cake 2683: Fish in the client, the addon row said Bread
    CHECK(HunterPetForever::FoodType(0, 1) == 1u);      // Meaty Bat Wing 12223: nothing in the client, Meat in the addon row
    CHECK(HunterPetForever::FoodType(0, 0) == 0u);      // not a pet food
    CHECK(HunterPetForever::FoodType(-1, 3) == 3u);
}

TEST_CASE("A family eats the food types of its PetFoodMask", "[HunterPetForever]")
{
    uint32 const bear = 63;     // Meat, Fish, Cheese, Bread, Fungus, Fruit
    uint32 const wolf = 1;      // Meat
    uint32 const turtle = 178;  // Fish, Fungus, Fruit, Raw Fish
    for (uint32 foodType = 1; foodType <= 6; ++foodType)
        CHECK(HunterPetForever::EatsFoodType(bear, foodType));
    CHECK_FALSE(HunterPetForever::EatsFoodType(bear, 7));       // Raw Meat (Pound of Flesh) is not in a bear's mask
    CHECK_FALSE(HunterPetForever::EatsFoodType(bear, 8));

    CHECK(HunterPetForever::EatsFoodType(wolf, 1));
    CHECK_FALSE(HunterPetForever::EatsFoodType(wolf, 2));
    CHECK(HunterPetForever::EatsFoodType(turtle, 2));
    CHECK(HunterPetForever::EatsFoodType(turtle, 8));
    CHECK_FALSE(HunterPetForever::EatsFoodType(turtle, 1));

    CHECK_FALSE(HunterPetForever::EatsFoodType(bear, 0));       // an item with no food type is never food
    CHECK_FALSE(HunterPetForever::EatsFoodType(0xFFFFFFFF, 33)); // no shift past the mask
}
