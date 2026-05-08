#!/bin/bash

WAYBAR_DIR="$HOME/.config/waybar"
PRESETS_DIR="$WAYBAR_DIR/presets"

# Check if presets directory exists
if [ ! -d "$PRESETS_DIR" ]; then
    notify-send "Waybar Theme Switcher" "Presets directory not found!"
    exit 1
fi

# Get list of presets (directories only)
options=$(find "$PRESETS_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)

if [ -z "$options" ]; then
    notify-send "Waybar Theme Switcher" "No presets found!"
    exit 1
fi

# Show Rofi menu and get selection
choice=$(echo -e "$options" | rofi -dmenu -theme ~/.config/rofi/config.rasi -i -p "Select Waybar Theme...")

if [ -z "$choice" ]; then
    exit 0
fi

SELECTED_PRESET="$PRESETS_DIR/$choice"

if [ -f "$SELECTED_PRESET/config.jsonc" ]; then
    # Create symlinks so Waybar reads the preset directly
    ln -sf "$SELECTED_PRESET/config.jsonc" "$WAYBAR_DIR/config.jsonc"
    ln -sf "$SELECTED_PRESET/style.css" "$WAYBAR_DIR/style.css"
    
    # Restart Waybar
    killall waybar
    waybar &
    
    notify-send "Waybar Theme Switcher" "Theme switched to $choice"
else
    notify-send "Waybar Theme Switcher" "Invalid preset: $choice"
    exit 1
fi
