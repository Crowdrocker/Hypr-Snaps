#!/bin/bash
######################################################################################
# WehttamSnaps J.A.R.V.I.S. Sound Manager
# Plays J.A.R.V.I.S. sounds for various system events
######################################################################################

SOUND_DIR="$HOME/.local/share/sounds/jarvis"
SOUND_PLAYER="paplay"  # or use mpv, ffplay, etc.

# Check if sound directory exists
if [ ! -d "$SOUND_DIR" ]; then
    echo "J.A.R.V.I.S. sound directory not found: $SOUND_DIR"
    exit 1
fi

# Function to play sound
play_sound() {
    local sound_file="$SOUND_DIR/$1"

    if [ -f "$sound_file" ]; then
        $SOUND_PLAYER "$sound_file" &
    else
        echo "Sound file not found: $sound_file"
        # Send notification as fallback
        notify-send "J.A.R.V.I.S." "$2"
    fi
}

# Parse command
case "$1" in
    startup)
        play_sound "jarvis-startup.mp3" "Good morning, Sir. All systems operational."
        ;;

    shutdown)
        play_sound "jarvis-shutdown.mp3" "Shutting down. Have a good day, Sir."
        ;;

    notification)
        play_sound "jarvis-notification.mp3" "Sir, you have a notification."
        ;;

    warning)
        play_sound "jarvis-warning.mp3" "Warning: System temperature critical."
        ;;

    gaming)
        play_sound "jarvis-gaming.mp3" "Gaming mode activated. Systems at maximum performance."
        notify-send -i gaming "J.A.R.V.I.S." "Gaming mode activated. Performance maximized."
        ;;

    streaming)
        play_sound "jarvis-streaming.mp3" "Streaming systems online. All feeds operational."
        notify-send -i video-display "J.A.R.V.I.S." "Streaming systems online."
        ;;

    work)
        play_sound "jarvis-work.mp3" "Work mode activated. Creative suite ready."
        notify-send -i applications-graphics "J.A.R.V.I.S." "Work mode activated."
        ;;

    critical)
        play_sound "jarvis-critical.mp3" "Critical system alert detected."
        notify-send -u critical "J.A.R.V.I.S." "Critical system alert!"
        ;;

    complete)
        play_sound "jarvis-complete.mp3" "Task completed successfully, Sir."
        notify-send "J.A.R.V.I.S." "Task completed."
        ;;

    error)
        play_sound "jarvis-error.mp3" "Error detected. Diagnostics recommended."
        notify-send -u normal "J.A.R.V.I.S." "Error detected."
        ;;

    *)
        echo "Usage: $0 {startup|shutdown|notification|warning|gaming|streaming|work|critical|complete|error}"
        exit 1
        ;;
esac
