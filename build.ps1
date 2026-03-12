# build.ps1 — Build midway-imgtool (Windows/SDL2 port) using VS 2022
# Run from a regular Windows PowerShell window:
#   powershell -ExecutionPolicy Bypass -File build.ps1
#
# Source lives in WSL at /home/alex/midway-imgtool
# This script accesses it via \\wsl.localhost\Ubuntu\...

param(
    [string]$SourceDir  = "\\wsl.localhost\Ubuntu\home\alex\midway-imgtool",
    [string]$BuildRoot  = "$env:LOCALAPPDATA\imgtool-build",
    [string]$Sdl2Ver    = ""          # leave empty to auto-fetch latest SDL2 2.x
)

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# -----------------------------------------------------------------------
# 1. Locate VS 2022
# -----------------------------------------------------------------------
$vcvarsall = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
if (-not (Test-Path $vcvarsall)) {
    Write-Error "VS 2022 Community not found at:`n  $vcvarsall"
    exit 1
}
Write-Host "[1/4] Found VS 2022" -ForegroundColor Cyan

# -----------------------------------------------------------------------
# 2. Resolve SDL2 version
# -----------------------------------------------------------------------
if (-not $Sdl2Ver) {
    Write-Host "[2/4] Querying GitHub for latest SDL2 2.x release..." -ForegroundColor Cyan
    try {
        $releases = Invoke-RestMethod "https://api.github.com/repos/libsdl-org/SDL/releases?per_page=20"
        $r = $releases | Where-Object { $_.tag_name -match '^release-2\.' } | Select-Object -First 1
        $Sdl2Ver = $r.tag_name -replace '^release-', ''
        Write-Host "    Latest SDL2: $Sdl2Ver"
    } catch {
        $Sdl2Ver = "2.30.2"
        Write-Host "    GitHub query failed, using fallback SDL2 $Sdl2Ver"
    }
} else {
    Write-Host "[2/4] Using SDL2 $Sdl2Ver" -ForegroundColor Cyan
}

$depsDir   = "$BuildRoot\deps"
$sdl2Root  = "$depsDir\SDL2-$Sdl2Ver"
$sdl2Cmake = "$sdl2Root\cmake"
$buildDir  = "$BuildRoot\build"

New-Item -ItemType Directory -Force -Path $BuildRoot | Out-Null
New-Item -ItemType Directory -Force -Path $depsDir   | Out-Null
New-Item -ItemType Directory -Force -Path $buildDir  | Out-Null

# -----------------------------------------------------------------------
# 3. Download + extract SDL2 VC dev package
# -----------------------------------------------------------------------
if (-not (Test-Path $sdl2Root)) {
    $url = "https://github.com/libsdl-org/SDL/releases/download/release-$Sdl2Ver/SDL2-devel-$Sdl2Ver-VC.zip"
    $zip = "$depsDir\sdl2.zip"
    Write-Host "[3/4] Downloading SDL2-devel-$Sdl2Ver-VC.zip ..." -ForegroundColor Cyan
    (New-Object Net.WebClient).DownloadFile($url, $zip)
    Write-Host "      Extracting..."
    Expand-Archive -Path $zip -DestinationPath $depsDir -Force
    Remove-Item $zip
} else {
    Write-Host "[3/4] SDL2 $Sdl2Ver already present" -ForegroundColor Cyan
}

if (-not (Test-Path $sdl2Cmake)) {
    Write-Error "SDL2 cmake dir not found at $sdl2Cmake — check version/extraction"
    exit 1
}

# -----------------------------------------------------------------------
# 4. CMake configure + build via a temp batch (inherits vcvarsall env)
# -----------------------------------------------------------------------
Write-Host "[4/4] Configuring and building (x86 Release)..." -ForegroundColor Cyan

$bat = @"
@echo off
call "$vcvarsall" x86
if errorlevel 1 exit /b 1

cmake -B "$buildDir" -G "Visual Studio 17 2022" -A Win32 ^
    -DSDL2_DIR="$sdl2Cmake" ^
    "$SourceDir"
if errorlevel 1 exit /b 1

cmake --build "$buildDir" --config Release
if errorlevel 1 exit /b 1
"@

$batFile = "$env:TEMP\build_imgtool.bat"
[System.IO.File]::WriteAllText($batFile, $bat, [System.Text.Encoding]::ASCII)
& cmd.exe /c $batFile
$exitCode = $LASTEXITCODE

if ($exitCode -eq 0) {
    $exe = "$buildDir\Release\imgtool.exe"
    Write-Host ""
    Write-Host "*** Build succeeded ***" -ForegroundColor Green
    Write-Host "EXE: $exe" -ForegroundColor Green
    # SDL2.dll must be next to the exe
    $sdl2Dll = "$sdl2Root\lib\x86\SDL2.dll"
    if (Test-Path $sdl2Dll) {
        Copy-Item $sdl2Dll (Split-Path $exe) -Force
        Write-Host "Copied SDL2.dll to output folder" -ForegroundColor Green
    }
} else {
    Write-Host ""
    Write-Host "*** Build FAILED (exit $exitCode) ***" -ForegroundColor Red
}

exit $exitCode
