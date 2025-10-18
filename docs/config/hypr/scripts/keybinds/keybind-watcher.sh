#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                                                                      ║
# ║  __        __   _     _   _                    ____                  ║
# ║  \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _    ║
# ║   \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` |   ║
# ║    \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| |   ║
# ║     \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_|   ║
# ║                                                                      ║
# ║  Keybind Config Watcher - Auto Regenerate on Changes                ║
# ║  GitHub: https://github.com/Crowdrocker                              ║
# ║                                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Configuration
WATCH_FILE="$HOME/.config/hypr/modules/binds.conf"
GENERATOR_SCRIPT="$HOME/.config/hypr/scripts/keybinds/generate-cheatsheet.sh"
LOG_FILE="$HOME/.config/hypr-snaps/logs/keybind-watcher.log"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Function to log messages
log_message() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $1" | tee -a "$LOG_FILE"
}

# Function to check if inotifywait is installed
check_dependencies() {
    if ! command -v inotifywait &> /dev/null; then
        echo "Error: inotifywait not found. Install inotify-tools:"
        echo "  paru -S inotify-tools"
        exit 1
    fi
}

# Function to generate cheat sheet
regenerate_cheatsheet() {
    log_message "Detected change in binds.conf, regenerating cheat sheet..."

    if [ -f "$GENERATOR_SCRIPT" ]; then
        bash "$GENERATOR_SCRIPT" >> "$LOG_FILE" 2>&1

        if [ $? -eq 0 ]; then
            log_message "✓ Cheat sheet regenerated successfully"
            notify-send -u normal \
                "Keybindings Updated" \
                "Cheat sheet has been regenerated" \
                -i keyboard
        else
            log_message "✗ Failed to regenerate cheat sheet"
            notify-send -u critical \
                "Keybinding Error" \
                "Failed to regenerate cheat sheet" \
                -i error
        fi
    else
        log_message "✗ Generator script not found: $GENERATOR_SCRIPT"
    fi
}

# Function to start watching
start_watching() {
    log_message "Starting keybind config watcher..."
    log_message "Watching: $WATCH_FILE"

    echo -e "${BLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║     Keybind Config Watcher - Running                     ║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${GREEN}Watching:${NC} $WATCH_FILE"
    echo -e "${GREEN}Log file:${NC} $LOG_FILE"
    echo -e "${YELLOW}Press Ctrl+C to stop${NC}"
    echo ""

    # Watch for modifications
    while inotifywait -e modify,close_write "$WATCH_FILE" 2>/dev/null; do
        # Small delay to avoid multiple triggers
        sleep 1
        regenerate_cheatsheet
        echo ""
    done
}

# Function to run as systemd service
run_as_service() {
    log_message "Starting as systemd service..."

    # Watch file in background
    while true; do
        inotifywait -e modify,close_write "$WATCH_FILE" 2>/dev/null
        sleep 1
        regenerate_cheatsheet
        sleep 5  # Cooldown period
    done
}

# Main function
main() {
    check_dependencies

    case "${1:-}" in
        --service)
            run_as_service
            ;;
        --once)
            regenerate_cheatsheet
            ;;
        --help|-h)
            cat << EOF
Keybind Config Watcher

Automatically regenerates the keybindings cheat sheet when binds.conf changes.

Usage: keybind-watcher.sh [OPTIONS]

Options:
  (none)        Start watching in foreground
  --service     Run as background service
  --once        Regenerate once and exit
  --help        Show this help message

Files:
  Watch:  $WATCH_FILE
  Script: $GENERATOR_SCRIPT
  Log:    $LOG_FILE

To run at startup, add to Hyprland autostart:
  exec-once = ~/.config/hypr/scripts/keybinds/keybind-watcher.sh --service
EOF
            ;;
        *)
            start_watching
            ;;
    esac
}

# Run main
main "$@"
