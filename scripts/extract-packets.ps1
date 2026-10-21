# Pulls specific packets out of a worldserver packet log (TrinityCore PKT 3.1, PacketLogFile in worldserver.conf),
# so only the packets we need go into the captures branch, never the whole log.
#
# 1) Find the moment something happened, e.g. when you typed a chat command:
#      .\extract-packets.ps1 -Pkt ..\server-bot\Logs\invite.pkt -Find ".bot call"
#    prints the tick of every packet whose bytes contain that text.
# 2) Dump the packets of some opcodes in a tick window as hex:
#      .\extract-packets.ps1 -Pkt ..\server-bot\Logs\invite.pkt -Opcode 0x5C0000 -FromTick 123000 -ToTick 153000 -Out C:\temp\upd.txt
#    Opcodes are the server's (retail) numbers: SMSG_UPDATE_OBJECT 0x5C0000, SMSG_INSPECT_RESULT 0x4500DA, CMSG_INSPECT 0x3E00CB.
param(
    [Parameter(Mandatory)] [string] $Pkt,
    [string[]] $Find,
    [uint32[]] $Opcode,
    [uint32] $FromTick = 0,
    [uint32] $ToTick = [uint32]::MaxValue,
    [int] $MaxBytes = 65536,
    [string] $Out
)

$data = [System.IO.File]::ReadAllBytes((Resolve-Path $Pkt))
# header: 3s magic, u16 version, u8 sniffer, u32 build, 4s locale, 40s session key, u32 time, u32 tick, u32 optional length
$pos = 66 + [BitConverter]::ToUInt32($data, 62)
$ascii = [System.Text.Encoding]::ASCII
$lines = New-Object System.Collections.Generic.List[string]
$index = 0
while ($pos + 20 -le $data.Length) {
    $direction = [BitConverter]::ToUInt32($data, $pos)
    $ticks     = [BitConverter]::ToUInt32($data, $pos + 8)
    $optSize   = [BitConverter]::ToUInt32($data, $pos + 12)
    $length    = [BitConverter]::ToInt32($data, $pos + 16)
    $pos += 20 + $optSize
    if ($pos + $length -gt $data.Length) { break }
    $op = [BitConverter]::ToUInt32($data, $pos)
    $payloadStart = $pos + 4
    $payloadLength = $length - 4
    $pos += $length
    $index++
    $dir = if ($direction -eq 0x47534D43) { 'C>S' } else { 'S>C' }
    $head = '{0} tick {1} {2} 0x{3:X6} {4} bytes' -f $index, $ticks, $dir, $op, $payloadLength

    if ($Find) {
        $text = $ascii.GetString($data, $payloadStart, $payloadLength)
        foreach ($f in $Find) { if ($text.Contains($f)) { $lines.Add("$head  contains '$f'") } }
        continue
    }
    if ($ticks -lt $FromTick -or $ticks -gt $ToTick) { continue }
    if ($Opcode -and -not ($Opcode -contains $op)) { continue }
    if ($payloadLength -gt $MaxBytes) { $lines.Add("$head  (skipped, over -MaxBytes)"); continue }
    $lines.Add($head)
    $lines.Add(([BitConverter]::ToString($data, $payloadStart, $payloadLength)).Replace('-', ' ').ToLower())
}

if ($Out) { [System.IO.File]::WriteAllLines($Out, $lines); "$($lines.Count) lines written to $Out" }
else { $lines }
