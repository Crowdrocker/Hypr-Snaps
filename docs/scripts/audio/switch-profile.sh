#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                                                                      ║
# ║  __        __   _     _   _                    ____                  ║
# ║  \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _    ║
# ║   \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` |   ║
# ║    \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| |   ║
# ║     \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_|   ║
# ║                                                                      ║
# ║  Audio Profile Switcher (Voicemeter Alternative)                     ║
# ║  GitHub: https://github.com/Crowdrocker                              ║
# ║                                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Configuration
PROFILE_DIR="$HOME/.config/qpwgraph/profiles"
STATE_FILE="$HOME/.config/hypr-snaps/state/audio-profile"
LOG_FILE="$HOME/.config/hypr-snaps/logs/audio-profile.log"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Create directories
mkdir -p "$PROFILE_DIR"
mkdir -p "$(dirname "$STATE_FILE")"
mkdir -p "$(dirname "$LOG_FILE")"

# Logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Get current profile
get_current_profile() {
    if [ -f "$STATE_FILE" ]; then
        cat "$STATE_FILE"
    else
        echo "default"
    fi
}

# Set current profile
set_current_profile() {
    echo "$1" > "$STATE_FILE"
}

# List available profiles
list_profiles() {
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║            Available Audio Profiles                      ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    local current=$(get_current_profile)
    local count=1

    for profile in "$PROFILE_DIR"/*.qpwgraph; do
        if [ -f "$profile" ]; then
            local name=$(basename "$profile" .qpwgraph)
            if [ "$name" = "$current" ]; then
                echo -e "  ${GREEN}► $count. $name (active)${NC}"
            else
                echo -e "    $count. $name"
            fi
            count=$((count + 1))
        fi
    done

    if [ $count -eq 1 ]; then
        echo -e "${YELLOW}  No profiles found${NC}"
        echo -e "${BLUE}  Create profiles with: $0 create${NC}"
    fi

    echo ""
}

# Load audio profile
load_profile() {
    local profile_name="$1"
    local profile_file="$PROFILE_DIR/${profile_name}.qpwgraph"

    if [ ! -f "$profile_file" ]; then
        echo -e "${RED}Error: Profile '$profile_name' not found${NC}"
        return 1
    fi

    log "Loading audio profile: $profile_name"

    # Load profile with qpwgraph
    if command -v qpwgraph &> /dev/null; then
        qpwgraph -a "$profile_file" &> /dev/null
        sleep 1
    else
        echo -e "${RED}Error: qpwgraph not installed${NC}"
        return 1
    fi

    # Update state
    set_current_profile "$profile_name"

    # Send notification
    notify-send -u normal \
        "Audio Profile Loaded" \
        "Profile: $profile_name" \
        -i audio-card \
        -t 2000

    log "Audio profile '$profile_name' loaded successfully"
    echo -e "${GREEN}✓ Profile '$profile_name' loaded${NC}"
}

# Switch to next profile
next_profile() {
    local profiles=()
    for profile in "$PROFILE_DIR"/*.qpwgraph; do
        if [ -f "$profile" ]; then
            profiles+=("$(basename "$profile" .qpwgraph)")
        fi
    done

    if [ ${#profiles[@]} -eq 0 ]; then
        echo -e "${RED}No profiles available${NC}"
        return 1
    fi

    local current=$(get_current_profile)
    local current_index=-1

    # Find current profile index
    for i in "${!profiles[@]}"; do
        if [ "${profiles[$i]}" = "$current" ]; then
            current_index=$i
            break
        fi
    done

    # Calculate next index
    local next_index=$(( (current_index + 1) % ${#profiles[@]} ))
    local next_profile="${profiles[$next_index]}"

    load_profile "$next_profile"
}

# Interactive profile selector
select_profile() {
    if command -v fzf &> /dev/null; then
        select_profile_fzf
    elif command -v rofi &> /dev/null; then
        select_profile_rofi
    else
        select_profile_menu
    fi
}

# Select with fzf
select_profile_fzf() {
    local current=$(get_current_profile)
    local profiles=()

    for profile in "$PROFILE_DIR"/*.qpwgraph; do
        if [ -f "$profile" ]; then
            local name=$(basename "$profile" .qpwgraph)
            if [ "$name" = "$current" ]; then
                profiles+=("$name (current)")
            else
                profiles+=("$name")
            fi
        fi
    done

    local selected=$(printf '%s\n' "${profiles[@]}" | fzf \
        --header="Select Audio Profile" \
        --prompt="Profile: " \
        --height=40% \
        --border=rounded \
        --color="fg:#cdd6f4,bg:#1e1e2e,hl:#f38ba8")

    if [ -n "$selected" ]; then
        local profile_name="${selected% (current)}"
        load_profile "$profile_name"
    fi
}

# Select with rofi
select_profile_rofi() {
    local profiles=()
    for profile in "$PROFILE_DIR"/*.qpwgraph; do
        if [ -f "$profile" ]; then
            profiles+=("$(basename "$profile" .qpwgraph)")
        fi
    done

    local selected=$(printf '%s\n' "${profiles[@]}" | rofi \
        -dmenu \
        -i \
        -p "Audio Profile")

    if [ -n "$selected" ]; then
        load_profile "$selected"
    fi
}

# Select with menu
select_profile_menu() {
    list_profiles
    read -p "Select profile number: " choice

    local count=1
    for profile in "$PROFILE_DIR"/*.qpwgraph; do
        if [ -f "$profile" ]; then
            if [ "$count" -eq "$choice" ]; then
                local name=$(basename "$profile" .qpwgraph)
                load_profile "$name"
                return
            fi
            count=$((count + 1))
        fi
    done

    echo -e "${RED}Invalid selection${NC}"
}

# Create default profiles
create_default_profiles() {
    echo -e "${CYAN}Creating default audio profiles...${NC}"
    echo ""

    # Create profile directory
    mkdir -p "$PROFILE_DIR"

    # Note: qpwgraph profiles need to be created interactively
    # This will create template information files

    cat > "$PROFILE_DIR/README.md" << 'EOF'
# Audio Profiles

Create your audio routing profiles using qpwgraph:

## Creating a Profile:

1. Open qpwgraph: `qpwgraph`
2. Set up your audio routing (drag connections)
3. Go to File → Save As...
4. Save to: `~/.config/qpwgraph/profiles/profile-name.qpwgraph`

## Recommended Profiles:

### Default Profile
- Standard desktop audio routing
- All audio → default output

### Gaming Profile
- Game audio → game_audio sink → Headphones + OBS
- Discord → discord_audio sink → Headphones + OBS
- Music → music_audio sink → Headphones (ducked)
- Mic → Headphones (for monitoring) + OBS

### Streaming Profile
- Similar to gaming but with additional OBS routing
- Background music ducking enabled
- Multiple audio sources to OBS

### Work Profile
- Simple routing for productivity
- Notifications to speakers
- Meeting audio to headset

## Usage:

Switch profiles:
```bash
switch-audio-profile.sh           # Interactive selector
switch-audio-profile.sh gaming    # Load specific profile
switch-audio-profile.sh next      # Cycle to next profile
```

Keybind: SUPER + Alt + A
EOF

    echo -e "${GREEN}✓ README created: $PROFILE_DIR/README.md${NC}"
    echo ""
    echo -e "${YELLOW}To create profiles:${NC}"
    echo "1. Run: qpwgraph"
    echo "2. Set up your routing"
    echo "3. Save to: $PROFILE_DIR/profile-name.qpwgraph"
    echo ""
}

# Show current audio routing
show_routing() {
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║            Current Audio Routing                         ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BLUE}Current Profile:${NC} $(get_current_profile)"
    echo ""

    echo -e "${BLUE}Audio Sinks:${NC}"
    pactl list sinks short | awk '{printf "  %s - %s\n", $2, $NF}'

    echo ""
    echo -e "${BLUE}Audio Sources:${NC}"
    pactl list sources short | awk '{printf "  %s - %s\n", $2, $NF}'

    echo ""
    echo -e "${BLUE}Active Applications:${NC}"
    pactl list sink-inputs | grep -E "application.name|Sink:" | paste - - | \
        awk -F'"' '{print "  " $2}' | head -10

    echo ""
}

# Open qpwgraph
open_qpwgraph() {
    if command -v qpwgraph &> /dev/null; then
        qpwgraph &> /dev/null &
        echo -e "${GREEN}qpwgraph opened${NC}"
    else
        echo -e "${RED}qpwgraph not installed${NC}"
        echo "Install with: paru -S qpwgraph"
    fi
}

# Open pavucontrol
open_pavucontrol() {
    if command -v pavucontrol &> /dev/null; then
        pavucontrol &> /dev/null &
        echo -e "${GREEN}pavucontrol opened${NC}"
    else
        echo -e "${RED}pavucontrol not installed${NC}"
        echo "Install with: paru -S pavucontrol"
    fi
}

# Main function
main() {
    case "${1:-}" in
        list|ls)
            list_profiles
            ;;
        load)
            if [ -z "$2" ]; then
                echo -e "${RED}Error: Profile name required${NC}"
                echo "Usage: $0 load <profile-name>"
                exit 1
            fi
            load_profile "$2"
            ;;
        next|cycle)
            next_profile
            ;;
        select|menu)
            select_profile
            ;;
        create|setup)
            create_default_profiles
            ;;
        status|show)
            show_routing
            ;;
        qpwgraph|graph)
            open_qpwgraph
            ;;
        pavucontrol|mixer)
            open_pavucontrol
            ;;
        default)
            load_profile "default"
            ;;
        gaming)
            load_profile "gaming"
            ;;
        streaming)
            load_profile "streaming"
            ;;
        work)
            load_profile "work"
            ;;
        --help|-h)
            cat << EOF
WehttamSnaps Audio Profile Switcher

Linux alternative to Voicemeter using PipeWire + qpwgraph.
Separate and route audio from games, Discord, Spotify, etc.

Usage: switch-audio-profile.sh [COMMAND] [OPTIONS]

Commands:
  list, ls              List available profiles
  load <profile>        Load specific profile
  next, cycle           Switch to next profile
  select, menu          Interactive profile selector
  create, setup         Create default profile templates
  status, show          Show current routing
  qpwgraph, graph       Open qpwgraph (routing editor)
  pavucontrol, mixer    Open pavucontrol (volume mixer)

  default               Load default profile
  gaming                Load gaming profile
  streaming             Load streaming profile
  work                  Load work profile

  --help                Show this help

Profile Locations:
  ~/.config/qpwgraph/profiles/

Creating Profiles:
  1. Run: qpwgraph
  2. Set up your audio routing
  3. Save to: ~/.config/qpwgraph/profiles/name.qpwgraph
  4. Switch with: switch-audio-profile.sh load name

Audio Routing Examples:

Gaming Profile:
  Game Audio    → game_audio sink → Headphones + OBS
  Discord       → discord_audio sink → Headphones + OBS
  Music         → music_audio sink → Headphones
  Microphone    → Headphones (monitor) + OBS

Streaming Profile:
  All sources → Individual sinks → OBS (with filters)
  Background music automatically ducked during speech

Work Profile:
  Meetings → Headset
  Notifications → Speakers
  Simple routing for productivity

Keybinds:
  SUPER + Alt + A      # Cycle profiles
  SUPER + Shift + A    # Open qpwgraph
  SUPER + Ctrl + A     # Open pavucontrol

Examples:
  switch-audio-profile.sh              # Interactive menu
  switch-audio-profile.sh next         # Next profile
  switch-audio-profile.sh gaming       # Load gaming
  switch-audio-profile.sh qpwgraph     # Open editor

Virtual Audio Sinks:
  These are created automatically when needed:
  • game_audio - For game audio
  • discord_audio - For Discord/Voice chat
  • music_audio - For Spotify/Music
  • browser_audio - For browser audio

GitHub: https://github.com/Crowdrocker
EOF
            ;;
        *)
            # Default action: show menu
            select_profile
            ;;
    esac
}

# Run main
main "$@"
