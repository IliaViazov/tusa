# tidalüb

## Features
- Much more stable performance than other possible solutions
- Easy installation
- After installation: Double-click and then ready to play, nothing more
- Four separate windows: interpreter, snippets window, reference window and SuperCollider server window
- Syntax Highlighting
- Reference ala Cheat-Sheet
- No need to press Cmd+C to copy, copying is automatic while selecting (if it disturbs — check .tmux.conf)
- For devs: all setting for dependencies are local and don't affect global .rc files
- Should work in any modern Bash Terminal

## Installation
```
#bash
cd path-to-directory
git clone https://github.com/IliaViazov/tidal-nano
./installation.sh
```

The following script assumes that you have installed `git` and `homebrew`. The installation algorithm is following:
- Installing haskell
- Installing tidal package for haskell
- Installing nano editor
- Installing glow
- Installing tmux
- Installing SuperCollider and SuperDirt

## Usage
### Start
```
cd path-to-directory
./tidal-nano.command
```
or
*just double click* **the .command file**
or
*just double click* **the app**

### Finish
In interpreter window type:
```
:quit
tmux kill-server
```
and then close the window.

### Multi-line
Multi-line could be used in a standard haskell manner:
```
:{
d1 $ "bd sn bd sn"
#gain rand
#octer 0.5
#room 1
:}
```

### 

## References to the used resources and repos
Tidal Cycles: https://tidalcycles.org/
vim-tidal: https://github.com/tidalcycles/vim-tidal
Syntax Highlightning for Nano: https://github.com/scopatz/nanorc.git
Colored GHCI: https://github.com/rhysd/ghci-color/tree/master

## FAQ
### How to add my samples?
### How to add my synths?
