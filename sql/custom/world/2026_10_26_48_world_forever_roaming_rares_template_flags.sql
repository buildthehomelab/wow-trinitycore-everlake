-- Spawns: the roaming rares of _44 took AnoCore's 0 for npcflag and unit_flags, which AnoCore reads as "use the template".
-- Here 0 overrides the template, so the spawns go back to NULL (template flags).
UPDATE `creature` SET `npcflag`=NULL, `unit_flags`=NULL, `unit_flags2`=NULL, `unit_flags3`=NULL WHERE `guid` BETWEEN 42000000 AND 42000097;
