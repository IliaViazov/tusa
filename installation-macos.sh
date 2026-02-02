#!/usr/bin/env bash
set -e

echo "Starting setup for TidalCycles environment..."

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}


#0.a Creating a symlink from root to the app
ln -sf $PWD ~/tcii

#0.b Creating an icon to the app and .command
./config-util/setIcon.sh config-util/logo.png tcii.app
./config-util/setIcon.sh config-util/logo.png tcii.command

#0.c Update Homebrew
echo "Updating Homebrew..."
brew update

# 1. Install Haskell via ghcup
if ! command_exists ghc ; then
    echo "Installing Haskell via ghcup..."
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    echo "Haskell installation complete. You may need to restart your terminal or source your profile."
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
else
    echo "Haskell already installed."
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
fi

# 1a. Install Python via homebrew
if ! command_exists python3 ; then
    echo "Installing Python via homebrew..."
    brew install python3
    echo "Python installation complete. You may need to restart your terminal or source your profile."
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
else
    echo "Python already installed."
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
fi

# 2. Install TidalCycles package
if ! ghc-pkg list | grep -q tidal ; then
    echo "Installing TidalCycles..."
    cabal update
    cabal install --lib tidal
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
else
    echo "TidalCycles already installed."
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
fi

# 3.a Install Nano editor
if ! command_exists nano ; then
    echo "Installing Nano editor..."
    brew install nano
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
else
    echo "Nano already installed."
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
fi

# 3.b Install Glow
if ! command_exists glow ; then
    echo "Installing Glow..."
    brew install glow
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
else
    echo "Glow exists"
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
fi

# 3.c Install tmux
if ! command_exists tmux ; then
    echo "Installing tmux..."
    brew install tmux
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
else
    echo "tmux already installed."
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
fi

# 4. Install SuperCollider
if ! command_exists sclang ; then
    echo "Installing SuperCollider..."
    brew install --cask supercollider
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
else
    echo "SuperCollider already installed."
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
fi

# 5. Install necessary Quarks for TidalCycles
curl -Lk https://github.com/supercollider/sc3-plugins/releases/download/Version-3.13.0/sc3-plugins-3.13.0-macOS.zip --output /tmp/sc3plugins.zip
	/bin/mkdir -p ~/Library/Application\ Support/SuperCollider/Extensions/SC3Plugins
	unzip -nq /tmp/sc3plugins.zip -d ~/Library/Application\ Support/SuperCollider/Extensions/SC3Plugins
    rm /tmp/sc3plugins.zip
    echo "sc3-plugins installed"
curl -Lk https://github.com/flucoma/flucoma-sc/archive/refs/tags/1.0.9.zip -o /tmp/flucoma-sc-1.0.9.zip
    mkdir -p ~/Library/Application\ Support/SuperCollider/Extensions/Flucoma
    unzip -nq /tmp/flucoma-sc-1.0.9.zip -d ~/Library/Application\ Support/SuperCollider/Extensions/Flucoma/
    rm /tmp/flucoma-sc-1.0.9.zip
    echo "flucoma installed"

echo "Installing SuperDirt and Dirt Samples Quarks..."
sclang -D <<EOL
Quarks.install("https://github.com/tidalcycles/Dirt-Samples");
Quarks.install("https://github.com/musikinformatik/SuperDirt");

s.waitForBoot {
    "Quarks installed".postln;
    0.exit();
};
EOL

echo "Dirt Samples and SuperDirt are installed. Now everything should work"
