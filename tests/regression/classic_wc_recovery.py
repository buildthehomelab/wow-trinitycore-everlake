"""Compile the real Classic reset and instance state methods with minimal test doubles.

Run: python3 tests/regression/classic_wc_recovery.py [path-to-core-root]
Requires a C++17 compiler (CXX or c++). This does not start a worldserver.
"""
import os
from pathlib import Path
import shlex
import subprocess
import sys
import tempfile


def definition(text, signature):
    start = text.index(signature)
    pos = text.index("{", start)
    depth = 1
    while depth:
        pos += 1
        depth += (text[pos] == "{") - (text[pos] == "}")
    return text[start:pos + 1]


root = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parents[2]
folder = root / "src/server/scripts/Custom/Classic/instances/wailing_caverns"
escort = (folder / "classic_wailing_caverns.cpp").read_text()
instance = (folder / "classic_instance_wailing_caverns.cpp").read_text()
header = (folder / "classic_wailing_caverns.h").read_text()
code = r'''
#include <array>
#include <cstdint>
#include <iostream>
#include <stdexcept>
#include <vector>
using uint32 = std::uint32_t;
using ObjectGuid = int;
#define override
#define TC_LOG_ERROR(...)
#define TC_LOG_DEBUG(...)
constexpr uint32 NOT_STARTED=0, IN_PROGRESS=1, FAIL=2, DONE=3, SPECIAL=4;
constexpr int INTERACTION_DISTANCE=5;
[[maybe_unused]] constexpr int STATE_ESCORT_ESCORTING=1;
struct Loot { bool isLooted() const { return false; } };
struct Creature {
    Loot* m_loot=nullptr;
    bool IsAlive() const { return false; }
    Creature* FindNearestCreature(uint32, float) { return nullptr; }
    void DisappearAndDie() { }
    void DespawnOrUnsummon() { }
};
struct FakeMap { Creature* GetCreature(ObjectGuid) { return nullptr; } };
void ClassicScriptText(uint32, Creature*) { }
''' + definition(header, "enum ClassicWailingCavernsData") + r''';
struct InstanceScript {
    FakeMap map;
    FakeMap* instance=&map;
    std::array<uint32, CWC_MAX_ENCOUNTER> states{DONE,DONE,DONE,DONE,IN_PROGRESS,NOT_STARTED};
    bool Assaulted=true;
    ObjectGuid m_uiAnacondraGUID=0, m_uiDiscipleGUID=0;
    std::vector<ObjectGuid> vNightmareMonsters;
    int writes=0;
    uint32 Enc(uint32 index) const { return states.at(index); }
    void SetEnc(uint32 index, uint32 value) { states.at(index)=value; ++writes; }
    void DoSerpentisYell() { }
''' + definition(instance, "void SetData(") + "\n" + definition(instance, "uint32 GetData(") + r'''
};
struct Disciple {
    InstanceScript* m_pInstance;
    bool escorting;
    uint32 Event_Timer=123, Sleep_Timer=0, Potion_Timer=0, Cleansing_Timer=0;
    int Point=30, Subevent_Phase=8;
    bool Yelled=true, isAggro=true;
    bool HasEscortState(int) const { return escorting; }
''' + definition(escort, "void Initialize()") + "\n" + definition(escort, "void Reset() override") + r'''
};
void check(bool valid, char const* message) { if (!valid) throw std::runtime_error(message); }
int main() {
    try {
        InstanceScript afterWipe;
        Disciple retry{&afterWipe,false};
        retry.Reset();
        check(afterWipe.GetData(CWC_TYPE_DISCIPLE)==SPECIAL, "respawn after wipe must re-arm gossip");
        check(retry.Point==0 && retry.Subevent_Phase==0, "retry must reset escort-local counters");

        InstanceScript incomplete;
        incomplete.states[CWC_TYPE_SERPENTIS]=NOT_STARTED;
        Disciple blocked{&incomplete,false};
        blocked.Reset();
        check(incomplete.GetData(CWC_TYPE_DISCIPLE)==NOT_STARTED, "prerequisite gate must remain closed");

        InstanceScript afterLoad;
        afterLoad.states[CWC_TYPE_DISCIPLE]=NOT_STARTED;
        Disciple loaded{&afterLoad,false};
        loaded.Reset();
        check(afterLoad.GetData(CWC_TYPE_DISCIPLE)==SPECIAL, "loaded prerequisites must re-arm eligible ritual");

        InstanceScript afterFailure;
        afterFailure.states[CWC_TYPE_DISCIPLE]=FAIL;
        Disciple failed{&afterFailure,false};
        failed.Reset();
        check(afterFailure.GetData(CWC_TYPE_DISCIPLE)==SPECIAL, "failed unfinished ritual can retry");

        InstanceScript active;
        Disciple running{&active,true};
        running.Reset();
        check(active.GetData(CWC_TYPE_DISCIPLE)==IN_PROGRESS && active.writes==0, "active escort instance state must remain unchanged");

        InstanceScript eligible;
        eligible.states[CWC_TYPE_DISCIPLE]=SPECIAL;
        Disciple ready{&eligible,false};
        ready.Reset();
        check(eligible.GetData(CWC_TYPE_DISCIPLE)==SPECIAL && eligible.writes==0, "already armed gossip must not re-arm/yell");

        InstanceScript completed;
        completed.states[CWC_TYPE_DISCIPLE]=DONE;
        Disciple finished{&completed,false};
        finished.Reset();
        check(completed.GetData(CWC_TYPE_DISCIPLE)==DONE && completed.writes==0, "completed ritual cannot reopen");

        InstanceScript killed;
        killed.states[CWC_TYPE_MUTANUS]=DONE;
        Disciple deadBoss{&killed,false};
        deadBoss.Reset();
        check(killed.GetData(CWC_TYPE_MUTANUS)==DONE && killed.writes==0, "completed Mutanus cannot be replayed");

        Disciple noInstance{nullptr,false};
        noInstance.Reset();
        check(noInstance.Point==0, "reset without an instance still resets local counters");
    } catch (std::exception const& error) {
        std::cerr << error.what() << '\n';
        return 1;
    }
    std::cout << "Wailing Caverns recovery: all nine cases passed\n";
}
'''
with tempfile.TemporaryDirectory(prefix="classic-wc-recovery-") as temp:
    source = Path(temp) / "recovery.cpp"
    executable = Path(temp) / "recovery"
    source.write_text(code)
    subprocess.run(shlex.split(os.environ.get("CXX", "c++")) +
                   ["-std=c++17", "-Wall", "-Wextra", "-Werror", str(source), "-o", str(executable)], check=True)
    subprocess.run([str(executable)], check=True)
