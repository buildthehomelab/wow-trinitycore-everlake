# Build and test tools (cloud check, scenario watcher, Ninja build)

## 1. Cloud compile + unit tests: `scripts/cloud-check.sh`
Any cloud thread, from the checkout:

    scripts/cloud-check.sh setup        # once: apt packages (ccache, ninja, boost, mysql client, GCC 13) + cmake configure into build-cloud/
    scripts/cloud-check.sh compile      # only the files changed against origin/trunk plus uncommitted edits (seconds with a warm cache)
    scripts/cloud-check.sh tests        # build the `tests` (and `tools_tests`) targets and run ctest; `tests -R ClassicSpellRank` or `-L label` narrows the ctest run
    scripts/cloud-check.sh all          # compile, then tests

`compile` maps each changed .cpp to its object file through compile_commands.json and asks Ninja for just those; a changed header
rebuilds every object that includes it (Ninja's dependency log, available after the first full build). A new .cpp triggers a reconfigure.
GCC 13, `-DBUILD_PLAYERBOT_V2=1`, `-DBUILD_TESTING=1`, ccache with `CCACHE_SLOPPINESS=pch_defines,time_macros,include_file_mtime,include_file_ctime`.
Green here is strong evidence, not proof, that MSVC builds (GCC and MSVC disagree on a few things). It cannot run the server or scenarios.
The first `tests` build compiles the whole game library; later runs are cache hits.

## 2. PC watcher: `scripts\scenario-watch.ps1`
Runs scenarios over SOAP (through run-scenario.ps1, credentials stay in secrets\) and publishes results to branch `scenario-reports`
of the repo from a separate clone `<root>\reports-git`. Threads read `latest/summary.md` and `latest/<scenario>.txt` (failures carry
the Scenario.log block and the tagged Playerbot.log lines of that run, secrets blanked). History in `runs/<utc>_<commit>/` (newest 20).

    .\scenario-watch.ps1 -Probe                                  # read-only: can this PC reach and push to the repo?
    .\scenario-watch.ps1 -Scenarios deadmines_full,mc_garr       # after a server is up on the new build
    .\scenario-watch.ps1 -All                                    # the dungeon set
    .\scenario-watch.ps1 -Watch -Scenarios deadmines_full        # waits for install.ps1 to finish a NEW build, starts servers if none run, runs, publishes
    add -NoPush to keep the report on the PC only

If the push is refused, the commit stays in reports-git and goes out with the next successful push; the report is also in
`reports-git\latest\` to attach by hand. It never stops a server and never installs anything.

## 3. Faster PC build: `scripts\build-fast.ps1`
Ninja in `build-ninja\` beside the Visual Studio `build\` (untouched). CMake settings are copied from `build\CMakeCache.txt`.
Same 75% CPU / below-normal rule. `-Bench` times a no-op build and a one-file edit so the gain is measured, not assumed.
Install a Ninja build with `.\install.ps1 -Commit <hash> -BuildDir build-ninja`. sccache is off by default (it cannot cache
precompiled-header compiles); the first Ninja build is a full rebuild.
