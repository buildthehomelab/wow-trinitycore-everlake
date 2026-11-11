"""Compile the real shrine completion and Update methods with minimal test doubles.

Run: python3 tests/regression/classic_bfd_wave_completion.py [path-to-core-root]
Requires a C++17 compiler (CXX or c++). Summoning and door operations are stubbed.
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
folder = root / "src/server/scripts/Custom/Classic/instances/blackfathom_deeps"
instance = (folder / "classic_instance_blackfathom_deeps.cpp").read_text()
header = (folder / "classic_blackfathom_deeps.h").read_text()
code = r'''
#include <cstdint>
#include <iostream>
#include <list>
#include <map>
#include <stdexcept>
using uint8 = std::uint8_t;
using uint32 = std::uint32_t;
using ObjectGuid = int;
#define override
constexpr uint32 IN_PROGRESS=1, DONE=3;
struct Creature { bool alive=true; bool IsAlive() const { return alive; } };
struct FakeMap {
    std::map<ObjectGuid, Creature> mobs;
    Creature* GetCreature(ObjectGuid guid) {
        auto it=mobs.find(guid);
        return it == mobs.end() ? nullptr : &it->second;
    }
};
struct Tracker { void Update(uint32) { } };
''' + definition(header, "enum ClassicBlackfathomDeepsData") + r''';
struct InstanceScript {
    FakeMap map;
    FakeMap* instance=&map;
    Tracker _encounterTracker;
    uint32 state=IN_PROGRESS;
    bool doorOpened=false;
    uint8 m_uiShrinesLit=4;
    uint32 m_uiCheckEventEnd=5000;
    uint32 m_uiSpawnMobsTimer[4]{3000,3000,3000,3000};
    std::list<ObjectGuid> m_lWaveMobsGUIDList;
    int wavesSpawned=0;
    uint32 Enc(uint32) const { return state; }
    void SetData(uint32, uint32 value) { state=value; doorOpened=value==DONE; }
    void DoSpawnMobs(uint8 wave) {
        ObjectGuid guid=wave+1;
        map.mobs[guid]=Creature{};
        m_lWaveMobsGUIDList.push_back(guid);
        ++wavesSpawned;
    }
''' + definition(instance, "bool IsWaveEventFinished()") + "\n" + definition(instance, "void Update(uint32 diff) override") + r'''
};
void check(bool valid, char const* message) { if (!valid) throw std::runtime_error(message); }
int main() {
    try {
        InstanceScript run;
        run.Update(5000);
        check(run.state==IN_PROGRESS && !run.doorOpened, "long tick opened door before queued waves were killed");
        check(run.wavesSpawned==4, "queued waves must still dispatch on the long tick");
        run.Update(1000);
        check(run.state==IN_PROGRESS && !run.doorOpened, "living wave mobs must block completion");
        for (auto& pair : run.map.mobs) pair.second.alive=false;
        run.Update(1000);
        check(run.state==DONE && run.doorOpened, "door must open after queued waves are dead");

        InstanceScript partial;
        partial.m_uiSpawnMobsTimer[0]=0;
        partial.m_uiSpawnMobsTimer[1]=0;
        partial.m_uiSpawnMobsTimer[2]=0;
        check(!partial.IsWaveEventFinished(), "a single pending timer must block completion");
        partial.m_uiSpawnMobsTimer[3]=0;
        partial.m_uiShrinesLit=3;
        check(!partial.IsWaveEventFinished(), "all four fires must still be required");
        partial.m_uiShrinesLit=4;
        check(partial.IsWaveEventFinished(), "drained queues and no live mobs can complete");
    } catch (std::exception const& error) {
        std::cerr << error.what() << '\n';
        return 1;
    }
    std::cout << "Blackfathom wave completion: all seven checks passed\n";
}
'''
with tempfile.TemporaryDirectory(prefix="classic-bfd-waves-") as temp:
    source = Path(temp) / "waves.cpp"
    executable = Path(temp) / "waves"
    source.write_text(code)
    subprocess.run(shlex.split(os.environ.get("CXX", "c++")) +
                   ["-std=c++17", "-Wall", "-Wextra", "-Werror", str(source), "-o", str(executable)], check=True)
    subprocess.run([str(executable)], check=True)
