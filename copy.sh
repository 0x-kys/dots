#!/usr/bin/env sh

DIRS_TO_COPY="rofi wezterm i3 glow btop doom fish ghostty nvim picom"
SOURCE_DIR="$HOME/.config"
DEST_DIR="$(pwd)/cfg"
TMUX_CONF="$HOME/.tmux.conf"

for dir in $DIRS_TO_COPY; do
  src_dir="$SOURCE_DIR/$dir"
  
  if [ -d "$src_dir" ]; then
    cp -r "$src_dir" "$DEST_DIR"
    echo "copied $src_dir to $DEST_DIR"
  else
    echo "dir $src_dir does not exist in $SOURCE_DIR"
  fi
done

if [ -f $TMUX_CONF ]; then
  cp "$TMUX_CONF" "$(pwd)"
  echo "copied tmux config to $(pwd)"
else
  echo "couldn't find tmux config"
fi
