#!/bin/bash
######################################################################################
# WehttamSnaps Hyprland Startup Script
# Launches all necessary components and J.A.R.V.I.S. welcome
######################################################################################

SCRIPT_DIR="$HOME/.config/hypr/scripts"
LOG_FILE="/tmp/wehttamsnaps-startup.log"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=========================================="
log "WehttamSnaps Startup Sequence Initiated"
log "=========================================="

# Wait for compositor to be ready
sleep 2

######################################################################################
# CORE SERVICES
######################################################################################

log "Starting core services..."

# Polkit Authentication Agent
if ! pgrep -x "polkit-kde-auth" > /dev/null; then
    /usr/lib/polkit-kde-authentication-agent-1 &
    log "✓ Polkit agent started"
fi

# Network Manager Applet
if ! pgrep -x "nm-applet" > /dev/null; then
    nm-applet --indicator &
    log "✓ Network Manager applet started"
fi

# Bluetooth (if enabled)
if systemctl is-enabled bluetooth.service &>/dev/null; then
    blueman-applet &
    log "✓ Bluetooth applet started"
fi

######################################################################################
# DISPLAY & WALLPAPER
######################################################################################

log "Setting up display..."

# Kill any existing wallpaper daemons
killall hyprpaper swww 2>/dev/null

# Start wallpaper manager (choose one)
if command -v hyprpaper &> /dev/null; then
    hyprpaper &
    log "✓ Hyprpaper started"
elif command -v swww &> /dev/null; then
    swww init &
    sleep 1
    swww img ~/.local/share/wallpapers/current.png &
    log "✓ SWWW wallpaper set"
fi

######################################################################################
# STATUS BAR & WIDGETS
######################################################################################

log "Starting status bar and widgets..."

# Kill existing bars
killall waybar quickshell 2>/dev/null
sleep 1

# Start Quickshell (preferred) or Waybar (fallback)
if command -v quickshell &> /dev/null; then
    quickshell &
    log "✓ Quickshell started"
elif command -v waybar &> /dev/null; then
    waybar &
    log "✓ Waybar started"
fi

######################################################################################
# NOTIFICATION DAEMON
######################################################################################

log "Starting notification daemon..."

# Kill existing notification daemons
killall dunst mako 2>/dev/null

# Start notification daemon
if command -v dunst &> /dev/null; then
    dunst &
    log "✓ Dunst started"
elif command -v mako &> /dev/null; then
    mako &
    log "✓ Mako started"
fi

######################################################################################
# AUDIO SERVICES
######################################################################################

log "Configuring audio..."

# Ensure PipeWire is running
if ! systemctl --user is-active --quiet pipewire.service; then
    systemctl --user start pipewire.service pipewire-pulse.service wireplumber.service
    log "✓ PipeWire services started"
fi

# Load virtual audio sinks if configured
if [ -f "$SCRIPT_DIR/audio-sinks-load.sh" ]; then
    "$SCRIPT_DIR/audio-sinks-load.sh" &
    log "✓ Virtual audio sinks loaded"
fi

######################################################################################
# SYSTEM MONITORING
######################################################################################

log "Starting system monitors..."

# LACT for AMD GPU control (if installed)
if command -v lact &> /dev/null && systemctl is-enabled lactd &>/dev/null; then
    sudo systemctl start lactd
    log "✓ LACT GPU control started"
fi

# Gamemode daemon
if command -v gamemoded &> /dev/null; then
    systemctl --user start gamemoded
    log "✓ Gamemode daemon started"
fi

######################################################################################
# CLIPBOARD MANAGER
######################################################################################

log "Starting clipboard manager..."

# Start clipboard history
if command -v cliphist &> /dev/null; then
    wl-paste --type text --watch cliphist store &
    wl-paste --type image --watch cliphist store &
    log "✓ Cliphist clipboard manager started"
fi

######################################################################################
# IDLE & LOCK MANAGEMENT
######################################################################################

log "Configuring idle management..."

# Kill existing hypridle
killall hypridle 2>/dev/null

# Start hypridle for auto-lock and screen timeout
if command -v hypridle &> /dev/null; then
    hypridle &
    log "✓ Hypridle started"
fi

######################################################################################
# XDG PORTAL
######################################################################################

log "Ensuring XDG portals are running..."

# Kill existing portals
killall xdg-desktop-portal-hyprland xdg-desktop-portal 2>/dev/null
sleep 1

# Start XDG portals
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
log "✓ XDG portals started"

######################################################################################
# AUTO-START APPLICATIONS
######################################################################################

log "Starting auto-start applications..."

# Discord (if configured)
if [ -f "$HOME/.config/autostart-discord" ]; then
    discord --start-minimized &
    log "✓ Discord started (minimized)"
fi

# Steam (if configured for auto-start)
if [ -f "$HOME/.config/autostart-steam" ]; then
    steam -silent &
    log "✓ Steam started (minimized)"
fi

######################################################################################
# SYSTEM OPTIMIZATIONS
######################################################################################

log "Applying system optimizations..."

# Set CPU scaling governor
if [ -f "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" ]; then
    echo "schedutil" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
    log "✓ CPU governor set to schedutil"
fi

# Enable ZRAM if available
if systemctl is-active --quiet systemd-zram-setup@zram0.service; then
    log "✓ ZRAM is active"
fi

######################################################################################
# CUSTOM SCRIPTS
######################################################################################

log "Running custom scripts..."

# Check for updates notification
if [ -f "$SCRIPT_DIR/check-updates.sh" ]; then
    "$SCRIPT_DIR/check-updates.sh" &
fi

# Temperature monitoring
if [ -f "$SCRIPT_DIR/temp-monitor.sh" ]; then
    "$SCRIPT_DIR/temp-monitor.sh" &
    log "✓ Temperature monitor started"
fi

######################################################################################
# J.A.R.V.I.S. WELCOME
######################################################################################

log "Initiating J.A.R.V.I.S. welcome sequence..."

# Wait for audio system to be ready
sleep 3

# Play J.A.R.V.I.S. startup sound
if [ -f "$SCRIPT_DIR/jarvis-sound.sh" ]; then
    "$SCRIPT_DIR/jarvis-sound.sh" startup &
    log "✓ J.A.R.V.I.S. startup sound played"
fi

# Show system information notification
UPTIME=$(uptime -p | sed 's/up //')
CPU_TEMP=$(sensors | grep "Tctl" | awk '{print $2}' | head -1)
GPU_TEMP=$(sensors | grep "edge" | awk '{print $2}' | head -1)

notify-send "J.A.R.V.I.S. Systems Online" \
    "Welcome back, Sir.\n\nSystem Status:\n• Uptime: $UPTIME\n• CPU Temp: ${CPU_TEMP:-N/A}\n• GPU Temp: ${GPU_TEMP:-N/A}\n\nAll systems operational." \
    -i ~/.local/share/icons/wehttamsnaps-logo.png \
    -t 8000 &

log "✓ System status notification sent"

######################################################################################
# FINALIZATION
######################################################################################

log "=========================================="
log "Startup sequence completed successfully"
log "=========================================="

# Optional: Show welcome app on first login of the day
LAST_LOGIN_FILE="/tmp/wehttamsnaps-last-login"
TODAY=$(date +%Y-%m-%d)

if [ ! -f "$LAST_LOGIN_FILE" ] || [ "$(cat $LAST_LOGIN_FILE)" != "$TODAY" ]; then
    echo "$TODAY" > "$LAST_LOGIN_FILE"
    
    # Wait a bit then show welcome app
    sleep 5
    if [ -f "$SCRIPT_DIR/welcome-app.sh" ]; then
        "$SCRIPT_DIR/welcome-app.sh" &
        log "✓ Welcome app launched (first login today)"
    fi
fi

# End of startup script
exit 0
