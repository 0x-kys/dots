#!/usr/bin/env bash

entries="⇠ Lock\n⏾ Suspend\n⏻ Hibernate\n← Exit Hyprland"

selected=$(echo -e $entries | wofi --dmenu --cache-file=/dev/null | awk '{print tolower($2)}')

case $selected in
  lock)
    swaylock;;
  suspend)
    systemctl suspend;;
  hibernate)
    systemctl hibernate;;
  hyprland)
    hyprctl dispatch exit;;
esac
