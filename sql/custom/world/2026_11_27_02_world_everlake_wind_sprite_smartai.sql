-- Wind Sprite (252481, 19 spawns): its SmartAI rows (on aggro the sniffed "The tiny sprite squeaks fearfully and
-- vanishes!" and its cast 1253200) never ran: 2026_10_01_03_world_forever_sniff.sql re-inserted the template with an
-- empty AIName over the baseline's SmartAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 252481 AND `ScriptName` = '';
