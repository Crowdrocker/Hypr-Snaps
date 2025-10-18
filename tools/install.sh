#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# WehttamSnaps Hyprland Setup - Installer
# GitHub: https://github.com/Crowdrocker
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Logo
print_logo() {
    echo -e "${CYAN}"
    cat << "EOF"
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    Arch Linux • Hyprland • Noctalia
    Photography • Gaming • Streaming
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    echo -e "${NC}"
}

# Print colored message
print_msg() {
    echo -e "${GREEN}==>${NC} $1"
}

print_error() {
    echo -e "${RED}ERROR:${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}WARNING:${NC} $1"
}

print_info() {
    echo -e "${BLUE}INFO:${NC} $1"
}

# Check if running on Arch Linux
check_arch() {
    if [ ! -f /etc/arch-release ]; then
        print_error "This installer is designed for Arch Linux."
        exit 1
    fi
}

# Check if running as root
check_root() {
    if [ "$EUID" -eq 0 ]; then
        print_error "Please do not run this script as root."
        exit 1
    fi
}

# Check internet connection
check_internet() {
    print_msg "Checking internet connection..."
    if ! ping -c 1 archlinux.org &> /dev/null; then
        print_error "No internet connection. Please connect to the internet and try again."
        exit 1
    fi
    print_info "Internet connection: OK"
}

# Install paru if not installed
install_paru() {
    if ! command -v paru &> /dev/null; then
        print_msg "Installing paru (AUR helper)..."
        sudo pacman -S --needed --noconfirm base-devel git
        cd /tmp
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si --noconfirm
        cd ~
        rm -rf /tmp/paru
    else
        print_info "paru is already installed"
    fi
}

# Update system
update_system() {
    print_msg "Updating system..."
    sudo pacman -Syu --noconfirm
}

# Install packages
install_packages() {
    local package_file=$1
    local description=$2
    
    if [ -f "$package_file" ]; then
        print_msg "Installing $description..."
        paru -S --needed --noconfirm - < "$package_file" || {
            print_warning "Some packages from $description failed to install. Continuing..."
        }
    else
        print_warning "$package_file not found. Skipping $description."
    fi
}

# Create directories
create_directories() {
    print_msg "Creating directories..."
    mkdir -p ~/.config/hypr
    mkdir -p ~/.config/quickshell
    mkdir -p ~/.config/ghostty
    mkdir -p ~/.config/rofi
    mkdir -p ~/.config/dunst
    mkdir -p ~/.config/swappy
    mkdir -p ~/.config/wehttamsnaps
    mkdir -p ~/Pictures/Screenshots
    mkdir -p ~/Pictures/Wallpapers
    mkdir -p ~/.local/share/applications
    mkdir -p ~/.themes
    mkdir -p ~/.icons
}

# Copy configuration files
copy_configs() {
    print_msg "Copying configuration files..."
    
    # Hyprland configs
    if [ -d "configs/hyprland" ]; then
        cp -r configs/hyprland/* ~/.config/hypr/
        print_info "Hyprland configs copied"
    fi
    
    # Noctalia configs
    if [ -d "configs/noctalia" ]; then
        cp -r configs/noctalia/* ~/.config/quickshell/
        print_info "Noctalia configs copied"
    fi
    
    # Scripts
    if [ -d "configs/scripts" ]; then
        cp -r configs/scripts ~/.config/hypr/
        chmod +x ~/.config/hypr/scripts/*.sh
        chmod +x ~/.config/hypr/scripts/webapps/*.sh
        print_info "Scripts copied and made executable"
    fi
    
    # Wallpapers
    if [ -d "assets/wallpapers" ]; then
        cp -r assets/wallpapers/* ~/Pictures/Wallpapers/
        print_info "Wallpapers copied"
    fi
    
    # Themes
    if [ -d "assets/themes" ]; then
        cp -r assets/themes/* ~/.themes/
        print_info "Themes copied"
    fi
}

# Set up services
setup_services() {
    print_msg "Setting up services..."
    
    # Enable PipeWire
    systemctl --user enable --now pipewire
    systemctl --user enable --now pipewire-pulse
    systemctl --user enable --now wireplumber
    
    print_info "Services configured"
}

# Create version file
create_version() {
    print_msg "Creating version file..."
    echo "1.0.0" > ~/.config/wehttamsnaps/VERSION
}

# Set default shell
set_shell() {
    if [ "$SHELL" != "$(which zsh)" ]; then
        print_msg "Setting zsh as default shell..."
        chsh -s $(which zsh)
        print_info "Default shell changed to zsh. Please log out and log back in for changes to take effect."
    fi
}

# Final message
print_final_message() {
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}Installation Complete!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${CYAN}Next Steps:${NC}"
    echo -e "  1. ${YELLOW}Reboot your system${NC}"
    echo -e "  2. ${YELLOW}Select Hyprland from your display manager${NC}"
    echo -e "  3. ${YELLOW}Press SUPER + H to see keybindings${NC}"
    echo ""
    echo -e "${CYAN}Essential Shortcuts:${NC}"
    echo -e "  ${BLUE}SUPER + ENTER${NC}     - Terminal"
    echo -e "  ${BLUE}SUPER + D${NC}         - Application Launcher"
    echo -e "  ${BLUE}SUPER + H${NC}         - Help / Keybindings"
    echo -e "  ${BLUE}SUPER + COMMA${NC}     - Settings"
    echo ""
    echo -e "${CYAN}Documentation:${NC}"
    echo -e "  ${BLUE}~/.config/hypr/docs/${NC}"
    echo -e "  ${BLUE}https://github.com/Crowdrocker/WehttamSnaps-Hyprland${NC}"
    echo ""
    echo -e "${PURPLE}Made with ❤️  by WehttamSnaps${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# Interactive menu
show_menu() {
    echo ""
    echo -e "${CYAN}Installation Options:${NC}"
    echo -e "  ${GREEN}1)${NC} Full Installation (Recommended)"
    echo -e "  ${GREEN}2)${NC} Core Packages Only"
    echo -e "  ${GREEN}3)${NC} Core + Photography"
    echo -e "  ${GREEN}4)${NC} Core + Gaming"
    echo -e "  ${GREEN}5)${NC} Core + Streaming"
    echo -e "  ${GREEN}6)${NC} Custom Installation"
    echo -e "  ${RED}0)${NC} Exit"
    echo ""
    read -p "Select an option [1-6]: " choice
    
    case $choice in
        1)
            install_full
            ;;
        2)
            install_core
            ;;
        3)
            install_core
            install_packages "packages/photography.txt" "Photography packages"
            ;;
        4)
            install_core
            install_packages "packages/gaming.txt" "Gaming packages"
            ;;
        5)
            install_core
            install_packages "packages/streaming.txt" "Streaming packages"
            ;;
        6)
            install_custom
            ;;
        0)
            print_info "Installation cancelled."
            exit 0
            ;;
        *)
            print_error "Invalid option. Please try again."
            show_menu
            ;;
    esac
}

# Full installation
install_full() {
    print_msg "Starting full installation..."
    install_packages "packages/core.txt" "Core packages"
    install_packages "packages/photography.txt" "Photography packages"
    install_packages "packages/gaming.txt" "Gaming packages"
    install_packages "packages/streaming.txt" "Streaming packages"
    install_packages "packages/optional.txt" "Optional packages"
}

# Core installation
install_core() {
    print_msg "Starting core installation..."
    install_packages "packages/core.txt" "Core packages"
}

# Custom installation
install_custom() {
    print_msg "Custom installation..."
    
    read -p "Install core packages? (y/n): " install_core_choice
    [ "$install_core_choice" = "y" ] && install_packages "packages/core.txt" "Core packages"
    
    read -p "Install photography packages? (y/n): " install_photo_choice
    [ "$install_photo_choice" = "y" ] && install_packages "packages/photography.txt" "Photography packages"
    
    read -p "Install gaming packages? (y/n): " install_gaming_choice
    [ "$install_gaming_choice" = "y" ] && install_packages "packages/gaming.txt" "Gaming packages"
    
    read -p "Install streaming packages? (y/n): " install_streaming_choice
    [ "$install_streaming_choice" = "y" ] && install_packages "packages/streaming.txt" "Streaming packages"
    
    read -p "Install optional packages? (y/n): " install_optional_choice
    [ "$install_optional_choice" = "y" ] && install_packages "packages/optional.txt" "Optional packages"
}

# Main installation flow
main() {
    print_logo
    
    print_msg "WehttamSnaps Hyprland Setup Installer"
    print_info "This script will install and configure your Hyprland setup."
    echo ""
    
    # Pre-flight checks
    check_arch
    check_root
    check_internet
    
    # Show menu
    show_menu
    
    # Common installation steps
    update_system
    install_paru
    create_directories
    copy_configs
    setup_services
    create_version
    set_shell
    
    # Final message
    print_final_message
}

# Run main function
main