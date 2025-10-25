# tidalueb

tidalueb (*tidal* for *Tidal Cycles*, *-lueb* — wordplay: *-lueb* — *Lübeck*, *-lueb* = *-люб*, Russian analogue for Greek *-phil*) is a framework for Tidal Cycles that aims to provide fast performance, minimalism, and seamless usage during music practices.

The framework functions as a tmux workflow with different panes of a terminal performing different parts of the program.
It features an interpreter for Tidal Cycles, a snippets window for fast copying of precomposed material, a reference window that represents [the official reference](https://tidalcycles.org/docs/reference/cycles) in a brief format, and a SuperCollider server.

## Features
- Stable performance
- Easy installation
- Fast boot-up
- Convenient keyboard shortcuts
- Syntax highlighting
- Reference as a cheat sheet
- No need to press Cmd+C to copy; copying is automatic while selecting
- For devs: all settings for dependencies are local and don't affect global .rc files
- Should work in any modern Bash terminal

## Installation

```sh
cd path-to-directory
git clone https://github.com/IliaViazov/tidalueb
./installation.sh
```

The following script assumes that you have installed `git` and `homebrew`. The installation process is as follows:
- Installing Haskell
- Installing the Tidal package for Haskell
- Installing the nano editor
- Installing glow
- Installing tmux
- Installing SuperCollider and SuperDirt

## Usage

### Start

```sh
cd path-to-directory
./tidalueb.command
```
or  
*just double-click* **the .command file**  
or  
*just double-click* **the app**

### Finish

In the interpreter window, type:
```haskell
:quit
-- or
:q
```
and then close the window. Native haskell commands :q and :quit are overwritten so that they automatically close the tmux session.

### Multi-line

Multi-line can be used in the standard Haskell manner:
```haskell
:{
d1 $ "bd sn bd sn"
# gain rand
# octer 0.5
# room 1
:}
```

## References to the used resources and repos

- Tidal Cycles: https://tidalcycles.org/
- vim-tidal: https://github.com/tidalcycles/vim-tidal
- Syntax Highlighting for Nano: https://github.com/scopatz/nanorc.git
- Colored GHCI: https://github.com/rhysd/ghci-color/tree/master

## FAQ

### SuperCollider crashed during performance

`Cmd + .` to kill.  
`↑` then `Enter` to start again.

### How do I add my samples?

Adjust this part of the code inside the SuperCollider bootloader, adding your unique path or just put it into the Dirt Samples folder.
```supercollider
~dirt.loadSoundFiles("/Users/myUserName/Dirt-Samples/samples/*");
```
The path may differ from the example.

### How do I add my synths?

Adjust this part of the code inside the SuperCollider bootloader, adding your unique path or just put it into the Dirt Samples folder.
```supercollider
~dirt.loadSynthDefs("/Users/myUserName/SuperDirt/synthdefs/*");
```
The path may differ from the example.

### Don't like autocopying?

Adjust `.tmux.conf` inside the repository's folder.
