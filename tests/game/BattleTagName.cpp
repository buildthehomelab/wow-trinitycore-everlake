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
// to whisper (an empty tag gave "Tell :" with no target). As Evermore, a player picks the name with
// .battletag and the number is drawn.
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

TEST_CASE("A picked BattleTag name is 2-12 ASCII letters and digits starting with a letter (as Evermore)", "[BattleTag]")
{
    REQUIRE(IsValidName("Jo"));
    REQUIRE(IsValidName("Jean"));
    REQUIRE(IsValidName("Red2Panda"));
    REQUIRE(IsValidName("Abcdefghijkl"));
    REQUIRE_FALSE(IsValidName("J"));
    REQUIRE_FALSE(IsValidName("Abcdefghijklm"));
    REQUIRE_FALSE(IsValidName("2Jean"));
    REQUIRE_FALSE(IsValidName("Jean Jumpspring"));
    REQUIRE_FALSE(IsValidName("Je_an"));                // a LIKE wildcard
    REQUIRE_FALSE(IsValidName("Je%an"));
    REQUIRE_FALSE(IsValidName("Je'an"));
    REQUIRE_FALSE(IsValidName("Jean#1234"));
    REQUIRE_FALSE(IsValidName("Z\xC3\xB3ra"));          // accented: the automatic tag skips it, the player picks one
    REQUIRE_FALSE(IsValidName(""));
}

TEST_CASE("BattleTag number is read back from a stored tag", "[BattleTag]")
{
    REQUIRE(NumberOf("Jean#4821") == 4821u);
    REQUIRE(NumberOf("jean#0042") == 42u);
    REQUIRE_FALSE(NumberOf("Jean"));
    REQUIRE_FALSE(NumberOf("Jean#"));
    REQUIRE_FALSE(NumberOf("Jean#12a4"));
}

TEST_CASE("BattleTag number is drawn among the free ones", "[BattleTag]")
{
    std::unordered_set<uint32> used;
    for (uint32 n = MinNumber; n <= MaxNumber; ++n)
        if (n != 5555)
            used.insert(n);
    // only 5555 free, but more than MaxUsedPerName taken: the name is full
    REQUIRE_FALSE(DrawNumber(used, [](uint32 min, uint32) { return min; }));

    used.clear();
    used.insert(1000);
    used.insert(1001);
    uint32 next = MinNumber;
    auto counting = [&next](uint32, uint32) { return next++; };
    REQUIRE(DrawNumber(used, counting) == 1002u);       // 1000 and 1001 skipped

    std::unordered_set<uint32> const none;
    for (int i = 0; i < 200; ++i)
    {
        Optional<uint32> drawn = DrawNumber(none, [](uint32 min, uint32 max) { return min + (max - min) / 2; });
        REQUIRE(drawn);
        REQUIRE(*drawn >= MinNumber);
        REQUIRE(*drawn <= MaxNumber);
    }
}
