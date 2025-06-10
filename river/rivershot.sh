#!/usr/bin/env bash

# Screenshot script for River WM mimicking grimblast --notify area copy
# Dependencies: grim, slurp, wl-clipboard, libnotify
#
# TODO: implement freeze functionality

# Ensure dependencies are installed
for cmd in grim slurp wl-copy notify-send; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: $cmd is required but not installed."
        exit 1
    fi
done

# Prevent multiple instances
lockfile="${XDG_RUNTIME_DIR:-${XDG_CACHE_DIR:-$HOME/.cache}}/rivershot.lock"
if [ -e "$lockfile" ]; then
    notify-send -a "rivershot" -t 3000 "Screenshot" "Error: Another instance of this script is running."
    exit 2
fi
touch "$lockfile"
trap 'rm -f "$lockfile"' EXIT

# Temporary file for the screenshot
tempfile="/tmp/screenshot-$(date -Ins).png"

# Get the selected area using slurp
geometry=$(slurp -d -b 00000000 -c 89B4FAff -s 00000000 2>/dev/null)
if [ $? -ne 0 ]; then
    kill $freeze_pid
    echo "Error: Area selection cancelled."
    exit 1
fi

# Capture screenshot of the selected area
grim -g "$geometry" "$tempfile"
if [ $? -ne 0 ]; then
    kill $freeze_pid
    echo "Error: Failed to capture screenshot."
    exit 1
fi

# Copy screenshot to clipboard
wl-copy < "$tempfile"
if [ $? -ne 0 ]; then
    echo "Error: Failed to copy screenshot to clipboard."
    rm -f "$tempfile"
    exit 1
fi

# Send notification
notify-send -a "rivershot" -t 3000 "Screenshot" "Area screenshot copied to clipboard"

# Clean up
rm -f "$tempfile"

exit 0
