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
echo DOWNLOADING ZEsarUX EMULATOR
echo ========================================
:: Set installation directories
set "ZESARUX_DIR=%TOOLS_DIR%\ZEsarUX"
mkdir "%ZESARUX_DIR%" 2>nul

:: Download ZEsarUX
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%ZESARUX_ZIP%" "%ZESARUX_URL%"
) else (
    bitsadmin /transfer "ZEsarUXDownload" "%ZESARUX_URL%" "%ZESARUX_ZIP%"
)

:: Extract ZEsarUX
tar -xf "%ZESARUX_ZIP%" --strip-components=1 -C "%ZESARUX_DIR%"

:: Cleanup
del "%ZESARUX_ZIP%"

:: Final messages
echo.
echo ========================================
echo DONE!
echo Add these to your PATH (manually):
echo   %ZESARUX_DIR%
echo ========================================
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on
