-- WoW Forever: Darkspear Islands capture point announcements (map 2997, battleground_darkspear_islands).
-- The four capture points (637673 Camp, 637674 Ruins, 637675 Abandoned Tower, 637677 Shipwreck Cove) name broadcast texts
-- 310228-310252 (except 310237) for assault / capture / defend per team, but the texts are in no data we have: not in
-- the client's BroadcastText (encrypted section), not in any hotfix push up to 71139, not in the EG Link text sets.
-- Without the rows the core skips the announcement. These are OUR wording, in Arathi Basin's exact pattern (broadcast
-- texts 10199-10204: "$n has assaulted the Stables!", "$n has defended the Stables!", "The Horde has taken the
-- Stables!") with the base names from AreaTable 16607-16610; each id keeps the slot its capture point gives it.
-- Server only (no hotfix_data): the battleground sends the finished line in the chat packet. Only our own rows
-- (VerifiedBuild 0) are replaced. The core loads VerifiedBuild 0 rows after the real ones, so they would override a real
-- text: any id that already has a real row loses ours here, and a later hotfix import that brings the real texts should
-- delete these VerifiedBuild 0 rows. Safe to run again.

DELETE FROM `broadcast_text` WHERE `ID` IN (310228,310229,310230,310231,310232,310233,310234,310235,310236,310238,310239,310240,310241,310242,310243,310244,310245,310246,310247,310248,310249,310250,310251,310252) AND `VerifiedBuild` = 0;
INSERT INTO `broadcast_text` (`Text`,`Text1`,`ID`,`LanguageID`,`ConditionID`,`EmotesID`,`Flags`,`ChatBubbleDurationMs`,`VoiceOverPriorityID`,`SoundKitID1`,`SoundKitID2`,`EmoteID1`,`EmoteID2`,`EmoteID3`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`VerifiedBuild`) VALUES
('$n has assaulted the Camp!','',310228,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('The Horde has taken the Camp!','',310229,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has defended the Camp!','',310230,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('The Alliance has taken the Camp!','',310231,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has defended the Camp!','',310232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has assaulted the Camp!','',310233,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('The Horde has taken the Ruins!','',310234,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('The Alliance has taken the Ruins!','',310235,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has defended the Ruins!','',310236,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has defended the Ruins!','',310238,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has assaulted the Ruins!','',310239,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has assaulted the Ruins!','',310240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has defended Shipwreck Cove!','',310241,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has defended Shipwreck Cove!','',310242,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has assaulted Shipwreck Cove!','',310243,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has assaulted Shipwreck Cove!','',310244,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('The Horde has taken Shipwreck Cove!','',310245,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('The Alliance has taken Shipwreck Cove!','',310246,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('The Horde has taken the Abandoned Tower!','',310247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('The Alliance has taken the Abandoned Tower!','',310248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has defended the Abandoned Tower!','',310249,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has defended the Abandoned Tower!','',310250,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has assaulted the Abandoned Tower!','',310251,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
('$n has assaulted the Abandoned Tower!','',310252,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE c FROM `broadcast_text` c JOIN `broadcast_text` r ON r.`ID` = c.`ID` AND r.`VerifiedBuild` > 0
WHERE c.`VerifiedBuild` = 0 AND c.`ID` IN (310228,310229,310230,310231,310232,310233,310234,310235,310236,310238,310239,310240,310241,310242,310243,310244,310245,310246,310247,310248,310249,310250,310251,310252);
