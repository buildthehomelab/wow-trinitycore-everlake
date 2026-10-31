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

#include "../../src/modules/PlayerbotV2/Bot/RecoverRules.h"

using namespace Playerbot::Classic;

// Deadmines, live 2026-10-10: the priest at 87 % mana never sat because some mob with a victim was always within 45 y.
TEST_CASE("An enemy only blocks sitting down when it is engaged with the bot's side and close", "[ClassicRecoverRules]")
{
    CHECK_FALSE(EnemyBlocksRecovery(false, 10.0f * 10.0f));   // fighting someone else (a pet, another pack)
    CHECK_FALSE(EnemyBlocksRecovery(true, 35.0f * 35.0f));    // engaged but out of reach
    CHECK(EnemyBlocksRecovery(true, 25.0f * 25.0f));
    CHECK(MemberFightBlocksRecovery(40.0f * 40.0f));
    CHECK_FALSE(MemberFightBlocksRecovery(50.0f * 50.0f));
}

TEST_CASE("RecoverRules: a player's bot sits only when the group has stopped, and not straight back down", "[ClassicRecoverRules]")
{
    using namespace Playerbot::Classic;
    LedRestInputs in;
    CHECK(LedMaySitDown(in));                          // never stood up, the player has not moved
    in.since_anchor_moved_ms = 500;                     // the player walks on: no sitting
    CHECK_FALSE(LedMaySitDown(in));
    in.since_anchor_moved_ms = kLedAnchorStillMs;       // he has stood 3 s: the group has stopped
    CHECK(LedMaySitDown(in));
    in.since_stood_ms = 4000;                           // the follow got it up 4 s ago (UBRS RC5: Harmony re-drank every stop)
    CHECK_FALSE(LedMaySitDown(in));
    in.since_stood_ms = kLedResitMs;
    CHECK(LedMaySitDown(in));
    in.resting = true;                                  // already eating / drinking: stays down
    in.since_anchor_moved_ms = 0;
    in.since_stood_ms = 0;
    CHECK(LedMaySitDown(in));
    // Only the bots that need it: a drink well under the old 90 % dungeon-healer mark, food only when properly hurt.
    CHECK(kLedDrinkBelowManaPct <= 60);
    CHECK(kLedEatBelowHpPct <= 60);
}
