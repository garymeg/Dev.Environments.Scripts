@echo off
setlocal enabledelayedexpansion
cls

:: Set Common directories
set "TOOLS_DIR=%USERPROFILE%\DeveloperTools"
set "TEMP_DIR=%TEMP%\DevSetup"
:: Create Common directories
mkdir "%TOOLS_DIR%" "%TEMP_DIR%" >nul 2>nul  2>nul >nul 2>nul  2>nul >nul 2>nul  2>nul >nul 2>nul

:: Check for curl or fallback
where curl >nul 2>nul
if errorlevel 1 (
    echo curl not found. Trying bitsadmin...
    set "DOWNLOADER=bitsadmin"
) else (
    set "DOWNLOADER=curl"
)

echo ========================================
echo DOWNLOADING PASMO ASSEMBLER
echo ========================================
:: Set installation directories
set "PASMO_DIR=%TOOLS_DIR%\PASMO-Assembler"
set "PASMO_URL=https://pasmo.speccy.org/bin/pasmo-0.5.4.beta2.zip"
set "PASMO_ZIP=%TEMP_DIR%\pasmo.zip"
mkdir "%PASMO_DIR%" 2>nul

:: Download PASMO Assembler
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%PASMO_ZIP%" "%PASMO_URL%"
) else (
    bitsadmin /transfer "PASMODownload" "%PASMO_URL%" "%PASMO_ZIP%"
)

:: Extract PASMO Assembler
tar -xf "%PASMO_ZIP%" -C "%PASMO_DIR%"

:: Cleanup
del "%PASMO_ZIP%"

:: Final messages
echo.
echo ========================================
echo DONE!
echo Add these to your PATH (manually):
echo   %PASMO_DIR%
echo ========================================
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on
