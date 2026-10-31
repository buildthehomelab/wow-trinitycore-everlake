# Joining a friend's server (and letting friends join yours)

## The easy way: a join code (launcher)

**Host** (the one whose server it is): open the launcher, **Settings** > **Host for friends...** (also on the **Server** tab).
Type a name for your server and press **Turn on**. The launcher opens a tunnel through Cloudflare and shows a **join code**
(`WFB-...`). Press **Copy** and send it to your friend. Make an account for each friend: **Server** tab > **Create account**.
**Turn off** closes the tunnel.

How the tunnel works: the first time, the launcher downloads Cloudflare's free tunnel program `cloudflared` (version
2026.10.3, about 55 MB, checked against its published SHA-256, kept in the `tunnel` folder). While hosting is on it runs
hidden and connects out to Cloudflare, so nothing is opened in your router or Windows Firewall, no Windows prompt, no
account, and your home address is not in the code. The server keeps its normal one-PC settings and is not restarted.
Cloudflare gives the tunnel a new random name each time, so **the code changes every time you turn hosting on** (and if
the tunnel has to reconnect: the window then shows the new code). Nothing runs while hosting is off, and nothing starts with
Windows: after a restart of the PC, turn hosting on again. Cloudflare offers these tunnels for free without any promise of
uptime; if it does not work for you, use **Port forwarding** below.

**Port forwarding** (the button in the same window, picked while hosting is off): for a host whose router forwards TCP
1119, 8081 and 8085 to this PC. **Turn on** then opens those ports in Windows Firewall (one Windows prompt), asks your
router to forward them (UPnP; if the router does not allow that, the window says which ports to forward by hand) and
restarts the server. That code holds your internet address.

**Friend**: open the launcher, **Server** tab > **Join a friend**, paste the code and press **Join**. The launcher finds the
server, checks its certificate against the code, asks once to trust it (Windows prompt; it is limited to names under
`actual.battle.net`), adds the server to the list and picks it. Press **PLAY NOW** and log in with the account your friend made.
Removing the server from the list later removes the certificate too. Through a tunnel your launcher carries the game's
connections on this PC's ports 1119, 8081 and 8085, so your own server (if you have one) is stopped first; the launcher asks.
Keep the launcher open while you play.

Give the code only to people you trust. When the host's launcher shows a new code, the friend joins with the new one and the
same server entry is updated.

The rest of this file is the same thing by hand, for setups the code does not cover.

The game client only talks to servers whose name ends in `.actual.battle.net` and it checks that server's certificate. So
joining someone else needs three things on your side, and two on the host's side. Done by hand, nothing is automatic for
the certificate: you install it yourself once, on purpose.

## If you want to join a friend

Ask your friend for:
1. their server address (an IP address or host name),
2. the file `certs\ca.pem` from their WoW Forever Bots folder (it is the public certificate of their own certificate
   authority; never ask for or send `ca.key`, that one must stay private),
3. only if they changed it: their public key and portal name (the defaults work for a normal install).

Then:
1. **Trust their certificate (once per friend).** Double-click their `ca.pem` > **Install Certificate...** > **Local Machine**
   > **Place all certificates in the following store** > **Browse...** > **Trusted Root Certification Authorities** > Finish.
   Their certificate authority is limited to names under `actual.battle.net`, so it cannot vouch for any other website.
   To remove it later: Start > `certmgr.msc` (or `certlm.msc`) > Trusted Root Certification Authorities > Certificates >
   delete "WoW Forever Local CA".
2. Open the **WoW Forever** launcher window, press **Add...**, enter a name, their address and (if needed) the other
   fields, and press **Add server**.
3. Pick the server in the list and press **PLAY**. The first time, Windows asks for permission once so the launcher can
   point `trinity.actual.battle.net` at your friend's address (a line in the Windows hosts file; the old file is saved as
   `hosts.wowforever.bak`). Pick "This PC (own server)" and press PLAY to go back to your own server; that switches the
   line back.
4. Log in with an account that exists **on your friend's server** (they create it for you: menu A on their side).

## If you want friends to join you

Double-click **Host-For-Others.cmd** in the main folder. It:
- shows your address in your home network and on the internet, and lets you pick which one players use (or type your own:
  a dynamic DNS name such as No-IP or DuckDNS, or this PC's IP in Radmin VPN / ZeroTier / Hamachi),
- lets the login and world servers listen for other PCs (`BindIP = "0.0.0.0"`) and puts your address in the realm list
  (realm 70), with your home network address for players in your own network,
- adds one Windows Firewall rule for TCP **1119** (login), **8081** (login web port) and **8085** (world); Windows asks for
  permission once. MySQL stays closed to other PCs,
- restarts the server and shows the file to give players: `certs\ca.pem` (never `ca.key`, that one stays private) and its
  fingerprint.

While hosting is on, every server start puts these settings back (an update rewrites the server settings) and looks up your
internet address again (home addresses can change). Run Host-For-Others.cmd again to turn it all off.

What you still do yourself:
- in your router, forward TCP ports 1119, 8081 and 8085 to your PC (not needed for a VPN or home network address). If your
  provider shares one internet address between many homes (CGNAT), forwarding cannot work: use a VPN such as Radmin VPN or
  ZeroTier instead,
- create an account for each player (menu A),
- send each player your address and `certs\ca.pem`, and tell them to follow "If you want to join a friend" above.

Only do this for people you trust.

Problems: run `repack\bug-bundle.ps1` and send the zip in our Discord.
