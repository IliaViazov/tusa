#!/usr/bin/env bash
set -euo pipefail

# Directory where captures are stored
CAPTURE_DIR="./sessions"
mkdir -p "$CAPTURE_DIR"

# Timestamp for unique filenames
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

CAPTURE_FILE="$CAPTURE_DIR/tmux-buffer-$DATE.txt"
OUTPUT_FILE="$CAPTURE_DIR/session-$DATE.hs"

# Capture tmux pane
tmux capture-pane -pS - > "$CAPTURE_FILE"

# Run Python processor
python3 processor.py "$CAPTURE_FILE" "$OUTPUT_FILE"

# Remove intermediate txt file
rm -f "$CAPTURE_FILE"

echo "Session is saved"

# Optional: keep only the last 5 .hs files
MAX_FILES=10
FILES=($(ls -1t "$CAPTURE_DIR" | grep '^session-' | sort))
COUNT=${#FILES[@]}

if (( COUNT > MAX_FILES )); then
    TO_DELETE=$((COUNT - MAX_FILES))
    echo "🧹 Cleaning up old files ($TO_DELETE to delete)..."
    ls -1t "$CAPTURE_DIR" | grep '^session-' | tail -n "$TO_DELETE" | while read -r f; do
        echo "Deleting $f"
        rm -f "$CAPTURE_DIR/$f"
    done
fi

tmux kill-server

echo "Session is ended"
