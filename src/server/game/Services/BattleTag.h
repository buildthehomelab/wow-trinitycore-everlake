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
#include <string>
#include <string_view>

// A Battle.net account's BattleTag ("Name#1234"). The client names a Battle.net friend by it (the friends list, the
// whisper target, the own tag in the Social window), so an account without one gets friends it cannot whisper. Nothing
// else gives accounts a tag here (no Battle.net site), so the worldserver makes one from the character the account
// first enters the world with.
namespace Trinity::BattleTag
{
    constexpr std::size_t MaxNameLength = 12;           // UTF-8 characters, as Battle.net
    constexpr uint32 MinNumber = 1000;                  // four digits, five once the four-digit tries all collide
    constexpr uint32 MaxNumber = 9999;

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

    inline std::string Make(std::string_view name, uint32 number)
    {
        std::string tag(name);
        tag += '#';
        tag += std::to_string(number);
        return tag;
    }
}

#endif // TRINITYCORE_BATTLE_TAG_H
