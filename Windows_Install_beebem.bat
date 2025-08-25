@echo off
setlocal enabledelayedexpansion

:: Set directories
set "TOOLS_DIR=%USERPROFILE%\DeveloperTools"
set "TEMP_DIR=%TEMP%\DevSetup"
set "KICK_DIR=%TOOLS_DIR%\KickAssembler"
set "BEEBEM_DIR=%TOOLS_DIR%\BeebEm"
set "BEEBASM_DIR=%TOOLS_DIR%\BeebAsm"
set "EXTENSION=paulhocker.kick-assembler-vscode-ext"
set "BEEBASM_EXTENSION=simondotm.beeb-vsc"
set "CONFIG_DIR=%USERPROFILE%\AppData\Roaming\Code\User"
set "SETTINGS_FILE=%CONFIG_DIR%\settings.json"

:: Create directories
mkdir "%TOOLS_DIR%" 2>nul
mkdir "%TEMP_DIR%" 2>nul
mkdir "%KICK_DIR%" 2>nul
mkdir "%BEEBASM_DIR%" 2>nul
mkdir "%BEEBEM_DIR%" 2>nul

:: Check for curl or fallback
where curl >nul 2>nul
if errorlevel 1 (
    echo curl not found. Trying bitsadmin...
    set "DOWNLOADER=bitsadmin"
) else (
    set "DOWNLOADER=curl"
)

echo ========================================
echo INSTALLING JDK 8 (Temurin from Adoptium)
echo ========================================
set "JDK_URL=https://download.java.net/java/GA/jdk24.0.1/24a58e0e276943138bf3e963e6291ac2/9/GPL/openjdk-24.0.1_windows-x64_bin.zip"
set "JDK_ZIP=%TEMP_DIR%\jdk.zip"
set "JDK_DEST=%TOOLS_DIR%\jdk"

mkdir "%JDK_DEST%" 2>nul

if "%DOWNLOADER%"=="curl" (
    curl -L -o "%JDK_ZIP%" "%JDK_URL%"
) else (
    bitsadmin /transfer "JDKDownload" "%JDK_URL%" "%JDK_ZIP%"
)

tar -xf "%JDK_ZIP%" -C "%JDK_DEST%"

set PATH=%PATH%;%JDK_DEST%\jdk-24.0.1\bin

echo ========================================
echo INSTALLING GIT
echo ========================================
set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.50.0.windows.1/Git-2.50.0-64-bit.exe"
set "GIT_EXE=%TEMP_DIR%\git-installer.exe"

curl -L -o "%GIT_EXE%" "%GIT_URL%"
"%GIT_EXE%" /VERYSILENT /NORESTART /DIR="%TOOLS_DIR%\Git"

set PATH=%PATH%;%TOOLS_DIR%\Git\cmd

echo ========================================
echo INSTALLING VISUAL STUDIO CODE
echo ========================================
set "VSCODE_URL=https://update.code.visualstudio.com/latest/win32-x64-user/stable"
set "VSCODE_EXE=%TEMP_DIR%\vscode-installer.exe"

curl -L -o "%VSCODE_EXE%" "%VSCODE_URL%"
"%VSCODE_EXE%" /VERYSILENT /NORESTART /MERGETASKS=!runcode

set PATH=%PATH%;%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\bin

echo ========================================
echo DOWNLOADING KICK ASSEMBLER
echo ========================================
set "KICK_URL=https://www.theweb.dk/KickAssembler/KickAssembler.zip"
set "KICK_ZIP=%TEMP_DIR%\kickassembler.zip"

curl -L -o "%KICK_ZIP%" "%KICK_URL%"
tar -xf "%KICK_ZIP%" -C "%KICK_DIR%"


echo ========================================
echo INSTALLING Visual C++ Redistributable
echo ========================================
set MSVC_URL="https://aka.ms/vs/17/release/vc_redist.x86.exe"
set "MSVC_EXE=%TEMP_DIR%\vc_redist.x86.exe"
curl -L -o "%MSVC_EXE%" "%MSVC_URL%"
"%MSVC_EXE%" /QUIET /NORESTART

echo ========================================
echo DOWNLOADING BEEBASM
echo ========================================
set "BEEBASM_URL=https://github.com/stardot/beebasm/releases/download/v1.10/beebasm-win32.zip"
set "BEEBASM_ZIP=%TEMP_DIR%\beebasm.zip"

curl -L -o "%BEEBASM_ZIP%" "%BEEBASM_URL%"
tar -xf "%BEEBASM_ZIP%" -C "%BEEBASM_DIR%"
set PATH=%PATH%;%TOOLS_DIR%\beebasm

echo ========================================
echo DOWNLOADING beebem EMULATOR
echo ========================================
set "beebem_url=https://github.com/stardot/beebem-windows/releases/download/4.19/BeebEm419.zip"
set "beebem_ZIP=%TEMP_DIR%\beebem419.zip"

curl -L -o "%beebem_ZIP%" "%beebem_url%"
tar -xf "%beebem_ZIP%" -C "%TOOLS_DIR%"

set PATH=%PATH%;%TOOLS_DIR%\beebem

@echo on
> %SETTINGS_FILE% echo {
>> %SETTINGS_FILE% echo     "editor.tabSize": 4,
>> %SETTINGS_FILE% echo     "editor.rulers": [80, 120],
>> %SETTINGS_FILE% echo     "files.autoSave": "afterDelay",
>> %SETTINGS_FILE% echo     "kickassembler.java.runtime": "%JDK_DEST:\=/%/jdk-24.0.1/bin/java.exe",
>> %SETTINGS_FILE% echo     "kickassembler.assembler.jar": "%KICK_DIR:\=/%/KickAss.jar",
>> %SETTINGS_FILE% echo     "kickassembler.emulator.runtime": "%TOOLS_DIR:\=/%/beebem/BeebEm.exe",
>> %SETTINGS_FILE% echo }

code --install-extension "%EXTENSION%" --force
code --install-extension "%BEEBASM_EXTENSION%" --force

echo.
echo ========================================
echo DONE!
echo Add these to your PATH (manually):
echo   %JDK_DEST%\bin
echo   %TOOLS_DIR%\Git\bin
echo   %KICK_DIR%
echo   %X16_DIR%
echo ========================================
pause
