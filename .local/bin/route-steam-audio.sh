#!/bin/bash
# File: ~/.local/bin/route-steam-audio.sh

# Wait for Steam game to start
sleep 2

# Find Steam game process and route to game_sink
STEAM_SINK=$(pactl list sink-inputs | grep -B 20 "application.name = \"REAPER\"" | grep "Sink Input" | awk '{print $3}' | sed 's/#//')

if [ -n "$STEAM_SINK" ]; then
    pactl move-sink-input $STEAM_SINK game_sink
    notify-send "🎮 Audio Routing" "Game audio routed to game sink"
fi
