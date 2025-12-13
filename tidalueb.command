#!/bin/bash
cd 
REAL_PATH=$(readlink -f ~/tcii)
cd "$REAL_PATH"

tmux new-session -d -s mysession
tmux source-file config-util/.tmux.conf

tmux send-keys "./config-util/ghci-color -ghci-script 'config-util/BootTidal.hs'" Enter

# SuperCollider
tmux splitw -v -p 10
tmux send-keys "sclang config-util/BootSC.scd" Enter
tmux selectp -t 0

# Reference
tmux splitw -h -p 30
tmux send-keys "glow reference" Enter
tmux selectp -t mysession:0.0

# Snippets
tmux splitw -h -p 30
tmux send-keys "nano snippets/snippets.hs --rcfile config-util/.nanorc -/" Enter
tmux selectp -t mysession:0.0


tmux attach -t mysession
