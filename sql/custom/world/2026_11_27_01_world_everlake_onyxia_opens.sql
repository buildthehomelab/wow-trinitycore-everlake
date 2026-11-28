-- Everlake (user decision 2026-11-27): Onyxia's Lair opens by itself on 2026-12-09, the day WoW Forever opens its first raids
-- (tracker phase "first-raids"). 2026_11_19_83_world_everlake_close_vanilla_raids.sql closed the lair (map disable) and hid the
-- six Head of Onyxia quests (quest disables). Those rows stay; `disables_game_event` lifts them while game event 131 runs.
-- Event 131 starts 2026-12-09 15:00 UTC (game_event times are UTC; 10:00 in Toronto) and stays on: occurence = length, ten years.
-- Blizzard gave the date, not the hour: move start_time if Forever opens at another time.
-- The timed Rallying Cry (Classic.WorldBuffs) keeps running next to real head turn-ins (user, 2026-11-27).

CREATE TABLE IF NOT EXISTS `disables_game_event` (
  `sourceType` int unsigned NOT NULL COMMENT 'disables.sourceType',
  `entry` int unsigned NOT NULL COMMENT 'disables.entry',
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'game_event.eventEntry: the disable does not apply while this event runs',
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`sourceType`,`entry`,`eventEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Everlake: disables lifted while a game event runs';

DELETE FROM `game_event` WHERE `eventEntry` = 131;
INSERT INTO `game_event` (`eventEntry`,`start_time`,`end_time`,`occurence`,`length`,`holiday`,`holidayStage`,`WorldStateId`,`description`,`world_event`,`announce`) VALUES
(131,'2026-12-09 15:00:00','2036-12-09 15:00:00',5256000,5256000,0,0,NULL,'WoW Forever first raids: Onyxia''s Lair opens',0,0);

DELETE FROM `disables_game_event` WHERE `eventEntry` = 131;
INSERT INTO `disables_game_event` (`sourceType`,`entry`,`eventEntry`,`comment`) VALUES
(2,249,131,'Onyxia''s Lair'),
(1,7490,131,'Victory for the Horde'),
(1,7491,131,'For All To See'),
(1,7493,131,'The Journey Has Just Begun (Horde)'),
(1,7495,131,'Victory for the Alliance'),
(1,7496,131,'Celebrating Good Times'),
(1,7497,131,'The Journey Has Just Begun (Alliance)');
