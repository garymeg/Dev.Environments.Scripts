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
echo DOWNLOADING Atari EMULATOR
echo ========================================
:: Set installation directories
set "ATARI_DIR=%TOOLS_DIR%\Atari-Emulator"
set "ATARI_URL=https://www.virtualdub.org/downloads/Altirra-4.31.zip"
mkdir "%ATARI_DIR%" 2>nul

:: Download Atari Emulator
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%ATARI_DIR%\Altirra-4.31.zip" "%ATARI_URL%"
) else (
    bitsadmin /transfer "ATARI_Download" "%ATARI_URL%" "%ATARI_DIR%\Altirra-4.31.zip"
)

:: Extract Atari Emulator
tar -xf "%ATARI_DIR%\Altirra-4.31.zip" -C "%ATARI_DIR%"

:: Cleanup
del "%ATARI_DIR%\Altirra-4.31.zip"

:: Final messages
echo.
echo ========================================
echo DONE!
echo Add these to your PATH (manually):
echo   %ATARI_DIR%
echo ========================================
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on

