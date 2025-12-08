# Tidalüb 
# Live-Coding through Instrumental Paradigm

## Abstract


## Introduction

Interface shapes the interaction, as well as interaction shows the weak and strong points of the interface. Minimal interface of the computer (mouse/touchpad and keyboard as an input, and feedback-responsive screen and loudspeakers) created as well very minimal interaction with it, keeping at the same time your laptop as the most powerful in the meaning of DSP-performance synthesizer that probably you have at home as a professional electronic musician.

Live-Coding, as an improvisational/compositional performative practice, became a very important part of the currents, bringing the laptop from its traditional role as a magic box into the realm of instruments and live musical performance. The computer was not designed with the thought of making it a good musical instrument. Its interface lacks different types of interaction, which is why we always try to extend it using aggregate devices (from simple to more complex). Live-Coding, on the other hand, is using computers' primary ability — describing information flow through encrypted keyboard messages. 

Tidalüb is a framework solution for TidalCycles. TidalCycles is a programming language for generating sequences with prerecorded samples or preprogrammed SynthDefs in SuperCollider. Tidalüb brings many necessary and useful utilities together in one application, providing better and more reliable execution, access to prepared snippets and the reference during performance, as well as easier installation.

## Live-Coding as a Praxis. Understanding the computer as an instrument.

## Overview of TidalCycles as a programming language and toolchain for it

Practising and performing with the traditional setup of TidalCycles using Pulsar and bootloader in SuperCollider IDE, I found myself lacking some things that I would love to have with TidalCycles, like: an easy and automated way of booting it up, a reference window, and the ability to monitor everything in one window. My machine also didn't like Pulsar as an IDE, and it always crashed somewhere during the setup time.

## Tidalüb Overview

Building this framework, I was trying to solve my personal performative problems that I wanted to improve in my setup of TidalCycles, as well as creating a platform which can be reused by other people who would like to jump into live-coding and use their laptop as an instrument with TidalCycles. Many of the decisions were dictated out of thinking in the instrumental paradigm of playing the laptop. One of my interests is also keeping this framework as FLOSS, so only Free/Libre Software was used as building parts, as well as all sources were credited.

After some thinking process, I decided to establish a workflow that runs directly in the terminal through tmux that supports different parts of the application:
1) TidalCycles REPL
2) Snippets window, which you can use for pre-written material
3) Reference window with small cheat-sheets (abstraction of the original documentation)
4) SuperCollider interpreter

Implementation of it in the terminal seemed to me like a quite reasonable solution at that point:
- All parts of the environment are available as scripts that could be run in the shell.
- Almost the absence of the GUI can provide more resources for performance, allowing to do more crazy stuff

### TidalCycles REPL

For the TidalCycles REPL part, was used a GHCi, an an interactive environment for functional programming language Haskell, that lays in the heart of TidalCycles. The GHCi runs an interpreter for TidalCycles via a Haskell Package that was originally developed by Alex McLean. On top of traditional GHCi, I've installed a very simple syntax highlighting to create a bit better readability for the user.
TidalCycles package for Haskell 
Addition was a command `:finish` for REPL that runs a script, that closes all the processes and saves your REPL session as a separate file with prompts, so you can look through it for some future material.

### Snippets

Okay, in the most minimal way, I can already use TidalCycles with the REPL, but what if I would like to have some snippets? For that was included a snippets window was included, which basically is just a Nano Editor window — a free-libre text-editor that comes with probably any bash shell automatically, so usually there is even no need to install it. Nano opens a .hs file and allows you to edit text in format .hs with syntax highlighting, copy via just selecting the text (no need to press `Cmd+C`) and paste it into the REPL Window. All traditional Nano shortcuts were reconfigured to be more common once (comparison: `Ctl+X` vs `Ctl+Q` to quit the program, or `Ctl+O` vs `Ctl+S` to save your file), but with a local configuration file, which doesn't affect global settings of the Nano editor, in case it's needed.
In the future, it would be nice to also evaluate command lines from there, but it will be a task for the future.

### Reference

Original documentation of TidalCycles exists in the format of a Website and a repository, but not as something integrated and adjusted for fast use during improvisation, in situations when you forget something or keep running into a syntax mistake.

I took the original documentation and reduced it to smaller definitions, creating a set of cheat-sheets, which can be used even during performance. Currently, it supports the following sections of the original documentation:
- Notation and Syntax
- Samples
- Synthesizers 
- Effects
- Oscillators and Generators
- Transitions

All of these pages are written as `.md` files, and run in the Glow Markdown Reader for the Terminal, which allows you to navigate through the documentation using you arrow keys and mouse.

### SuperCollider

SuperCollider part was realized as a scsynth running in a separate terminal pan, with a standard TidalCycles bootloader that we can find in the original documentation, with little adjustments to always choose your Default Sound Device, to which you are connected in the main settings (to minimize the setup time, if we speak of traditional stereo playing). Also server is loaded with an OSCFunc that posts the stats of the server to keep track if you are on the edge of a crash.

### Installation and Setup

All installation scripts were organized in one main script that essentially does next:
- Installs Haskell and Python (for autosaving feature);
- TidalCycle package for Haskell;
- Nano, Glow, tmux;
- SuperCollider and dependencies;

After that, it unpacks all the scripts and creates an application `tidalueb.app`, which refers to the file with a bash script in the repositories folder, but much nicer to use, because you can call it even from Finder. 

### Current work and plans

Currently, the development is going in the direction of supporting advanced ways of spatialisation with beam forming algorithms. Now the version supports test version beam forming for the third-order ambisonics, intended to be used with the IKO loudspeaker, which is currently available at the Musikhochschule Lübeck. Now it is done with a sort of illegal trick. Original SuperDirt signal is wrapped around 8-channel straight spatialisation and then parsed through SuperCollider server into the **i8->o3 encoder** with equal spacing of the input channels across the azimuth, and then convolved by **mcfx_convolver24** onto the surface of the IKO with corrected filtering.

I would say that it is a very rough and hacky solution, but it does its work, creating a virtual space of an 8-channel equally spaced loudspeaker ring, not overriding any of the original SuperDirt Methods, and is still comfortable using syntax with `#pan` parameter.
Later, it is planned to integrate beam forming algorithms on the level of SuperDirt's Class, so that each of the Orbits could be addressed with their own encoding parameters of azimuth and elevation.

In the future, I plan to add an interface with an ML agent, to which you can give a query in a filtering manner (accessing playback through analysed features of the sound source, like: harmonicty, chroma, MFCC, etc.). The idea was taken from Shai Rosenblitt and implemented as a test build of Tidalüb to understand the interactions with this part of the software. This version functions in the way that it generates two TidalCycles listeners, which creates a certain level of latency (considering that all of that goes also through Python). The final implementation is considered to be done as different SynthDefs in SuperCollider using the Flucoma library.


References:
- [Tidal Cycles](https://tidalcycles.org/)
- [Tidal Cycles Documentation](https://github.com/tidalcycles/tidal-doc)
- [SuperCollider](https://supercollider.github.io/)
- [Nano](https://www.nano-editor.org/)
- [Syntax Highlighting for Nano](https://github.com/scopatz/nanorc.git)
- [vim-tidal](https://github.com/tidalcycles/vim-tidal)
- [Glow](https://www.nano-editor.org/)
- [tmux](https://github.com/tmux/tmux/wiki)
- [Haskell](https://www.haskell.org/ghcup/)
- [Colored GHCi](https://github.com/rhysd/ghci-color/tree/master)
- [Python](https://www.python.org/)
- [mcfx - Multi-Channel Plug-In Suite](https://www.matthiaskronlachner.com/?p=1910)
- [ambiX - Ambisonic Plug-In Suite](https://www.matthiaskronlachner.com/?p=2015)
- [Tidal Sound Explorer](https://github.com/ShaiRosenblit/tidal-sound-explorer)
- [The Fluid Corpus Manipulation project](https://www.flucoma.org/)
