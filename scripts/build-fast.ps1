# Ninja build of the same server, in its own folder (build-ninja\), next to the Visual Studio build in build\ which it never touches.
# Why: MSBuild runs project after project and starts a compiler per project; Ninja schedules every compile of every project in one
# queue, has a near-instant "nothing to do" check, and /Z7 (debug info inside the .obj) removes the shared-PDB lock between compilers.
# Same CPU rule as build-server.ps1: below-normal priority, pinned to 75% of the logical CPUs.
#
#   .\build-fast.ps1 -Configure          -> first time: CMake with the same settings as build\ (read from build\CMakeCache.txt)
#   .\build-fast.ps1                     -> build everything that build\ builds
#   .\build-fast.ps1 -Target worldserver -> only that target (and what it needs); faster for a bot-only change, but then use
#                                           install-server.ps1 only if the install rules accept it (install.ps1 -BuildDir build-ninja)
#   .\build-fast.ps1 -Launcher sccache   -> compiler cache (only if sccache.exe is on PATH). Off by default: the project uses
#                                           precompiled headers, which sccache refuses to cache; measure with -Bench before turning on.
#   .\build-fast.ps1 -Bench              -> times a no-op build and a one-file edit (touches Bot\BotArchetype.cpp), prints seconds;
#                                           run build-server.ps1 on the same touched file to compare
#   .\build-fast.ps1 -DryRun             -> prints the cmake/ninja commands, runs nothing
# Install a Ninja build with:  .\install.ps1 -Commit <hash> -BuildDir build-ninja
param(
    [switch]$Configure,
    [string[]]$Target = @(),
    [ValidateSet('none', 'sccache', 'ccache')][string]$Launcher = 'none',
    [switch]$Bench,
    [switch]$DryRun,
    [string]$Dir = 'build-ninja'
)
. "$PSScriptRoot\common.ps1"
$ErrorActionPreference = 'Stop'
$vsRoot = 'C:\Program Files\Microsoft Visual Studio\2022\Community'
$cmake  = "$vsRoot\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
$ninja  = "$vsRoot\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe"
$vcvars = "$vsRoot\VC\Auxiliary\Build\vcvars64.bat"
$vsBuild = Join-Path $root 'build'
$out    = Join-Path $root $Dir
foreach ($p in @($cmake, $ninja, $vcvars)) { if (-not (Test-Path $p)) { throw "missing $p (Visual Studio path changed?)" } }

# Load the compiler environment (cl.exe, link.exe, Windows SDK paths) of an x64 prompt into this process. vcvars64.bat calls vswhere.exe,
# which lives in the Visual Studio Installer folder that is not on PATH in the cmd child. A dry run prints the commands and loads nothing.
if ($DryRun) {
    Write-Host "DRY RUN: would load the compiler environment from $vcvars"
} else {
    $env:PATH = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer;$env:PATH"
    $envDump = & cmd /c "`"$vcvars`" >nul && set"
    foreach ($l in $envDump) { if ($l -match '^([^=]+)=(.*)$') { [Environment]::SetEnvironmentVariable($Matches[1], $Matches[2], 'Process') } }
}

$cpus = [Environment]::ProcessorCount
$use  = [Math]::Max(1, [Math]::Floor($cpus * 0.75))
$mask = [IntPtr]([Int64][Math]::Pow(2, $use) - 1)
function Invoke-Limited([string]$exe, [string[]]$arguments) {
    if ($DryRun) { Write-Host "DRY RUN: $exe $($arguments -join ' ')"; return 0 }
    $p = Start-Process $exe -ArgumentList $arguments -NoNewWindow -PassThru
    $null = $p.Handle   # cache the handle, or ExitCode stays empty and a failed build looks like success
    try { $p.ProcessorAffinity = $mask; $p.PriorityClass = 'BelowNormal' } catch { }
    $p.WaitForExit()
    return $p.ExitCode
}

if ($Configure -or -not (Test-Path "$out\build.ninja")) {
    # carry over every setting that decides what gets built (toolchain, boost, Qt, options) from the working VS build
    $keys = 'CMAKE_TOOLCHAIN_FILE', 'BOOST_ROOT', 'BOOST_INCLUDEDIR', 'BOOST_LIBRARYDIR', 'CMAKE_PREFIX_PATH', 'CMAKE_INSTALL_PREFIX',
            'SERVERS', 'TOOLS', 'SCRIPTS', 'BUILD_PLAYERBOT_V2', 'BUILD_TESTING', 'WITH_WARNINGS', 'WITH_COREDEBUG', 'USE_COREPCH', 'USE_SCRIPTPCH',
            'MYSQL_INCLUDE_DIR', 'MYSQL_LIBRARY', 'OPENSSL_ROOT_DIR', 'OPENSSL_INCLUDE_DIR', 'HEADLESS_TESTS'
    $defs = @()
    $cache = Get-Content "$vsBuild\CMakeCache.txt"
    foreach ($k in $keys) {
        $m = $cache | Select-String -Pattern "^${k}(:[A-Z]+)?=(.*)$" | Select-Object -First 1
        if ($m) { $defs += "-D$k=$($m.Matches[0].Groups[2].Value)" }
    }
    $defs += '-DCMAKE_BUILD_TYPE=RelWithDebInfo'
    # /Z7: debug info in each .obj (no shared compiler PDB); the linker still writes worldserver.pdb as before
    $defs += '-DCMAKE_C_FLAGS_RELWITHDEBINFO=/O2 /Ob1 /DNDEBUG /Z7', '-DCMAKE_CXX_FLAGS_RELWITHDEBINFO=/O2 /Ob1 /DNDEBUG /Z7'
    $defs += "-DCMAKE_MAKE_PROGRAM=$ninja"
    if ($Launcher -ne 'none') { $defs += "-DCMAKE_C_COMPILER_LAUNCHER=$Launcher", "-DCMAKE_CXX_COMPILER_LAUNCHER=$Launcher" }
    $args2 = @('-S', "`"$repoRoot`"", '-B', "`"$out`"", '-G', 'Ninja') + ($defs | ForEach-Object { "`"$_`"" })
    if ((Invoke-Limited $cmake $args2)) { throw 'cmake configure failed' }
}

function Invoke-Build {
    $a = @('-C', "`"$out`"", '-j', "$use")
    if ($Target.Count) { $a += $Target }
    return (Invoke-Limited $ninja $a)
}

if ($Bench) {
    $f = Get-ChildItem $repoRoot -Recurse -Filter BotArchetype.cpp | Select-Object -First 1
    "bench file: $($f.FullName)"
    $t = Measure-Command { $code = Invoke-Build }; "no-op / catch-up build: {0:n1} s (exit $code)" -f $t.TotalSeconds
    (Get-Item $f.FullName).LastWriteTime = Get-Date
    $t = Measure-Command { $code = Invoke-Build }; "one touched .cpp, build + relink: {0:n1} s (exit $code)" -f $t.TotalSeconds
    "now touch the same file and time build-server.ps1 for the same edit; compare the two numbers"
    return
}

"Ninja build with $use of $cpus logical CPUs (below-normal priority) in $out"
$sw = [Diagnostics.Stopwatch]::StartNew()
$code = Invoke-Build
if ($code) { throw "build failed (exit $code)" }
"Build finished in {0:n0} s" -f $sw.Elapsed.TotalSeconds
