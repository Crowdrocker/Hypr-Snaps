#!/bin/bash

# ╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
# ║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
# ╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
#
# J.A.R.V.I.S. Startup Sound
# GitHub: https://github.com/Crowdrocker/Hypr-Snaps

JARVIS_SOUNDS="$HOME/.local/share/sounds/jarvis"

# Wait for audio system to be ready
sleep 2

# Get current hour
HOUR=$(date +%H)

# Play appropriate greeting based on time of day
if [ $HOUR -ge 5 ] && [ $HOUR -lt 12 ]; then
    # Morning (5 AM - 11:59 AM)
    if [ -f "$JARVIS_SOUNDS/jarvis-startup.mp3" ]; then
        mpv --no-video --volume=70 "$JARVIS_SOUNDS/jarvis-startup.mp3" &
    fi
elif [ $HOUR -ge 12 ] && [ $HOUR -lt 18 ]; then
    # Afternoon (12 PM - 5:59 PM)
    if [ -f "$JARVIS_SOUNDS/jarvis-startup.mp3" ]; then
        mpv --no-video --volume=70 "$JARVIS_SOUNDS/jarvis-startup.mp3" &
    fi
else
    # Evening/Night (6 PM - 4:59 AM)
    if [ -f "$JARVIS_SOUNDS/jarvis-startup.mp3" ]; then
        mpv --no-video --volume=70 "$JARVIS_SOUNDS/jarvis-startup.mp3" &
    fi
fi