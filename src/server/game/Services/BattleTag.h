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

#ifndef TRINITYCORE_BATTLE_TAG_H
#define TRINITYCORE_BATTLE_TAG_H

#include "Define.h"
#include "Optional.h"
#include <string>
#include <string_view>
#include <unordered_set>

// A Battle.net account's BattleTag ("Name#1234"). The client names a Battle.net friend by it (the friends list, the
// whisper target, the own tag in the Social window), so an account without one gets friends it cannot whisper. Nothing
// else gives accounts a tag here (no Battle.net site). As on Evermore, the player picks the name (.battletag <name>) and
// the server draws the number. Until then the account gets one from the first name of the character it first enters
// the world with, when that name is a valid tag name.
namespace Trinity::BattleTag
{
    constexpr std::size_t MinPickedNameLength = 2;
    constexpr std::size_t MaxNameLength = 12;
    constexpr uint32 MinNumber = 1000;                  // four digits, drawn at random among the free ones
    constexpr uint32 MaxNumber = 9999;
    constexpr std::size_t MaxUsedPerName = 8000;        // of 9000: past this, drawing a free number gets slow

    // The name part: the character's first name (no surname, no spaces), cut to MaxNameLength characters on a
    // character boundary. Empty when nothing usable is left.
    inline std::string NameFromCharacter(std::string_view characterName)
    {
        std::string name;
        std::size_t characters = 0;
        for (std::size_t i = 0; i < characterName.size();)
        {
            uint8 const lead = uint8(characterName[i]);
            if (lead == ' ' || lead == '-' || lead == '#')  // surname or realm separator, or the tag's own '#'
                break;

            std::size_t length = 1;
            if (lead >= 0xF0)
                length = 4;
            else if (lead >= 0xE0)
                length = 3;
            else if (lead >= 0xC0)
                length = 2;
            else if (lead >= 0x80)                          // stray continuation byte: not a name
                return {};
            if (i + length > characterName.size())
                return {};

            if (characters == MaxNameLength)
                break;
            name.append(characterName.substr(i, length));
            ++characters;
            i += length;
        }
        return name;
    }

    // A tag name a player may pick (.battletag): 2-12 ASCII letters and digits, starting with a letter. The same rule as
    // Evermore's friend tags. It keeps the name safe in SQL and in LIKE patterns without escaping.
    inline bool IsValidName(std::string_view name)
    {
        auto letter = [](char c) { return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'); };
        auto digit = [](char c) { return c >= '0' && c <= '9'; };
        if (name.size() < MinPickedNameLength || name.size() > MaxNameLength || !letter(name.front()))
            return false;
        for (char c : name)
            if (!letter(c) && !digit(c))
                return false;
        return true;
    }

    inline std::string Make(std::string_view name, uint32 number)
    {
        std::string tag(name);
        tag += '#';
        tag += std::to_string(number);
        return tag;
    }

    // The number after the '#' of a stored tag, if it is one.
    inline Optional<uint32> NumberOf(std::string_view tag)
    {
        std::size_t const hash = tag.rfind('#');
        if (hash == std::string_view::npos || hash + 1 >= tag.size() || tag.size() - hash - 1 > 9)
            return {};
        uint32 number = 0;
        for (char c : tag.substr(hash + 1))
        {
            if (c < '0' || c > '9')
                return {};
            number = number * 10 + uint32(c - '0');
        }
        return number;
    }

    // A free four-digit number for a name whose tags already use `used`. None once the name is crowded (more than
    // MaxUsedPerName taken): the player picks another name.
    template<class Random>
    Optional<uint32> DrawNumber(std::unordered_set<uint32> const& used, Random random)
    {
        std::size_t taken = 0;
        for (uint32 number : used)
            if (number >= MinNumber && number <= MaxNumber)
                ++taken;
        if (taken > MaxUsedPerName)
            return {};
        for (;;)
        {
            uint32 const number = random(MinNumber, MaxNumber);
            if (!used.contains(number))
                return number;
        }
    }
}

#endif // TRINITYCORE_BATTLE_TAG_H
