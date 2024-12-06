#!/bin/sh
# This file echos a string that will be processed and displayed on the spectrwm bar.
# Any spectrwm bar_format character sequences will be expanded.

# Text markup sequences
BOLD="+@fn=1;+@fg=1;"
REGULAR="+@fn=0;+@fg=0;"

# Echo the name(s) of connected bluetooth 
# device(s) via BlueZ (bluetoothctl).
# bluetooth () {
#   con=$(
#     bluetoothctl devices \
#     | cut -f2 -d' ' \
#     | while read uuid; do bluetoothctl info $uuid; done \
#     | grep -e "Name\|Connected: yes" \
#     | grep -B1 "yes" \
#     | head -n 1 \
#     | cut -d\  -f2-
#   )
#
#   if ! [ -z "$con" ]; then
#     con="󰂯 ${BOLD}${con}${REGULAR}"
#   else
#     con="󰂲"
#   fi
#
#   echo "$con"
# }

# Echo an icon representing volume from amixer Master, including mute status.
volume () {
  # Get the current volume percentage
  vol=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
  vol=${vol::-1}

  # Check if the audio is muted
  mute_status=$(amixer sget Master | grep -o '\[off\]')
  
  # If muted, show "Muted", otherwise show the volume percentage
  if [ -n "$mute_status" ]; then
    echo -e "Vol ${BOLD}Muted${REGULAR}"
  else
    echo -e "Vol ${BOLD}${vol}%${REGULAR}"
  fi
}


# Echo an icon representing internet connectivity.
internet () {
  if nc -zw1 google.com 443; then
    echo "[eth]"
  else
    echo "[...]"
  fi
}

# Echo the thermal_zone0 temp
temp () {
  tempraw=$(cat /sys/class/thermal/thermal_zone0/temp)
  tempcel=$(expr $tempraw / 1000)
  echo "Temp ${BOLD}${tempcel}C${REGULAR}"
}

# Echo the amount of memory currently being used.
memory () {
  mem=$(free -m | awk '/^Mem:/{print $3}')
  echo "Mem ${BOLD}${mem}MiB${REGULAR}"
}

# Update the bar utilities every five seconds.
while :; do
  # Display username and window manager workspace info on left.
  left="+|L󱄅 ${BOLD}${USER}@$(hostname)${REGULAR}  Space ${BOLD}+L${REGULAR}  Hidden ${BOLD}+M${REGULAR}  Stack ${BOLD}+S${REGULAR}"

  # Display date and time in the center.
  center="+|C$(date +"%a %b %d %H:%M")"

  # Display utilities from this script on the right.
  right="+|R$(memory)  $(temp)  $(volume)  $(internet)"

  echo "${left}${center}${right}"
  sleep 4
done
