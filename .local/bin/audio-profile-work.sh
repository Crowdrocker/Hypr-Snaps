#!/bin/bash
# File: ~/.local/bin/audio-profile-work.sh

# Simple routing - everything to default
pactl set-default-sink @DEFAULT_SINK@

# Set comfortable volume
wpctl set-volume @DEFAULT_AUDIO_SINK@ 60%
wpctl set-volume music_sink 80%

notify-send -i audio-headphones "🎵 Work Mode" "Audio profile activated"
