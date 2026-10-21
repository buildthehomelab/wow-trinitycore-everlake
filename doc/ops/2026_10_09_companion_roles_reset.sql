-- ONE-OFF, FOR REVIEW. NOT applied by anything: it lives outside sql/playerbot_v2 so no migration run picks it up.
-- Run it by hand, in the characters schema, with the worldserver stopped, only after chris says OK and a backup exists
-- (scripts\install.ps1 makes a verified one; a plain `mysqldump <characters schema>` works too).
--
-- Why: before the fix in Fleet/CompanionRole.h, the login and the 5-minute upkeep stored a role inferred from the talents,
-- read before the setup step had spent the points. Stormwind 2026-10-09: 285 owned rows, many healers stored as dps
-- (priest role 3 x9, paladin role 3 x6, druid role 3 x12) and hybrids stored as tank (paladin role 1 x11, druid role 1 x6).
-- A stored guess cannot be told apart from a role the owner chose (`.bot add <class> healer`), so the hybrid/healer classes
-- are cleared as a group: priest 5, paladin 2, druid 11, shaman 7. Cleared = "not declared": the companion reads its live
-- talents again, and the raid quota fill (RaidBrain, 3 healers per 10 members, 4 tanks from 25) hands out healer and tank
-- roles again and stores them as chosen ones. Warriors, rogues, mages, warlocks, hunters are left alone.
--
-- Caveat: a cleared companion whose talents were respecced to a dps build by the stored role stays a dps until the quota
-- fill (or `.bot role healer` / the panel's role buttons) chooses for it; the quota fill picks lowest guid first.
-- companion_role: 0 = none, 1 = tank, 2 = healer, 3 = dps.

-- 1. REVIEW FIRST: what would change.
SELECT c.class, p.companion_role, COUNT(*) AS bots
  FROM playerbot_v2_character p
  JOIN characters c ON c.guid = p.character_guid_low
 WHERE p.owner_account_id <> 0 AND c.class IN (5, 2, 11, 7) AND p.companion_role <> 0
 GROUP BY c.class, p.companion_role
 ORDER BY c.class, p.companion_role;

-- 2. THE CHANGE.
UPDATE playerbot_v2_character p
  JOIN characters c ON c.guid = p.character_guid_low
   SET p.companion_role = 0
 WHERE p.owner_account_id <> 0 AND c.class IN (5, 2, 11, 7) AND p.companion_role <> 0;

-- 3. CHECK: should list nothing for these classes now.
SELECT c.class, p.companion_role, COUNT(*) AS bots
  FROM playerbot_v2_character p
  JOIN characters c ON c.guid = p.character_guid_low
 WHERE p.owner_account_id <> 0 AND c.class IN (5, 2, 11, 7) AND p.companion_role <> 0
 GROUP BY c.class, p.companion_role;
