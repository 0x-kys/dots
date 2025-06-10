#!/usr/bin/env sh

DOTFILES="waybar river ghostty wofi mako hypr i3 rofi foot starship.toml alacritty"

for item in $DOTFILES; do
  if [ -e "$HOME/.config/$item" ]; then
    cp -r "$HOME/.config/$item" .
    echo "Copied/Updated $item to $(pwd)"
  else
    echo "Warning: $item not found in ~/.config"
  fi
done

cp -r $HOME/.config/tmux/tmux.conf ./tmux.conf

echo "Dotfiles copied to $(pwd)"
