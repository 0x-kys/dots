#!/bin/sh
BOLD="+@fn=1;+@fg=1;"
REGULAR="+@fn=0;+@fg=0;"

volume () {
  vol=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
  vol=${vol::-1}

  mute_status=$(amixer sget Master | grep -o '\[off\]')
  
  if [ -n "$mute_status" ]; then
    echo -e "Vol ${BOLD}Muted${REGULAR}"
  else
    echo -e "Vol ${BOLD}${vol}%${REGULAR}"
  fi
}

internet () {
  if nc -zw1 google.com 443; then
    echo -e "[${BOLD}net${REGULAR}]${BOLD}"
  else
    echo "[${REGULAR}...${BOLD}]${REGULAR}"
  fi
}

temp () {
  tempraw=$(cat /sys/class/thermal/thermal_zone0/temp)
  tempcel=$(expr $tempraw / 1000)
  echo "Temp ${BOLD}${tempcel}C${REGULAR}"
}

memory () {
  mem=$(free -m | awk '/^Mem:/{print $3}')
  echo "Mem ${BOLD}${mem}MiB${REGULAR}"
}

dnd_status () {
    status=$(xfconf-query -c xfce4-notifyd -p /do-not-disturb -v 2>/dev/null)

    if [ "$status" = "true" ]; then
        echo "DND ${BOLD}on${REGULAR}"
    else
        echo "DND ${BOLD}off${REGULAR}"
    fi
}

while :; do
  left="+|L󱄅 ${BOLD}${USER}@$(hostname)${REGULAR}  Space ${BOLD}+L${REGULAR}  Hidden ${BOLD}+M${REGULAR}  Stack ${BOLD}+S${REGULAR}"
  center="+|C$(date +"%a %b %d %H:%M")"
  right="+|R$(memory)  $(temp)  $(volume)  $(dnd_status)  $(internet)"

  echo "${left}${center}${right}"
  sleep 5
done

