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

#include "FullName.h"
#include "ObjectMgr.h"
#include "Util.h"

namespace
{
    // the blanks normalizePlayerName trims (the unit menu sends "Name " for a character with no surname)
    bool IsBlank(wchar_t c)
    {
        switch (c)
        {
            case L' ': case L'\t': case L' ': case L'​': case L'‌': case L'‍': case L'‎':
            case L'‏': case L'﻿':
                return true;
            default:
                return false;
        }
    }

    std::wstring Trimmed(std::wstring const& text)
    {
        std::size_t first = 0;
        while (first < text.size() && IsBlank(text[first]))
            ++first;
        std::size_t last = text.size();
        while (last > first && IsBlank(text[last - 1]))
            --last;
        return text.substr(first, last - first);
    }

    bool Folded(std::string_view text, std::wstring& folded)
    {
        if (!Utf8toWStr(text, folded))
            return false;
        folded = Trimmed(folded);
        wstrToLower(folded);
        return true;
    }
}

bool Trinity::FullName::Split(std::string_view text, Parts& parts)
{
    parts = Parts();

    std::wstring wide;
    if (!Utf8toWStr(text, wide))
        return false;
    wide = Trimmed(wide);

    std::size_t blank = 0;
    while (blank < wide.size() && !IsBlank(wide[blank]))
        ++blank;

    std::wstring surname = blank < wide.size() ? Trimmed(wide.substr(blank)) : std::wstring();
    if (!WStrToUtf8(wide.substr(0, blank), parts.Name) || !WStrToUtf8(surname, parts.Surname))
        return false;

    parts.HasSurname = !parts.Surname.empty();
    return normalizePlayerName(parts.Name);
}

bool Trinity::FullName::SurnameEquals(std::string_view a, std::string_view b)
{
    std::wstring foldedA, foldedB;
    if (!Folded(a, foldedA) || !Folded(b, foldedB))
        return false;
    return foldedA == foldedB;
}

std::size_t Trinity::FullName::Pick(std::vector<std::string_view> const& candidateSurnames, Parts const& wanted)
{
    constexpr std::size_t none = std::size_t(-1);

    if (wanted.HasSurname)
    {
        for (std::size_t i = 0; i < candidateSurnames.size(); ++i)
            if (SurnameEquals(candidateSurnames[i], wanted.Surname))
                return i;
        return none;
    }

    for (std::size_t i = 0; i < candidateSurnames.size(); ++i)
        if (candidateSurnames[i].empty())
            return i;

    return candidateSurnames.size() == 1 ? 0 : none;
}
