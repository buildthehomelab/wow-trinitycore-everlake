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

#ifndef TRINITY_CLASSIC_PROC_RULES_H
#define TRINITY_CLASSIC_PROC_RULES_H

#include "Define.h"
#include "FlagsArray.h"
#include "SharedDefines.h"
#include <algorithm>

// Classic 1.60: the decisions of the proc scripts in classic_spell_scripts.cpp (advocaite/TrinityCore#325), apart from the
// scripts so tests can reach them. Pure: the script reads the aura, the weapon and the proc event and passes plain values.
namespace ClassicProcRules
{
    // Shaman weapon imbues: every rank's temporary enchantment applies the same DUMMY aura (Flametongue Weapon 436519, Windfury
    // Weapon 439431); the enchantment on the weapon that hit tells the rank. 0: not an enchantment of that imbue.

    // Flametongue: enchantment -> the rank's "Flametongue Weapon Proc" spell, whose effect 0 points carry the damage
    constexpr uint32 FlametongueRankSpell(uint32 enchantId)
    {
        switch (enchantId)
        {
            case 5:    return 8026;
            case 4:    return 8028;
            case 3:    return 8029;
            case 523:  return 10445;
            case 1665: return 16343;
            case 1666:
            case 7567: return 16344;    // 7567: the enchantment of the newer Flametongue Weapon 461634
            default:   return 0;
        }
    }

    // Windfury: enchantment -> the rank's attack power + extra attacks spell
    constexpr uint32 WindfuryRankSpell(uint32 enchantId)
    {
        switch (enchantId)
        {
            case 283:  return 8233;
            case 284:  return 8236;
            case 525:  return 10484;
            case 1669:
            case 7569: return 16361;    // 7569: the enchantment of the newer Windfury Weapon 461636
            case 8293: return 8233;     // Windwrath 1
            default:   return 0;
        }
    }

    // Flametongue Weapon: "${$8026m1/77} to ${$8026m1/25}" Fire damage: the rank's points / 100 per second of weapon speed
    // (1.3 s to 4.0 s), at least 1. Spell power is added by Flametongue Attack 10444 itself (its bonus coefficient).
    inline int32 FlametongueDamage(float rankPoints, uint32 weaponDelayMs)
    {
        return std::max(int32(rankPoints * (float(weaponDelayMs) / 1000.0f) / 100.0f), 1);
    }

    // Talents whose proc chance is an effect amount scaled by the trait rank while SpellAuraOptions.ProcChance is 100: the effect
    // that holds the chance (the tooltip's $m1 / $m2 / $s2).
    constexpr SpellEffIndex TalentChanceEffect(uint32 talentSpellId)
    {
        switch (talentSpellId)
        {
            case 11180:   // Winter's Chill: $m2
            case 12298:   // Shield Specialization (warrior): $m2
            case 14909:   // Searing Light: $m2
            case 16850:   // Improved Starfire: $s2
            case 20150:   // Shield Specialization (paladin): $m2
            case 1224716: // Puncturing Wounds: $m2
                return EFFECT_1;
            default:
                return EFFECT_0;
        }
    }

    // What a proc event was, as far as the talent rules look at it
    struct ProcEvent
    {
        uint32 SpellFamily = 0;     // SpellFamilyNames of the spell of the event, SPELLFAMILY_GENERIC without one (melee swing)
        flag128 SpellFamilyFlags;   // its SpellClassMask
        uint32 SchoolMask = 0;      // SpellSchoolMask of the event
        bool Blocked = false;       // PROC_HIT_BLOCK or PROC_HIT_FULL_BLOCK
        bool Critical = false;      // PROC_HIT_CRITICAL
        bool Periodic = false;      // a periodic tick (PROC_FLAG_DEAL_HARMFUL_PERIODIC)
        bool Damage = false;        // the event dealt damage
        bool FinishingMove = false; // the spell costs combo points
        bool Chill = false;         // a mage spell with a snare (a mage "Chill effect")
    };

    // Whether the event is one the talent's tooltip names. #325: every event the talent's proc flags let through.
    inline bool TalentProcMatches(uint32 /*talentSpellId*/, ProcEvent const& /*event*/)
    {
        return true;
    }

    // 400588 - Missile Barrage: Arcane Blast $m1%; Arcane Wrath (named Arcane Surge in #325), Fireball, Frostbolt and Frostfire Bolt
    // $m1 / 2; told apart by their whole SpellClassMask, so no other mage spell matches. 0: no chance.
    constexpr float MissileBarrageChance(uint32 spellFamily, flag128 const& f, float amount)
    {
        if (spellFamily != SPELLFAMILY_MAGE || f[3] != 0)
            return 0.0f;
        if (f[0] == 0x60000000 && f[1] == 0 && f[2] == 0)                       // Arcane Blast
            return amount;
        if ((f[0] == 0x40000000 && f[1] == 0x8000 && f[2] == 0)                 // Arcane Wrath
            || (f[0] == 0x40000001 && f[1] == 0 && f[2] == 0)                   // Fireball
            || (f[0] == 0x40180020 && f[1] == 0 && f[2] == 0)                   // Frostbolt
            || (f[0] == 0x40100000 && f[1] == 0x1000 && f[2] == 0x8))           // Frostfire Bolt
            return amount / 2.0f;
        return 0.0f;
    }

    // 20177 - Reckoning: "a $m1% chance after Blocking and a ${$m1*2.5}% chance after receiving a non-periodic critical strike to gain
    // an extra attack ... Cannot occur from Blocks more than once every 1.5 sec". The chance to roll, 0 for none; fromBlock tells the
    // script to start the block cooldown when the roll succeeds.
    constexpr uint32 ReckoningBlockCooldownMs = 1500;

    constexpr float ReckoningChance(ProcEvent const& event, uint32 nowMs, uint32 lastBlockMs, float amount, bool& fromBlock)
    {
        fromBlock = false;
        if (!event.Blocked && !event.Damage)    // a full block leaves no damage and still counts
            return 0.0f;
        if (event.Blocked)
        {
            if (lastBlockMs && nowMs - lastBlockMs < ReckoningBlockCooldownMs)
                return 0.0f;
            fromBlock = true;
            return amount;
        }
        if (event.Critical)
            return amount * 2.5f;
        return 0.0f;
    }
}

#endif // TRINITY_CLASSIC_PROC_RULES_H
