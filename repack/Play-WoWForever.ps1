# Starts the game client pointed at this repack's server and makes the client trust the server's login key.
# Replaces the separate launcher: one window, no extra download. Windows PowerShell 5.1, no administrator rights needed.
#
#   .\Play-WoWForever.ps1                       -> start the game and apply the server key
#   .\Play-WoWForever.ps1 -Attach               -> game is already running: only apply the key
#   .\Play-WoWForever.ps1 -Client "D:\WoW"      -> use this game folder (_forever_ with Wow.exe, or _classic_beta_ with WowB.exe)
#   .\Play-WoWForever.ps1 -CheckOnly            -> print what would happen, start nothing
#
# What it does, and nothing else:
#  1. Writes WTF\ForeverLauncher.wtf (a copy of your Config.wtf) with SET portal "<portal>" and starts the game with
#     -config ForeverLauncher.wtf. Your own Config.wtf is not changed.
#  2. The client keeps a table of 12 login public keys in its memory (12 records of 40 bytes: number 1..12, 32-byte key,
#     flag, padding). The server announces one of them by region group. This script finds that table in the running game
#     (by its layout, so it keeps working when the client is updated) and writes the server's PUBLIC key into the
#     record of the server's region group. Nothing on disk and no program code is changed.
#  3. Keeps watching while the game runs (re-applies the key if the client rebuilds the table), exits when the game closes.
[CmdletBinding()]
param(
    [string]$Client,                 # default: config\client.txt written by the installer
    [string]$Portal,                 # default: config\server.json or trinity.actual.battle.net
    [string]$PublicKey,              # 64 hex characters; default: the key stock TrinityCore (and this repack) uses
    [int]$RegionGroup = 0,           # 2-12 except 9; default 8
    [switch]$Attach,
    [switch]$CheckOnly,
    [switch]$NoUpdateCheck
)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent

# --- settings: optional config\server.json {"portal":"...","publicKey":"...","regionGroup":8} ---------------------------------
$cfg = $null
$cfgFile = Join-Path $root 'config\server.json'
if (Test-Path $cfgFile) { try { $cfg = Get-Content $cfgFile -Raw | ConvertFrom-Json } catch { Write-Warning "config\server.json is not valid JSON; ignored." } }
if (-not $Portal)    { $Portal = if ($cfg -and $cfg.portal) { [string]$cfg.portal } else { 'trinity.actual.battle.net' } }
if (-not $PublicKey) { $PublicKey = if ($cfg -and $cfg.publicKey) { [string]$cfg.publicKey } else { '02596F0D0C061A8B30745988FD72C59E29EC367FB0F341F28E0F08D037BAFC69' } }
if ($RegionGroup -eq 0) { $RegionGroup = if ($cfg -and $cfg.regionGroup) { [int]$cfg.regionGroup } else { 8 } }
if ($Portal -notmatch '^[A-Za-z0-9.-]+$') { throw "Portal '$Portal' is not a host name." }
if ($Portal -notmatch '\.actual\.battle\.net$') { Write-Warning "The client only accepts portals ending in .actual.battle.net; '$Portal' will probably not connect." }
if ($PublicKey -notmatch '^[0-9A-Fa-f]{64}$') { throw 'Public key must be 64 hex characters.' }
if ($RegionGroup -lt 2 -or $RegionGroup -gt 12 -or $RegionGroup -eq 9) { throw 'Region group must be 2-12 (not 9).' }
$newKey = New-Object byte[] 32
for ($i = 0; $i -lt 32; $i++) { $newKey[$i] = [Convert]::ToByte($PublicKey.Substring($i * 2, 2), 16) }

# --- game folder ---------------------------------------------------------------------------------------------------------------
if (-not $Client) {
    $saved = Join-Path $root 'config\client.txt'
    if (Test-Path $saved) { $Client = (Get-Content $saved -TotalCount 1).Trim() }
}
function Find-Exe([string]$dir) {
    if (-not $dir) { return $null }
    foreach ($d in @($dir, (Join-Path $dir '_forever_'), (Join-Path $dir '_classic_beta_'))) { foreach ($e in 'Wow.exe', 'WowB.exe') { if (Test-Path (Join-Path $d $e)) { return $d } } }
    $null
}
$gameDir = Find-Exe $Client
if (-not $gameDir) { throw "Wow.exe (_forever_) or WowB.exe (_classic_beta_) not found in '$Client'. Run: Play-WoWForever.ps1 -Client `"<folder that contains _forever_ or _classic_beta_>`"" }

# --- client config -------------------------------------------------------------------------------------------------------------
$wtfDir = Join-Path $gameDir 'WTF'
$wtf = Join-Path $wtfDir 'ForeverLauncher.wtf'
$base = Join-Path $wtfDir 'Config.wtf'
$lines = @()
if (Test-Path $wtf) { $lines = @(Get-Content $wtf) } elseif (Test-Path $base) { $lines = @(Get-Content $base) }
$want = 'SET portal "' + $Portal + '"'
if ($lines | Where-Object { $_ -like 'SET portal *' }) { $lines = @($lines | ForEach-Object { if ($_ -like 'SET portal *') { $want } else { $_ } }) } else { $lines += $want }
if (-not ($lines | Where-Object { $_ -like 'SET textLocale *' })) { $lines += 'SET textLocale "enUS"' }

Write-Host "Game folder: $gameDir"
Write-Host "Portal:      $Portal   (region group $RegionGroup)"
if ($CheckOnly) { Write-Host 'Check only: nothing started, nothing written.'; return }
New-Item -ItemType Directory -Force $wtfDir | Out-Null
Set-Content $wtf $lines -Encoding ASCII

# --- update hint (never blocks) --------------------------------------------------------------------------------------------------
if (-not $NoUpdateCheck) {
    try {
        $p = Start-Process powershell -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$PSScriptRoot\update.ps1`"", '-Quiet' -Wait -PassThru -WindowStyle Hidden
        $null = $p.Handle   # Windows PowerShell 5.1 leaves ExitCode empty unless the process handle is read right after the start
        if ($p.ExitCode -eq 10) { Write-Host 'A new version of the server is available. Close the game later and use Update in the WoW Forever Bots menu.' -ForegroundColor Yellow }
    } catch { }
}

# --- memory access -----------------------------------------------------------------------------------------------------------------
Add-Type -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

public static class KeyStore
{
    [StructLayout(LayoutKind.Sequential)]
    struct MBI { public IntPtr BaseAddress, AllocationBase; public uint AllocationProtect; public IntPtr RegionSize; public uint State, Protect, Type; }
    [DllImport("kernel32.dll", SetLastError = true)] static extern IntPtr OpenProcess(uint access, bool inherit, int pid);
    [DllImport("kernel32.dll", SetLastError = true)] static extern bool CloseHandle(IntPtr h);
    [DllImport("kernel32.dll", SetLastError = true)] static extern IntPtr VirtualQueryEx(IntPtr h, IntPtr addr, out MBI mbi, IntPtr len);
    [DllImport("kernel32.dll", SetLastError = true)] static extern bool ReadProcessMemory(IntPtr h, IntPtr addr, byte[] buf, IntPtr size, out IntPtr read);
    [DllImport("kernel32.dll", SetLastError = true)] static extern bool WriteProcessMemory(IntPtr h, IntPtr addr, byte[] buf, IntPtr size, out IntPtr written);

    const uint ACCESS = 0x0400 | 0x0010 | 0x0020 | 0x0008;   // query information, read, write, operation
    const uint MEM_COMMIT = 0x1000, MEM_PRIVATE = 0x20000, PAGE_READWRITE = 0x04;
    public const int Entries = 12, EntrySize = 40, BlockSize = 480;
    static readonly byte[] Flags = new byte[] { 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1 };

    public static IntPtr Open(int pid) { return OpenProcess(ACCESS, false, pid); }
    public static void Close(IntPtr h) { CloseHandle(h); }

    // true if buf[off .. off+480) has the layout of the key table
    static bool Looks(byte[] b, int off)
    {
        for (int e = 0; e < Entries; e++)
        {
            int o = off + e * EntrySize;
            uint id = (uint)(b[o] | (b[o + 1] << 8) | (b[o + 2] << 16) | (b[o + 3] << 24));
            if (id != (uint)(e + 1)) return false;
            if (b[o + 36] != Flags[e]) return false;
            if (b[o + 38] != 0 || b[o + 39] != 0) return false;
            if (b[o + 37] != 0 && b[o + 37] != 0x7f) return false;
            bool nonzero = false;
            for (int k = 4; k < 36; k++) if (b[o + k] != 0) { nonzero = true; break; }
            if (!nonzero) return false;
        }
        return true;
    }

    // addresses (in the target) of every table found in private read/write memory
    public static List<long> Find(IntPtr h)
    {
        List<long> found = new List<long>();
        long addr = 0;
        MBI mbi;
        IntPtr mbiSize = (IntPtr)Marshal.SizeOf(typeof(MBI));
        while (addr < 0x7FFFFFFF0000L)
        {
            if (VirtualQueryEx(h, (IntPtr)addr, out mbi, mbiSize) == IntPtr.Zero) break;
            long size = mbi.RegionSize.ToInt64();
            long baseAddr = mbi.BaseAddress.ToInt64();
            if (mbi.State == MEM_COMMIT && mbi.Type == MEM_PRIVATE && mbi.Protect == PAGE_READWRITE && size > 0)
            {
                long pos = 0;
                while (pos < size)
                {
                    int take = (int)Math.Min(8L * 1024 * 1024, size - pos);
                    byte[] buf = new byte[take];
                    IntPtr got;
                    if (!ReadProcessMemory(h, (IntPtr)(baseAddr + pos), buf, (IntPtr)take, out got)) break;
                    int n = got.ToInt32();
                    for (int i = 0; i + BlockSize <= n; i += 4)
                    {
                        if (buf[i] == 1 && buf[i + 1] == 0 && buf[i + 40] == 2 && Looks(buf, i)) found.Add(baseAddr + pos + i);
                    }
                    if (pos + take >= size) break;
                    pos += take - BlockSize;   // overlap so a table on a chunk border is not missed
                }
            }
            addr = baseAddr + size;
            if (size <= 0) break;
        }
        return found;
    }

    // "invalid" | "original" | "patched"
    public static string State(IntPtr h, long table, int group, byte[] key)
    {
        byte[] b = new byte[BlockSize];
        IntPtr got;
        if (!ReadProcessMemory(h, (IntPtr)table, b, (IntPtr)BlockSize, out got) || got.ToInt32() != BlockSize) return "invalid";
        if (!Looks(b, 0)) return "invalid";
        int o = (group - 1) * EntrySize + 4;
        for (int k = 0; k < 32; k++) if (b[o + k] != key[k]) return "original";
        return "patched";
    }

    public static bool Write(IntPtr h, long table, int group, byte[] key)
    {
        IntPtr w;
        long target = table + (group - 1) * EntrySize + 4;
        if (!WriteProcessMemory(h, (IntPtr)target, key, (IntPtr)32, out w) || w.ToInt32() != 32) return false;
        return State(h, table, group, key) == "patched";
    }
}
'@

function Say($m, $c = 'Gray') { Write-Host ("[{0}] {1}" -f (Get-Date -Format 'HH:mm:ss'), $m) -ForegroundColor $c }

# --- start / attach ----------------------------------------------------------------------------------------------------------------
if ($Attach) {
    $proc = Get-Process Wow, WowB -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $proc) { throw 'The game (Wow.exe or WowB.exe) is not running.' }
} else {
    if (Get-Process Wow, WowB -ErrorAction SilentlyContinue) { throw 'The game is already running. Close it first, or use -Attach to only apply the key.' }
    Say 'Starting the game...' 'Cyan'
    $proc = Start-Process (Join-Path $gameDir $(if (Test-Path (Join-Path $gameDir 'Wow.exe')) { 'Wow.exe' } else { 'WowB.exe' })) -ArgumentList '-config', 'ForeverLauncher.wtf' -WorkingDirectory $gameDir -PassThru
    $null = $proc.Handle   # Windows PowerShell 5.1 leaves ExitCode empty unless the process handle is read right after the start
}
$h = [KeyStore]::Open($proc.Id)
if ($h -eq [IntPtr]::Zero) { throw 'Could not open the game process. Start the game from this script as the same Windows user (no administrator window).' }
Say ("Game is running (process {0}). Log in and pick your realm." -f $proc.Id) 'Cyan'

# --- watch loop --------------------------------------------------------------------------------------------------------------------
$table = $null
$waitSaid = $false
try {
    while (-not $proc.HasExited) {
        if ($table) {
            $st = [KeyStore]::State($h, $table, $RegionGroup, $newKey)
            if ($st -eq 'patched') { Start-Sleep -Seconds 3; continue }
            if ($st -eq 'original') {
                Say 'The client restored its key table: applying the server key again.' 'Yellow'
                if ([KeyStore]::Write($h, $table, $RegionGroup, $newKey)) { Say 'Server key applied.' 'Green' }
                continue
            }
            $table = $null   # table was freed; look again
        }
        $found = [KeyStore]::Find($h)
        if ($found.Count -eq 1) {
            $t = $found[0]
            if ([KeyStore]::Write($h, $t, $RegionGroup, $newKey)) {
                $table = $t
                Say 'Server key applied. If the first login attempt failed, log in again without closing the game.' 'Green'
            } else { Say 'Could not write the key; trying again.' 'Yellow'; Start-Sleep -Seconds 2 }
        } elseif ($found.Count -gt 1) {
            Say ("{0} key tables found at once; waiting until there is one." -f $found.Count) 'Yellow'
            Start-Sleep -Seconds 2
        } else {
            if (-not $waitSaid) { Say 'Waiting for the client to prepare the login...' 'DarkGray'; $waitSaid = $true }
            Start-Sleep -Milliseconds 1500
        }
        $proc.Refresh()
    }
} finally {
    [KeyStore]::Close($h)
}
Say 'The game was closed.' 'Cyan'
