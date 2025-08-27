
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
echo DOWNLOADING TMPx Assembler
echo ========================================

:: Set installation directories
set "TMPx_DIR=%TOOLS_DIR%\TMPx_Emu"
set "TMPx_URL=https://style64.org/file/TMPx_v1.1.0-STYLE.zip"
set "TMPx_ZIP=%TEMP_DIR%\TMPx.zip"
mkdir "%TMPx_DIR%" 2>nul

:: Download TMPx Emulator
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%TMPx_ZIP%" "%TMPx_URL%"
) else (
    bitsadmin /transfer "TMPx_Download" "%TMPx_URL%" "%TMPx_ZIP%"
)

:: Extract TMPx Emulator
tar -xf "%TMPx_ZIP%" -C "%TMPx_DIR%"

:: Cleanup
del "%TMPx_ZIP%"

:: Final messages
echo.
echo ========================================
echo DONE!
echo Add these to your PATH (manually):
echo   %TMPx_DIR%
echo ========================================
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on