#!/bin/bash
# J.A.R.V.I.S. Startup Script

SOUND_DIR="$HOME/.config/jarvis-sounds"
HOUR=$(date +%H)

# Time-based greeting
if [ $HOUR -lt 12 ]; then
    GREETING="Good morning"
elif [ $HOUR -lt 18 ]; then
    GREETING="Good afternoon"
else
    GREETING="Good evening"
fi

# Play startup sound if available
if [ -f "$SOUND_DIR/jarvis-startup.mp3" ]; then
    mpv --no-video --volume=50 "$SOUND_DIR/jarvis-startup.mp3" &
fi

# Show notification
notify-send -i computer "$GREETING, Matthew" "All systems operational"
