#!/usr/bin/env bash
set -e

echo "Starting setup for TidalCycles environment..."

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}


#0.a Creating a symlink from root to the app
ln -sf $PWD ~/tidalueb

#0.b Creating an icon to the app and .command
./setIcon.sh logo.png tidalueb.app
./setIcon.sh logo.png tidalueb.command

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

# 2. Install TidalCycles package
if ! ghc-pkg list | grep -q tidal ; then
    echo "Installing TidalCycles..."
    cabal update
    cabal install tidal
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
else
    echo "TidalCycles already installed."
    echo "export PATH=\"$PATH\"" >> ~/.bashrc
fi

# 3.a Install Nano editor and highlight
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
echo "Installing TidalCycles Quarks..."
sclang -D <<EOL
Quarks.install("https://github.com/tidalcycles/Dirt-Samples")
s.waitForBoot {
    "Quarks installed".postln;
};
EOL

echo "Setup complete! Please restart your terminal and enjoy TidalCycles."
