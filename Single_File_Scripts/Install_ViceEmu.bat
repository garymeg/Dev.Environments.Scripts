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
echo DOWNLOADING VICE EMULATOR
echo ========================================
:: Set installation directories
set "VICE_URL=https://github.com/VICE-Team/svn-mirror/releases/download/r45737/GTK3VICE-3.9-win64-r45737.zip"
set "VICE_ZIP=%TEMP_DIR%\VICE.zip"
set "VICE_DIR=%TOOLS_DIR%\Vice"
mkdir "%VICE_DIR%" 2>nul

:: Download VICE Emulator
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%VICE_ZIP%" "%VICE_URL%"
) else (
    bitsadmin /transfer "VICEDownload" "%VICE_URL%" "%VICE_ZIP%"
)

:: Extract VICE Emulator
tar -xf "%VICE_ZIP%" --strip-components=1 -C "%VICE_DIR%"

:: Cleanup
del "%VICE_ZIP%"

:: Final messages
echo.
echo ========================================
echo DONE!
echo Add these to your PATH (manually):
echo   %VICE_DIR%/bin
echo ========================================
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on
