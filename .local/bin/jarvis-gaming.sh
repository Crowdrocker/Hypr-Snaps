#!/bin/bash

# ╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
# ║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
# ╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
#
# J.A.R.V.I.S. Gaming Mode Sound
# GitHub: https://github.com/Crowdrocker/Hypr-Snaps

JARVIS_SOUNDS="$HOME/.local/share/sounds/jarvis"

if [ -f "$JARVIS_SOUNDS/jarvis-gaming.mp3" ]; then
    mpv --no-video --volume=70 "$JARVIS_SOUNDS/jarvis-gaming.mp3" &
fi