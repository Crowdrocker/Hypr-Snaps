#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                                                                      ║
# ║  __        __   _     _   _                    ____                  ║
# ║  \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _    ║
# ║   \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` |   ║
# ║    \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| |   ║
# ║     \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_|   ║
# ║                                                                      ║
# ║  Keybind System Setup Script                                         ║
# ║  GitHub: https://github.com/Crowdrocker                              ║
# ║                                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
SCRIPT_DIR="$HOME/.config/hypr/scripts/keybinds"
SYSTEMD_DIR="$HOME/.config/systemd/user"
LOG_DIR="$HOME/.config/hypr-snaps/logs"

# ASCII Logo
print_logo() {
    echo -e "${PURPLE}"
    cat << 'EOF'
 __        __   _     _   _                    ____
 \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _ _ __  ___
  \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` | '_ \/ __|
   \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| | |_) \__ \
    \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_| .__/|___/
                                                                  |_|
EOF
    echo -e "${NC}"
}

# Print functions
print_header() {
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
}

print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Check dependencies
check_dependencies() {
    print_header "Checking Dependencies"

    local deps=("inotify-tools" "fzf" "bat")
    local missing=()

    for dep in "${deps[@]}"; do
        if command -v "${dep%%-*}" &> /dev/null || pacman -Q "$dep" &> /dev/null 2>&1; then
            print_success "$dep installed"
        else
            print_warning "$dep not found"
            missing+=("$dep")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        echo ""
        print_warning "Missing dependencies: ${missing[*]}"
        read -p "Install missing dependencies? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_status "Installing dependencies..."
            paru -S --needed "${missing[@]}"
        fi
    fi

    echo ""
}

# Create directory structure
create_directories() {
    print_header "Creating Directory Structure"

    local dirs=(
        "$SCRIPT_DIR"
        "$SYSTEMD_DIR"
        "$LOG_DIR"
        "$HOME/.config/hypr-snaps/docs"
    )

    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            print_success "Created: $dir"
        else
            print_status "Exists: $dir"
        fi
    done

    echo ""
}

# Make scripts executable
make_executable() {
    print_header "Setting Script Permissions"

    local scripts=(
        "generate-cheatsheet.sh"
        "keybind-viewer.sh"
        "keybind-watcher.sh"
    )

    for script in "${scripts[@]}"; do
        local script_path="$SCRIPT_DIR/$script"
        if [ -f "$script_path" ]; then
            chmod +x "$script_path"
            print_success "Made executable: $script"
        else
            print_warning "Not found: $script"
        fi
    done

    echo ""
}

# Generate initial cheat sheet
generate_initial() {
    print_header "Generating Initial Cheat Sheet"

    if [ -f "$SCRIPT_DIR/generate-cheatsheet.sh" ]; then
        print_status "Running generator..."
        bash "$SCRIPT_DIR/generate-cheatsheet.sh"
        print_success "Initial cheat sheet generated"
    else
        print_error "Generator script not found"
    fi

    echo ""
}

# Setup systemd service
setup_systemd() {
    print_header "Setting Up Systemd Service"

    local service_file="$SYSTEMD_DIR/keybind-watcher.service"

    if [ -f "$service_file" ]; then
        print_status "Service file exists"

        # Reload systemd
        systemctl --user daemon-reload
        print_success "Systemd daemon reloaded"

        # Ask to enable service
        read -p "Enable auto-regeneration service? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            systemctl --user enable --now keybind-watcher.service
            print_success "Service enabled and started"
        else
            print_warning "Service not enabled (you can enable it later)"
        fi
    else
        print_warning "Service file not found: $service_file"
        print_status "You can enable it manually later"
    fi

    echo ""
}

# Add Hyprland keybind
add_hyprland_keybind() {
    print_header "Adding Hyprland Keybind"

    local binds_file="$HOME/.config/hypr/modules/binds.conf"
    local keybind="bind = SUPER, slash, exec, $SCRIPT_DIR/keybind-viewer.sh"

    if [ -f "$binds_file" ]; then
        if grep -q "keybind-viewer" "$binds_file"; then
            print_status "Keybind already exists in binds.conf"
        else
            read -p "Add SUPER + / keybind to show viewer? (y/n): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo "" >> "$binds_file"
                echo "# Show Keybindings" >> "$binds_file"
                echo "$keybind" >> "$binds_file"
                print_success "Keybind added: SUPER + /"
                print_warning "Reload Hyprland to apply (SUPER + Shift + R)"
            fi
        fi
    else
        print_warning "Binds config not found: $binds_file"
    fi

    echo ""
}

# Test the system
test_system() {
    print_header "Testing System"

    # Test generator
    print_status "Testing generator..."
    if bash "$SCRIPT_DIR/generate-cheatsheet.sh" > /dev/null 2>&1; then
        print_success "Generator works"
    else
        print_error "Generator failed"
    fi

    # Test viewer
    print_status "Testing viewer..."
    if bash "$SCRIPT_DIR/keybind-viewer.sh" --help > /dev/null 2>&1; then
        print_success "Viewer works"
    else
        print_error "Viewer failed"
    fi

    # Check systemd service
    if systemctl --user is-active keybind-watcher.service > /dev/null 2>&1; then
        print_success "Watcher service is running"
    else
        print_warning "Watcher service not running"
    fi

    echo ""
}

# Show usage instructions
show_usage() {
    print_header "Usage Instructions"

    cat << EOF
${GREEN}✓ Setup Complete!${NC}

${CYAN}How to Use:${NC}

${YELLOW}1. View Keybindings:${NC}
   Press: ${GREEN}SUPER + /${NC}
   Or run: ${CYAN}~/.config/hypr/scripts/keybinds/keybind-viewer.sh${NC}

${YELLOW}2. Regenerate Cheat Sheet:${NC}
   Manual: ${CYAN}~/.config/hypr/scripts/keybinds/generate-cheatsheet.sh${NC}
   Auto:   Changes detected automatically if service is running

${YELLOW}3. Check Service Status:${NC}
   ${CYAN}systemctl --user status keybind-watcher.service${NC}

${YELLOW}4. View Logs:${NC}
   ${CYAN}tail -f ~/.config/hypr-snaps/logs/keybind-watcher.log${NC}

${YELLOW}5. Edit Keybindings:${NC}
   ${CYAN}nvim ~/.config/hypr/modules/binds.conf${NC}
   Cheat sheet will regenerate automatically!

${CYAN}Commands:${NC}
  keybind-viewer.sh          # Interactive menu
  keybind-viewer.sh --quick  # Quick reference
  keybind-viewer.sh --search # Search with fzf
  keybind-viewer.sh --full   # Full documentation

${GREEN}GitHub:${NC} https://github.com/Crowdrocker/Hypr-Snaps

EOF
}

# Main setup function
main() {
    clear
    print_logo
    print_header "WehttamSnaps Keybind System Setup"
    echo ""

    # Run setup steps
    check_dependencies
    create_directories
    make_executable
    generate_initial
    setup_systemd
    add_hyprland_keybind
    test_system
    show_usage

    # Final message
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║          Setup Complete - Enjoy Your Setup!              ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Run main
main "$@"
