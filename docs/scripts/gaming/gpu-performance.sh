#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                                                                      ║
# ║  __        __   _     _   _                    ____                  ║
# ║  \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _    ║
# ║   \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` |   ║
# ║    \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| |   ║
# ║     \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_|   ║
# ║                                                                      ║
# ║  GPU Performance Toggle Script (AMD RX 580)                          ║
# ║  GitHub: https://github.com/Crowdrocker                              ║
# ║                                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Configuration
STATE_FILE="$HOME/.config/hypr-snaps/state/gpu-performance"
LOG_FILE="$HOME/.config/hypr-snaps/logs/gpu-performance.log"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Create directories
mkdir -p "$(dirname "$STATE_FILE")"
mkdir -p "$(dirname "$LOG_FILE")"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Check if performance mode is active
is_performance_mode() {
    [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "performance" ]
}

# Detect AMD GPU
detect_amd_gpu() {
    if lspci | grep -i "VGA.*AMD" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Get GPU temperature
get_gpu_temp() {
    if command -v sensors &> /dev/null; then
        sensors | grep -i "edge" | awk '{print $2}' | tr -d '+°C'
    elif [ -f /sys/class/drm/card0/device/hwmon/hwmon*/temp1_input ]; then
        echo $(($(cat /sys/class/drm/card0/device/hwmon/hwmon*/temp1_input 2>/dev/null | head -1) / 1000))
    else
        echo "N/A"
    fi
}

# Get GPU clock speed
get_gpu_clock() {
    if [ -f /sys/class/drm/card0/device/pp_dpm_sclk ]; then
        grep -E "\*" /sys/class/drm/card0/device/pp_dpm_sclk | awk '{print $2}' | tr -d 'Mhz'
    else
        echo "N/A"
    fi
}

# Get GPU power usage
get_gpu_power() {
    if [ -f /sys/class/drm/card0/device/hwmon/hwmon*/power1_average ]; then
        echo $(($(cat /sys/class/drm/card0/device/hwmon/hwmon*/power1_average 2>/dev/null | head -1) / 1000000))
    else
        echo "N/A"
    fi
}

# Enable performance mode using LACT
enable_with_lact() {
    log "Using LACT for GPU control..."

    # Set performance level to high
    lact set-performance-level high &> /dev/null

    # Set power profile to maximum
    lact set-power-profile 3d-fullspeed &> /dev/null

    # Remove power cap
    lact set-power-cap 0 &> /dev/null

    # Set manual fan control with aggressive curve
    lact set-fan-control manual &> /dev/null
    lact set-fan-speed 70 &> /dev/null

    log "LACT: Performance mode enabled"
}

# Disable performance mode with LACT
disable_with_lact() {
    log "Restoring LACT default settings..."

    # Set performance level to auto
    lact set-performance-level auto &> /dev/null

    # Set power profile to auto
    lact set-power-profile auto &> /dev/null

    # Restore automatic fan control
    lact set-fan-control auto &> /dev/null

    log "LACT: Auto mode restored"
}

# Enable performance mode using CoreCtrl
enable_with_corectrl() {
    log "Using CoreCtrl for GPU control..."

    # Load gaming profile if exists
    if [ -f "$HOME/.config/corectrl/profiles/gaming.profile" ]; then
        corectrl --profile gaming &> /dev/null &
    fi

    log "CoreCtrl: Gaming profile loaded"
}

# Disable performance mode with CoreCtrl
disable_with_corectrl() {
    log "Restoring CoreCtrl default..."

    # Load default profile
    if [ -f "$HOME/.config/corectrl/profiles/default.profile" ]; then
        corectrl --profile default &> /dev/null &
    fi

    log "CoreCtrl: Default profile loaded"
}

# Enable performance mode with sysfs
enable_with_sysfs() {
    log "Using sysfs for GPU control..."

    # Set power profile to high
    if [ -f /sys/class/drm/card0/device/power_dpm_force_performance_level ]; then
        echo "high" | pkexec tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
    fi

    # Set highest performance state
    if [ -f /sys/class/drm/card0/device/pp_power_profile_mode ]; then
        echo "1" | pkexec tee /sys/class/drm/card0/device/pp_power_profile_mode > /dev/null
    fi

    log "Sysfs: High performance set"
}

# Disable performance mode with sysfs
disable_with_sysfs() {
    log "Restoring sysfs defaults..."

    # Set power profile to auto
    if [ -f /sys/class/drm/card0/device/power_dpm_force_performance_level ]; then
        echo "auto" | pkexec tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
    fi

    log "Sysfs: Auto mode restored"
}

# Enable GPU performance mode
enable_performance_mode() {
    if ! detect_amd_gpu; then
        echo -e "${RED}Error: AMD GPU not detected${NC}"
        exit 1
    fi

    log "Enabling GPU performance mode..."
    echo "performance" > "$STATE_FILE"

    # Try LACT first (preferred)
    if command -v lact &> /dev/null; then
        enable_with_lact
    # Try CoreCtrl second
    elif command -v corectrl &> /dev/null; then
        enable_with_corectrl
    # Fall back to sysfs
    else
        enable_with_sysfs
    fi

    # Additional optimizations
    log "Applying additional optimizations..."

    # Disable GPU power management for maximum performance
    if [ -f /sys/class/drm/card0/device/power_dpm_state ]; then
        echo "performance" | pkexec tee /sys/class/drm/card0/device/power_dpm_state > /dev/null 2>&1
    fi

    # Set minimum GPU clock to maximum
    if [ -f /sys/class/drm/card0/device/pp_dpm_sclk ]; then
        # Get highest clock level
        local max_level=$(grep -E "[0-9]+:" /sys/class/drm/card0/device/pp_dpm_sclk | tail -1 | cut -d':' -f1)
        echo "$max_level" | pkexec tee /sys/class/drm/card0/device/pp_dpm_sclk > /dev/null 2>&1
    fi

    # Send notification
    notify-send -u normal \
        "GPU Performance Mode" \
        "High performance enabled\nRX 580 optimized for gaming" \
        -i video-display \
        -t 3000

    log "GPU performance mode enabled"
}

# Disable GPU performance mode
disable_performance_mode() {
    log "Disabling GPU performance mode..."
    echo "auto" > "$STATE_FILE"

    # Restore settings based on available tool
    if command -v lact &> /dev/null; then
        disable_with_lact
    elif command -v corectrl &> /dev/null; then
        disable_with_corectrl
    else
        disable_with_sysfs
    fi

    # Restore automatic power management
    if [ -f /sys/class/drm/card0/device/power_dpm_state ]; then
        echo "balanced" | pkexec tee /sys/class/drm/card0/device/power_dpm_state > /dev/null 2>&1
    fi

    # Send notification
    notify-send -u normal \
        "GPU Auto Mode" \
        "Automatic GPU management restored\nRX 580 balanced mode" \
        -i video-display \
        -t 3000

    log "GPU auto mode restored"
}

# Toggle performance mode
toggle_performance_mode() {
    if is_performance_mode; then
        disable_performance_mode
    else
        enable_performance_mode
    fi
}

# Show GPU status
show_status() {
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║            AMD RX 580 GPU Status                         ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Performance mode status
    if is_performance_mode; then
        echo -e "Mode: ${GREEN}HIGH PERFORMANCE${NC}"
    else
        echo -e "Mode: ${YELLOW}AUTO (Balanced)${NC}"
    fi

    echo ""
    echo -e "${BLUE}GPU Information:${NC}"

    # Temperature
    local temp=$(get_gpu_temp)
    if [ "$temp" != "N/A" ]; then
        if [ "$temp" -lt 65 ]; then
            echo -e "  Temperature:  ${GREEN}${temp}°C${NC}"
        elif [ "$temp" -lt 80 ]; then
            echo -e "  Temperature:  ${YELLOW}${temp}°C${NC}"
        else
            echo -e "  Temperature:  ${RED}${temp}°C${NC}"
        fi
    else
        echo "  Temperature:  N/A"
    fi

    # Clock speed
    local clock=$(get_gpu_clock)
    echo "  Clock Speed:  ${clock} MHz"

    # Power usage
    local power=$(get_gpu_power)
    if [ "$power" != "N/A" ]; then
        echo "  Power Draw:   ${power}W"
    fi

    echo ""

    # Fan speed (if available)
    if command -v lact &> /dev/null; then
        echo -e "${BLUE}Fan Control:${NC}"
        lact info | grep -i "fan" | head -3
        echo ""
    fi

    # Available control methods
    echo -e "${BLUE}Available Controls:${NC}"
    command -v lact &> /dev/null && echo "  ✓ LACT (Linux AMDGPU Controller)" || echo "  ✗ LACT"
    command -v corectrl &> /dev/null && echo "  ✓ CoreCtrl" || echo "  ✗ CoreCtrl"
    [ -f /sys/class/drm/card0/device/power_dpm_force_performance_level ] && echo "  ✓ Sysfs" || echo "  ✗ Sysfs"

    echo ""
}

# Monitor GPU in real-time
monitor_gpu() {
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║            Real-Time GPU Monitoring                      ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Press Ctrl+C to stop..."
    echo ""

    while true; do
        local temp=$(get_gpu_temp)
        local clock=$(get_gpu_clock)
        local power=$(get_gpu_power)

        printf "\r  Temp: %s°C | Clock: %s MHz | Power: %sW    " "$temp" "$clock" "$power"
        sleep 1
    done
}

# Benchmark GPU
benchmark_gpu() {
    echo -e "${CYAN}Running GPU Benchmark...${NC}"
    echo ""

    if command -v glxgears &> /dev/null; then
        echo "Running glxgears for 10 seconds..."
        timeout 10 vblank_mode=0 glxgears &> /dev/null &
        sleep 10
        echo "Benchmark complete!"
    else
        echo "glxgears not found. Install mesa-demos."
    fi
}

# Create CoreCtrl gaming profile
create_corectrl_profile() {
    local profile_dir="$HOME/.config/corectrl/profiles"
    mkdir -p "$profile_dir"

    cat > "$profile_dir/gaming.profile" << 'EOF'
# WehttamSnaps Gaming Profile for AMD RX 580
# Auto-generated by gpu-performance.sh

[General]
Name=Gaming
Description=High performance settings for gaming

[GPU]
PerformanceLevel=high
PowerProfile=3d-fullspeed
PowerLimit=0

[Fan]
Mode=manual
Speed=70
EOF

    echo "CoreCtrl gaming profile created: $profile_dir/gaming.profile"
}

# Main function
main() {
    case "${1:-}" in
        on|enable|high)
            enable_performance_mode
            ;;
        off|disable|auto)
            disable_performance_mode
            ;;
        toggle)
            toggle_performance_mode
            ;;
        status)
            show_status
            ;;
        monitor)
            monitor_gpu
            ;;
        benchmark)
            benchmark_gpu
            ;;
        create-profile)
            create_corectrl_profile
            ;;
        --help|-h)
            cat << EOF
WehttamSnaps GPU Performance Toggle (AMD RX 580)

Optimizes AMD RX 580 for gaming with performance tweaks.

Usage: gpu-performance.sh [COMMAND]

Commands:
  toggle            Toggle performance mode (default)
  on, enable, high  Enable high performance mode
  off, disable, auto Disable (auto mode)
  status            Show GPU status
  monitor           Real-time GPU monitoring
  benchmark         Run quick benchmark
  create-profile    Create CoreCtrl gaming profile
  --help            Show this help

Performance Mode Features:
  • High performance power profile
  • Maximum GPU clocks
  • Aggressive fan curve (70%)
  • Removed power limits
  • Optimized for RX 580

Control Methods (in order of preference):
  1. LACT - Linux AMDGPU Controller (recommended)
  2. CoreCtrl - Advanced GPU control
  3. Sysfs - Direct kernel interface

Installation:
  LACT:     paru -S lact
  CoreCtrl: paru -S corectrl

Keybind: SUPER + F11

Examples:
  gpu-performance.sh toggle    # Toggle mode
  gpu-performance.sh status    # Show info
  gpu-performance.sh monitor   # Watch temps

GitHub: https://github.com/Crowdrocker
EOF
            ;;
        *)
            toggle_performance_mode
            ;;
    esac
}

# Check if AMD GPU present
if ! detect_amd_gpu; then
    echo -e "${RED}Error: AMD GPU not detected${NC}"
    echo "This script is designed for AMD RX 580"
    exit 1
fi

# Run main
main "$@"
