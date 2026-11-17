-- WoW Forever Revelation (weapon enchant 8217): proc aura 1248806 and the class buffs, checked against the live client data (build
-- 70707) and wowsims/forever (MIT, https://github.com/wowsims/forever) evidence EV-0028 and EV-0129. Script classic_spell_enchant_revelation
-- in src/server/scripts/Custom/Classic/world/classic_spell_scripts.cpp.
--  * 1248806: direct damage or heal hits that do not crit (helpful and harmful spells), 8% (EV-0129). Flamestrike's ground ticks count.
--  * Class buffs (+100% crit chance to the next spell their class flags name, one charge, 15 sec): only a spell the crit mod changed
--    spends the charge. The mage's goes as the cast completes (EV-0028: 81 of 84 in the millisecond of the cast's success, no ground
--    tick spends it); the other classes' with the spell's hit.
-- Safe to run again.

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_enchant_revelation';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(1248806, 'classic_spell_enchant_revelation');

DELETE FROM `spell_proc` WHERE `SpellId` IN (1248806, 1248808, 1323377, 1323392, 1323400, 1323410, 1323418, 1323419);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`, `ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(1248806, 0, 0, 0, 0, 0, 0, 0x14000, 0, 3, 2, 0x1, 0, 0, 0, 8, 0, 0), -- Revelation (enchant): non-crit direct damage and heal hits, 8%
(1248808, 0, 0, 0, 0, 0, 0, 0x14000, 0, 7, 1, 0, 8, 0, 0, 100, 0, 1), -- Revelation (mage): spent as the cast completes
(1323377, 0, 0, 0, 0, 0, 0, 0x14000, 0, 7, 2, 0, 8, 0, 0, 100, 0, 1), -- Revelation (priest)
(1323392, 0, 0, 0, 0, 0, 0, 0x14000, 0, 7, 2, 0, 8, 0, 0, 100, 0, 1), -- Revelation (warlock)
(1323400, 0, 0, 0, 0, 0, 0, 0x14000, 0, 7, 2, 0, 8, 0, 0, 100, 0, 1), -- Revelation (druid)
(1323410, 0, 0, 0, 0, 0, 0, 0x14000, 0, 7, 2, 0, 8, 0, 0, 100, 0, 1), -- Revelation (hunter)
(1323418, 0, 0, 0, 0, 0, 0, 0x14000, 0, 7, 2, 0, 8, 0, 0, 100, 0, 1), -- Revelation (shaman)
(1323419, 0, 0, 0, 0, 0, 0, 0x14000, 0, 7, 2, 0, 8, 0, 0, 100, 0, 1); -- Revelation (paladin)
