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

#include "ScriptMgr.h"
#include "Pet.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "Unit.h"
#include <algorithm>
#include <cmath>

// 416189 - Warlock Pet Scaling. A family passive every demon gets (SkillLineAbility rows on the Imp, Voidwalker, Succubus, Felhunter,
// Infernal and Doomguard skill lines, AcquireMethod 2, learned in Pet::LearnPetPassives). In the 1.60.1.70938 client all 20 effects are
// SPELL_EFFECT_APPLY_AURA on the pet with amount 0, as on 415429 Hunter Pet Scaling: the server fills them in.
//
// Only effect 0 (230 SPELL_AURA_MOD_MAX_HEALTH) is filled. Blizzard's WoW Forever notes of 3 November 2026: "Warlock: Pets now gain 2 Health
// per point of Master's Stamina (was 7.5 Health per point of Master's Stamina)." No source gives the other effects (attack power, spell
// damage, resistances, armor, hit, haste, crit) for demons, so they stay 0.
//
// The amount follows the warlock's current Stamina: effect 0 ticks every second and recalculates when the value changed.
class classic_spell_warl_pet_scaling : public AuraScript
{
    static constexpr float HealthPerStamina = 2.0f;
    static constexpr int32 RecalculateIntervalMs = 1 * IN_MILLISECONDS;

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellEffect({ { spellInfo->Id, EFFECT_0 } });
    }

    // Pet::GetOwner (the owner pointer the pet is created with), not WorldObject::GetOwner (a lookup by OwnerGUID, which fails while the
    // warlock is not on the pet's map).
    static Player const* GetWarlock(Unit const* unit)
    {
        Pet const* pet = unit ? unit->ToPet() : nullptr;
        if (!pet || pet->getPetType() != SUMMON_PET)
            return nullptr;

        Player const* owner = pet->GetOwner();
        return owner && owner->GetClass() == CLASS_WARLOCK ? owner : nullptr;
    }

    static float HealthAmount(Unit const* pet)
    {
        Player const* warlock = GetWarlock(pet);
        if (!warlock)
            return 0.0f;

        return std::floor(std::max(0.0f, warlock->GetStat(STAT_STAMINA) * HealthPerStamina));
    }

    void CalcAmount(AuraEffect const* /*aurEff*/, SpellEffectValue& amount, bool& canBeRecalculated)
    {
        canBeRecalculated = true;
        amount = HealthAmount(GetUnitOwner());
    }

    void CalcRecalculateTimer(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = RecalculateIntervalMs;
    }

    void RecalculateChanged(AuraEffect* aurEff)
    {
        Unit* pet = GetUnitOwner();
        if (!GetWarlock(pet))
            return; // keep the last amount rather than dropping it to 0 for a moment

        SpellEffectValue const oldAmount = aurEff->GetAmount();
        if (std::abs(oldAmount - HealthAmount(pet)) <= 0.001)
            return;

        // Recalculating takes the old amount off with health floored at 1, then heals the whole new amount: a demon with less health than
        // the old bonus came back near full whenever the warlock's Stamina changed. Keep its health, moved by the change.
        int64 const health = pet->GetHealth();
        aurEff->RecalculateAmount();
        if (pet->IsAlive() && health > 0)
        {
            int64 const changed = health + int64(aurEff->GetAmount() - oldAmount);
            pet->SetHealth(uint64(std::clamp<int64>(changed, 1, int64(pet->GetMaxHealth()))));
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(classic_spell_warl_pet_scaling::CalcAmount, EFFECT_0, SPELL_AURA_MOD_MAX_HEALTH);
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(classic_spell_warl_pet_scaling::CalcRecalculateTimer, EFFECT_0, SPELL_AURA_MOD_MAX_HEALTH);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(classic_spell_warl_pet_scaling::RecalculateChanged, EFFECT_0, SPELL_AURA_MOD_MAX_HEALTH);
    }
};

void AddSC_classic_warlock_pet_scaling()
{
    RegisterSpellScript(classic_spell_warl_pet_scaling);
}
