#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpapers"

# Start swww daemon if not running
if ! pidof swww-daemon >/dev/null; then
    swww-daemon &
    sleep 0.5
fi

SELECTED=$(
    for img in "$WALL_DIR"/*; do
        [[ "$img" =~ \.(jpg|jpeg|png|webp|JPG|PNG)$ ]] || continue

        printf "%s\0icon\x1f%s\n" "$(basename "$img")" "$img"
    done | rofi \
        -dmenu \
        -i \
        -show-icons \
        -theme ~/.config/rofi/scripts/wallpaper.rasi \
        -p ""
)

if [ -n "$SELECTED" ]; then
    swww img "$WALL_DIR/$SELECTED" \
        --transition-type wipe \
        --transition-duration 1
fi
