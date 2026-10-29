# Builds WoWForeverLauncher.exe from launcher\WoWForeverLauncher.cs with the C# compiler that ships with Windows
# (.NET Framework 4.x, no SDK needed).
#   .\build-launcher.ps1                 -> <repack folder's parent>\WoWForeverLauncher.exe
#   .\build-launcher.ps1 -Out C:\x\L.exe -> write it there
param([string]$Out)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
if (-not $Out) { $Out = Join-Path $root 'WoWForeverLauncher.exe' }
$csc = Join-Path $env:windir 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
if (-not (Test-Path $csc)) { throw "csc.exe not found at $csc (needs the .NET Framework 4 that comes with Windows 10/11)." }
$srcDir = Join-Path $PSScriptRoot 'launcher'
$cmdArgs = @('/nologo', '/target:winexe', '/platform:x64', '/optimize+', "/out:$Out",
    "/win32icon:$(Join-Path $PSScriptRoot 'wow-forever.ico')", "/win32manifest:$(Join-Path $srcDir 'app.manifest')",
    '/r:System.dll', '/r:System.Core.dll', '/r:System.Drawing.dll', '/r:System.Windows.Forms.dll', '/r:System.Web.Extensions.dll', '/r:System.Management.dll')
# the pictures and fonts of the window (art\gen_art.py draws the pictures), embedded as "art.<file name>"
$artDir = Join-Path $srcDir 'art'
foreach ($f in @(Get-ChildItem -Path $artDir -Filter '*.png') + @(Get-ChildItem -Path (Join-Path $artDir 'fonts') -Filter '*.ttf' | Where-Object { $_.Name -ne 'CinzelDecorative-Black.ttf' })) {
    $cmdArgs += "/resource:$($f.FullName),art.$($f.Name)"
}
$cmdArgs += @(Get-ChildItem -Path $srcDir -Filter '*.cs' | ForEach-Object { $_.FullName })   # WoWForeverLauncher.cs + Skin.cs + Lang.cs + ServerOps.cs + Setup.cs + ChatSetup.cs + Friends.cs + StartForm.cs
& $csc @cmdArgs
if ($LASTEXITCODE -ne 0) { throw "csc failed (exit code $LASTEXITCODE)." }
"Built $Out ($((Get-Item $Out).Length) bytes)"
