# WoW Forever + Bots: playtest build

Unofficial fan project, not endorsed by Blizzard. Playtest software: it will break. Play on a private local server only.
Your feedback is the point: please report what goes wrong (see the end).

## You need
- Windows 10/11 64-bit, 16 GB RAM (8 GB works with the small bot preset), 4+ cores, about 25 GB free disk.
- Your own WoW Forever client at the build this release names (shown in the release notes and by the installer, which also warns if your client has another build). Copy the client folder first and do not let Battle.net patch the copy; a client of another build logs in to Battle.net but sees no realms.
- Administrator rights once (hosts entry and a local certificate).
- The **ForeverBots addon** (included; Install.cmd installs it). It is required: this client cannot whisper bots without it.

## Install
1. Download **WoW-Forever-Bots-<version>.zip** from the Releases page and unzip it into a folder with no spaces, for example `C:\WoWForever`.
2. Double-click **Install.cmd**. Windows asks once for permission (needed for the local certificate and hosts line). It then does everything: sets up the database, finds your game folder (or asks you to pick it), extracts the maps from your own client (the slow part: about 10 to 20 minutes on a modern PC, longer on an older one), makes the certificate, installs the ForeverBots add-on, creates two shortcuts on the Desktop and in the Start Menu ("WoW Forever" opens the launcher window, "WoW Forever Bots" the control panel), starts the server, opens the menu and prints how to log in. If it is interrupted, run Install.cmd again: finished steps are skipped.
3. The installer offers to create your account (name, password typed twice, optional GM): say yes. Later, menu key A does it. Then start the game with Play-WoWForever.cmd (or P in the control panel), keep its window open, log in, realm Trinity. At character select, open AddOns and make sure ForeverBots is ticked.
Details if you prefer to do it by hand: `repack\first-run.ps1` (database and settings), `repack\extract-data.ps1 -Client <game folder>` (maps), `repack\make-certs.ps1` (as Administrator), `repack\install-addon.ps1`, `repack\Start-WoWForever.ps1`. No game data (maps) is included in the package; nothing from Blizzard is downloaded or shipped.

## The menu
`WoW-Forever-Bots.cmd` (the one "WoW Forever Bots" shortcut on the Desktop / Start Menu) is a control panel in one window that stays open: banner, a status line (version, core, server RUNNING/STOPPED, players online, restarter on/off) and keys **1** Start server, **2** Stop server, **3** Restart server, **T** Restarter mode (restarts the server by itself if it crashes; gives up after 5 crashes in 10 minutes), **A** Create account (name, password, optional GM; the running server creates it, nothing is written to the database by hand), **S** Server settings (opens your own override file in Notepad; survives updates), **B** Backup now / restore, **U** Update, **D** Join our Discord, **H** Help, **0** Exit (the server keeps running).

## Play with bots
`.summon all` calls your bots; the addon has Call and role buttons. To talk to a bot use `/w`, `/whisper`, `/t`, `/tell` or `/cw` (they work through the addon; without it nothing happens). Commands: see BOT_COMMANDS.pdf.

## Joining a friend's server
The launcher window has a server list: **Add...** a server by name and address, pick it, press **PLAY**. The friend's certificate is installed by hand, once; the steps (and how to let friends join you) are in `repack\JOIN-A-FRIEND.md`.

## Update
Double-click **Update-WoWForever.cmd** in the main folder (or key **U** in the control panel; updates also tidy the shortcuts down to the single "WoW Forever Bots" one). A window shows whether a newer version exists; click **Update now**.
It downloads the newest release, checks it, stops the server cleanly, backs up your characters, accounts and bots (folder `backups\`, the newest three are kept), installs the new files and the new add-on, and starts the server again. The first start after an update applies database changes and can take a few minutes.
Kept: your characters, accounts, bots, certificates, secrets, maps and your own settings. Your own settings go in `server\worldserver.conf.d\zz-9-local.conf` (never changed by updates); `zz-1-wow-forever-realm.conf` is replaced by every update so the server always plays like the main realm.
If something goes wrong: `repack\restore-backup.ps1` lists the backups and puts one back. Command line: `repack\update.ps1 -CheckOnly`, `repack\update.ps1`.

## Stop / remove
`repack\Stop-WoWForever.ps1`. To remove the certificate and hosts line: Administrator PowerShell, `repack\uninstall.ps1`.

## Community
Discord: https://discord.gg/QJBM6tR3E4

## Report a bug
Run `repack\bug-bundle.ps1` (makes a zip on your Desktop with logs, names and IPs masked) and send it with what happened: class, level, place, what you expected.

## Licence
GPL v2 (TrinityCore and derivatives). Source: see SOURCE.txt. Credits: NOTICE.txt. No Blizzard files are included.
