-- AnoCore v10 changelog (NPCs and world) items still wrong in our world.

-- "Bareth Dawnstone, ... Ander Solliden ... no longer appear several times in a row in the world": our 70170 sniff caught
-- them at several points of their walk and spawned each one.
-- Bareth Dawnstone: one spawn at the start of his Seeking Refuge route (AnoCore v10 spot, where the route in _38 begins).
-- Ander Solliden: keep the sniffed spawn at the AnoCore v10 spot (21200066), remove the other three.
DELETE FROM `creature_addon` WHERE `guid` IN (21200065,21200067,21200068,21200482,21200483,21200484,21200485,21200486);
DELETE FROM `creature` WHERE `guid` IN (21200065,21200067,21200068) AND `id`=246394;
DELETE FROM `creature` WHERE `guid` IN (21200482,21200483,21200484,21200485,21200486) AND `id`=275954;
DELETE FROM `creature` WHERE `guid`=27595400;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(27595400,275954,0,0,0,'0',0,0,0,-1,0,0,2445.73,1587.33,37.067,0,300,0,0,100,0,0,0,0,0,'',NULL,0);

-- "Magram Necromancers and Marauders give Gelkis reputation (and a Magram loss), like the other Magram centaurs":
-- the Forever Magram Necromancer and Magram Marauder had no kill reputation. Same values as the classic Magram Marauder 4644.
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (253272,262838);
INSERT INTO `creature_onkill_reputation` (`creature_id`,`RewOnKillRepFaction1`,`RewOnKillRepFaction2`,`MaxStanding1`,`IsTeamAward1`,`RewOnKillRepValue1`,`MaxStanding2`,`IsTeamAward2`,`RewOnKillRepValue2`,`TeamDependent`) VALUES
(253272,92,93,4,0,20,4,0,-100,0), -- Magram Necromancer
(262838,92,93,4,0,20,4,0,-100,0); -- Magram Marauder
