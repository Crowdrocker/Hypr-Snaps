#!/bin/bash
# J.A.R.V.I.S. Shutdown Script

SOUND_DIR="$HOME/.config/jarvis-sounds"

# Play shutdown sound
if [ -f "$SOUND_DIR/jarvis-shutdown.mp3" ]; then
    mpv --no-video --volume=50 "$SOUND_DIR/jarvis-shutdown.mp3"
    sleep 2
fi

# Actual shutdown
systemctl poweroff
