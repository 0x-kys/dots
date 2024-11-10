#!/bin/sh

DIRS_TO_COPY="alacritty betterlockscreen bspwm btop dunst fish ghostty nvim picom polybar sxhkd"

SOURCE_DIR="$HOME/.config"

DEST_DIR="$(pwd)/cfg"

for dir in $DIRS_TO_COPY; do
  src_dir="$SOURCE_DIR/$dir"
  
  if [ -d "$src_dir" ]; then
    cp -r "$src_dir" "$DEST_DIR"
    echo "Copied $src_dir to $DEST_DIR"
  else
    echo "Directory $src_dir does not exist in $SOURCE_DIR"
  fi
done
