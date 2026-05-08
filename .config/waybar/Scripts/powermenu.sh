#!/bin/bash

options="Shutdown\nReboot\nSuspend\nLogout\nLock"

chosen=$(echo -e "$options" | rofi -dmenu -theme ~/.config/rofi/config.rasi -i -p "Power Menu")

case "$chosen" in
    "Shutdown") systemctl poweroff ;;
    "Reboot") systemctl reboot ;;
    "Suspend") systemctl suspend ;;
    "Logout") hyprctl dispatch exit ;;
    "Lock") ~/.local/share/quickshell-lockscreen/lock.sh ;;
esac
