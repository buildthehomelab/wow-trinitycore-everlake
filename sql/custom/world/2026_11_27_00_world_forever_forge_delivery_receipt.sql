-- Forge Delivery Receipt (1269600), cast by the Forged Delivery Receipt (262902, 15 Merchant's Favor): "Slap a forged delivery
-- receipt onto an empty Waylaid Crate, allowing you to return it to the Azeroth Commerce Authority for +50 reputation."
-- The spell's second effect is a dummy holding the 50; classic_spell_item_forge_delivery_receipt uses up the labeled Waylaid Crate
-- it is cast on and gives the reputation (2586 Alliance, 2587 Horde).
-- Safe to run again.
DELETE FROM `spell_script_names` WHERE `spell_id` = 1269600 AND `ScriptName` = 'classic_spell_item_forge_delivery_receipt';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (1269600, 'classic_spell_item_forge_delivery_receipt');
