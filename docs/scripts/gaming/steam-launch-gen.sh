#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                                                                      ║
# ║  __        __   _     _   _                    ____                  ║
# ║  \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _    ║
# ║   \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` |   ║
# ║    \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| |   ║
# ║     \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_|   ║
# ║                                                                      ║
# ║  Streaming Mode Toggle Script                                        ║
# ║  GitHub: https://github.com/Crowdrocker                              ║
# ║                                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Configuration
STATE_FILE="$HOME/.config/hypr-snaps/state/streaming-mode"
LOG_FILE="$HOME/.config/hypr-snaps/logs/streaming-mode.log"
JARVIS_SOUND_STREAMING="$HOME/.config/hypr-snaps/assets/sounds/jarvis/jarvis-streaming.mp3"
JARVIS_SOUND_NORMAL="$HOME/.config/hypr-snaps/assets/sounds/jarvis/jarvis-normal.mp3"

# Audio profile paths
AUDIO_PROFILE_STREAMING="$HOME/.config/qpwgraph/profiles/streaming.qpwgraph"
AUDIO_PROFILE_DEFAULT="$HOME/.config/qpwgraph/profiles/default.qpwgraph"

# OBS settings
OBS_PROFILE="Streaming"
OBS_SCENE_COLLECTION="WehttamSnaps"

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

# Check if streaming mode is active
is_streaming_mode_active() {
    [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "active" ]
}

# Check if OBS is running
is_obs_running() {
    pgrep -x obs &> /dev/null
}

# Start OBS with streaming profile
start_obs() {
    if ! is_obs_running; then
        log "Starting OBS Studio..."
        obs --profile "$OBS_PROFILE" --collection "$OBS_SCENE_COLLECTION" &> /dev/null &
        sleep 3
    fi
}

# Setup audio routing for streaming
setup_streaming_audio() {
    log "Setting up streaming audio routing..."

    # Load streaming audio profile
    if [ -f "$AUDIO_PROFILE_STREAMING" ] && command -v qpwgraph &> /dev/null; then
        qpwgraph -a "$AUDIO_PROFILE_STREAMING" &> /dev/null &
        sleep 2
    fi

    # Create virtual audio sinks if not exist
    if command -v pw-cli &> /dev/null; then
        # Check if virtual sinks exist
        if ! pactl list sinks short | grep -q "game_audio"; then
            log "Creating virtual audio sinks..."

            # Game audio sink
            pactl load-module module-null-sink \
                sink_name=game_audio \
                sink_properties=device.description="Game_Audio" &> /dev/null

            # Discord audio sink
            pactl load-module module-null-sink \
                sink_name=discord_audio \
                sink_properties=device.description="Discord_Audio" &> /dev/null

            # Music audio sink
            pactl load-module module-null-sink \
                sink_name=music_audio \
                sink_properties=device.description="Music_Audio" &> /dev/null
        fi
    fi
}

# Enable streaming mode
enable_streaming_mode() {
    log "Enabling streaming mode..."
    echo "active" > "$STATE_FILE"

    # Play J.A.R.V.I.S. sound
    play_jarvis_sound "$JARVIS_SOUND_STREAMING"

    # Start OBS
    start_obs

    # Setup audio routing
    setup_streaming_audio

    # Set CPU governor to performance (for encoding)
    if command -v cpupower &> /dev/null; then
        log "Setting CPU governor to performance..."
        pkexec cpupower frequency-set -g performance &> /dev/null
    fi

    # AMD GPU optimizations for encoding
    if lspci | grep -i "VGA.*AMD" &> /dev/null; then
        log "Applying AMD GPU streaming optimizations..."

        # Set GPU to high performance
        if command -v lact &> /dev/null; then
            lact set-performance-level high &> /dev/null
            lact set-fan-control manual &> /dev/null
        fi
    fi

    # Disable unnecessary animations (keep some for stream)
    hyprctl keyword decoration:blur:enabled false &> /dev/null

    # Set process priority for OBS
    if pgrep -x obs &> /dev/null; then
        log "Setting OBS priority..."
        renice -n -15 -p $(pgrep -x obs) &> /dev/null
    fi

    # Enable Do Not Disturb in Noctalia (prevent stream interruptions)
    if command -v qs &> /dev/null; then
        qs -c noctalia-shell ipc call notifications toggleDND &> /dev/null
    fi

    # Disable screen blanking
    if command -v hypridle &> /dev/null; then
        killall hypridle &> /dev/null
    fi

    # Enable idle inhibitor
    if command -v qs &> /dev/null; then
        qs -c noctalia-shell ipc call idleInhibitor toggle &> /dev/null
    fi

    # Start system monitoring
    if command -v btop &> /dev/null; then
        log "Starting system monitor..."
        # Could launch btop in a special workspace for monitoring
    fi

    # Send notification
    notify-send -u normal \
        "Streaming Mode Enabled" \
        "All systems ready for streaming\nOBS: Started\nAudio: Routed\nDND: ON" \
        -i camera-video \
        -t 5000

    log "Streaming mode enabled successfully"

    # Show quick info
    show_streaming_info
}

# Disable streaming mode
disable_streaming_mode() {
    log "Disabling streaming mode..."
    echo "inactive" > "$STATE_FILE"

    # Play normal sound
    if [ -f "$JARVIS_SOUND_NORMAL" ]; then
        play_jarvis_sound "$JARVIS_SOUND_NORMAL"
    fi

    # Restore CPU governor
    if command -v cpupower &> /dev/null; then
        log "Restoring CPU governor..."
        pkexec cpupower frequency-set -g schedutil &> /dev/null
    fi

    # Restore AMD GPU settings
    if lspci | grep -i "VGA.*AMD" &> /dev/null; then
        log "Restoring AMD GPU settings..."

        if command -v lact &> /dev/null; then
            lact set-performance-level auto &> /dev/null
            lact set-fan-control auto &> /dev/null
        fi
    fi

    # Re-enable compositor effects
    hyprctl keyword decoration:blur:enabled true &> /dev/null

    # Restore default audio profile
    if [ -f "$AUDIO_PROFILE_DEFAULT" ] && command -v qpwgraph &> /dev/null; then
        log "Restoring default audio profile..."
        qpwgraph -a "$AUDIO_PROFILE_DEFAULT" &> /dev/null &
        sleep 1
    fi

    # Remove virtual audio sinks
    log "Cleaning up virtual audio sinks..."
    pactl list sinks short | grep -E "game_audio|discord_audio|music_audio" | \
        awk '{print $2}' | while read sink; do
        pactl unload-module "$(pactl list sinks | grep -B 20 "$sink" | grep "Owner Module:" | awk '{print $3}')" &> /dev/null
    done

    # Disable Do Not Disturb
    if command -v qs &> /dev/null; then
        qs -c noctalia-shell ipc call notifications toggleDND &> /dev/null
    fi

    # Re-enable screen blanking
    if command -v hypridle &> /dev/null; then
        hypridle &> /dev/null &
    fi

    # Send notification
    notify-send -u normal \
        "Streaming Mode Disabled" \
        "Normal mode restored\nOBS: Running (not stopped)\nAudio: Default" \
        -i preferences-desktop \
        -t 3000

    log "Streaming mode disabled successfully"
}

# Toggle streaming mode
toggle_streaming_mode() {
    if is_streaming_mode_active; then
        disable_streaming_mode
    else
        enable_streaming_mode
    fi
}

# Show streaming info
show_streaming_info() {
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║            Streaming Mode - Quick Info                   ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${GREEN}Audio Routing:${NC}"
    echo "  Game Audio    → game_audio sink → OBS"
    echo "  Discord       → discord_audio sink → OBS"
    echo "  Music         → music_audio sink → OBS (ducked)"
    echo "  Microphone    → OBS (with filters)"
    echo ""
    echo -e "${GREEN}OBS Hotkeys:${NC}"
    echo "  Start/Stop Stream: SUPER + Shift + S"
    echo "  Start/Stop Record: SUPER + Shift + R"
    echo "  Mute Mic:          SUPER + M"
    echo ""
    echo -e "${BLUE}Tip:${NC} Route game audio to 'Game_Audio' sink in pavucontrol"
    echo ""
}

# Show status
show_status() {
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║            Streaming Mode Status                         ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    if is_streaming_mode_active; then
        echo -e "Status: ${GREEN}ACTIVE${NC}"
        echo ""
        echo -e "${GREEN}Enabled Features:${NC}"
        echo "  ✓ OBS Studio launched"
        echo "  ✓ Streaming audio routing"
        echo "  ✓ Virtual audio sinks created"
        echo "  ✓ Performance CPU governor"
        echo "  ✓ Do Not Disturb enabled"
        echo "  ✓ Screen blanking disabled"
        echo "  ✓ OBS high priority"
    else
        echo -e "Status: ${RED}INACTIVE${NC}"
        echo ""
        echo -e "${YELLOW}Normal Mode:${NC}"
        echo "  • Default audio routing"
        echo "  • Standard CPU governor"
        echo "  • Notifications enabled"
        echo "  • Normal process priorities"
    fi

    echo ""
    echo -e "${BLUE}OBS Status:${NC}"
    if is_obs_running; then
        echo -e "  ${GREEN}Running${NC} (PID: $(pgrep -x obs))"

        # Check if streaming
        if command -v obs-cli &> /dev/null; then
            if obs-cli streaming status | grep -q "active"; then
                echo -e "  Stream: ${GREEN}LIVE${NC}"
            else
                echo -e "  Stream: ${YELLOW}Offline${NC}"
            fi

            if obs-cli recording status | grep -q "active"; then
                echo -e "  Recording: ${RED}●${NC} REC"
            else
                echo -e "  Recording: ${YELLOW}Stopped${NC}"
            fi
        fi
    else
        echo -e "  ${RED}Not running${NC}"
    fi

    echo ""
    echo -e "${BLUE}Audio Sinks:${NC}"
    pactl list sinks short | grep -E "game_audio|discord_audio|music_audio" | \
        awk '{print "  ✓ " $2}' || echo "  No virtual sinks active"

    echo ""
}

# Quick audio test
test_audio() {
    echo -e "${CYAN}Testing Audio Routing...${NC}"
    echo ""

    if command -v speaker-test &> /dev/null; then
        echo "Playing test tone on Game Audio sink..."
        speaker-test -t sine -f 440 -c 2 -l 1 -s 1 -D game_audio &> /dev/null
        echo "Did you hear the tone? Check OBS audio levels!"
    else
        echo "speaker-test not found. Install alsa-utils."
    fi
}

# Open audio mixer
open_audio_mixer() {
    if command -v qpwgraph &> /dev/null; then
        qpwgraph &> /dev/null &
    elif command -v pavucontrol &> /dev/null; then
        pavucontrol &> /dev/null &
    else
        echo "No audio mixer found. Install qpwgraph or pavucontrol."
    fi
}

# Main function
main() {
    case "${1:-}" in
        on|enable)
            enable_streaming_mode
            ;;
        off|disable)
            disable_streaming_mode
            ;;
        toggle)
            toggle_streaming_mode
            ;;
        status)
            show_status
            ;;
        info)
            show_streaming_info
            ;;
        test-audio)
            test_audio
            ;;
        mixer)
            open_audio_mixer
            ;;
        obs)
            start_obs
            ;;
        --help|-h)
            cat << EOF
WehttamSnaps Streaming Mode Toggle

Optimizes system for streaming with audio routing and J.A.R.V.I.S. integration.

Usage: toggle-streaming.sh [COMMAND]

Commands:
  toggle        Toggle streaming mode on/off (default)
  on, enable    Enable streaming mode
  off, disable  Disable streaming mode
  status        Show detailed status
  info          Show streaming info and tips
  test-audio    Test audio routing
  mixer         Open audio mixer (qpwgraph/pavucontrol)
  obs           Start OBS Studio
  --help        Show this help

Streaming Mode Features:
  • OBS Studio auto-launch
  • Advanced audio routing (qpwgraph)
  • Virtual audio sinks (game, Discord, music)
  • CPU performance optimization
  • Do Not Disturb mode
  • Screen blanking disabled
  • High priority for OBS
  • J.A.R.V.I.S. audio feedback

Audio Routing:
  Game Audio    → game_audio → OBS → Stream
  Discord       → discord_audio → OBS → Stream
  Music         → music_audio → OBS (ducked)
  Microphone    → OBS (with filters) → Stream

Keybind: SUPER + Shift + S

Examples:
  toggle-streaming.sh              # Toggle mode
  toggle-streaming.sh status       # Check status
  toggle-streaming.sh mixer        # Open audio mixer
  toggle-streaming.sh test-audio   # Test routing

GitHub: https://github.com/Crowdrocker
EOF
            ;;
        *)
            toggle_streaming_mode
            ;;
    esac
}

# Run main
main "$@"
