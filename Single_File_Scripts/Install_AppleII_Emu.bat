@echo off
setlocal enabledelayedexpansion
cls

:: Set Common directories
set "TOOLS_DIR=%USERPROFILE%\DeveloperTools"
set "TEMP_DIR=%TEMP%\DevSetup"
:: Create Common directories
mkdir "%TOOLS_DIR%" "%TEMP_DIR%"

:: Check for curl or fallback
where curl >nul 2>nul
if errorlevel 1 (
    echo curl not found. Trying bitsadmin...
    set "DOWNLOADER=bitsadmin"
) else (
    set "DOWNLOADER=curl"
)


echo ========================================
echo DOWNLOADING Apple II EMULATOR
echo ========================================

:: Set installation directories
set "APPLE2_DIR=%TOOLS_DIR%\AppleII_Emu"
set "APPLE2_URL=https://github.com/AppleWin/AppleWin/releases/download/v1.30.21.0/AppleWin1.30.21.0.zip"
set "APPLE2_ZIP=%TEMP_DIR%\AppleIIEmulator.zip"
mkdir "%APPLE2_DIR%" 2>nul

:: Download Apple II Emulator
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%APPLE2_ZIP%" "%APPLE2_URL%"
) else (
    bitsadmin /transfer "APPLE2_Download" "%APPLE2_URL%" "%APPLE2_ZIP%"
)

:: Extract Apple II Emulator
tar -xf "%APPLE2_ZIP%" -C "%APPLE2_DIR%"

:: Cleanup
del "%APPLE2_ZIP%"

:: Final messages
echo.
echo ========================================
echo DONE!
echo Add these to your PATH (manually):
echo   %APPLE2_DIR%
echo ========================================
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on