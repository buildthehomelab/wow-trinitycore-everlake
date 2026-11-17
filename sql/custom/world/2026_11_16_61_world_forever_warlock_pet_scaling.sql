-- 416189 Warlock Pet Scaling: WoW Forever's health from the warlock's Stamina (Blizzard, 3 November 2026: "Pets now gain 2 Health per
-- point of Master's Stamina"). Every effect is 0 in the 1.60 client, so the amount comes from C++: classic_spell_warl_pet_scaling
-- (Custom/Classic/world/classic_warlock_pet_scaling.cpp). Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_warl_pet_scaling';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(416189, 'classic_spell_warl_pet_scaling');
