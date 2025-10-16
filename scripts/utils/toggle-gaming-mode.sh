#!/bin/bash

# ╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
# ║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
# ╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
#
# Toggle Gaming Mode
# GitHub: https://github.com/Crowdrocker/Hypr-Snaps

STATE_FILE="$HOME/.cache/gaming-mode-state"

# Check current state
if [ -f "$STATE_FILE" ]; then
    # Gaming mode is ON, turn it OFF
    rm "$STATE_FILE"
    
    # Disable gamemode
    pkill -f gamemoded
    
    # Reset GPU to normal profile
    if command -v corectrl &> /dev/null; then
        corectrl --profile "Default"
    fi
    
    # Notification
    notify-send "Gaming Mode" "Gaming mode disabled" -i gamepad
    
    echo "Gaming mode disabled"
else
    # Gaming mode is OFF, turn it ON
    touch "$STATE_FILE"
    
    # Enable gamemode
    gamemoded -d
    
    # Set GPU to performance profile
    if command -v corectrl &> /dev/null; then
        corectrl --profile "Gaming"
    fi
    
    # Play J.A.R.V.I.S. sound
    ~/.local/bin/jarvis-gaming.sh
    
    # Notification
    notify-send "Gaming Mode" "Gaming mode enabled - Maximum performance" -i gamepad
    
    echo "Gaming mode enabled"
fi