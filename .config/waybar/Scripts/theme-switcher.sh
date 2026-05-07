#!/bin/bash

# Define the waybar directory
DIR="$HOME/.config/waybar"

# Define the options
options="Fun\nMinimal"

# Show Rofi menu and get selection
choice=$(echo -e "$options" | rofi -dmenu -i -p "Bar select theme...")

# Apply the theme based on selection
if [ "$choice" == "Fun" ]; then
    cp "$DIR/funconfig.jsonc" "$DIR/config.jsonc"
    cp "$DIR/funstyle.css" "$DIR/style.css"
    cp "$DIR/funcolors.css" "$DIR/colors.css"
elif [ "$choice" == "Minimal" ]; then
    cp "$DIR/minimalconfig.jsonc" "$DIR/config.jsonc"
    cp "$DIR/minimalstyle.css" "$DIR/style.css"
    cp "$DIR/minimalcolors.css" "$DIR/colors.css"
else
    exit 0
fi

# Restart Waybar
killall waybar
waybar &
