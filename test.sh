#!/bin/sh

tmux new-session -d -s mysession
tmux send-keys -t mysession "cd ~" Enter
tmux split-window -h -t mysession
tmux send-keys -t mysession "watch -n 1 df -H" Enter
tmux split-window -v -p 50 -t mysession
tmux send-keys -t mysession "htop" Enter
tmux select-pane -t mysession:0.0
tmux split-window -v -p 50 -t mysession
tmux send-keys -t mysession "cd ~" Enter
tmux select-pane -t mysession:0.0
# Attach to session 
tmux attach -t mysession
