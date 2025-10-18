#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                                                                      ║
# ║  __        __   _     _   _                    ____                  ║
# ║  \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _    ║
# ║   \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` |   ║
# ║    \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| |   ║
# ║     \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_|   ║
# ║                                                                      ║
# ║  Interactive Keybind Viewer                                          ║
# ║  GitHub: https://github.com/Crowdrocker                              ║
# ║                                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Configuration
KEYBINDS_MD="$HOME/.config/hypr-snaps/docs/KEYBINDS.md"
HYPR_CONFIG="$HOME/.config/hypr/modules/binds.conf"

# Check for required tools
check_dependencies() {
    local missing_deps=()

    # Check for fzf (preferred)
    if ! command -v fzf &> /dev/null; then
        missing_deps+=("fzf")
    fi

    # Check for rofi (alternative)
    if ! command -v rofi &> /dev/null && ! command -v fzf &> /dev/null; then
        missing_deps+=("rofi or fzf")
    fi

    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo "Missing dependencies: ${missing_deps[*]}"
        echo "Install with: paru -S fzf rofi"
        exit 1
    fi
}

# Function to show keybinds with fzf
show_with_fzf() {
    # Parse keybinds from config
    local keybinds=$(grep -P "^(bind|binde|bindm)" "$HYPR_CONFIG" | while read -r line; do
        # Extract modifier, key, and action
        local modifier=$(echo "$line" | sed -n 's/.*= *\([^,]*\),.*/\1/p' | xargs)
        local key=$(echo "$line" | sed -n 's/.*,[^,]*,\s*\([^,]*\),.*/\1/p' | xargs)
        local action=$(echo "$line" | sed -n 's/.*,[^,]*,[^,]*,\s*\(.*\)/\1/p' | xargs)

        # Clean up action
        action=$(echo "$action" | sed 's/exec, //; s/exec //; s/,.*//; s/~\/\.config\/hypr\/scripts\///')

        # Format for display
        printf "%-30s │ %s\n" "$modifier + $key" "$action"
    done)

    # Show in fzf with preview
    echo "$keybinds" | fzf \
        --header "WehttamSnaps Keybindings - Press ESC to exit" \
        --header-lines=0 \
        --layout=reverse \
        --border=rounded \
        --prompt="Search: " \
        --pointer="▶" \
        --marker="✓" \
        --color="fg:#cdd6f4,bg:#1e1e2e,hl:#f38ba8" \
        --color="fg+:#cdd6f4,bg+:#313244,hl+:#f38ba8" \
        --color="info:#cba6f7,prompt:#cba6f7,pointer:#f5e0dc" \
        --color="marker:#f5e0dc,spinner:#f5e0dc,header:#f38ba8" \
        --preview 'echo {}' \
        --preview-window=up:3:wrap
}

# Function to show keybinds with rofi
show_with_rofi() {
    # Parse keybinds from config
    local keybinds=$(grep -P "^(bind|binde|bindm)" "$HYPR_CONFIG" | while read -r line; do
        # Extract modifier, key, and action
        local modifier=$(echo "$line" | sed -n 's/.*= *\([^,]*\),.*/\1/p' | xargs)
        local key=$(echo "$line" | sed -n 's/.*,[^,]*,\s*\([^,]*\),.*/\1/p' | xargs)
        local action=$(echo "$line" | sed -n 's/.*,[^,]*,[^,]*,\s*\(.*\)/\1/p' | xargs)

        # Clean up action
        action=$(echo "$action" | sed 's/exec, //; s/exec //; s/,.*//; s/~\/\.config\/hypr\/scripts\///')

        # Format for display
        printf "%-30s │ %s\n" "$modifier + $key" "$action"
    done)

    # Show in rofi
    echo "$keybinds" | rofi \
        -dmenu \
        -i \
        -p "Keybindings" \
        -theme-str 'window {width: 60%;}' \
        -theme-str 'listview {lines: 20;}'
}

# Function to show full documentation
show_documentation() {
    if [ -f "$KEYBINDS_MD" ]; then
        if command -v bat &> /dev/null; then
            bat --style=numbers,grid --color=always "$KEYBINDS_MD" | less -R
        elif command -v mdcat &> /dev/null; then
            mdcat "$KEYBINDS_MD" | less -R
        else
            less "$KEYBINDS_MD"
        fi
    else
        echo "Documentation not found: $KEYBINDS_MD"
        echo "Generate it with: ~/.config/hypr/scripts/keybinds/generate-cheatsheet.sh"
        exit 1
    fi
}

# Function to show quick reference
show_quick_reference() {
    cat << 'EOF'
╔═══════════════════════════════════════════════════════════╗
║           WehttamSnaps Keybindings Quick Reference        ║
╚═══════════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────────┐
│                    ESSENTIAL BINDS                       │
├─────────────────────────────────────────────────────────┤
│ SUPER + Return          Terminal                         │
│ SUPER + Space           App Launcher                     │
│ SUPER + Q               Close Window                     │
│ SUPER + L               Lock Screen                      │
│ SUPER + 1-9             Switch Workspace                 │
├─────────────────────────────────────────────────────────┤
│                    QUICK ACCESS                          │
├─────────────────────────────────────────────────────────┤
│ SUPER + F               File Manager                     │
│ SUPER + B               Browser                          │
│ SUPER + G               Gaming Mode                      │
│ SUPER + S               Control Center                   │
│ SUPER + W               YouTube WebApp                   │
│ SUPER + I               Instagram WebApp                 │
├─────────────────────────────────────────────────────────┤
│                    WINDOW MGMT                           │
├─────────────────────────────────────────────────────────┤
│ SUPER + H/J/K/L         Move Focus (VIM)                 │
│ SUPER + Shift + H/J/K/L Move Window (VIM)                │
│ SUPER + Ctrl + H/J/K/L  Resize Window (VIM)              │
│ SUPER + X               Toggle Floating                  │
│ SUPER + M               Toggle Maximize                  │
├─────────────────────────────────────────────────────────┤
│                    GAMING & STREAMING                    │
├─────────────────────────────────────────────────────────┤
│ SUPER + G               Gaming Mode                      │
│ SUPER + Shift + S       Streaming Mode                   │
│ SUPER + Shift + R       Screen Recording                 │
│ SUPER + Alt + 1         Steam                            │
│ SUPER + Alt + 2         Lutris                           │
├─────────────────────────────────────────────────────────┤
│                    AUDIO CONTROLS                        │
├─────────────────────────────────────────────────────────┤
│ XF86AudioRaiseVolume    Volume Up                        │
│ XF86AudioLowerVolume    Volume Down                      │
│ XF86AudioMute           Mute                             │
│ SUPER + M               Mute Microphone                  │
│ SUPER + Shift + A       qpwgraph (Audio Routing)         │
└─────────────────────────────────────────────────────────┘

Press any key to exit...
EOF
    read -n 1 -s
}

# Function to show category menu
show_category_menu() {
    local categories=(
        "1. Essential Keybinds"
        "2. System & Core"
        "3. Noctalia Shell"
        "4. WebApps"
        "5. Work & Photography"
        "6. Gaming & Entertainment"
        "7. Streaming & Recording"
        "8. Audio Controls"
        "9. Window Management"
        "10. Workspace Management"
        "11. All Keybindings (Search)"
        "12. Full Documentation"
        "13. Quick Reference Card"
        "0. Exit"
    )

    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║        WehttamSnaps Keybindings - Category Menu          ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""

    for category in "${categories[@]}"; do
        echo "  $category"
    done

    echo ""
    read -p "Select category (0-13): " choice

    case $choice in
        1) show_category_keybinds "Essential" ;;
        2) show_category_keybinds "System" ;;
        3) show_category_keybinds "Noctalia" ;;
        4) show_category_keybinds "WebApp" ;;
        5) show_category_keybinds "Work\|Photography" ;;
        6) show_category_keybinds "Gaming" ;;
        7) show_category_keybinds "Streaming" ;;
        8) show_category_keybinds "Audio" ;;
        9) show_category_keybinds "Window" ;;
        10) show_category_keybinds "Workspace" ;;
        11)
            if command -v fzf &> /dev/null; then
                show_with_fzf
            else
                show_with_rofi
            fi
            ;;
        12) show_documentation ;;
        13) show_quick_reference ;;
        0) exit 0 ;;
        *) echo "Invalid choice"; sleep 2; show_category_menu ;;
    esac
}

# Function to show keybinds by category
show_category_keybinds() {
    local category="$1"

    echo ""
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║  Keybindings: $category"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""

    # Extract section from config
    local in_section=0
    while IFS= read -r line; do
        # Check for section header
        if echo "$line" | grep -qiP "^# .*$category"; then
            in_section=1
            continue
        fi

        # Check for next section
        if [[ $in_section -eq 1 ]] && echo "$line" | grep -qP "^# ═{50,}"; then
            break
        fi

        # Parse bind lines
        if [[ $in_section -eq 1 ]] && echo "$line" | grep -qP "^(bind|binde|bindm)"; then
            local modifier=$(echo "$line" | sed -n 's/.*= *\([^,]*\),.*/\1/p' | xargs)
            local key=$(echo "$line" | sed -n 's/.*,[^,]*,\s*\([^,]*\),.*/\1/p' | xargs)
            local action=$(echo "$line" | sed -n 's/.*,[^,]*,[^,]*,\s*\(.*\)/\1/p' | xargs)

            # Clean up action
            action=$(echo "$action" | sed 's/exec, //; s/exec //; s/,.*//; s/~\/\.config\/hypr\/scripts\///')

            # Format modifier
            modifier=$(echo "$modifier" | sed 's/ / + /g')

            printf "  %-35s │ %s\n" "$modifier + $key" "$action"
        fi
    done < "$HYPR_CONFIG"

    echo ""
    read -p "Press Enter to continue..."
    show_category_menu
}

# Main menu
main() {
    # Check if running in terminal
    if [ ! -t 0 ]; then
        # Not in terminal, use rofi/fzf
        if command -v fzf &> /dev/null; then
            ghostty -e bash -c "$(declare -f show_with_fzf); show_with_fzf"
        elif command -v rofi &> /dev/null; then
            show_with_rofi
        else
            notify-send "Keybind Viewer" "Please install fzf or rofi"
        fi
        exit 0
    fi

    # Parse command line arguments
    case "${1:-}" in
        -f|--full)
            show_documentation
            ;;
        -q|--quick)
            show_quick_reference
            ;;
        -s|--search)
            if command -v fzf &> /dev/null; then
                show_with_fzf
            else
                show_with_rofi
            fi
            ;;
        -h|--help)
            cat << EOF
WehttamSnaps Keybind Viewer

Usage: keybind-viewer.sh [OPTIONS]

Options:
  -f, --full       Show full documentation
  -q, --quick      Show quick reference card
  -s, --search     Interactive search (fzf/rofi)
  -h, --help       Show this help message

If no option is provided, shows interactive menu.

Examples:
  keybind-viewer.sh              # Interactive menu
  keybind-viewer.sh --quick      # Quick reference
  keybind-viewer.sh --search     # Search with fzf

Keybind: SUPER + /
EOF
            ;;
        *)
            show_category_menu
            ;;
    esac
}

# Check dependencies
check_dependencies

# Run main function
main "$@"
