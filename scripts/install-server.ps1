# Installs the RelWithDebInfo build into its CMAKE_INSTALL_PREFIX (server\ for the plain build, server-bot\ for the
# PlayerbotV2 build), copies the runtime DLLs the exes need, and regenerates that folder's configs.
#   .\install-server.ps1 [-BuildDir <dir>]   (default: build\ ; build-fast.ps1 builds into build-ninja\)
param([string]$BuildDir = '')
. "$PSScriptRoot\common.ps1"
if (-not $BuildDir) { $BuildDir = Join-Path $root 'build' }
$cmake = 'C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe'
$prefix = ((Select-String "$BuildDir\CMakeCache.txt" -Pattern '^CMAKE_INSTALL_PREFIX:PATH=(.+)$').Matches[0].Groups[1].Value) -replace '/','\'
& $cmake --install "$BuildDir" --config RelWithDebInfo
if ($LASTEXITCODE) { throw "cmake --install failed" }
$dlls = @(
    'C:\local\OpenSSL-Win64\bin\libssl-3-x64.dll',
    'C:\local\OpenSSL-Win64\bin\libcrypto-3-x64.dll',
    'C:\local\mysql-8.4.11\lib\libmysql.dll'
)
Copy-Item $dlls $prefix -Force
& "$PSScriptRoot\make-configs.ps1" -Server (Split-Path $prefix -Leaf)
