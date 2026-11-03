# Builds WoWForeverLauncher.exe from launcher\WoWForeverLauncher.cs with the C# compiler that ships with Windows
# (.NET Framework 4.x, no SDK needed).
#   .\build-launcher.ps1                 -> <repack folder's parent>\WoWForeverLauncher.exe
#   .\build-launcher.ps1 -Out C:\x\L.exe -> write it there
# The dev launcher and the release launcher are always the same exe (chris): every build is also copied to <repo>\launcher-dev
# when that folder exists (the dev PC), so a release build (build-package.ps1 -> -Out <stage>) and the dev launcher never differ.
# A dev launcher that is open cannot be replaced: the copy then goes next to it as WoWForeverLauncher.exe.new, which
# goes in place when the dev launcher is closed and the file renamed. -NoDevCopy skips the copy.
param([string]$Out, [switch]$NoDevCopy)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
if (-not $Out) { $Out = Join-Path $root 'WoWForeverLauncher.exe' }
$csc = Join-Path $env:windir 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
if (-not (Test-Path $csc)) { throw "csc.exe not found at $csc (needs the .NET Framework 4 that comes with Windows 10/11)." }
$srcDir = Join-Path $PSScriptRoot 'launcher'
$cmdArgs = @('/nologo', '/target:winexe', '/platform:x64', '/optimize+', "/out:$Out",
    "/win32icon:$(Join-Path $PSScriptRoot 'wow-forever.ico')", "/win32manifest:$(Join-Path $srcDir 'app.manifest')",
    '/r:System.dll', '/r:System.Core.dll', '/r:System.Drawing.dll', '/r:System.Windows.Forms.dll', '/r:System.Web.Extensions.dll', '/r:System.Management.dll')
# the pictures of the window (art\gen_art.py draws them), embedded as "art.<file name>"; the lettering is Windows' own Segoe UI
$artDir = Join-Path $srcDir 'art'
foreach ($f in @(Get-ChildItem -Path $artDir -Filter '*.png')) {
    $cmdArgs += "/resource:$($f.FullName),art.$($f.Name)"
}
$cmdArgs += @(Get-ChildItem -Path $srcDir -Filter '*.cs' | ForEach-Object { $_.FullName })   # WoWForeverLauncher.cs + Skin.cs + Lang.cs + ServerOps.cs + Setup.cs + ChatSetup.cs + Friends.cs + StartForm.cs
& $csc @cmdArgs
if ($LASTEXITCODE -ne 0) { throw "csc failed (exit code $LASTEXITCODE)." }
"Built $Out ($((Get-Item $Out).Length) bytes)"
$devDir = Join-Path $root 'launcher-dev'
if (-not $NoDevCopy -and (Test-Path -LiteralPath $devDir -PathType Container)) {
    $dev = Join-Path $devDir 'WoWForeverLauncher.exe'
    if ([IO.Path]::GetFullPath($dev) -ne [IO.Path]::GetFullPath($Out)) {
        try {
            Copy-Item -LiteralPath $Out -Destination $dev -Force
            Remove-Item -LiteralPath "$dev.new" -ErrorAction SilentlyContinue   # an older one waiting there is not this build
            "Copied the same exe to $dev (dev and release launcher are the same)."
        } catch {
            Copy-Item -LiteralPath $Out -Destination "$dev.new" -Force
            Write-Warning "$dev is open, so the same exe was put next to it as WoWForeverLauncher.exe.new: close the dev launcher, delete WoWForeverLauncher.exe there and rename the .new file."
        }
        $a = (Get-FileHash -LiteralPath $Out).Hash
        $b = (Get-FileHash -LiteralPath $(if (Test-Path -LiteralPath "$dev.new") { "$dev.new" } else { $dev })).Hash
        if ($a -ne $b) { throw "The dev launcher copy differs from $Out." }
    }
}
