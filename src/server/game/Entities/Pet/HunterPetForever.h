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

#ifndef TRINITYCORE_HUNTER_PET_FOREVER_H
#define TRINITYCORE_HUNTER_PET_FOREVER_H

#include "Define.h"
#include <algorithm>

// Classic 1.60 (WoW Forever) hunter pet rules that differ from vanilla. Sources: the Classic Hunter Lodge wiki
// (github.com/classic-hunter/forever-hunter/wiki), pages Pet-Stat-Mechanics and Pet-Fundamentals, and the 1.60.1.70862
// client's PowerType table.
namespace HunterPetForever
{
    // Pet-Stat-Mechanics, "Hunter Inheritance": pet AP = 10% of the higher of the hunter's ranged and melee attack power, 2 pet
    // health per hunter Stamina, 30% of the hunter's armor, 100% of the higher of the hunter's ranged and melee crit, and the
    // hunter's hit. Inheritance follows the hunter's current stats, buffs included.
    constexpr float AttackPowerShare = 0.10f;
    constexpr float HealthPerStamina = 2.0f;
    constexpr float ArmorShare = 0.30f;
    constexpr float CritShare = 1.0f;

    // Pet-Fundamentals, "Pet Level and Experience": a pet level needs 20% of the hunter's XP for that level (vanilla: 5%).
    constexpr float LevelXpShare = 0.20f;

    // Pet-Fundamentals, "Focus": 10 focus per second, continuously, in and out of combat; the same as the client's PowerType row 3
    // (FOCUS, RegenPeace 10, RegenCombat 10). Used only when that row is missing. Vanilla gave 24 focus every 4 seconds.
    constexpr float FocusPerSecondFallback = 10.0f;

    struct HunterStats
    {
        float RangedAttackPower = 0.0f;
        float MeleeAttackPower = 0.0f;
        float Stamina = 0.0f;
        float Armor = 0.0f;
        float RangedCrit = 0.0f;    // percent
        float MeleeCrit = 0.0f;     // percent
        float RangedHit = 0.0f;     // percent
        float MeleeHit = 0.0f;      // percent
    };

    inline float AttackPower(HunterStats const& hunter)
    {
        return std::max(0.0f, std::max(hunter.RangedAttackPower, hunter.MeleeAttackPower) * AttackPowerShare);
    }

    inline float MaxHealth(HunterStats const& hunter)
    {
        return std::max(0.0f, hunter.Stamina * HealthPerStamina);
    }

    inline float Armor(HunterStats const& hunter)
    {
        return std::max(0.0f, hunter.Armor * ArmorShare);
    }

    inline float Crit(HunterStats const& hunter)
    {
        return std::max(0.0f, std::max(hunter.RangedCrit, hunter.MeleeCrit) * CritShare);
    }

    // The wiki says only "Hit: inherited by the pet"; the higher of ranged and melee hit, as for attack power and crit.
    inline float Hit(HunterStats const& hunter)
    {
        return std::max(0.0f, std::max(hunter.RangedHit, hunter.MeleeHit));
    }

    inline uint32 NextLevelXp(uint32 hunterXpForLevel)
    {
        return uint32(float(hunterXpForLevel) * LevelXpShare);
    }

    inline float FocusPerTick(float focusPerSecond, uint32 tickMs)
    {
        return focusPerSecond * float(tickMs) / 1000.0f;
    }
}

#endif
