// BotNamePool — central allocator for bot character names backed by
// the pre-curated `wowc_playerbot.playerbots_names` table (107K rows).
//
// Each call to Acquire(gender) picks an unused name and atomically
// flags it as taken. Names are released on bot deletion. On boot,
// ReconcileOnBoot() walks the table and frees names whose used_by_guid
// no longer maps to an existing characters row — this catches manual
// SQL wipes that didn't release names through the C++ delete paths.
//
// Why a pool instead of the syllable generator (BotComposition::
// RollUniqueName): the syllable generator can produce names that fail
// `ObjectMgr::CheckPlayerName` (triple-consonant rule, banned words,
// length-after-suffix). The curated pool contains real human names that
// have already passed validation, so name-side Create failures vanish.

#pragma once

#include "Bot/BotTypes.h"
#include <string>

namespace Playerbot::V2::Fleet {

class BotNamePool
{
public:
    // Reserve a name from the pool. Filters by gender so the name fits
    // the character's appearance (the table has gender=0 male, 1 female,
    // 2 universal — universal names match any gender). Returns empty if
    // the pool is exhausted (caller should fall back to syllable gen).
    //
    // Cross-DB: the names table lives in `wowc_playerbot`, but the
    // `playerbot` MySQL user has access to both schemas, so the queries
    // explicitly qualify with `wowc_playerbot.playerbots_names`.
    static std::string Acquire(uint8 gender);

    // Full-name allocation: excludes local characters and player reservations on every realm.
    static std::string AcquireSurname(std::string const& name, uint8 race);

    // Bind a previously-acquired name to a created character. Stores
    // the character's guid in used_by_guid so the row can be reverse-
    // looked-up from `.playerbot wipe` and from ReconcileOnBoot.
    static void BindToCharacter(std::string const& name, uint64 guid_low);

    // Release a name back to the pool — called when a bot is deleted
    // (via hygiene cron or `.playerbot delete`). No-op if the name was
    // never in our pool (e.g. legacy V1 syllable names).
    static void Release(std::string const& name);

    // Boot-time housekeeping: scans is_used=1 rows and clears the flag
    // when the referenced character no longer exists. Covers the SQL-
    // wipe case where the DBA bypassed the C++ delete path. Cheap;
    // one JOIN scan per boot.
    static void ReconcileOnBoot();

    // Everlake name reservation (NameReservationMgr, login database). Bots never reserve a name and never take one a
    // player holds:
    //  - AcquireSurname skips held full names;
    //  - pool accounts are exempt from reserving (a GM rename or dump load onto a bot account reserves nothing);
    //  - a player who may claim a bot's full name gets it immediately, even if the bot is online.
    // Startup also assigns surnames to legacy bots. Call after the account pool loads, before bots log in.
    static void RegisterNameReservationHooks();
    static uint32 RenameBotsHoldingReservedNames();

    // Diagnostic — returns (available, total) for /popstats.
    struct PoolStats { uint32 available; uint32 total; };
    static PoolStats GetStats();
};

} // namespace Playerbot::V2::Fleet
