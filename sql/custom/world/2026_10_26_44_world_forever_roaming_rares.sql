-- Forever rares that roam over several spots, one at a time (Elmpaw, Elder Finseer, Halikor, Croaky, Ukorsbane, Mistmantle Prowler
-- and others). Our world had their templates but no spawns. Spots and one-at-a-time pools as the AnoCore v10 world has them
-- (its spots come from the Wowhead Forever map pins). Spawn guids 42000000+, pools 1400000+.
DELETE FROM `pool_members` WHERE `type`=0 AND `spawnId` BETWEEN 42000000 AND 42000097;
DELETE FROM `creature` WHERE `guid` BETWEEN 42000000 AND 42000097;
-- 248278 Croaky: 5 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400000;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400000,1,'Croaky (248278), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000000,248278,0,0,0,'0',0,0,0,-1,0,0,-9939.87,-1118.77,21.953,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000001,248278,0,0,0,'0',0,0,0,-1,0,0,-10001.1,-1132.27,21.897,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000002,248278,0,0,0,'0',0,0,0,-1,0,0,-9893.09,-1109.36,28.833,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000003,248278,0,0,0,'0',0,0,0,-1,0,0,-9909.29,-1119.77,25.941,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000004,248278,0,0,0,'0',0,0,0,-1,0,0,-9888.46,-1130.18,26.928,0,600,5,0,100,1,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000000,1400000,0,'Croaky'),
(0,42000001,1400000,0,'Croaky'),
(0,42000002,1400000,0,'Croaky'),
(0,42000003,1400000,0,'Croaky'),
(0,42000004,1400000,0,'Croaky');
-- 248299 Elmpaw: 30 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400001;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400001,1,'Elmpaw (248299), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000005,248299,0,0,0,'0',0,0,0,-1,0,0,-8865.42,-977.467,74.639,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000006,248299,0,0,0,'0',0,0,0,-1,0,0,-8833.01,-998.292,74.002,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000007,248299,0,0,0,'0',0,0,0,-1,0,0,-8870.04,-1012.17,73.881,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000008,248299,0,0,0,'0',0,0,0,-1,0,0,-8772.83,-1019.12,76.456,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000009,248299,0,0,0,'0',0,0,0,-1,0,0,-8883.93,-1046.88,73.887,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000010,248299,0,0,0,'0',0,0,0,-1,0,0,-8907.08,-1046.88,67.152,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000011,248299,0,0,0,'0',0,0,0,-1,0,0,-8865.42,-1053.82,75.517,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000012,248299,0,0,0,'0',0,0,0,-1,0,0,-8828.38,-1067.71,74.057,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000013,248299,0,0,0,'0',0,0,0,-1,0,0,-8879.3,-1067.71,74.429,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000014,248299,0,0,0,'0',0,0,0,-1,0,0,-8828.38,-1116.3,75.493,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000015,248299,0,0,0,'0',0,0,0,-1,0,0,-8809.87,-1130.18,77.038,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000016,248299,0,0,0,'0',0,0,0,-1,0,0,-8842.27,-1130.18,76.695,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000017,248299,0,0,0,'0',0,0,0,-1,0,0,-8814.5,-1157.95,81.229,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000018,248299,0,0,0,'0',0,0,0,-1,0,0,-8865.42,-1171.83,78.185,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000019,248299,0,0,0,'0',0,0,0,-1,0,0,-8823.75,-1192.66,89.428,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000020,248299,0,0,0,'0',0,0,0,-1,0,0,-9906.98,-1289.84,31.807,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000021,248299,0,0,0,'0',0,0,0,-1,0,0,-9888.46,-1303.72,34.167,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000022,248299,0,0,0,'0',0,0,0,-1,0,0,-9846.8,-1310.67,38.452,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000023,248299,0,0,0,'0',0,0,0,-1,0,0,-9962.53,-1310.67,25.375,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000024,248299,0,0,0,'0',0,0,0,-1,0,0,-9962.53,-1352.32,23.889,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000025,248299,0,0,0,'0',0,0,0,-1,0,0,-9925.5,-1373.14,30.11,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000026,248299,0,0,0,'0',0,0,0,-1,0,0,-9832.91,-1380.08,49.119,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000027,248299,0,0,0,'0',0,0,0,-1,0,0,-9888.46,-1387.03,32.822,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000028,248299,0,0,0,'0',0,0,0,-1,0,0,-9906.98,-1407.85,30.205,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000029,248299,0,0,0,'0',0,0,0,-1,0,0,-9814.39,-1449.5,39.776,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000030,248299,0,0,0,'0',0,0,0,-1,0,0,-9795.88,-1456.44,44.323,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000031,248299,0,0,0,'0',0,0,0,-1,0,0,-9698.67,-1470.32,53.543,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000032,248299,0,0,0,'0',0,0,0,-1,0,0,-9786.62,-1484.21,44.857,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000033,248299,0,0,0,'0',0,0,0,-1,0,0,-9763.47,-1491.15,47.039,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000034,248299,0,0,0,'0',0,0,0,-1,0,0,-9791.25,-1518.92,43.572,0,600,5,0,100,1,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000005,1400001,0,'Elmpaw'),
(0,42000006,1400001,0,'Elmpaw'),
(0,42000007,1400001,0,'Elmpaw'),
(0,42000008,1400001,0,'Elmpaw'),
(0,42000009,1400001,0,'Elmpaw'),
(0,42000010,1400001,0,'Elmpaw'),
(0,42000011,1400001,0,'Elmpaw'),
(0,42000012,1400001,0,'Elmpaw'),
(0,42000013,1400001,0,'Elmpaw'),
(0,42000014,1400001,0,'Elmpaw'),
(0,42000015,1400001,0,'Elmpaw'),
(0,42000016,1400001,0,'Elmpaw'),
(0,42000017,1400001,0,'Elmpaw'),
(0,42000018,1400001,0,'Elmpaw'),
(0,42000019,1400001,0,'Elmpaw'),
(0,42000020,1400001,0,'Elmpaw'),
(0,42000021,1400001,0,'Elmpaw'),
(0,42000022,1400001,0,'Elmpaw'),
(0,42000023,1400001,0,'Elmpaw'),
(0,42000024,1400001,0,'Elmpaw'),
(0,42000025,1400001,0,'Elmpaw'),
(0,42000026,1400001,0,'Elmpaw'),
(0,42000027,1400001,0,'Elmpaw'),
(0,42000028,1400001,0,'Elmpaw'),
(0,42000029,1400001,0,'Elmpaw'),
(0,42000030,1400001,0,'Elmpaw'),
(0,42000031,1400001,0,'Elmpaw'),
(0,42000032,1400001,0,'Elmpaw'),
(0,42000033,1400001,0,'Elmpaw'),
(0,42000034,1400001,0,'Elmpaw');
-- 248474 Geosculptor Yip: 3 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400002;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400002,1,'Geosculptor Yip (248474), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000035,248474,0,0,0,'0',0,0,0,-1,0,0,-9082.99,-557.496,60.6945,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000036,248474,0,0,0,'0',0,0,0,-1,0,0,-9085.3,-574.85,61.9363,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000037,248474,0,0,0,'0',0,0,0,-1,0,0,-9071.41,-592.204,62.744,0,600,5,0,100,1,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000035,1400002,0,'Geosculptor Yip'),
(0,42000036,1400002,0,'Geosculptor Yip'),
(0,42000037,1400002,0,'Geosculptor Yip');
-- 257079 Cavalry Scout Alturin: 7 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400003;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400003,1,'Cavalry Scout Alturin (257079), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000038,257079,0,0,0,'0',0,0,0,-1,0,0,-8471.33,-4607.67,20.133,0,600,0,0,100,0,0,0,0,0,'',NULL,0),
(42000039,257079,0,0,0,'0',0,0,0,-1,0,0,-8846.4,-4646.47,29.87,0,600,0,0,100,0,0,0,0,0,'',NULL,0),
(42000040,257079,0,0,0,'0',0,0,0,-1,0,0,-8620.07,-4675.57,14.174,0,600,0,0,100,0,0,0,0,0,'',NULL,0),
(42000041,257079,0,0,0,'0',0,0,0,-1,0,0,-8904.6,-4685.27,27.599,0,600,0,0,100,0,0,0,0,0,'',NULL,0),
(42000042,257079,0,0,0,'0',0,0,0,-1,0,0,-8924,-4704.67,22.906,0,600,0,0,100,0,0,0,0,0,'',NULL,0),
(42000043,257079,0,0,0,'0',0,0,0,-1,0,0,-8975.73,-4762.87,22.632,0,600,0,0,100,0,0,0,0,0,'',NULL,0),
(42000044,257079,0,0,0,'0',0,0,0,-1,0,0,-9040.4,-4840.47,-0.536,0,600,0,0,100,0,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000038,1400003,0,'Cavalry Scout Alturin'),
(0,42000039,1400003,0,'Cavalry Scout Alturin'),
(0,42000040,1400003,0,'Cavalry Scout Alturin'),
(0,42000041,1400003,0,'Cavalry Scout Alturin'),
(0,42000042,1400003,0,'Cavalry Scout Alturin'),
(0,42000043,1400003,0,'Cavalry Scout Alturin'),
(0,42000044,1400003,0,'Cavalry Scout Alturin');
-- 260061 Lieutenant Maclan: 5 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400004;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400004,1,'Lieutenant Maclan (260061), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000045,260061,0,0,0,'0',0,0,0,-1,0,0,-9208.53,-4888.97,56.486,0,300,0,0,100,0,0,0,0,0,'',NULL,0),
(42000046,260061,0,0,0,'0',0,0,0,-1,0,0,-9163.27,-4947.17,38.081,0,300,0,0,100,0,0,0,0,0,'',NULL,0),
(42000047,260061,0,0,0,'0',0,0,0,-1,0,0,-9189.13,-4947.17,39.156,0,300,0,0,100,0,0,0,0,0,'',NULL,0),
(42000048,260061,0,0,0,'0',0,0,0,-1,0,0,-9143.87,-4985.97,36.263,0,300,0,0,100,0,0,0,0,0,'',NULL,0),
(42000049,260061,0,0,0,'0',0,0,0,-1,0,0,-9059.8,-5015.07,38.564,0,300,0,0,100,0,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000045,1400004,0,'Lieutenant Maclan'),
(0,42000046,1400004,0,'Lieutenant Maclan'),
(0,42000047,1400004,0,'Lieutenant Maclan'),
(0,42000048,1400004,0,'Lieutenant Maclan'),
(0,42000049,1400004,0,'Lieutenant Maclan');
-- 263071 Blademaster Kaijo: 3 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400005;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400005,1,'Blademaster Kaijo (263071), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000050,263071,0,0,0,'0',0,0,0,-1,0,0,-7650.07,-4675.57,17.722,0,600,0,0,100,0,0,0,0,0,'',NULL,0),
(42000051,263071,0,0,0,'0',0,0,0,-1,0,0,-7688.87,-4714.37,13.73,0,600,0,0,100,0,0,0,0,0,'',NULL,0),
(42000052,263071,0,0,0,'0',0,0,0,-1,0,0,-7753.53,-4724.07,15.358,0,600,0,0,100,0,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000050,1400005,0,'Blademaster Kaijo'),
(0,42000051,1400005,0,'Blademaster Kaijo'),
(0,42000052,1400005,0,'Blademaster Kaijo');
-- 266851 Ukorsbane: 4 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400006;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400006,1,'Ukorsbane (266851), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000053,266851,1,0,0,'0',0,0,0,-1,0,0,-186.817,-4563.95,64.303,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000054,266851,1,0,0,'0',0,0,0,-1,0,0,-179.767,-4585.1,57.469,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000055,266851,1,0,0,'0',0,0,0,-1,0,0,-183.292,-4606.25,49.88,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000056,266851,1,0,0,'0',0,0,0,-1,0,0,-109.267,-4648.55,34.635,0,600,5,0,100,1,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000053,1400006,0,'Ukorsbane'),
(0,42000054,1400006,0,'Ukorsbane'),
(0,42000055,1400006,0,'Ukorsbane'),
(0,42000056,1400006,0,'Ukorsbane');
-- 266852 Halikor: 8 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400007;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400007,1,'Halikor (266852), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000057,266852,1,0,0,'0',0,0,0,-1,0,0,891.833,-4014.05,-13.425,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000058,266852,1,0,0,'0',0,0,0,-1,0,0,828.383,-4066.93,-12.503,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000059,266852,1,0,0,'0',0,0,0,-1,0,0,786.083,-4098.65,-9.352,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000060,266852,1,0,0,'0',0,0,0,-1,0,0,757.883,-4098.65,-10.097,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000061,266852,1,0,0,'0',0,0,0,-1,0,0,729.683,-4130.38,-6.896,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000062,266852,1,0,0,'0',0,0,0,-1,0,0,976.433,-4204.4,-5.985,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000063,266852,1,0,0,'0',0,0,0,-1,0,0,969.383,-4246.7,-8.023,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000064,266852,1,0,0,'0',0,0,0,-1,0,0,962.333,-4267.85,-8.55,0,600,5,0,100,1,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000057,1400007,0,'Halikor'),
(0,42000058,1400007,0,'Halikor'),
(0,42000059,1400007,0,'Halikor'),
(0,42000060,1400007,0,'Halikor'),
(0,42000061,1400007,0,'Halikor'),
(0,42000062,1400007,0,'Halikor'),
(0,42000063,1400007,0,'Halikor'),
(0,42000064,1400007,0,'Halikor');
-- 266901 Pexmit: 2 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400008;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400008,1,'Pexmit (266901), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000065,266901,1,0,0,'0',0,0,0,-1,0,0,5336.67,-2964.99,1538.26,0,3600,0,0,100,0,0,0,0,0,'',NULL,0),
(42000066,266901,1,0,0,'0',0,0,0,-1,0,0,5165.39,-2992.77,1570.9,0,3600,0,0,100,0,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000065,1400008,0,'Pexmit'),
(0,42000066,1400008,0,'Pexmit');
-- 267182 Ve''ho Manyhorns: 3 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400009;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400009,1,'Ve''ho Manyhorns (267182), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000067,267182,1,0,0,'0',0,0,0,-1,0,0,5549.61,-3555.39,1569.88,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000068,267182,1,0,0,'0',0,0,0,-1,0,0,5494.06,-3555.39,1558.19,0,600,5,0,100,1,0,0,0,0,'',NULL,0),
(42000069,267182,1,0,0,'0',0,0,0,-1,0,0,5517.21,-3569.28,1572.22,0,600,5,0,100,1,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000067,1400009,0,'Ve''ho Manyhorns'),
(0,42000068,1400009,0,'Ve''ho Manyhorns'),
(0,42000069,1400009,0,'Ve''ho Manyhorns');
-- 276180 Elder Finseer: 19 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400010;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400010,1,'Elder Finseer (276180), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000070,276180,0,0,0,'0',0,0,0,-1,0,0,-9291.3,-1144.07,67.869,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000071,276180,0,0,0,'0',0,0,0,-1,0,0,-9226.49,-1164.89,62.336,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000072,276180,0,0,0,'0',0,0,0,-1,0,0,-9258.89,-1178.78,68.634,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000073,276180,0,0,0,'0',0,0,0,-1,0,0,-9240.38,-1192.66,67.709,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000074,276180,0,0,0,'0',0,0,0,-1,0,0,-9282.04,-1192.66,70.609,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000075,276180,0,0,0,'0',0,0,0,-1,0,0,-8976.52,-1199.6,71.754,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000076,276180,0,0,0,'0',0,0,0,-1,0,0,-9258.89,-1199.6,70.968,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000077,276180,0,0,0,'0',0,0,0,-1,0,0,-9018.18,-1206.54,67.103,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000078,276180,0,0,0,'0',0,0,0,-1,0,0,-9147.79,-1213.48,65.354,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000079,276180,0,0,0,'0',0,0,0,-1,0,0,-9166.31,-1213.48,65.287,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000080,276180,0,0,0,'0',0,0,0,-1,0,0,-9203.34,-1213.48,68.095,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000081,276180,0,0,0,'0',0,0,0,-1,0,0,-9078.36,-1220.43,67.214,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000082,276180,0,0,0,'0',0,0,0,-1,0,0,-9022.81,-1227.37,72.06,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000083,276180,0,0,0,'0',0,0,0,-1,0,0,-9207.97,-1227.37,72.573,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000084,276180,0,0,0,'0',0,0,0,-1,0,0,-9189.46,-1234.31,74.002,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000085,276180,0,0,0,'0',0,0,0,-1,0,0,-9059.84,-1241.25,71.102,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000086,276180,0,0,0,'0',0,0,0,-1,0,0,-9161.68,-1241.25,73.757,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000087,276180,0,0,0,'0',0,0,0,-1,0,0,-9078.36,-1248.19,72.339,0,18000,0,0,100,0,0,0,0,0,'',NULL,0),
(42000088,276180,0,0,0,'0',0,0,0,-1,0,0,-9231.12,-1255.13,76.653,0,18000,0,0,100,0,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000070,1400010,0,'Elder Finseer'),
(0,42000071,1400010,0,'Elder Finseer'),
(0,42000072,1400010,0,'Elder Finseer'),
(0,42000073,1400010,0,'Elder Finseer'),
(0,42000074,1400010,0,'Elder Finseer'),
(0,42000075,1400010,0,'Elder Finseer'),
(0,42000076,1400010,0,'Elder Finseer'),
(0,42000077,1400010,0,'Elder Finseer'),
(0,42000078,1400010,0,'Elder Finseer'),
(0,42000079,1400010,0,'Elder Finseer'),
(0,42000080,1400010,0,'Elder Finseer'),
(0,42000081,1400010,0,'Elder Finseer'),
(0,42000082,1400010,0,'Elder Finseer'),
(0,42000083,1400010,0,'Elder Finseer'),
(0,42000084,1400010,0,'Elder Finseer'),
(0,42000085,1400010,0,'Elder Finseer'),
(0,42000086,1400010,0,'Elder Finseer'),
(0,42000087,1400010,0,'Elder Finseer'),
(0,42000088,1400010,0,'Elder Finseer');
-- 276246 Mistmantle Prowler: 9 spots, 1 at a time
DELETE FROM `pool_template` WHERE `entry`=1400011;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1400011,1,'Mistmantle Prowler (276246), one spot at a time');
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(42000089,276246,0,0,0,'0',0,0,0,-1,0,0,-11264.7,-349.267,72.6,0,300,5,0,100,1,0,0,0,0,'',NULL,0),
(42000090,276246,0,0,0,'0',0,0,0,-1,0,0,-11009.1,-1375.27,51.861,0,300,5,0,100,1,0,0,0,0,'',NULL,0),
(42000091,276246,0,0,0,'0',0,0,0,-1,0,0,-10551.9,412.133,35.533,0,300,5,0,100,1,0,0,0,0,'',NULL,0),
(42000092,276246,0,0,0,'0',0,0,0,-1,0,0,-10548.3,-1245.67,30.485,0,300,5,0,100,1,0,0,0,0,'',NULL,0),
(42000093,276246,0,0,0,'0',0,0,0,-1,0,0,-10533.9,-1186.27,28.022,0,300,5,0,100,1,0,0,0,0,'',NULL,0),
(42000094,276246,0,0,0,'0',0,0,0,-1,0,0,-10512.3,-1259.17,41.422,0,300,5,0,100,1,0,0,0,0,'',NULL,0),
(42000095,276246,0,0,0,'0',0,0,0,-1,0,0,-10508.7,-1207.87,27.236,0,300,5,0,100,1,0,0,0,0,'',NULL,0),
(42000096,276246,0,0,0,'0',0,0,0,-1,0,0,-10505.1,-1321.27,39.493,0,300,5,0,100,1,0,0,0,0,'',NULL,0),
(42000097,276246,0,0,0,'0',0,0,0,-1,0,0,-10011.9,-1580.47,27.096,0,300,5,0,100,1,0,0,0,0,'',NULL,0);
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,42000089,1400011,0,'Mistmantle Prowler'),
(0,42000090,1400011,0,'Mistmantle Prowler'),
(0,42000091,1400011,0,'Mistmantle Prowler'),
(0,42000092,1400011,0,'Mistmantle Prowler'),
(0,42000093,1400011,0,'Mistmantle Prowler'),
(0,42000094,1400011,0,'Mistmantle Prowler'),
(0,42000095,1400011,0,'Mistmantle Prowler'),
(0,42000096,1400011,0,'Mistmantle Prowler'),
(0,42000097,1400011,0,'Mistmantle Prowler');
