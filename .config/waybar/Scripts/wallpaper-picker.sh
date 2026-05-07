#!/bin/bash

# Directory where wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Check if directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    rofi -e "Wallpaper directory not found: $WALLPAPER_DIR"
    exit 1
fi

# Step 1: Select Category (subdirectories inside WALLPAPER_DIR)
categories=$(find "$WALLPAPER_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)

if [ -z "$categories" ]; then
    rofi -e "No categories (folders) found in $WALLPAPER_DIR"
    exit 1
fi

# Use rofi to select a category
selected_category=$(echo "$categories" | rofi -dmenu -i -p "Folder pick wallpaper...")

if [ -z "$selected_category" ]; then
    exit 0
fi

CATEGORY_PATH="$WALLPAPER_DIR/$selected_category"

# Step 2: Select Wallpaper
wallpapers=$(find "$CATEGORY_PATH" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) -exec basename {} \;)

if [ -z "$wallpapers" ]; then
    rofi -e "No images found in $CATEGORY_PATH"
    exit 1
fi

# Use rofi to select an image
selected_wallpaper=$(echo "$wallpapers" | rofi -dmenu -i -p "Select Wallpaper...")

if [ -z "$selected_wallpaper" ]; then
    exit 0
fi

WALLPAPER_PATH="$CATEGORY_PATH/$selected_wallpaper"

# Step 3: Apply Wallpaper with swww (grow transition for smooth round shape change)
swww img "$WALLPAPER_PATH" --transition-type grow --transition-pos 0.854,0.972 --transition-step 90

# Step 4: Generate Pywal colors for terminal
wal -i "$WALLPAPER_PATH" -n

# Step 5: Generate Matugen colors for Waybar
matugen image "$WALLPAPER_PATH"

# Step 6: Restart Waybar and update Kitty
killall -SIGUSR1 kitty 2>/dev/null
killall waybar
waybar &
