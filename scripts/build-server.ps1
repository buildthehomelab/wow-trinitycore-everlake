# Builds the RelWithDebInfo server in build\ while keeping a quarter of the PC free (chris, 2026-10-07: never use more
# than 75% of the PC). The build runs at below-normal priority, pinned to 75% of the logical CPUs (12 of 16), and
# MSBuild gets the same number of parallel projects. Every compiler/linker it starts inherits the CPU pinning.
#   .\build-server.ps1              -> build only
#   .\build-server.ps1 -Configure   -> re-run CMake first (needed when new .cpp files arrive)
param([switch]$Configure)
. "$PSScriptRoot\common.ps1"
$cmake = 'C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe'
$build = Join-Path $root 'build'
$cpus  = [Environment]::ProcessorCount
$use   = [Math]::Max(1, [Math]::Floor($cpus * 0.75))
$mask  = [IntPtr]([Int64][Math]::Pow(2, $use) - 1)

function Invoke-Limited([string[]]$arguments) {
    $p = Start-Process $cmake -ArgumentList $arguments -NoNewWindow -PassThru
    $null = $p.Handle   # cache the handle, or ExitCode stays empty and a failed build looks like success
    try { $p.ProcessorAffinity = $mask; $p.PriorityClass = 'BelowNormal' } catch { }
    $p.WaitForExit()
    return $p.ExitCode
}

if ($Configure) {
    if (Invoke-Limited @("`"$build`"")) { throw "cmake configure failed" }
}
"Building with $use of $cpus logical CPUs (below-normal priority)"
$code = Invoke-Limited @('--build', "`"$build`"", '--config', 'RelWithDebInfo', '--parallel', "$use")
if ($code) { throw "build failed (exit $code)" }
"Build finished"
