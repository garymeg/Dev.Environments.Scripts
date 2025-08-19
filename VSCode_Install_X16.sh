#!/bin/bash

# Exit if any command fails
set -e

# ====== Configurable Variables ======
EXTENSION="paulhocker.kick-assembler-vscode-ext"
CONFIG_DIR="$HOME/.config/Code/User"
SETTINGS_FILE="$CONFIG_DIR/settings.json"
# URL of the zip file
KICK_URL="https://theweb.dk/KickAssembler/KickAssembler.zip"
KICK_FILE="KickAss.zip"
KICK_DIR="$HOME/Documents/Tools/KickAss"
X16_EXAMPLES_DIR="$HOME/Documents/X16/VSCode.X16.Learning"

sudo apt update
sudo apt-get install -y curl unzip

# ====== Install GIT ======
echo "Installing GIT..."
sudo apt install -y git

# ====== Install Java ======
echo "Installing Java..."
sudo apt install -y default-jdk

# ====== Install Kick Assembler ======
echo "Installing Kick Assembler..."
if [ -e "$KICK_FILE" ]; then
    echo "File exists."
else
    curl -L -o "$KICK_FILE" "$KICK_URL"
    mkdir -p "$KICK_DIR"
    unzip "$KICK_FILE" -d "$KICK_DIR"
fi

# ====== Install X16 Emulator ======
echo "Installing X16 Emulator..."
sudo apt install -y snapd
sudo snap install core
sudo snap install x16emu

# ====== Install VS Code ======
echo "Installing VS Code..."
ARCH=$(dpkg --print-architecture)
if [[ "$ARCH" == "armhf" ]]; then
    sudo apt install -y code
elif [[ "$ARCH" == "arm64" ]]; then
    sudo apt install -y code
else
    sudo snap install code --classic
fi

# ====== Install VS Code Extension ======
echo "Installing VS Code extension: $EXTENSION..."
code --install-extension "$EXTENSION" --force

# ====== Create settings.json ======
echo "Configuring VS Code settings..."
mkdir -p "$CONFIG_DIR"

cat <<EOF > "$SETTINGS_FILE"
{
    "editor.tabSize": 4,
    "editor.rulers": [80, 120],
    "files.autoSave": "afterDelay",
    "kickassembler.java.runtime": "/usr/bin/java",
    "kickassembler.assembler.jar": "$KICK_DIR/KickAss.jar",
    "kickassembler.emulator.runtime": "/snap/bin/x16emu",
}
EOF

git clone https://github.com/OldSkoolCoder/VSCode.X16.Learning.git "$X16_EXAMPLES_DIR"
cd "$X16_EXAMPLES_DIR"
git checkout "Episode-06"
#sed -i "s/\\\\/-/g" "$X16_EXAMPLES_DIR/VSCode.X16.HelloWorld.code-workspace"
sed -i "s|E:/MyEmulators/X16-R48/x16emu.exe|/snap/bin/x16emu|g" "$X16_EXAMPLES_DIR/VSCode.X16.HelloWorld.code-workspace"
#sed -i "s,C:\\\\Users\\\\John\\\\Desktop\\\\CommanderX16\\\\R46\\\\x16emu.exe,/snap/bin/x16emu,g" "$X16_EXAMPLES_DIR/VSCode.X16.HelloWorld.code-workspace"

echo "VS Code is installed and configured with the $EXTENSION extension!"