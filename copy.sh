#!/usr/bin/env sh

DIRS_TO_COPY="rofi wezterm spectrwm btop fish ghostty nvim picom"
SOURCE_DIR="$HOME/.config"
DEST_DIR="$(pwd)/cfg"
TMUX_CONF="$HOME/.tmux.conf"

mkdir -p "$(pwd)/nix"
mkdir -p "$(pwd)/scripts"

for dir in $DIRS_TO_COPY; do
  src_dir="$SOURCE_DIR/$dir"
  
  if [ -d "$src_dir" ]; then
    cp -r "$src_dir" "$DEST_DIR"
    echo "copied $src_dir to $DEST_DIR"
  else
    echo "dir $src_dir does not exist in $SOURCE_DIR"
  fi
done

if [ -d "/etc/nixos" ]; then
  cp -r /etc/nixos/* "$(pwd)/nix/"
  echo "copied NixOS configuration files to $(pwd)/nix"
else
  echo "/etc/nixos directory does not exist"
fi

if [ -f $TMUX_CONF ]; then
  cp "$TMUX_CONF" "$(pwd)"
  echo "copied tmux config to $(pwd)"
else
  echo "couldn't find tmux config"
fi

if [ -d "$HOME/.scripts" ]; then
  cp -r $HOME/.scripts/* "$(pwd)/scripts/"
else
  echo "couldn't find scripts"
fi
