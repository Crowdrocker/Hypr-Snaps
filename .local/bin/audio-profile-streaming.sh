#!/bin/bash
# File: ~/.local/bin/audio-profile-streaming.sh

# Load streaming qpwgraph setup
qpwgraph -a ~/.config/qpwgraph/streaming-setup.qpwgraph &

# Set balanced volumes for streaming
wpctl set-volume game_sink 70%
wpctl set-volume discord_sink 60%
wpctl set-volume music_sink 30%

# Play J.A.R.V.I.S. sound
[ -f ~/.config/jarvis-sounds/jarvis-streaming.mp3 ] && \
    mpv --no-video --volume=50 ~/.config/jarvis-sounds/jarvis-streaming.mp3 &

notify-send -i obs "📹 Streaming Mode" "Audio profile activated"
