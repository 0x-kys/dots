#!/bin/sh

DIRS_TO_COPY="wezterm spectrwm btop fish ghostty nvim picom"
SOURCE_DIR="$HOME/.config"
DEST_DIR="$(pwd)/cfg"

mkdir -p "$(pwd)/nix"

for dir in $DIRS_TO_COPY; do
  src_dir="$SOURCE_DIR/$dir"
  
  if [ -d "$src_dir" ]; then
    cp -r "$src_dir" "$DEST_DIR"
    echo "Copied $src_dir to $DEST_DIR"
  else
    echo "Directory $src_dir does not exist in $SOURCE_DIR"
  fi
done

if [ -d "/etc/nixos" ]; then
  cp -r /etc/nixos/* "$(pwd)/nix/"
  echo "Copied NixOS configuration files to $(pwd)/nix"
else
  echo "/etc/nixos directory does not exist"
fi
