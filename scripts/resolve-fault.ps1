# Resolves "worldserver.exe+0x8EBC86" fault addresses (the Map::Update SEH lines of Server.log) to function and source line against the PDB of
# the build that ran, with dbghelp.dll (part of Windows). Windows PowerShell 5.1, no admin, no Visual Studio tools, changes nothing.
#   .\resolve-fault.ps1 -Exe C:\...\server-bot\worldserver.exe -Pdb C:\...\server-bot\symbols\worldserver.pdb -Offset 0x8EBC86
#   .\resolve-fault.ps1 -Exe ... -Pdb ... -Offset 0x8EBC86,0x1A2B3C,...         (the whole "stack: a < b < c" list works too)
#   .\resolve-fault.ps1 -Exe ... -Pdb ... -Line 'Map::Update SEH exception ... stack: worldserver.exe+0x8EBC86 < worldserver.exe+0x...'
# The PDB must be the archive of the same build as the exe (same commit): a mismatch resolves to wrong names or to nothing.
param(
    [Parameter(Mandatory = $true)][string]$Exe,
    [Parameter(Mandatory = $true)][string]$Pdb,
    [string[]]$Offset = @(),
    [string]$Line = ''
)
$ErrorActionPreference = 'Stop'
$offsets = @($Offset | ForEach-Object { [Convert]::ToUInt64($_.Trim().Replace('0x', ''), 16) })
if ($Line) {
    foreach ($m in [regex]::Matches($Line, 'worldserver\.exe\+0x([0-9A-Fa-f]+)')) { $offsets += [Convert]::ToUInt64($m.Groups[1].Value, 16) }
}
if ($offsets.Count -eq 0) { throw 'give -Offset 0x... or -Line <the log line>' }
if (-not (Test-Path $Exe)) { throw "no $Exe" }
if (-not (Test-Path $Pdb)) { throw "no $Pdb" }

Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
using System.Text;
public static class Dbg
{
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct SYMBOL_INFO
    {
        public uint SizeOfStruct, TypeIndex;
        public ulong Reserved0, Reserved1;
        public uint Index, Size;
        public ulong ModBase;
        public uint Flags;
        public ulong Value, Address;
        public uint Register, Scope, Tag, NameLen, MaxNameLen;
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 1024)] public byte[] Name;
    }
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Ansi)]
    public struct IMAGEHLP_LINE64 { public uint SizeOfStruct; public IntPtr Key; public uint LineNumber; public IntPtr FileName; public ulong Address; }
    [DllImport("dbghelp.dll", SetLastError = true)] public static extern bool SymInitialize(IntPtr p, string path, bool invade);
    [DllImport("dbghelp.dll", SetLastError = true)] public static extern uint SymSetOptions(uint o);
    [DllImport("dbghelp.dll", SetLastError = true, CharSet = CharSet.Ansi)]
    public static extern ulong SymLoadModuleEx(IntPtr p, IntPtr file, string image, string name, ulong baseAddr, uint size, IntPtr data, uint flags);
    [DllImport("dbghelp.dll", SetLastError = true)] public static extern bool SymFromAddr(IntPtr p, ulong addr, out ulong disp, ref SYMBOL_INFO s);
    [DllImport("dbghelp.dll", SetLastError = true)] public static extern bool SymGetLineFromAddr64(IntPtr p, ulong addr, out uint disp, ref IMAGEHLP_LINE64 l);
    [DllImport("dbghelp.dll")] public static extern bool SymCleanup(IntPtr p);
    public static string Resolve(IntPtr p, ulong addr)
    {
        var s = new SYMBOL_INFO(); s.SizeOfStruct = 88; s.MaxNameLen = 1024; s.Name = new byte[1024];
        ulong d; string name = "?";
        if (SymFromAddr(p, addr, out d, ref s))
        {
            int n = Array.IndexOf(s.Name, (byte)0); if (n < 0) n = 1024;
            name = Encoding.ASCII.GetString(s.Name, 0, n) + "+0x" + d.ToString("X");
        }
        var l = new IMAGEHLP_LINE64(); l.SizeOfStruct = (uint)Marshal.SizeOf(typeof(IMAGEHLP_LINE64)); uint ld;
        string where = "";
        if (SymGetLineFromAddr64(p, addr, out ld, ref l)) where = "  " + Marshal.PtrToStringAnsi(l.FileName) + ":" + l.LineNumber;
        return name + where;
    }
}
'@

$proc = [IntPtr]1234    # any handle value dbghelp can key a session on
[void][Dbg]::SymSetOptions(0x2 -bor 0x10 -bor 0x200)     # undecorated names, load lines, no prompts
if (-not [Dbg]::SymInitialize($proc, (Split-Path $Pdb -Parent), $false)) { throw 'SymInitialize failed' }
$base = [uint64]0x10000000
$loaded = [Dbg]::SymLoadModuleEx($proc, [IntPtr]::Zero, $Exe, $null, $base, 0, [IntPtr]::Zero, 0)
if ($loaded -eq 0) { throw "SymLoadModuleEx failed ($([Runtime.InteropServices.Marshal]::GetLastWin32Error()))" }
foreach ($o in $offsets) {
    '{0,-12} {1}' -f ('0x{0:X}' -f $o), [Dbg]::Resolve($proc, $base + $o)
}
[void][Dbg]::SymCleanup($proc)
