// HealerIdleSay.h - a healer that has not healed a hurt group member for a while says why in party chat, when the reason is one the
// player can fix: the member is out of its sight, out of its range, or it is out of mana. "The healer does nothing" was the most common
// bot report (2026-11-27), and the reason was only in the server log ([heal_idle_reason], State_InCombat CombatIdleProbe).
//
// Only these three causes are said: moving clears itself, and a rule that held the heal (a threat hold, a raid mana rule) or "no rule
// acted" is the bot's own business, not something the player can do anything about. At most one line per kHealerSayGapMs, and the same
// cause again only after kHealerSameCauseMs, so a long fight out of sight is one line, not one every few seconds.
// Pure: tested in tests/game/HealerIdleSay.cpp.
#pragma once

#include <cstdint>
#include <string>

namespace Playerbot::HealerSay {

enum class Cause : uint8_t { None, OutOfSight, OutOfRange, OutOfMana, Moving, Other };

constexpr float    kHealRangeYd       = 40.0f;
constexpr int      kOutOfManaPct      = 10;
constexpr int      kSayBelowPct       = 60;       // the hurt member is below this
constexpr uint32_t kSayAfterIdleMs    = 4000u;    // with no heal for this long
constexpr uint32_t kHealerSayGapMs    = 30000u;   // at most one line in this time
constexpr uint32_t kHealerSameCauseMs = 60000u;   // the same cause again only after this

// The same order as the [heal_idle_reason] log line.
inline Cause Classify(bool in_los, float dist, bool moving, int mana_pct)
{
    if (!in_los)                return Cause::OutOfSight;
    if (dist > kHealRangeYd)    return Cause::OutOfRange;
    if (moving)                 return Cause::Moving;
    if (mana_pct < kOutOfManaPct) return Cause::OutOfMana;
    return Cause::Other;
}

struct SayState
{
    uint32_t last_ms = 0;
    Cause    last_cause = Cause::None;
};

// Whether to say it now; records the line when it returns true.
inline bool SayDue(SayState& st, Cause cause, int hurt_pct, uint32_t idle_ms, uint32_t now_ms)
{
    if (cause != Cause::OutOfSight && cause != Cause::OutOfRange && cause != Cause::OutOfMana)
        return false;
    if (hurt_pct >= kSayBelowPct || idle_ms < kSayAfterIdleMs)
        return false;
    if (st.last_ms != 0)
    {
        uint32_t const since = now_ms - st.last_ms;
        if (since < kHealerSayGapMs || (cause == st.last_cause && since < kHealerSameCauseMs))
            return false;
    }
    st.last_ms = now_ms ? now_ms : 1u;
    st.last_cause = cause;
    return true;
}

// The line, about `who` (the hurt member's name; may be empty).
inline std::string Line(Cause cause, std::string const& who)
{
    std::string const name = who.empty() ? std::string("you") : who;
    switch (cause)
    {
        case Cause::OutOfSight: return "I can't see " + name + " from here to heal.";
        case Cause::OutOfRange: return name + " is too far away for my heals.";
        case Cause::OutOfMana:  return "I'm out of mana, I can't heal.";
        default:                return std::string();
    }
}

}  // namespace Playerbot::HealerSay
