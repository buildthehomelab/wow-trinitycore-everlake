// HireMgr - hired bots (Playerbot.Hire.*; the rules are HirePolicy.h). Keeps each hired bot's grade, what was paid for it and how
// long its upkeep is paid, and which accounts chose hired bots (Playerbot.Hire.Mode = 2). Stored in playerbot_v2_character
// (hire_grade, hire_price, hire_paid_until) and playerbot_v2_hire_pref, migration 0037. Reads from any thread, writes on the world
// thread (hiring, upkeep, `.bot hire on|off`).

#pragma once

#include "HirePolicy.h"
#include "../Bot/BotTypes.h"
#include <shared_mutex>
#include <string>
#include <unordered_map>
#include <unordered_set>

class Creature;
class Player;

namespace Playerbot::V2::Fleet {

struct HireRecord
{
    Hire::Grade grade = Hire::Grade::None;
    uint64 price = 0;        // copper paid for the bot (its upkeep is a share of this)
    uint64 paid_until = 0;   // unix seconds; the upkeep is due again from then, the next time the bot is called
};

class HireMgr
{
public:
    static HireMgr& Instance();

    void LoadFromDb();

    // The server's settings, read from the config each call (a `.reload config` takes effect at once).
    static Hire::Mode ConfigMode();
    static Hire::Prices ConfigPrices();
    static float BrokerRange();
    static uint32 MaxPerAccount();          // 0 = no limit
    static uint32 LegendMaxPerAccount();    // 0 = no limit

    // Whether `player` must hire companions instead of making them (Hire::Required with the player's choice and GM bypass).
    bool MustHire(Player const* player) const;
    // The same for the account owning a bot (its owner offline: the account's choice, no GM bypass).
    bool MustHireAccount(uint32 account_id) const;

    bool OptedIn(uint32 account_id) const;
    void SetOptedIn(uint32 account_id, bool on);

    HireRecord RecordOf(BotId bot) const;
    // A bot was hired for `price`: its first day is paid.
    void SetHired(BotId bot, Hire::Grade grade, uint64 price);
    void Forget(BotId bot);
    uint32 CountGrade(uint32 account_id, Hire::Grade grade) const;

    // The gear mode a companion wears under hired mode (Gear::Owned::GearMode value), -1 when the owner's own choice stands.
    int GearModeOverride(BotId bot, uint32 owner_account) const;

    // The broker NPC within Playerbot.Hire.BrokerRange of `player` that sells `grade`, or nullptr. World thread.
    Creature* NearbyBroker(Player* player, Hire::Grade grade) const;
    // Whether a new bot for `player` fills a raid place: a raid group, or an instance for more than 5.
    static bool RaidPlace(Player* player);
    // The price `player` pays for one bot of `grade` here (0 = not for sale at this level).
    static uint64 PriceHere(Player* player, Hire::Grade grade);

    // A companion of `owner` is being called: takes the day's upkeep when it is due. False (and `why` says so) when the owner cannot
    // pay; the bot then stays home. World thread.
    bool TakeUpkeep(Player* owner, BotId bot, std::string const& bot_name, std::string& why);

    // A hired bot that was just called by an add (Quick party sends one `.bot add` per place) is not picked again for the next
    // place while it logs in.
    void NoteCalled(BotId bot, uint32 now_ms);
    bool RecentlyCalled(BotId bot, uint32 now_ms) const;

private:
    mutable std::shared_mutex mtx_;
    std::unordered_map<BotId, HireRecord> hired_;
    std::unordered_set<uint32> opted_in_;
    std::unordered_map<BotId, uint32> called_ms_;
};

}  // namespace Playerbot::V2::Fleet
