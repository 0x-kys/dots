#!/bin/bash
# Toggle Mako DND mode

if makoctl mode | grep -q "dnd"; then
    # DND is on, turn it off
    makoctl mode -r dnd
    notify-send "Notifications Enabled" "You will now receive notifications" -u low
else
    # DND is off, turn it on
    makoctl mode -a dnd
    # This notification will show briefly before DND activates
    notify-send "Do Not Disturb" "Notifications are now muted" -u low
fi
