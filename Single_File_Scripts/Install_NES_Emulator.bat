@echo off
setlocal enabledelayedexpansion
cls

:: Set Common directories
set "TOOLS_DIR=%USERPROFILE%\DeveloperTools"
set "TEMP_DIR=%TEMP%\DevSetup"
:: Create Common directories
mkdir "%TOOLS_DIR%" "%TEMP_DIR%" >nul 2>nul

:: Check for curl or fallback
where curl >nul 2>nul
if errorlevel 1 (
    echo curl not found. Trying bitsadmin...
    set "DOWNLOADER=bitsadmin"
) else (
    set "DOWNLOADER=curl"
)

echo ========================================
echo DOWNLOADING NES EMULATOR
echo ========================================

:: Set installation directories
set "NES_DIR=%TOOLS_DIR%\NES_Emulator"
set "NES_URL=https://github.com/TASEmulators/fceux/releases/download/v2.6.6/fceux-2.6.6-win64.zip"
set "NES_ZIP=%TEMP_DIR%\NES.zip"
mkdir "%NES_DIR%" 2>nul

:: Download NES Emulator
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%NES_ZIP%" "%NES_URL%"
) else (
    bitsadmin /transfer "NESDownload" "%NES_URL%" "%NES_ZIP%"
)

:: Extract NES Emulator
tar -xf "%NES_ZIP%" -C "%NES_DIR%"

:: Cleanup
del "%NES_ZIP%"

:: Final messages
echo.
echo ========================================
echo DONE!
echo Add these to your PATH (manually):
echo   %NES_DIR%
echo ========================================
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on
