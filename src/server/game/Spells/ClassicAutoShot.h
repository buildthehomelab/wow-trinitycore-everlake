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

#ifndef TRINITY_CLASSIC_AUTO_SHOT_H
#define TRINITY_CLASSIC_AUTO_SHOT_H

#include "SharedDefines.h"
#include <algorithm>
#include <cstdint>

// Classic 1.60 (vanilla): the hunter's Auto Shot (spell 75).
// - A shot needs the hunter to stand still for half a second first (the "wind-up"): the first shot after Auto Shot is turned on, and
//   the next shot after moving. Moving pauses Auto Shot, it does not cancel it, and no shot leaves while the hunter moves. A hunter
//   standing still shoots once per weapon speed, as before (the wind-up runs inside the ranged swing timer).
// - An arrow already in flight lands: turning Auto Shot off, clearing the target or starting another spell stops the next shot, not
//   the one in the air (handled where the repeat is interrupted, Unit::InterruptSpell).
// - A shot that cannot be taken either waits (out of range, facing, line of sight: the hunter can fix that by moving or turning) or
//   stops Auto Shot (no ammo, wrong or no ranged weapon, a dead or friendly target). The reason is told once, not every update: the
//   server used to repeat the error to the client every half second while the toggle stayed on.
namespace ClassicAutoShot
{
    constexpr uint32_t SpellId = 75;
    constexpr uint32_t WindupMs = 500;

    // Ranged haste shortens the wind-up as it shortens the swing: 0.5 sec / 1.10 with a 10% quiver (wowsims/forever
    // RangedSwingWindup / swing speed; the forever-hunter wiki's Shot Mechanics page). attackSpeedPct is the unit's ranged attack time
    // multiplier (m_modAttackSpeedPct[RANGED_ATTACK], 1 / haste: 0.909 with a 10% quiver).
    inline uint32_t WindupFor(float attackSpeedPct)
    {
        if (!(attackSpeedPct > 0.0f))   // also catches NaN
            return WindupMs;
        return uint32_t(float(WindupMs) * std::min(attackSpeedPct, 1.0f) + 0.5f);
    }

    // stillSinceMs: game time the hunter last moved, or turned Auto Shot on (whichever is later).
    inline bool IsWindupDone(uint32_t nowMs, uint32_t stillSinceMs, uint32_t windupMs = WindupMs)
    {
        return uint32_t(nowMs - stillSinceMs) >= windupMs;   // unsigned difference: correct across the 49-day wrap of the ms clock
    }

    enum class FailAction
    {
        Wait,   // keep Auto Shot on, try again on the next update
        Stop    // turn Auto Shot off
    };

    inline FailAction OnFailedShot(SpellCastResult result)
    {
        switch (result)
        {
            case SPELL_FAILED_NO_AMMO:
            case SPELL_FAILED_NEED_AMMO:
            case SPELL_FAILED_NEED_AMMO_POUCH:
            case SPELL_FAILED_EQUIPPED_ITEM:
            case SPELL_FAILED_EQUIPPED_ITEM_CLASS:
            case SPELL_FAILED_EQUIPPED_ITEM_CLASS_MAINHAND:
            case SPELL_FAILED_EQUIPPED_ITEM_CLASS_OFFHAND:
            case SPELL_FAILED_TARGETS_DEAD:
            case SPELL_FAILED_TARGET_FRIENDLY:
            case SPELL_FAILED_BAD_TARGETS:
                return FailAction::Stop;
            default:
                return FailAction::Wait;
        }
    }

    // Whether a failed shot's reason goes to the client: once per reason, again only after a shot left or the reason changed.
    // A silent result (DONT_REPORT, the swing timer not ready yet) never does.
    inline bool ShouldReport(SpellCastResult result, SpellCastResult lastReported)
    {
        if (result == SPELL_CAST_OK || result == SPELL_FAILED_DONT_REPORT)
            return false;
        return result != lastReported;
    }
}

#endif
