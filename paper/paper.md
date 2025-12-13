# tcii 
# Tidal Cycles Instrumental Interface

## Abstract

Overview of Software DMI "tcii" (stands for "Tidal Cycles Instrumental Interface") for Tidal Cycles live-coding programming language implemented in the terminal. tcii creates a seamless workflow for improvisation and learning, oriented to personal use as an instrument that could be set up in a few seconds and run locally. 
In the article, I provide an overview of how the program is organised, as well as showing examples of my artistic practice with Tidal Cycles in areas of ambisonics and machine learning.
## Introduction

Interface shapes the interaction, and the way the interaction occurs defines the interface's overall usability, influencing its evolution.  The minimal interface of the computer (mouse/touchpad and keyboard as an input, and screen with loudspeakers as feedback devices) doesn't create much of a field for interaction, rather absolutely loses the battle in comparison with your phone, but is at the same time probably the most powerful and practical DSP device that a musician has at home. 
The computer was not designed with the thought of making it a good DMI. It lacks different types of interaction, which is why we always try to extend it using peripheral devices. Lacking a variety of interactions via interface surface, on the other hand, the computer proposes another beneficial side — very accurate work with information, leading it to be used as a magical black box that can calculate everything and be connected to peripheral devices, with which a person usually has already performative interaction (MIDI-keyboard, DIY-controllers, etc).
Live-Coding, as an improvisational/compositional performative practice, uses these limitations and abuses the ability of the computer to precisely generate the desired result to create funky sounds, giving the computer keyboard new performative instrumental qualities. 
tcii (or "Tidal Cycles Instrumental Interface") is a framework for the Tidal Cycles programming language that tries to accomplish several needs during live-coding practice in this language. It creates a TUI for Tidal Cycles in the Terminal, that supports interaction with the interpreter of the language, SuperCollider server, a very basic text editor and a reference of the language, keeping the setup very minimal, but on the other hand, able to handle greater abuse of the system, still having nice UI features like auto-saving and auto-copying. 

## tcii

The traditional variant of the installation of Tidal Cycles requires having several units of the software, and the experience of going through that might be considered extreme for a beginner/intermediate laptop user. Also as running and managing several applications at once can be challenging, and sometimes does not provide stable performance in the situation of stressed code execution. Building this framework, I was trying to solve my personal performative problems, which I wanted to improve in my setup of Tidal Cycles, as well as creating a reusable platform for other people that can offer easier expansion, allowing the system to execute something more. Many of the decisions were dictated out of thinking in the instrumental paradigm of laptop playing, trying to notice what actually falls out, missing in the interface what would allow me as a performer to be a bit happier. 

After some thinking process, I decided to establish a workflow that runs directly in the terminal through a terminal multiplexer that supports different parts of the application:
1) TidalCycles REPL
2) Snippets window, which you can use for pre-written material
3) Reference window with small cheat-sheets (abstraction of the original documentation)
4) Super Collider Server

### TidalCycles REPL

For the Tidal Cycles REPL, I used direct implementation in GHCi. The GHCi runs an interpreter for TidalCycles via a Haskell Package that was originally developed by Alex McLean. On top of traditional GHCi, a very simple syntax highlighting was installed to create better readability for the user. 
In addition to a traditional TidalCycles booter was a command `:finish` for REPL that runs a script, closing all the processes, including backend, and saves your REPL session as a separate file with prompts, so you can look through it for some future material.

### Snippets

Interpreter allows you to execute the command in an interactive way, but doesn't allow you the ability to edit the text. To solve that problem was included a separate pane for Nano editor — a free-libre text editor that comes with probably any bash shell automatically, so usually there is no need to install it. Nano opens a `.hs` file and allows you to edit text with syntax highlighting, copy via just selecting the text (no need to press `Cmd+C`, which can significantly save time during performance) and paste it into the REPL Window. All traditional Nano shortcuts were reconfigured to be more common once (comparison: default Nano `Ctl+X` vs common `Ctl+Q` to quit the program), but with a local configuration file, which doesn't affect global settings of the Nano editor, in case it's needed.

### Reference

Original documentation of TidalCycles exists in the format of a Website and a repository, but not as something integrated and adjusted for fast use during improvisation, in situations when you forget something or keep running into a syntax mistake, or just simply remind yourself, or even learn.

I took the original documentation and reduced it to smaller definitions, creating a set of cheat-sheets, which can be used even during performance. Currently, it supports the following sections of the original documentation:
- Notation and Syntax
- Samples
- Synthesizers 
- Effects
- Oscillators and Generators
- Transitions

All of these pages are written as `.md` files, and run in the Glow Markdown Reader for the Terminal, which allows you to navigate through the documentation using your arrow keys and mouse.

### SuperCollider

SuperCollider part was realised as a running server in a separate terminal pane, with a standard TidalCycles bootloader, with little adjustments to always choose your Default Sound Device, to which you are connected in the main settings of the computer (to minimise the setup time, if we speak of traditional stereo playing). Also server is loaded with an OSCFunc that posts the stats of the server to keep track if you are on the edge of a crash.

### Installation and Setup

All installation scripts were organised in one main script that essentially does next:
- Installs Haskell and Python (for autosaving feature);
- TidalCycle package for Haskell;
- Nano, Glow, tmux;
- SuperCollider and dependencies;

After that, it unpacks all the scripts and creates an application `tcii.app`, which refers to the file with a bash script in the repositories folder, but much nicer to use, because you can call it even from Finder. 

### Personal use of the system

Currently, in my own artistic practice, I have expanded the initial setup of tcii to support a beam forming algorithm. The easiest and cheapest way was to implement it by creating an initial setup of SuperDirt with a multi-channel configuration of 8, and then passing these audio buses to Kronlachner's ambiX encoder, which encodes these 8 signals as a virtual space of 8-channel loudspeaker ring into B-Format for third-order ambisonics and then convolves it with mcfx convolver to use spatialisation with the IKO loudspeaker. This allowed to spatialise the sound across azimuth using only the native `#pan` function, as well as perform azimuth modulation up to the audio rate.

'''add here ML after Flucoma finished'''