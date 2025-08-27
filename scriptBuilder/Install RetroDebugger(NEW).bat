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
echo DOWNLOADING RETRO Debugger
echo ========================================
:: Set installation directories
set "RETRODEBUG_URL=https://github.com/slajerek/RetroDebugger/releases/download/v0.64.72/RetroDebugger.v0.64.72-windows-x64-notsigned.zip"
set "RETRODEBUG_ZIP=%TEMP_DIR%\RetroDebugger.zip"
set "RETRODEBUG_DIR=%TOOLS_DIR%\RetroDebugger"
mkdir "%RETRODEBUG_DIR%" 2>nul

:: Download RetroDebugger
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%RETRODEBUG_ZIP%" "%RETRODEBUG_URL%"
) else (
    bitsadmin /transfer "RetroDebuggerDownload" "%RETRODEBUG_URL%" "%RETRODEBUG_ZIP%"
)

:: Extract RetroDebugger
tar -xf "%RETRODEBUG_ZIP%" --strip-components=1 -C "%RETRODEBUG_DIR%"

:: Cleanup
del "%RETRODEBUG_ZIP%"

:: Final messages
echo.
echo ========================================
echo DONE!
echo Add these to your PATH (manually):
echo   %RETRODEBUG_DIR%
echo ========================================
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on
