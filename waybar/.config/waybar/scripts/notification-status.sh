#!/bin/bash
# Check Mako DND status and output JSON for Waybar

# Check if mako is running
if ! pgrep -x mako > /dev/null; then
    echo '{"text":"󰂞","class":"disabled","tooltip":"Mako is not running"}'
    exit 0
fi

# Check DND mode
if makoctl mode | grep -q "dnd"; then
    echo '{"text":"󰂛","class":"dnd","tooltip":"Do Not Disturb\nClick to enable notifications"}'
else
    echo '{"text":"󰂚","class":"active","tooltip":"Notifications enabled\nClick for Do Not Disturb"}'
fi
