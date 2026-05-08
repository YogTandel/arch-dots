#!/usr/bin/env bash

STATE_DIR="$HOME/.config/cloud-center/settings/theme"
mkdir -p "$STATE_DIR"

MODE_FILE="$STATE_DIR/mode"
SCHEME_FILE="$STATE_DIR/scheme"
CONTRAST_FILE="$STATE_DIR/contrast"

MODE=$(cat "$MODE_FILE" 2>/dev/null || echo "dark")
SCHEME=$(cat "$SCHEME_FILE" 2>/dev/null || echo "neutral")
CONTRAST=$(cat "$CONTRAST_FILE" 2>/dev/null || echo "0")

get_current_wallpaper() {
    local wp
    wp=$(cat "$HOME/.cache/wal/wal" 2>/dev/null)
    if [ -z "$wp" ] || [ ! -f "$wp" ]; then
        wp=$(find "$HOME/Pictures/Wallpapers" -type f | head -n 1)
    fi
    echo "$wp"
}

CURRENT_WP=$(get_current_wallpaper)

apply_theme() {
    # Run Matugen
    if [ "$MODE" = "dark" ]; then
        matugen image "$CURRENT_WP" -m dark -t "$SCHEME" -c "$CONTRAST"
    else
        matugen image "$CURRENT_WP" -m light -t "$SCHEME" -c "$CONTRAST"
    fi
    
    # Reload components
    killall -SIGUSR2 waybar
    qs ipc call reload >/dev/null 2>&1 || true
}

case "$1" in
    set)
        if [ "$2" = "--mode" ]; then
            echo "$3" > "$MODE_FILE"
            MODE="$3"
            apply_theme
        fi
        ;;
    refresh)
        if [ -n "$2" ]; then
            echo "$2" > "$SCHEME_FILE"
            SCHEME="$2"
        fi
        if [ -n "$3" ]; then
            echo "$3" > "$CONTRAST_FILE"
            CONTRAST="$3"
        fi
        apply_theme
        ;;
    set-image)
        if [ -n "$2" ]; then
            swww img "$2" --transition-type grow --transition-duration 1.5
            wal -i "$2" -n
            CURRENT_WP="$2"
            apply_theme
        fi
        ;;
    *)
        echo "Usage: $0 {set|refresh|set-image}"
        ;;
esac
