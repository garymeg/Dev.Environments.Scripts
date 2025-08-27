http://sun.hasenbraten.de/vasm/bin/rel/vasm6502_std_Win64.zip

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
echo DOWNLOADING VASM ASSEMBLER
echo ========================================
:: Set installation directories
set "VASM_DIR=%TOOLS_DIR%\Vasm-Assembler"
set "VASM_URL=http://sun.hasenbraten.de/vasm/bin/rel/vasm6502_std_Win64.zip"
mkdir "%VASM_DIR%" 2>nul

:: Download VASM Assembler
if "%DOWNLOADER%"=="curl" (
    curl -L -o "%VASM_DIR%\vasm6502_std_Win64.zip" "%VASM_URL%"
) else (
    bitsadmin /transfer "VASM_Download" "%VASM_URL%" "%VASM_DIR%\vasm6502_std_Win64.zip"
)

:: Extract VASM Assembler
tar -xf "%VASM_DIR%\vasm6502_std_Win64.zip" -C "%VASM_DIR%"

:: Cleanup
del "%VASM_DIR%\vasm6502_std_Win64.zip"

:: Final messages
echo.
echo ========================================
echo DONE!
echo Add these to your PATH (manually):
echo   %VASM_DIR%
echo ========================================
start rundll32 sysdm.cpl,EditEnvironmentVariables
pause
@echo on
