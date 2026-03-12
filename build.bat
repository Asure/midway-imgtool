@echo off
setlocal EnableDelayedExpansion

set VCVARSALL=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat
set SOURCE=\\wsl.localhost\Ubuntu\home\alex\midway-imgtool
set BUILDROOT=%LOCALAPPDATA%\imgtool-build
set BUILDDIR=%BUILDROOT%\build
set DEPSDIR=%BUILDROOT%\deps
set SDL2VER=2.30.2
set SDL2DIR=%DEPSDIR%\SDL2-%SDL2VER%
set SDL2CMAKE=%SDL2DIR%\cmake
set CMAKEVER=3.29.3
set CMAKEDIR=%DEPSDIR%\cmake-%CMAKEVER%-windows-i386
set CMAKE=%CMAKEDIR%\bin\cmake.exe

echo [1/4] Setting up VS 2022 x86 environment...
call "%VCVARSALL%" x86
if errorlevel 1 (echo ERROR: vcvarsall failed & goto :fail)

echo [2/4] Creating build dirs...
if not exist "%DEPSDIR%" mkdir "%DEPSDIR%"
if not exist "%BUILDDIR%" mkdir "%BUILDDIR%"

echo [3/4] Getting cmake %CMAKEVER% + SDL2 %SDL2VER%...
if not exist "%CMAKE%" (
    powershell -NoProfile -Command ^
        "[Net.ServicePointManager]::SecurityProtocol='Tls12';" ^
        "(New-Object Net.WebClient).DownloadFile(" ^
        "'https://github.com/Kitware/CMake/releases/download/v%CMAKEVER%/cmake-%CMAKEVER%-windows-i386.zip'," ^
        "'%DEPSDIR%\cmake.zip')"
    if errorlevel 1 (echo ERROR: cmake download failed & goto :fail)
    powershell -NoProfile -Command ^
        "Expand-Archive -Path '%DEPSDIR%\cmake.zip' -DestinationPath '%DEPSDIR%' -Force"
    if errorlevel 1 (echo ERROR: cmake extract failed & goto :fail)
    del "%DEPSDIR%\cmake.zip"
) else (
    echo        cmake already present.
)

echo        Getting SDL2 %SDL2VER%...
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
    echo        Already present.
)

echo [4/4] CMake configure + build...
"%CMAKE%" -B "%BUILDDIR%" -G "Visual Studio 17 2022" -A Win32 ^
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
