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
#include "BattleTag.h"

// Everlake: an account with no BattleTag gets one from its character's first name, so Battle.net friends have a name
// to whisper (an empty tag gave "Tell :" with no target).
using namespace Trinity::BattleTag;

TEST_CASE("BattleTag name part is the character's first name", "[BattleTag]")
{
    REQUIRE(NameFromCharacter("Jean") == "Jean");
    REQUIRE(NameFromCharacter("Jean Jumpspring") == "Jean");
    REQUIRE(NameFromCharacter("Jean-Jumpspring") == "Jean");
    REQUIRE(NameFromCharacter("Ab#12") == "Ab");
}

TEST_CASE("BattleTag name part is cut to 12 characters on a character boundary", "[BattleTag]")
{
    REQUIRE(NameFromCharacter("Abcdefghijklmnop") == "Abcdefghijkl");
    // 13 two-byte letters: 12 kept, 24 bytes, no half character
    std::string const accented = "\xC3\xA9\xC3\xA9\xC3\xA9\xC3\xA9\xC3\xA9\xC3\xA9\xC3\xA9\xC3\xA9\xC3\xA9\xC3\xA9\xC3\xA9\xC3\xA9\xC3\xA9";
    std::string const name = NameFromCharacter(accented);
    REQUIRE(name.size() == 24);
    REQUIRE(name == accented.substr(0, 24));
    REQUIRE(NameFromCharacter("Z\xC3\xB3ra") == "Z\xC3\xB3ra");
}

TEST_CASE("BattleTag name part rejects broken text", "[BattleTag]")
{
    REQUIRE(NameFromCharacter("").empty());
    REQUIRE(NameFromCharacter(" Jean").empty());
    REQUIRE(NameFromCharacter("Je\x80n").empty());          // stray continuation byte
    REQUIRE(NameFromCharacter("Jea\xC3").empty());          // cut multi-byte letter
}

TEST_CASE("BattleTag is name#number", "[BattleTag]")
{
    REQUIRE(Make("Jean", 4821) == "Jean#4821");
    REQUIRE(Make("Jean", 10000) == "Jean#10000");
}
