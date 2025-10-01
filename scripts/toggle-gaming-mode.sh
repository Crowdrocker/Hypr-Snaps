#!/bin/bash
######################################################################################
# WehttamSnaps Gaming Mode Toggle
# Optimizes system for maximum gaming performance
######################################################################################

STATE_FILE="/tmp/wehttamsnaps-gaming-mode"
HYPR_CONFIG="$HOME/.config/hypr"

# Check current state
if [ -f "$STATE_FILE" ]; then
    GAMING_MODE=0
    rm "$STATE_FILE"
else
    GAMING_MODE=1
    touch "$STATE_FILE"
fi

# Function to enable gaming mode
enable_gaming_mode() {
    echo "Enabling Gaming Mode..."
    
    # Play J.A.R.V.I.S. sound
    "$HYPR_CONFIG/scripts/jarvis-sound.sh" gaming
    
    # Set CPU governor to performance
    echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
    
    # Disable blur and animations for performance
    hyprctl keyword decoration:blur:enabled false
    hyprctl keyword animations:enabled false
    
    # Set AMD GPU to high performance
    if command -v lact &> /dev/null; then
        lact set-profile performance
    fi
    
    # Enable gamemode (if available)
    if command -v gamemoded &> /dev/null; then
        systemctl --user start gamemoded
    fi
    
    # Increase CPU/GPU power limits (optional)
    # Uncomment if you want aggressive performance
    # sudo ryzenadj --tctl-temp=95 --stapm-limit=35000 --fast-limit=45000 --slow-limit=35000
    
    # Disable compositor effects temporarily
    hyprctl keyword decoration:drop_shadow false
    hyprctl keyword decoration:dim_inactive false
    
    # Notification
    notify-send -i gaming "Gaming Mode" "Performance mode activated\n• Animations disabled\n• CPU performance mode\n• GPU high performance" -t 5000
    
    # Optional: Launch gaming overlay/monitoring
    # pkill -f mangohud || mangohud &
}

# Function to disable gaming mode
disable_gaming_mode() {
    echo "Disabling Gaming Mode..."
    
    # Set CPU governor back to schedutil/powersave
    echo schedutil | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
    
    # Re-enable blur and animations
    hyprctl keyword decoration:blur:enabled true
    hyprctl keyword animations:enabled true
    
    # Set AMD GPU back to auto
    if command -v lact &> /dev/null; then
        lact set-profile auto
    fi
    
    # Re-enable compositor effects
    hyprctl keyword decoration:drop_shadow true
    hyprctl keyword decoration:dim_inactive true
    
    # Notification
    notify-send -i system "Gaming Mode" "Normal mode restored\n• Animations enabled\n• Power saving active" -t 3000
}

# Execute based on state
if [ $GAMING_MODE -eq 1 ]; then
    enable_gaming_mode
else
    disable_gaming_mode
fi

# Update waybar/quickshell indicator (if using custom module)
# pkill -RTMIN+8 waybar
