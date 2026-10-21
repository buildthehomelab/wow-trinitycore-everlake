# Whisper: bisecting the feature-status flags

Client 70205/70291 has no native `/w`: `SlashCmdList.SMART_WHISPER` is nil, typed `/w` and the unit menu's `/cw` fall through to
Say. Whispers sent by `SendChatMessage(..., "WHISPER")` reach the server and work, so the server's chat path is fine; the client
Lua switches its own handler off. Suspect: `SMSG_FEATURE_SYSTEM_STATUS` (`WorldSession::SendFeatureSystemStatus`), rewritten by the
merge 4ba34433 (2026-10-07) (the official values are now always sent, the Classic.OfficialFeatureFlags switch is gone).

Each login logs `[feature_status] ...` (logger `playerbot.v2`) with the values actually sent.

Steps (addon ForeverBots disabled in the character-select AddOns list, so only the client's own /w is tested):
1. Baseline, defaults: outside a BG, type `/w <bot> hi`. Expected today: nothing sent.
2. (removed: the official flag set is the only one sent now; start step 3 with the logged values.)
3. One `Classic.Feature.<Key>` at a time (set to the opposite of the logged value,
   `.reload config`, relog, retest). Order: VoiceChatParentalDisabled, FriendsDisabled, SpeakForMeAllowed,
   VoiceEnabled, NetEaseChatTelemetryEnabled, the two UserGeneratedContent keys, the two AADC keys, SocialRestriction.
4. The key that restores `/w` is the cause; fix its default in `SendFeatureSystemStatus` and drop the others.
5. In a BG (also with the addon disabled): `/w`, portrait Whisper, then `/dance`. The "secret keys" error in HandleChatType is the
   client's chat lockdown; note whether it still occurs with the winning setting.
