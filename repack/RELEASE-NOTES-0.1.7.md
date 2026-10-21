WoW Forever Bots 0.1.7 (certificate fix, Onyxia and Majordomo)

Matches the main realm build. Fixes the install step that made the local certificate, adds the Onyxia and Majordomo plans, and fixes the "can't release" bug after a wipe.

**Login and install**
- The certificate step now uses the openssl that ships in the package, with its own settings file, so it no longer fails on PCs where another OpenSSL (for example the one that comes with Git) is installed. Each step is checked, and a half-finished earlier try is thrown away and made again. If it still fails you get a plain message that says which step failed.
- Running Install.cmd again keeps your own config files. Put your own settings in server\worldserver.conf.d\zz-9-local.conf (menu S).
- The game data counts as done only when the install says so, so an interrupted run is finished by running Install.cmd again.
- The updater waits for the database to answer and explains in plain words what went wrong. The package always carries legacy.dll.

**Fixes**
- After a full group wipe in a dungeon or raid the ghost can release again: the encounter now ends properly when a boss resets, and encounters nobody is left alive to fight also end.
- Throw works with a thrown weapon in the ranged slot.
- World bots that got stuck find their way back onto the navigation mesh.

**Onyxia and Majordomo (still being tuned, tell us what you see)**
- Onyxia: the tank holds her with her back to the raid; in phase 2 the tanks take the whelps while she flies; the raid spreads out in flank wedges; bots stay off the lava traps in phase 3; fixed safe spots for every Deep Breath; fire protection potions; a way out of a hazard always comes first.
- Majordomo: one plan (a tank on him away from the raid, tanks on the Elites, up to three Healers sheeped). Your skull on a sheeped Healer is a kill call, your marks alone drive the sheep, and a tank takes your skull or cross mob when nobody holds it.

Update from an earlier release with the Update button (menu U). To install: download WoW-Forever-Bots-0.1.7.zip, unzip it into a folder without spaces in its path (for example C:\WoWForever) and double-click Install.cmd. wow-forever-update-0.1.7.zip is what the Update button downloads. wow-forever-source-0.1.7.zip is the complete source (GPL v2). Checksums: SHA256SUMS.txt.
