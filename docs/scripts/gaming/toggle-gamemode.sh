#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                                                                      ║
# ║  __        __   _     _   _                    ____                  ║
# ║  \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _    ║
# ║   \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` |   ║
# ║    \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| |   ║
# ║     \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_|   ║
# ║                                                                      ║
# ║  Gaming Mode Toggle Script                                           ║
# ║  GitHub: https://github.com/Crowdrocker                              ║
# ║                                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Configuration
STATE_FILE="$HOME/.config/hypr-snaps/state/gaming-mode"
LOG_FILE="$HOME/.config/hypr-snaps/logs/gaming-mode.log"
JARVIS_SOUND_GAMING="$HOME/.config/hypr-snaps/assets/sounds/jarvis/jarvis-gaming.mp3"
JARVIS_SOUND_NORMAL="$HOME/.config/hypr-snaps/assets/sounds/jarvis/jarvis-normal.mp3"

# Audio profile paths
AUDIO_PROFILE_GAMING="$HOME/.config/qpwgraph/profiles/gaming.qpwgraph"
AUDIO_PROFILE_DEFAULT="$HOME/.config/qpwgraph/profiles/default.qpwgraph"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Create directories
mkdir -p "$(dirname "$STATE_FILE")"
mkdir -p "$(dirname "$LOG_FILE")"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Play J.A.R.V.I.S. sound
play_jarvis_sound() {
    local sound_file="$1"
    if [ -f "$sound_file" ]; then
        if command -v mpv &> /dev/null; then
            mpv --no-video --volume=70 "$sound_file" &> /dev/null &
        elif command -v ffplay &> /dev/null; then
            ffplay -nodisp -autoexit -volume 70 "$sound_file" &> /dev/null &
        elif command -v paplay &> /dev/null; then
            paplay "$sound_file" &> /dev/null &
        fi
    fi
}

# Check if gaming mode is active
is_gaming_mode_active() {
    [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "active" ]
}

# Enable gaming mode
enable_gaming_mode() {
    log "Enabling gaming mode..."
    echo "active" > "$STATE_FILE"

    # Play J.A.R.V.I.S. sound
    play_jarvis_sound "$JARVIS_SOUND_GAMING"

    # Enable gamemode
    if command -v gamemoded &> /dev/null; then
        log "Starting gamemode daemon..."
        systemctl --user start gamemoded 2>/dev/null
    fi

    # Set CPU governor to performance
    if command -v cpupower &> /dev/null; then
        log "Setting CPU governor to performance..."
        pkexec cpupower frequency-set -g performance &> /dev/null
    fi

    # AMD GPU optimizations
    if lspci | grep -i "VGA.*AMD" &> /dev/null; then
        log "Applying AMD GPU optimizations..."

        # Set GPU to high performance via CoreCtrl
        if command -v corectrl &> /dev/null; then
            corectrl --profile gaming &> /dev/null &
        fi

        # LACT GPU settings
        if command -v lact &> /dev/null; then
            lact set-fan-control manual &> /dev/null
            lact set-performance-level high &> /dev/null
            lact set-power-cap 0 &> /dev/null # Remove power limit
        fi
    fi

    # Disable compositor effects for performance (if using Hyprland)
    hyprctl keyword animations:enabled false &> /dev/null
    hyprctl keyword decoration:blur:enabled false &> /dev/null
    hyprctl keyword decoration:drop_shadow false &> /dev/null

    # Load gaming audio profile
    if [ -f "$AUDIO_PROFILE_GAMING" ] && command -v qpwgraph &> /dev/null; then
        log "Loading gaming audio profile..."
        qpwgraph -a "$AUDIO_PROFILE_GAMING" &> /dev/null &
        sleep 1
    fi

    # Disable unnecessary services
    log "Stopping background services..."
    systemctl --user stop baloo_file 2>/dev/null # KDE file indexer
    systemctl --user stop tracker-miner-fs-3.service 2>/dev/null # GNOME tracker

    # Set process priority for common game launchers
    if pgrep -x steam &> /dev/null; then
        log "Setting Steam priority..."
        renice -n -10 -p $(pgrep -x steam) &> /dev/null
    fi

    # Disable Do Not Disturb in Noctalia
    if command -v qs &> /dev/null; then
        qs -c noctalia-shell ipc call notifications toggleDND &> /dev/null
    fi

    # Send notification
    notify-send -u normal \
        "Gaming Mode Enabled" \
        "Performance optimizations active\nGamemode: ON\nAnimations: OFF" \
        -i applications-games \
        -t 3000

    log "Gaming mode enabled successfully"
}

# Disable gaming mode
disable_gaming_mode() {
    log "Disabling gaming mode..."
    echo "inactive" > "$STATE_FILE"

    # Play J.A.R.V.I.S. sound (optional - normal mode)
    if [ -f "$JARVIS_SOUND_NORMAL" ]; then
        play_jarvis_sound "$JARVIS_SOUND_NORMAL"
    fi

    # Restore CPU governor
    if command -v cpupower &> /dev/null; then
        log "Restoring CPU governor to schedutil..."
        pkexec cpupower frequency-set -g schedutil &> /dev/null
    fi

    # AMD GPU - restore default settings
    if lspci | grep -i "VGA.*AMD" &> /dev/null; then
        log "Restoring AMD GPU settings..."

        if command -v corectrl &> /dev/null; then
            corectrl --profile default &> /dev/null &
        fi

        if command -v lact &> /dev/null; then
            lact set-fan-control auto &> /dev/null
            lact set-performance-level auto &> /dev/null
        fi
    fi

    # Re-enable compositor effects
    hyprctl keyword animations:enabled true &> /dev/null
    hyprctl keyword decoration:blur:enabled true &> /dev/null
    hyprctl keyword decoration:drop_shadow true &> /dev/null

    # Restore default audio profile
    if [ -f "$AUDIO_PROFILE_DEFAULT" ] && command -v qpwgraph &> /dev/null; then
        log "Restoring default audio profile..."
        qpwgraph -a "$AUDIO_PROFILE_DEFAULT" &> /dev/null &
        sleep 1
    fi

    # Re-enable services
    log "Restarting background services..."
    systemctl --user start baloo_file 2>/dev/null
    systemctl --user start tracker-miner-fs-3.service 2>/dev/null

    # Send notification
    notify-send -u normal \
        "Gaming Mode Disabled" \
        "Normal mode restored\nGamemode: OFF\nAnimations: ON" \
        -i preferences-desktop \
        -t 3000

    log "Gaming mode disabled successfully"
}

# Toggle gaming mode
toggle_gaming_mode() {
    if is_gaming_mode_active; then
        disable_gaming_mode
    else
        enable_gaming_mode
    fi
}

# Show status
show_status() {
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║            Gaming Mode Status                            ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    if is_gaming_mode_active; then
        echo -e "Status: ${GREEN}ACTIVE${NC}"
        echo ""
        echo -e "${GREEN}Enabled Features:${NC}"
        echo "  ✓ Gamemode daemon"
        echo "  ✓ Performance CPU governor"
        echo "  ✓ AMD GPU high performance"
        echo "  ✓ Animations disabled"
        echo "  ✓ Gaming audio profile"
        echo "  ✓ Background services stopped"
    else
        echo -e "Status: ${RED}INACTIVE${NC}"
        echo ""
        echo -e "${YELLOW}Normal Mode:${NC}"
        echo "  • Standard CPU governor"
        echo "  • Auto GPU settings"
        echo "  • Animations enabled"
        echo "  • Default audio profile"
        echo "  • All services running"
    fi

    echo ""
    echo -e "${BLUE}GPU Info:${NC}"
    if command -v radeontop &> /dev/null; then
        radeontop -d - -l 1 | grep -E "gpu|vram" | head -2
    elif command -v lact &> /dev/null; then
        lact info | grep -E "Temperature|Fan Speed|Power" | head -3
    fi

    echo ""
}

# Auto-detect game launch and enable gaming mode
auto_enable_on_game() {
    # Monitor for game processes
    local game_processes=(
        "steam"
        "gamemode"
        "wine"
        "proton"
        "lutris"
        "heroic"
    )

    for process in "${game_processes[@]}"; do
        if pgrep -x "$process" &> /dev/null; then
            if ! is_gaming_mode_active; then
                log "Game detected ($process), auto-enabling gaming mode..."
                enable_gaming_mode
            fi
            return 0
        fi
    done
}

# Main function
main() {
    case "${1:-}" in
        on|enable)
            enable_gaming_mode
            ;;
        off|disable)
            disable_gaming_mode
            ;;
        toggle)
            toggle_gaming_mode
            ;;
        status)
            show_status
            ;;
        auto)
            auto_enable_on_game
            ;;
        --help|-h)
            cat << EOF
WehttamSnaps Gaming Mode Toggle

Optimizes system for gaming with performance tweaks and J.A.R.V.I.S. integration.

Usage: toggle-gamemode.sh [COMMAND]

Commands:
  toggle        Toggle gaming mode on/off (default)
  on, enable    Enable gaming mode
  off, disable  Disable gaming mode
  status        Show current status
  auto          Auto-enable when game detected
  --help        Show this help

Gaming Mode Features:
  • Gamemode daemon activation
  • CPU performance governor
  • AMD GPU high performance profile
  • Disabled compositor effects
  • Gaming audio routing
  • Background services paused
  • J.A.R.V.I.S. audio feedback

Keybind: SUPER + G

Examples:
  toggle-gamemode.sh              # Toggle mode
  toggle-gamemode.sh status       # Check status
  toggle-gamemode.sh on           # Force enable

GitHub: https://github.com/Crowdrocker
EOF
            ;;
        *)
            toggle_gaming_mode
            ;;
    esac
}

# Run main
main "$@"
