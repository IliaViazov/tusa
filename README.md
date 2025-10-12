# tidalüb
tidalüb (*tidal* for *Tidal Cycles*, *-lüb* — wordplay: *-lüb* — *Lübeck*, *-lüb* = *-люб*, russian analog for greek *-phil*) is a framework for Tidal Cycles that aims to proceed fast performance, minimalism and seamless usage during music practices.

The framework functions as a tmux workflow with different panes of a terminal performing different parts of the programm.
It features interpreter for Tidal Cycles, snippets window for fast copying precomposed material, reference window that represents [the official reference](https://tidalcycles.org/docs/reference/cycles) in a brief format, and a SuperCollider server.

## Features
- Stable performance
- Easy installation
- Fast boot-up
- Convenient keyboard shortcuts
- Syntax Highlighting
- Reference as a Cheat-Sheet
- No need to press Cmd+C to copy, copying is automatic while selecting
- For devs: all setting for dependencies are local and don't affect global .rc files
- Should work in any modern Bash Terminal

## Installation
```
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

## References to the used resources and repos
Tidal Cycles: https://tidalcycles.org/
vim-tidal: https://github.com/tidalcycles/vim-tidal
Syntax Highlightning for Nano: https://github.com/scopatz/nanorc.git
Colored GHCI: https://github.com/rhysd/ghci-color/tree/master

## FAQ
### SuperCollider crashed during performance
`Cmd + .` to kill.
`↑` then `Enter` to start again.

### How to add my samples?
Adjust this part of the code inside of the SuperCollider bootloader, adding your unique path or just put it into the Dirt Samples folder.
```
~dirt.loadSoundFiles("/Users/myUserName/Dirt-Samples/samples/*");
```
The path can differ from the example.

### How to add my synths?
Adjust this part of the code inside of the SuperCollider bootloader, adding your unique path or just put it into the Dirt Samples folder.
```
~dirt.loadSynthDefs("/Users/myUserName/SuperDirt/synthdefs/*");
```
The path can differ from the example.

### Don't like autocopying
Adjust .tmux.conf inside of the repositories folder.
