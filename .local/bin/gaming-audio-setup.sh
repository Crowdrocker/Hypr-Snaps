#!/bin/bash
# Route Steam to game sink
pactl set-default-sink game_sink

# Load qpwgraph profile
qpwgraph -a ~/.config/qpwgraph/gaming-setup.qpwgraph &

# Set individual volumes
wpctl set-volume @DEFAULT_AUDIO_SINK@ 80%
wpctl set-volume game_sink 80%
wpctl set-volume discord_sink 100%
wpctl set-volume music_sink 30%

notify-send "🎮 Gaming Audio" "Audio routing configured"
