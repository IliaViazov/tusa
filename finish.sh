#!/usr/bin/env bash
set -euo pipefail

# Directory where captures are stored
CAPTURE_DIR="./tmux_captures"
mkdir -p "$CAPTURE_DIR"

# Timestamp for unique filenames
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

CAPTURE_FILE="$CAPTURE_DIR/tmux-buffer-$DATE.txt"
OUTPUT_FILE="$CAPTURE_DIR/session-$DATE.hs"

# Capture tmux pane
tmux capture-pane -pS - > "$CAPTURE_FILE"

# Run Python processor
python3 processor.py "$CAPTURE_FILE" "$OUTPUT_FILE"

echo "Session is saved"

# --- Limit stored files to 20 (remove oldest) ---
MAX_FILES=20

# List all capture files sorted by time (oldest first)
FILES=($(ls -1t "$CAPTURE_DIR" | grep '^tmux-buffer-' | sort))
COUNT=${#FILES[@]}

if (( COUNT > MAX_FILES )); then
    TO_DELETE=$((COUNT - MAX_FILES))
    echo "🧹 Cleaning up old files ($TO_DELETE to delete)..."
    # Delete the oldest ones
    ls -1t "$CAPTURE_DIR" | grep '^tmux-buffer-' | tail -n "$TO_DELETE" | while read -r f; do
        echo "Deleting $f"
        rm -f "$CAPTURE_DIR/$f"
    done
fi

tmux kill-server

echo "Session is ended"
