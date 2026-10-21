# Joining a friend's server (and letting friends join yours)

The game client only talks to servers whose name ends in `.actual.battle.net` and it checks that server's certificate. So
joining someone else needs three things on your side, and two on the host's side. Nothing here is automatic for the
certificate: you install it yourself once, on purpose.

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

1. **Make the server reachable.** By default the server only listens on your own PC (`BindIP = "127.0.0.1"`), and the
   realm list it hands to the game says 127.0.0.1. To let friends in:
   - set `BindIP = "0.0.0.0"` in both `server\bnetserver.conf` and `server\worldserver.conf` (or in your own override file
     for the worldserver, see menu S),
   - set the realm's address (realm id 70, table `realmlist` in the auth database) to your public IP address or host
     name, and its local address to your PC's LAN address,
   - restart the server,
   - in your router forward TCP ports **1119** (login), **8081** (login web port) and **8085** (world) to your PC, and
     allow them in the Windows firewall.
   Only do this if you are happy to have other people connect to your PC.
2. Send your friend your address and the file `certs\ca.pem` (never `ca.key`), and create their account (menu A).
3. Tell them to follow "If you want to join a friend" above.

Problems: run `repack\bug-bundle.ps1` and send the zip in our Discord.
