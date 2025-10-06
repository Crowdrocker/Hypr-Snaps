#!/bin/bash
# File: ~/.local/bin/audio-profile-gaming.sh

# Load gaming qpwgraph setup
qpwgraph -a ~/.config/qpwgraph/gaming-setup.qpwgraph &

# Set volumes
wpctl set-volume game_sink 85%
wpctl set-volume discord_sink 100%
wpctl set-volume music_sink 40%

# Play J.A.R.V.I.S. sound
[ -f ~/.config/jarvis-sounds/jarvis-gaming.mp3 ] && \
    mpv --no-video --volume=50 ~/.config/jarvis-sounds/jarvis-gaming.mp3 &

notify-send -i games "🎮 Gaming Mode" "Audio profile activated"
