# tidal-nano
## Installation
```
cd path-to-directory
git clone https://github.com/IliaViazov/tidal-nano
./installation.sh
```
The following script assumes that you have installed `git` and `homebrew`. Basically what happens in the script:
- Updating Homebrew
- Installing haskell
- Installing tidal package in haskell
- Installing nano editor with syntaxhighlighting
- Installing SuperCollider and SuperDirt

Abstraction:
```
# Updating homebrew
brew update

# Installing haskell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Installing tidal package in haskell
cabal install tidal

# Installing nano editor and highlighting
brew install nano
git clone https://github.com/scopatz/nanorc.git $install_path

# Installing glow markdown viewer
brew install glow

# Installing SuperCollider and SuperDirt
brew install --cask supercollider
sclang -D <<EOL
Quarks.install("https://github.com/tidalcycles/Dirt-Samples")
s.waitForBoot {
    "Quarks installed".postln;
};
```

Very small README

I was always frustrated playing TidalCycles that before playing you need to make quite some steps (even without installation, just prepairing to play): open SC, boot SuperDirt, open TextEditor (in my case it was Pulsar), boot Tidal there. All together takes usually 5-6 minutes, could be optimised with fast movements to three, but still. And I was, honestly, haiting Pulsar, because it is quite annoying Text Editor sometimes.

So I decided to collect all neccessary boot files into a folder and write a smal bash script that will start everything and create several windows for better navigation. All together takes about 5-7 seconds and your double-click.

You need a regularly installed TidalCycles: haskell, tidal package for it, SuperCollider, all Quarks.

Just drop the whole repo into the Application folder. The script looks into the directory: /Application/tidal-nano. Please, notice, it is not user's root directory, but regular Applications.

Some notes:
- multi-line thingy you can make with this haskell syntax.
~~~
    :{ 
        d1 $ s "bd!4"
        #pan random
    :}
~~~
- the environment automatically loading reference (in process) and snippets.txt. The last one you can overwrite with whatever you want. Unfortunately you can't evaluate from there. I tried to use vim for that, but during evaluation it makes an annoying allert sound. Something that I will try to fix in the future



### References
Tidal Cycles: https://tidalcycles.org/
vim-tidal: https://github.com/tidalcycles/vim-tidal
Syntax Highlightning for Nano: https://github.com/scopatz/nanorc.git
Colored GHCI: https://github.com/rhysd/ghci-color/tree/master

