#!/usr/bin/env sh

DOTFILES="helix ghostty nvim starship.toml"

for item in $DOTFILES; do
  if [ -e "$HOME/.config/$item" ]; then
    cp -r "$HOME/.config/$item" .
    echo "Copied/Updated $item to $(pwd)"
  else
    echo "Warning: $item not found in ~/.config"
  fi
done

[ -d zed ] || mkdir -p zed

cp -r $HOME/.config/zed/keymap.json ./zed/keymap.json
cp -r $HOME/.config/zed/settings.json ./zed/settings.json

echo "Dotfiles copied to $(pwd)"
