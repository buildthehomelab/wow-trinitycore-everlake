-- Classic 1.60 (Forever): Grolkar (253163), giver and turn-in of Big, No, MASSIVE Iron Axes (92818) in Desolace, had no spawn. AnoCore v10's
-- spawn, which sits on the Wowhead Forever pin (69.6, 78). Spawn flags NULL: the template decides.
DELETE FROM `creature` WHERE `guid`=25316300;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(25316300,253163,1,0,0,'0',0,0,0,-1,0,0,-1874.3,1095.24,91.958,0,300,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0);

-- Rigger Gizelton (11626) has no spawn of his own on purpose: Cork Gizelton summons him with the caravan. What was missing is his script:
-- taking Gizelton Caravan (5943) from him did not set the caravan off (VMaNGOS npc_rigger_gizelton, now classic_npc_rigger_gizelton).
UPDATE `creature_template` SET `ScriptName`='classic_npc_rigger_gizelton' WHERE `entry`=11626;
