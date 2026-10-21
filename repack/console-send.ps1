# Sends a line to the console of the running worldserver, as if typed there (the Windows worldserver reads its console
# only through the console window, so a pipe or redirect does not work). Dot-source this file: . .\console-send.ps1
#   Send-WorldserverCommand "bnetaccount create name@local password"
# Windows only. Nothing is written to the database by this script: the server itself carries the command out.
if (-not ('WfConsoleSend' -as [type])) {
    Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class WfConsoleSend
{
    [DllImport("kernel32.dll", SetLastError = true)] static extern bool FreeConsole();
    [DllImport("kernel32.dll", SetLastError = true)] static extern bool AttachConsole(uint pid);
    [DllImport("kernel32.dll", SetLastError = true)] static extern bool AllocConsole();
    [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Unicode)]
    static extern IntPtr CreateFile(string name, uint access, uint share, IntPtr security, uint disposition, uint flags, IntPtr template);
    [DllImport("kernel32.dll", SetLastError = true)] static extern bool CloseHandle(IntPtr h);
    [DllImport("kernel32.dll", SetLastError = true, EntryPoint = "WriteConsoleInputW")]
    static extern bool WriteConsoleInput(IntPtr h, INPUT_RECORD[] buffer, uint length, out uint written);

    [StructLayout(LayoutKind.Explicit, Size = 20)]
    struct INPUT_RECORD
    {
        [FieldOffset(0)] public ushort EventType;      // 1 = key event
        [FieldOffset(4)] public int bKeyDown;
        [FieldOffset(8)] public ushort wRepeatCount;
        [FieldOffset(10)] public ushort wVirtualKeyCode;
        [FieldOffset(12)] public ushort wVirtualScanCode;
        [FieldOffset(14)] public char UnicodeChar;
        [FieldOffset(16)] public uint dwControlKeyState;
    }

    static INPUT_RECORD Key(char c, ushort vk, bool down)
    {
        INPUT_RECORD r = new INPUT_RECORD();
        r.EventType = 1; r.bKeyDown = down ? 1 : 0; r.wRepeatCount = 1; r.wVirtualKeyCode = vk; r.UnicodeChar = c;
        return r;
    }

    public static string Send(uint pid, string text)
    {
        INPUT_RECORD[] recs = new INPUT_RECORD[(text.Length + 1) * 2];
        int n = 0;
        foreach (char c in text) { recs[n++] = Key(c, 0, true); recs[n++] = Key(c, 0, false); }
        recs[n++] = Key('\r', 0x0D, true); recs[n++] = Key('\r', 0x0D, false);
        string error = null;
        FreeConsole();
        try
        {
            if (!AttachConsole(pid)) { error = "AttachConsole failed (" + Marshal.GetLastWin32Error() + ")"; }
            else
            {
                // 0xC0000000 = read+write, 3 = share read+write, 3 = open existing
                IntPtr h = CreateFile("CONIN$", 0xC0000000, 3, IntPtr.Zero, 3, 0, IntPtr.Zero);
                if (h == new IntPtr(-1)) { error = "CONIN$ failed (" + Marshal.GetLastWin32Error() + ")"; }
                else
                {
                    uint written;
                    if (!WriteConsoleInput(h, recs, (uint)n, out written) || written != (uint)n) { error = "WriteConsoleInput failed (" + Marshal.GetLastWin32Error() + ")"; }
                    CloseHandle(h);
                }
            }
        }
        finally
        {
            FreeConsole();
            if (!AttachConsole(0xFFFFFFFF)) { AllocConsole(); }   // back to our own window
        }
        return error;
    }
}
'@
}

function Send-WorldserverCommand([string]$Line) {
    $p = Get-Process worldserver -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $p) { throw 'The server is not running.' }
    $err = [WfConsoleSend]::Send([uint32]$p.Id, $Line)
    if ($err) { throw "Could not reach the server console: $err" }
}
