#!/bin/sh

DIRS_TO_COPY="alacritty betterlockscreen bspwm btop dunst fish ghostty nvim picom polybar sxhkd zed"
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

echo "Copying scripts"
cp -r ~/scripts .

ZED_CONFIG="$DEST_DIR/zed/settings.json"

if [ -f "$ZED_CONFIG" ]; then
  sed '/\/\//d' "$ZED_CONFIG" | jq 'del(.lsp.wakatime.settings."api-key")' > "$ZED_CONFIG.tmp" && mv "$ZED_CONFIG.tmp" "$ZED_CONFIG"
  echo "Removed API key from Zed config"
else
  echo "Zed config file not found in $ZED_CONFIG"
fi

