@echo off
setlocal EnableDelayedExpansion

set "SOURCE=\\wsl.localhost\Ubuntu\home\alex\midway-imgtool"
set "BUILDROOT=%LOCALAPPDATA%\imgtool-build"
set "BUILDDIR=%BUILDROOT%\build"
set "DEPSDIR=%BUILDROOT%\deps"
set "SDL2VER=2.30.2"
set "SDL2DIR=%DEPSDIR%\SDL2-%SDL2VER%"
set "SDL2CMAKE=%SDL2DIR%\cmake"

echo [1/4] Locating Visual Studio (via vswhere)...
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
set "VSROOT="
set "VSMAJOR="
if exist "%VSWHERE%" (
    for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do set "VSROOT=%%i"
    for /f "usebackq tokens=1 delims=." %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationVersion`) do set "VSMAJOR=%%i"
)
if not defined VSROOT (
    echo ERROR: Visual Studio with C++ tools ^(x86^) not found
    goto :fail
)
set "VCVARSALL=%VSROOT%\VC\Auxiliary\Build\vcvarsall.bat"
set "CMAKE=%VSROOT%\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
set "GENYEAR="
if "%VSMAJOR%"=="17" set "GENYEAR=2022"
if "%VSMAJOR%"=="18" set "GENYEAR=2026"
if not defined GENYEAR (
    echo ERROR: Unsupported Visual Studio version "%VSMAJOR%"
    goto :fail
)
set "GENERATOR=Visual Studio %VSMAJOR% %GENYEAR%"
echo        VS:        %VSROOT%
echo        generator: %GENERATOR%

echo [2/4] Setting up VS x86 environment...
call "%VCVARSALL%" x86
if errorlevel 1 (echo ERROR: vcvarsall failed & goto :fail)

if not exist "%CMAKE%" (
    echo ERROR: cmake not found at %CMAKE%
    goto :fail
)

echo [3/4] Creating build dirs ^& fetching SDL2 %SDL2VER%...
if not exist "%BUILDROOT%" mkdir "%BUILDROOT%"
if not exist "%BUILDDIR%" mkdir "%BUILDDIR%"
if not exist "%DEPSDIR%"   mkdir "%DEPSDIR%"
if not exist "%SDL2DIR%" (
    powershell -NoProfile -Command ^
        "[Net.ServicePointManager]::SecurityProtocol='Tls12';" ^
        "(New-Object Net.WebClient).DownloadFile(" ^
        "'https://github.com/libsdl-org/SDL/releases/download/release-%SDL2VER%/SDL2-devel-%SDL2VER%-VC.zip'," ^
        "'%DEPSDIR%\sdl2.zip')"
    if errorlevel 1 (echo ERROR: SDL2 download failed & goto :fail)
    powershell -NoProfile -Command ^
        "Expand-Archive -Path '%DEPSDIR%\sdl2.zip' -DestinationPath '%DEPSDIR%' -Force"
    if errorlevel 1 (echo ERROR: SDL2 extract failed & goto :fail)
    del "%DEPSDIR%\sdl2.zip"
) else (
    echo        SDL2 already present.
)

echo [4/4] CMake configure + build...
"%CMAKE%" -B "%BUILDDIR%" -G "%GENERATOR%" -A Win32 ^
    -DSDL2_DIR="%SDL2CMAKE%" ^
    "%SOURCE%"
if errorlevel 1 (echo ERROR: cmake configure failed & goto :fail)

"%CMAKE%" --build "%BUILDDIR%" --config Release -- /v:normal
if errorlevel 1 (echo ERROR: cmake build failed & goto :fail)

copy /Y "%SDL2DIR%\lib\x86\SDL2.dll" "%BUILDDIR%\Release\"

echo.
echo *** Build succeeded! ***
echo EXE : %BUILDDIR%\Release\imgtool.exe
echo Copy that folder somewhere and run imgtool.exe
goto :eof

:fail
echo.
echo *** Build FAILED ***
exit /b 1
