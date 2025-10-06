#!/bin/bash
SOUND_DIR="$HOME/.config/jarvis-sounds"
URGENCY=$1

case $URGENCY in
    critical)
        [ -f "$SOUND_DIR/jarvis-warning.mp3" ] && mpv --no-video --volume=70 "$SOUND_DIR/jarvis-warning.mp3" &
        ;;
    *)
        [ -f "$SOUND_DIR/jarvis-notification.mp3" ] && mpv --no-video --volume=50 "$SOUND_DIR/jarvis-notification.mp3" &
        ;;
esac
