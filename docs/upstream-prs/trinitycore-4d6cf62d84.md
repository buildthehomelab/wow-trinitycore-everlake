# TrinityCore 4d6cf62d84: no entering dungeons while a boss fight is on

Thor1423, 2026-10-01, TrinityCore#31980 (cherry-picked from e490cad2b0). Reviewed 2026-11-09 against `everlake`
029c5dd9ca.

**Claim.** `InstanceMap::CannotEnter` refused entry with `TRANSFER_ABORT_ZONE_IN_COMBAT` only in raids while a boss was
`IN_PROGRESS`. The commit drops `IsRaid()`, so 5-player dungeons refuse it too (relogging inside stays allowed).

**Check.** A gameplay rule, not a bug fix, and it touches Forever's own line: Forever lets companion bots in during a
fight (`!player->GetSession()->IsBot()`, so a bot group is not left outside while its owner fights) and keeps the
raid-only rule. With the change, a player who dies, releases and runs back cannot enter a dungeon while the rest of
the group is still fighting a boss with an instance script. Not checked what Classic Era or live Forever do for
5-player dungeons. The pick conflicts on that line; the resolution would be Forever's line without `IsRaid()`, keeping
the bot exception.

**Test.** None.

**Verdict:** hold, for the user to decide: raids only (as now) or dungeons too.
