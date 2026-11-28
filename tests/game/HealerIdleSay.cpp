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

#include "../../src/modules/PlayerbotV2/Bot/HealerIdleSay.h"

using namespace Playerbot::HealerSay;

TEST_CASE("The healer's reason is read in the log line's order", "[HealerIdleSay]")
{
    REQUIRE(Classify(false, 50.f, true, 5) == Cause::OutOfSight);
    REQUIRE(Classify(true, 45.f, false, 50) == Cause::OutOfRange);
    REQUIRE(Classify(true, 20.f, true, 5) == Cause::Moving);
    REQUIRE(Classify(true, 20.f, false, 5) == Cause::OutOfMana);
    REQUIRE(Classify(true, 20.f, false, 50) == Cause::Other);
}

TEST_CASE("Only what the player can fix is said, for a member in real trouble, after a few seconds", "[HealerIdleSay]")
{
    SayState st;
    REQUIRE_FALSE(SayDue(st, Cause::Moving, 30, 10000, 1000));
    REQUIRE_FALSE(SayDue(st, Cause::Other, 30, 10000, 1000));
    REQUIRE_FALSE(SayDue(st, Cause::OutOfSight, 70, 10000, 1000));   // not hurt enough
    REQUIRE_FALSE(SayDue(st, Cause::OutOfSight, 30, 3000, 1000));    // not long enough
    REQUIRE(SayDue(st, Cause::OutOfSight, 30, 5000, 1000));
}

TEST_CASE("One line per 30 s, the same reason once a minute", "[HealerIdleSay]")
{
    SayState st;
    REQUIRE(SayDue(st, Cause::OutOfSight, 30, 5000, 10000));
    REQUIRE_FALSE(SayDue(st, Cause::OutOfMana, 30, 5000, 20000));    // 10 s later: too soon for any line
    REQUIRE_FALSE(SayDue(st, Cause::OutOfSight, 30, 5000, 45000));   // 35 s later: the same reason waits a minute
    REQUIRE(SayDue(st, Cause::OutOfMana, 30, 5000, 45000));          // another reason may come after 30 s
    REQUIRE(SayDue(st, Cause::OutOfSight, 30, 5000, 106000));
}

TEST_CASE("The lines name the hurt member", "[HealerIdleSay]")
{
    REQUIRE(Line(Cause::OutOfSight, "Brannoc") == "I can't see Brannoc from here to heal.");
    REQUIRE(Line(Cause::OutOfRange, "Elsabet") == "Elsabet is too far away for my heals.");
    REQUIRE(Line(Cause::OutOfMana, "Elsabet") == "I'm out of mana, I can't heal.");
    REQUIRE(Line(Cause::Other, "Elsabet").empty());
}
