#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                                                                      ║
# ║  __        __   _     _   _                    ____                  ║
# ║  \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _    ║
# ║   \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` |   ║
# ║    \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| |   ║
# ║     \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_|   ║
# ║                                                                      ║
# ║  WehttamSnaps Hyprland Setup - Interactive Installer                 ║
# ║  GitHub: https://github.com/Crowdrocker                              ║
# ║                                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

set -e  # Exit on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Configuration
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
HYPR_SNAPS_DIR="$CONFIG_DIR/hypr-snaps"
LOG_FILE="$HOME/wehttamsnaps-install.log"

# Installation options
INSTALL_CORE=true
INSTALL_GAMING=false
INSTALL_STREAMING=false
INSTALL_PHOTOGRAPHY=false
INSTALL_WEBAPPS=false
INSTALL_JARVIS=false

# Print functions
print_logo() {
    clear
    echo -e "${PURPLE}"
    cat << 'EOF'
 __        __   _     _   _                    ____                        
 \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _ _ __  ___ 
  \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` | '_ \/ __|
   \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| | |_) \__ \
    \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_| .__/|___/
                                                                  |_|        

                    Interactive Installer v1.0.0
          Photography • Gaming • Streaming • It Just Works!

EOF
    echo -e "${NC}"
}

print_header() {
    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║ $1${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
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

print_info() {
    echo -e "${CYAN}[i]${NC} $1"
}

# Logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Confirmation prompt
confirm() {
    local prompt="$1"
    local default="${2:-n}"
    
    if [ "$default" = "y" ]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi
    
    read -p "$prompt" -n 1 -r
    echo
    
    if [ "$default" = "y" ]; then
        [[ ! $REPLY =~ ^[Nn]$ ]]
    else
        [[ $REPLY =~ ^[Yy]$ ]]
    fi
}

# Welcome screen
show_welcome() {
    print_logo
    
    cat << EOF
${BOLD}Welcome to WehttamSnaps Hyprland Setup!${NC}

This installer will set up a complete Hyprland environment optimized for:
  ${GREEN}•${NC} Photography and Creative Work
  ${GREEN}•${NC} Gaming with AMD RX 580 optimizations
  ${GREEN}•${NC} Streaming with OBS and audio routing
  ${GREEN}•${NC} Beautiful Noctalia shell interface
  ${GREEN}•${NC} J.A.R.V.I.S. theme integration

${YELLOW}What this installer does:${NC}
  1. Checks system requirements
  2. Installs necessary packages
  3. Copies configuration files
  4. Sets up scripts and automation
  5. Configures themes and appearance
  6. Creates backups of existing configs

${CYAN}Installation log:${NC} $LOG_FILE

EOF

    if ! confirm "Continue with installation?" "y"; then
        echo "Installation cancelled."
        exit 0
    fi
}

# Check system requirements
check_requirements() {
    print_header "Checking System Requirements"
    
    log "Checking system requirements..."
    
    # Check if running Arch-based system
    if [ ! -f /etc/arch-release ]; then
        print_error "This installer requires an Arch-based distribution"
        exit 1
    fi
    print_success "Arch Linux detected"
    
    # Check if paru is installed
    if ! command -v paru &> /dev/null; then
        print_warning "paru AUR helper not found"
        if confirm "Install paru?" "y"; then
            sudo pacman -S --needed base-devel git
            git clone https://aur.archlinux.org/paru.git /tmp/paru
            cd /tmp/paru && makepkg -si
            cd -
        else
            print_error "paru is required for installation"
            exit 1
        fi
    fi
    print_success "paru AUR helper available"
    
    # Check available disk space
    local available_space=$(df -h / | awk 'NR==2 {print $4}' | sed 's/G//')
    if (( $(echo "$available_space < 5" | bc -l) )); then
        print_warning "Low disk space: ${available_space}GB available"
        if ! confirm "Continue anyway?" "n"; then
            exit 1
        fi
    else
        print_success "Sufficient disk space: ${available_space}GB available"
    fi
    
    # Check AMD GPU
    if lspci | grep -i "VGA.*AMD" &> /dev/null; then
        print_success "AMD GPU detected (optimizations available)"
    else
        print_warning "No AMD GPU detected (some features may not work)"
    fi
    
    echo ""
}

# Installation options menu
show_options_menu() {
    print_header "Installation Options"
    
    cat << EOF
Select what you want to install:

${BOLD}Core Components:${NC}
  ${GREEN}[✓]${NC} Hyprland + Noctalia Shell (Required)
  ${GREEN}[✓]${NC} Terminal + Shell (Ghostty + Zsh)
  ${GREEN}[✓]${NC} Basic utilities and themes

${BOLD}Optional Components:${NC}
EOF

    # Gaming
    if [ "$INSTALL_GAMING" = true ]; then
        echo -e "  ${GREEN}[✓]${NC} Gaming optimizations (gamemode, GPU tools)"
    else
        echo -e "  [ ] Gaming optimizations"
    fi
    
    # Streaming
    if [ "$INSTALL_STREAMING" = true ]; then
        echo -e "  ${GREEN}[✓]${NC} Streaming setup (OBS, audio routing)"
    else
        echo -e "  [ ] Streaming setup"
    fi
    
    # Photography
    if [ "$INSTALL_PHOTOGRAPHY" = true ]; then
        echo -e "  ${GREEN}[✓]${NC} Photography apps (GIMP, Darktable, etc.)"
    else
        echo -e "  [ ] Photography apps"
    fi
    
    # WebApps
    if [ "$INSTALL_WEBAPPS" = true ]; then
        echo -e "  ${GREEN}[✓]${NC} WebApp integration"
    else
        echo -e "  [ ] WebApp integration"
    fi
    
    # J.A.R.V.I.S.
    if [ "$INSTALL_JARVIS" = true ]; then
        echo -e "  ${GREEN}[✓]${NC} J.A.R.V.I.S. theme integration"
    else
        echo -e "  [ ] J.A.R.V.I.S. theme"
    fi
    
    echo ""
    echo "Options:"
    echo "  1) Toggle Gaming"
    echo "  2) Toggle Streaming"
    echo "  3) Toggle Photography"
    echo "  4) Toggle WebApps"
    echo "  5) Toggle J.A.R.V.I.S."
    echo "  6) Install All"
    echo "  7) Install Minimal (Core only)"
    echo ""
    echo "  C) Continue with installation"
    echo "  Q) Quit"
    echo ""
    
    read -p "Select option: " choice
    
    case $choice in
        1) INSTALL_GAMING=$([ "$INSTALL_GAMING" = true ] && echo false || echo true); show_options_menu ;;
        2) INSTALL_STREAMING=$([ "$INSTALL_STREAMING" = true ] && echo false || echo true); show_options_menu ;;
        3) INSTALL_PHOTOGRAPHY=$([ "$INSTALL_PHOTOGRAPHY" = true ] && echo false || echo true); show_options_menu ;;
        4) INSTALL_WEBAPPS=$([ "$INSTALL_WEBAPPS" = true ] && echo false || echo true); show_options_menu ;;
        5) INSTALL_JARVIS=$([ "$INSTALL_JARVIS" = true ] && echo false || echo true); show_options_menu ;;
        6) 
            INSTALL_GAMING=true
            INSTALL_STREAMING=true
            INSTALL_PHOTOGRAPHY=true
            INSTALL_WEBAPPS=true
            INSTALL_JARVIS=true
            show_options_menu
            ;;
        7)
            INSTALL_GAMING=false
            INSTALL_STREAMING=false
            INSTALL_PHOTOGRAPHY=false
            INSTALL_WEBAPPS=false
            INSTALL_JARVIS=false
            show_options_menu
            ;;
        [Cc]) return 0 ;;
        [Qq]) echo "Installation cancelled."; exit 0 ;;
        *) print_error "Invalid option"; sleep 2; show_options_menu ;;
    esac
}

# Backup existing configs
backup_configs() {
    print_header "Backing Up Existing Configurations"
    
    local backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    
    if [ -d "$CONFIG_DIR/hypr" ] || [ -d "$CONFIG_DIR/noctalia" ]; then
        print_status "Creating backup at: $backup_dir"
        mkdir -p "$backup_dir"
        
        [ -d "$CONFIG_DIR/hypr" ] && cp -r "$CONFIG_DIR/hypr" "$backup_dir/"
        [ -d "$CONFIG_DIR/noctalia" ] && cp -r "$CONFIG_DIR/noctalia" "$backup_dir/"
        [ -d "$CONFIG_DIR/ghostty" ] && cp -r "$CONFIG_DIR/ghostty" "$backup_dir/"
        [ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$backup_dir/"
        
        print_success "Backup created successfully"
        log "Backup created at: $backup_dir"
    else
        print_info "No existing configs to backup"
    fi
    
    echo ""
}

# Install core packages
install_core_packages() {
    print_header "Installing Core Packages"
    
    print_status "Installing Hyprland and essential components..."
    
    local core_packages=(
        # Hyprland
        "hyprland"
        "hypridle"
        "hyprlock"
        "hyprpaper"
        "hyprpicker"
        "xdg-desktop-portal-hyprland"
        
        # Noctalia Shell
        "noctalia-shell"
        "quickshell"
        
        # Terminal & Shell
        "ghostty"
        "zsh"
        "starship"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        
        # Audio
        "pipewire"
        "pipewire-alsa"
        "pipewire-pulse"
        "pipewire-jack"
        "wireplumber"
        "pavucontrol"
        
        # Utilities
        "rofi"
        "fuzzel"
        "dunst"
        "thunar"
        "brightnessctl"
        "networkmanager"
        "bluez"
        "bluez-utils"
        "fastfetch"
        "btop"
        
        # Fonts
        "ttf-jetbrains-mono-nerd"
        "ttf-fira-code"
        "inter-font"
        "ttf-roboto"
        
        # Themes
        "papirus-icon-theme"
        "gtk-engine-murrine"
        "kvantum"
    )
    
    paru -S --needed --noconfirm "${core_packages[@]}" 2>&1 | tee -a "$LOG_FILE"
    
    print_success "Core packages installed"
    echo ""
}

# Install gaming packages
install_gaming_packages() {
    if [ "$INSTALL_GAMING" = false ]; then
        return 0
    fi
    
    print_header "Installing Gaming Packages"
    
    local gaming_packages=(
        "steam"
        "lutris"
        "heroic-games-launcher-bin"
        "gamemode"
        "lib32-gamemode"
        "proton-ge-custom-bin"
        "corectrl"
        "lact"
        "mesa"
        "vulkan-radeon"
        "lib32-vulkan-radeon"
        "amdvlk"
        "lib32-amdvlk"
    )
    
    paru -S --needed --noconfirm "${gaming_packages[@]}" 2>&1 | tee -a "$LOG_FILE"
    
    print_success "Gaming packages installed"
    echo ""
}

# Install streaming packages
install_streaming_packages() {
    if [ "$INSTALL_STREAMING" = false ]; then
        return 0
    fi
    
    print_header "Installing Streaming Packages"
    
    local streaming_packages=(
        "obs-studio"
        "obs-vaapi"
        "obs-vkcapture"
        "qpwgraph"
        "easyeffects"
        "gpu-screen-recorder"
    )
    
    paru -S --needed --noconfirm "${streaming_packages[@]}" 2>&1 | tee -a "$LOG_FILE"
    
    print_success "Streaming packages installed"
    echo ""
}

# Install photography packages
install_photography_packages() {
    if [ "$INSTALL_PHOTOGRAPHY" = false ]; then
        return 0
    fi
    
    print_header "Installing Photography Packages"
    
    local photo_packages=(
        "gimp"
        "inkscape"
        "krita"
        "darktable"
        "rawtherapee"
        "shotwell"
    )
    
    paru -S --needed --noconfirm "${photo_packages[@]}" 2>&1 | tee -a "$LOG_FILE"
    
    print_success "Photography packages installed"
    echo ""
}

# Copy configuration files
copy_configs() {
    print_header "Installing Configuration Files"
    
    print_status "Creating directory structure..."
    mkdir -p "$CONFIG_DIR/hypr/"{modules,scripts}
    mkdir -p "$CONFIG_DIR/hypr/scripts/"{gaming,streaming,audio,jarvis,keybinds,utils}
    mkdir -p "$HYPR_SNAPS_DIR/"{docs,assets,state,logs}
    mkdir -p "$HYPR_SNAPS_DIR/assets/"{wallpapers,sounds/jarvis,icons,images}
    
    print_status "Copying Hyprland configs..."
    if [ -d "$REPO_DIR/config/hypr" ]; then
        cp -r "$REPO_DIR/config/hypr"/* "$CONFIG_DIR/hypr/"
        log "Hyprland configs copied"
    fi
    
    print_status "Copying Noctalia configs..."
    if [ -d "$REPO_DIR/config/noctalia" ]; then
        cp -r "$REPO_DIR/config/noctalia" "$CONFIG_DIR/"
        log "Noctalia configs copied"
    fi
    
    print_status "Copying Ghostty config..."
    if [ -d "$REPO_DIR/config/ghostty" ]; then
        cp -r "$REPO_DIR/config/ghostty" "$CONFIG_DIR/"
        log "Ghostty config copied"
    fi
    
    print_status "Copying scripts..."
    if [ -d "$REPO_DIR/scripts" ]; then
        cp -r "$REPO_DIR/scripts"/* "$CONFIG_DIR/hypr/scripts/"
        chmod +x "$CONFIG_DIR/hypr/scripts"/**/*.sh
        log "Scripts copied and made executable"
    fi
    
    print_status "Copying themes and assets..."
    if [ -d "$REPO_DIR/themes" ]; then
        cp -r "$REPO_DIR/themes" "$HYPR_SNAPS_DIR/"
    fi
    if [ -d "$REPO_DIR/assets" ]; then
        cp -r "$REPO_DIR/assets"/* "$HYPR_SNAPS_DIR/assets/"
    fi
    
    print_status "Copying documentation..."
    if [ -d "$REPO_DIR/docs" ]; then
        cp -r "$REPO_DIR/docs"/* "$HYPR_SNAPS_DIR/docs/"
    fi
    
    # Copy VERSION file
    echo "1.0.0" > "$HYPR_SNAPS_DIR/VERSION"
    
    print_success "Configuration files installed"
    echo ""
}

# Setup shell
setup_shell() {
    print_header "Setting Up Zsh Shell"
    
    if [ "$SHELL" != "/usr/bin/zsh" ]; then
        print_status "Changing default shell to zsh..."
        chsh -s /usr/bin/zsh
        log "Default shell changed to zsh"
    fi
    
    if [ -f "$REPO_DIR/config/zsh/.zshrc" ]; then
        print_status "Installing .zshrc..."
        cp "$REPO_DIR/config/zsh/.zshrc" "$HOME/"
        
        if [ -f "$REPO_DIR/config/zsh/aliases.zsh" ]; then
            mkdir -p "$HOME/.config/zsh"
            cp "$REPO_DIR/config/zsh/aliases.zsh" "$HOME/.config/zsh/"
        fi
    fi
    
    print_success "Zsh configured"
    echo ""
}

# Setup services
setup_services() {
    print_header "Setting Up System Services"
    
    print_status "Enabling NetworkManager..."
    sudo systemctl enable --now NetworkManager
    
    print_status "Enabling Bluetooth..."
    sudo systemctl enable --now bluetooth
    
    if [ "$INSTALL_GAMING" = true ]; then
        print_status "Enabling gamemode..."
        systemctl --user enable --now gamemoded
        
        if command -v lact &> /dev/null; then
            print_status "Enabling LACT daemon..."
            sudo systemctl enable --now lactd
            systemctl --user enable --now lact
        fi
    fi
    
    print_success "Services configured"
    echo ""
}

# Setup autostart
setup_autostart() {
    print_header "Configuring Autostart"
    
    print_status "Setting up Hyprland autostart..."
    
    # Add Noctalia to autostart if not already there
    if ! grep -q "noctalia-shell" "$CONFIG_DIR/hypr/modules/autostart.conf" 2>/dev/null; then
        cat >> "$CONFIG_DIR/hypr/modules/autostart.conf" << 'EOF'

# Noctalia Shell
exec-once = qs -c noctalia-shell

# Welcome app (first run)
exec-once = ~/.config/hypr-snaps/scripts/welcome-app.py
EOF
    fi
    
    print_success "Autostart configured"
    echo ""
}

# Generate keybind cheat sheet
generate_keybinds() {
    print_header "Generating Keybind Cheat Sheet"
    
    if [ -f "$CONFIG_DIR/hypr/scripts/keybinds/generate-cheatsheet.sh" ]; then
        print_status "Generating keybindings documentation..."
        bash "$CONFIG_DIR/hypr/scripts/keybinds/generate-cheatsheet.sh"
        print_success "Keybind cheat sheet generated"
    fi
    
    echo ""
}

# Setup J.A.R.V.I.S. sounds
setup_jarvis() {
    if [ "$INSTALL_JARVIS" = false ]; then
        return 0
    fi
    
    print_header "Setting Up J.A.R.V.I.S. Theme"
    
    print_info "J.A.R.V.I.S. sound files need to be created separately"
    print_info "Visit: https://www.101soundboards.com/"
    print_info "Place sound files in: $HYPR_SNAPS_DIR/assets/sounds/jarvis/"
    print_info ""
    print_info "Required files:"
    echo "  • jarvis-startup.mp3"
    echo "  • jarvis-shutdown.mp3"
    echo "  • jarvis-gaming.mp3"
    echo "  • jarvis-streaming.mp3"
    echo "  • jarvis-notification.mp3"
    echo "  • jarvis-warning.mp3"
    echo ""
}

# Final setup steps
final_setup() {
    print_header "Final Setup Steps"
    
    print_status "Setting permissions..."
    find "$CONFIG_DIR/hypr/scripts" -name "*.sh" -exec chmod +x {} \;
    
    print_status "Creating state files..."
    mkdir -p "$HYPR_SNAPS_DIR/state"
    
    print_success "Setup complete"
    echo ""
}

# Show post-installation info
show_completion() {
    print_logo
    
    print_header "Installation Complete!"
    
    cat << EOF
${GREEN}✓ WehttamSnaps Hyprland Setup has been installed successfully!${NC}

${CYAN}Next Steps:${NC}

1. ${BOLD}Reboot your system:${NC}
   ${YELLOW}sudo reboot${NC}

2. ${BOLD}At login, select Hyprland${NC}
   Your display manager should now show Hyprland as an option

3. ${BOLD}First time setup:${NC}
   • The welcome app will guide you through initial setup
   • Press ${GREEN}SUPER + /${NC} to view keybindings
   • Press ${GREEN}SUPER + Space${NC} for app launcher

4. ${BOLD}Configure J.A.R.V.I.S. sounds (if installed):${NC}
   Visit: ${CYAN}https://www.101soundboards.com/${NC}
   Place sounds in: ${YELLOW}~/.config/hypr-snaps/assets/sounds/jarvis/${NC}

5. ${BOLD}Set up audio routing (for gaming/streaming):${NC}
   • Open qpwgraph: ${YELLOW}qpwgraph${NC}
   • Create your routing
   • Save profiles to: ${YELLOW}~/.config/qpwgraph/profiles/${NC}

${CYAN}Quick Commands:${NC}

  ${BOLD}Essential:${NC}
  SUPER + Space         App Launcher
  SUPER + Return        Terminal
  SUPER + /             Keybindings Help
  SUPER + S             Control Center

  ${BOLD}Gaming:${NC}
  SUPER + G             Toggle Gaming Mode
  SUPER + F11           GPU Performance Mode

  ${BOLD}Streaming:${NC}
  SUPER + Shift + S     Toggle Streaming Mode
  SUPER + Shift + R     Screen Recording

  ${BOLD}Audio:${NC}
  SUPER + Alt + A       Switch Audio Profile
  SUPER + Shift + A     Open Audio Router

${CYAN}Documentation:${NC}

  Full guide:       ${YELLOW}~/.config/hypr-snaps/README.md${NC}
  Keybindings:      ${YELLOW}~/.config/hypr-snaps/docs/KEYBINDS.md${NC}
  Gaming setup:     ${YELLOW}~/.config/hypr-snaps/docs/GAMING.md${NC}
  Streaming guide:  ${YELLOW}~/.config/hypr-snaps/docs/STREAMING.md${NC}

${CYAN}Installation Log:${NC} $LOG_FILE

${GREEN}GitHub:${NC} https://github.com/Crowdrocker/Hypr-Snaps
${GREEN}Discord:${NC} https://discord.gg/nTaknDvdUA

${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
${BOLD}"It just works!" - WehttamSnaps${NC}
${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}

EOF

    if confirm "Would you like to reboot now?" "n"; then
        print_status "Rebooting system..."
        sudo reboot
    else
        print_info "Remember to reboot before using Hyprland!"
    fi
}

# Error handler
error_handler() {
    print_error "An error occurred during installation!"
    print_info "Check the log file for details: $LOG_FILE"
    exit 1
}

# Main installation flow
main() {
    # Set error handler
    trap error_handler ERR
    
    # Initialize log
    echo "=== WehttamSnaps Installation Log ===" > "$LOG_FILE"
    echo "Date: $(date)" >> "$LOG_FILE"
    echo "User: $USER" >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
    
    # Run installation steps
    show_welcome
    check_requirements
    show_options_menu
    backup_configs
    
    # Install packages
    install_core_packages
    install_gaming_packages
    install_streaming_packages
    install_photography_packages
    
    # Setup configuration
    copy_configs
    setup_shell
    setup_services
    setup_autostart
    generate_keybinds
    setup_jarvis
    final_setup
    
    # Complete
    show_completion
}

# Check if script is run with sudo
if [ "$EUID" -eq 0 ]; then
    print_error "Do not run this script as root!"
    print_info "Run as normal user, sudo will be requested when needed"
    exit 1
fi

# Run main installation
main "$@"