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

#ifndef TRINITY_CLASSIC_ATTACK_TABLE_H
#define TRINITY_CLASSIC_ATTACK_TABLE_H

#include <algorithm>
#include <cstdint>

// Classic 1.60 (vanilla) physical attack table rules shared by white and yellow attacks, melee and ranged. Source: Magey's
// classic-warrior wiki "Attack table" page (Beaza's formulas checked against 60K+ logged hits), which the forever-hunter wiki's
// Ranged Attack Table page follows for hunters.
namespace ClassicAttackTable
{
    // Crit change from weapon skill against defense: 0.04% per point, but 0.2% per point against a creature with more defense than
    // the attacker's weapon skill capped at the attacker's level maximum (-3% against a +3 creature at 300 skill, still -3% at 305).
    inline float CritSkillAdjustment(int32_t weaponSkill, int32_t cappedWeaponSkill, int32_t defense, bool victimIsPlayer)
    {
        int32_t const skillDiff = weaponSkill - defense;
        if (victimIsPlayer || skillDiff > 0)
            return float(skillDiff) * 0.04f;
        return float(cappedWeaponSkill - defense) * 0.2f;
    }

    // Against creatures three or more levels above the attacker, crit that comes from auras (talents, Equip: crit, buffs,
    // consumables; not base crit or agility) loses a flat 1.8%, never more than the aura crit there is.
    constexpr float AuraCritSuppression = 1.8f;
    constexpr int32_t AuraCritSuppressionLevelGap = 3;

    inline float AuraCritSuppressionFor(float auraCrit, int32_t levelGap, bool victimIsPlayer)
    {
        if (victimIsPlayer || levelGap < AuraCritSuppressionLevelGap || !(auraCrit > 0.0f))
            return 0.0f;
        return std::min(auraCrit, AuraCritSuppression);
    }

    // Hit suppression: when the victim's defense is more than 10 above the attacker's weapon skill, (gap - 10) * 0.2% of the +hit
    // from gear and talents is ignored: 1% at 300 skill against a +3 creature, 0.2% at 304, none at 305. Never more than the
    // +hit there is.
    inline float HitSuppression(float hitChance, int32_t defenseGap)
    {
        if (!(hitChance > 0.0f) || defenseGap <= 10)
            return 0.0f;
        return std::min(hitChance, float(defenseGap - 10) * 0.2f);
    }
}

#endif
