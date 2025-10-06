#!/bin/bash
# J.A.R.V.I.S. Gaming Mode Toggle

SOUND_DIR="$HOME/.config/jarvis-sounds"
MODE_FILE="/tmp/jarvis-gaming-mode"

if [ -f "$MODE_FILE" ]; then
    # Disable gaming mode
    systemctl --user stop gamemoded
    corectrl --profile default
    rm "$MODE_FILE"

    if [ -f "$SOUND_DIR/jarvis-notification.mp3" ]; then
        mpv --no-video --volume=50 "$SOUND_DIR/jarvis-notification.mp3" &
    fi

    notify-send -i games "Gaming Mode" "Performance mode deactivated"
else
    # Enable gaming mode
    systemctl --user start gamemoded
    corectrl --profile gaming
    touch "$MODE_FILE"

    if [ -f "$SOUND_DIR/jarvis-gaming.mp3" ]; then
        mpv --no-video --volume=50 "$SOUND_DIR/jarvis-gaming.mp3" &
    fi

    notify-send -i games "Gaming Mode" "Maximum performance activated"
fi
