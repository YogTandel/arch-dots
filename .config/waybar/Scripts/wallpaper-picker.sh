#!/usr/bin/env bash

# Directories
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-thumbnails"

# Ensure directories exist
mkdir -p "$CACHE_DIR"

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Wallpaper Picker" "Please create $WALLPAPER_DIR"
    exit 1
fi

# Select category first (text list)
categories=$(find "$WALLPAPER_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
if [ -z "$categories" ]; then
    # If no subdirectories, use root
    SELECTED_DIR="$WALLPAPER_DIR"
else
    # Let user pick category
    selected_category=$(echo "$categories" | rofi -dmenu -theme ~/.config/rofi/config.rasi -i -p "Folder pick wallpaper...")
    if [ -z "$selected_category" ]; then
        exit 0
    fi
    SELECTED_DIR="$WALLPAPER_DIR/$selected_category"
fi

# Generate thumbnails and build Rofi list
TEMP_INPUT=$(mktemp)
declare -A wallpaper_paths

# Only show notification if we actually have to generate thumbnails
notify-send "Wallpaper Picker" "Loading thumbnails..." -t 1500

while IFS= read -r -d '' img; do
    basename_img="$(basename "$img")"
    hash=$(echo -n "$img" | md5sum | cut -d' ' -f1)
    thumb="${CACHE_DIR}/${hash}.png"

    # Generate thumbnail if it doesn't exist
    if [ ! -f "$thumb" ]; then
        magick "${img}[0]" -strip -resize "200x200^" -gravity center -extent "200x200" -quality 85 "$thumb" 2>/dev/null
    fi

    if [ -f "$thumb" ]; then
        echo -en "${basename_img}\0icon\x1f${thumb}\n" >> "$TEMP_INPUT"
        wallpaper_paths["$basename_img"]="$img"
    fi
done < <(find "$SELECTED_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | sort -z)

if [ ! -s "$TEMP_INPUT" ]; then
    notify-send "Wallpaper Picker" "No images found in $SELECTED_DIR"
    rm -f "$TEMP_INPUT"
    exit 1
fi

# Show Rofi with thumbnails!
selection=$(rofi -dmenu -i -p "Select Wallpaper" -theme ~/.config/rofi/wallpaper.rasi -show-icons < "$TEMP_INPUT")

rm -f "$TEMP_INPUT"

if [ -n "$selection" ] && [ -n "${wallpaper_paths[$selection]}" ]; then
    chosen_wallpaper="${wallpaper_paths[$selection]}"
    
    # 1. Set Wallpaper with swww (ripple transition from cursor position)
    swww img "$chosen_wallpaper" \
        --transition-type grow \
        --transition-pos "$(hyprctl cursorpos | sed 's/ //g')" \
        --transition-duration 1.5
    
    # 2. Generate Pywal Colors (for terminals and legacy apps)
    wal -i "$chosen_wallpaper" -n &
    
    # 3. Generate Matugen Theme (Waybar + Swaync + QuickSHELL + Rofi all at once)
    matugen image "$chosen_wallpaper"
    
    # 4. Reload all components that consumed the new colors
    # Waybar — hot-reload colors without restart
    killall -SIGUSR2 waybar 2>/dev/null || true

    # SwayNC — reload its GTK CSS (colors-swaync.css was just regenerated)
    swaync-client --reload-config 2>/dev/null || true

    # QuickSHELL — reload Theme.qml tokens
    qs ipc call reload 2>/dev/null || true

    # Notify the user
    notify-send "󰸉 Wallpaper Applied" "$(basename "$chosen_wallpaper")" -t 2000
fi
