#!/bin/bash

# ╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
# ║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
# ╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
#
# WehttamSnaps Hyprland Setup - Installation Script
# GitHub: https://github.com/Crowdrocker/Hypr-Snaps
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Functions
print_header() {
    echo -e "${PURPLE}"
    cat << "EOF"
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
EOF
    echo -e "${NC}"
    echo -e "${CYAN}WehttamSnaps Hyprland Setup - Installation${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_step() {
    echo -e "${GREEN}➜${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

ask_yes_no() {
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please do not run this script as root"
    exit 1
fi

# Print header
print_header

# Check for paru
if ! command -v paru &> /dev/null; then
    print_warning "paru not found. Installing paru..."
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd ~
    print_success "paru installed"
fi

# Installation options
echo -e "${CYAN}Installation Options:${NC}"
echo "1. Minimal (Core system only)"
echo "2. Gaming (Core + Gaming packages)"
echo "3. Photography (Core + Creative packages)"
echo "4. Full (Everything)"
echo ""
read -p "Select installation type (1-4): " INSTALL_TYPE

# Backup existing configs
print_step "Backing up existing configurations..."
mkdir -p ~/.config-backup/$(date +%Y%m%d-%H%M%S)
if [ -d ~/.config/hypr ]; then
    cp -r ~/.config/hypr ~/.config-backup/$(date +%Y%m%d-%H%M%S)/ 2>/dev/null || true
fi
if [ -d ~/.config/noctalia ]; then
    cp -r ~/.config/noctalia ~/.config-backup/$(date +%Y%m%d-%H%M%S)/ 2>/dev/null || true
fi
print_success "Backup complete"

# Install core packages
print_step "Installing core packages..."
paru -S --needed --noconfirm \
    hyprland hyprpaper hyprlock hypridle hyprpicker hyprshot \
    xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
    quickshell noctalia-shell ttf-roboto inter-font \
    gpu-screen-recorder brightnessctl matugen-git \
    ghostty zsh zsh-autosuggestions zsh-syntax-highlighting \
    zsh-completions starship fastfetch \
    pipewire pipewire-alsa pipewire-pulse pipewire-jack \
    wireplumber pavucontrol qpwgraph \
    thunar thunar-archive-plugin thunar-volman \
    gvfs gvfs-mtp gvfs-smb \
    polkit-gnome dunst cliphist wl-clipboard \
    grim slurp rofi fuzzel \
    gtk-engine-murrine lxappearance qt5ct qt6ct \
    kvantum papirus-icon-theme \
    firefox chromium mpv

print_success "Core packages installed"

# Install additional packages based on selection
if [ "$INSTALL_TYPE" = "2" ] || [ "$INSTALL_TYPE" = "4" ]; then
    print_step "Installing gaming packages..."
    paru -S --needed --noconfirm \
        steam gamemode gamescope mangohud \
        lutris heroic-games-launcher-bin \
        proton-ge-custom-bin wine-staging winetricks \
        dxvk-bin vkd3d \
        mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
        amdvlk lib32-amdvlk vulkan-mesa-layers \
        corectrl lact nvtop radeontop \
        steamtinkerlaunch
    print_success "Gaming packages installed"
fi

if [ "$INSTALL_TYPE" = "3" ] || [ "$INSTALL_TYPE" = "4" ]; then
    print_step "Installing photography/creative packages..."
    paru -S --needed --noconfirm \
        gimp krita inkscape darktable rawtherapee \
        kdenlive obs-studio obs-vaapi obs-vkcapture \
        blender
    print_success "Photography/creative packages installed"
fi

# Copy configuration files
print_step "Installing configuration files..."

# Create necessary directories
mkdir -p ~/.config/{hypr,noctalia,ghostty,fastfetch,wehttamsnaps}
mkdir -p ~/.local/{bin,share/sounds/jarvis,share/wehttamsnaps}

# Copy Hyprland configs
cp -r "$REPO_DIR/configs/hyprland/"* ~/.config/hypr/
print_info "Hyprland configs installed"

# Copy Noctalia configs (if exists)
if [ -d "$REPO_DIR/configs/noctalia" ]; then
    cp -r "$REPO_DIR/configs/noctalia/"* ~/.config/noctalia/
    print_info "Noctalia configs installed"
fi

# Copy terminal configs
if [ -d "$REPO_DIR/configs/terminal" ]; then
    cp -r "$REPO_DIR/configs/terminal/ghostty/"* ~/.config/ghostty/ 2>/dev/null || true
    cp "$REPO_DIR/configs/terminal/.zshrc" ~/ 2>/dev/null || true
    print_info "Terminal configs installed"
fi

# Copy scripts
cp -r "$REPO_DIR/scripts/webapps/"* ~/.local/bin/ 2>/dev/null || true
cp -r "$REPO_DIR/scripts/jarvis/"* ~/.local/bin/ 2>/dev/null || true
cp -r "$REPO_DIR/scripts/utils/"* ~/.local/bin/ 2>/dev/null || true
chmod +x ~/.local/bin/*.sh
print_info "Scripts installed"

# Copy welcome app
cp "$REPO_DIR/apps/welcome/welcome-app.py" ~/.local/bin/
chmod +x ~/.local/bin/welcome-app.py
print_info "Welcome app installed"

# Copy assets
cp -r "$REPO_DIR/assets/logos" ~/.local/share/wehttamsnaps/
cp "$REPO_DIR/icon.png" ~/.config/wehttamsnaps/assets/
print_info "Assets installed"

print_success "Configuration files installed"

# Set up shell
if ask_yes_no "Do you want to set zsh as your default shell?"; then
    print_step "Setting zsh as default shell..."
    chsh -s $(which zsh)
    print_success "Default shell changed to zsh"
fi

# Install Oh My Zsh
if ask_yes_no "Do you want to install Oh My Zsh?"; then
    print_step "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
fi

# Enable services
print_step "Enabling services..."
systemctl --user enable --now pipewire pipewire-pulse wireplumber
if [ "$INSTALL_TYPE" = "2" ] || [ "$INSTALL_TYPE" = "4" ]; then
    systemctl --user enable --now gamemoded
fi
print_success "Services enabled"

# Create gaming drive mount point
if [ "$INSTALL_TYPE" = "2" ] || [ "$INSTALL_TYPE" = "4" ]; then
    print_step "Setting up gaming drive..."
    sudo mkdir -p /run/media/wehttamsnaps/LINUXDRIVE-1
    print_info "Gaming drive mount point created"
fi

# Final message
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Installation Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${CYAN}Next Steps:${NC}"
echo "1. Reboot your system: ${YELLOW}sudo reboot${NC}"
echo "2. Select Hyprland from your display manager"
echo "3. The welcome app will guide you through initial setup"
echo ""
echo -e "${CYAN}Useful Commands:${NC}"
echo "• View keybindings: ${YELLOW}cat ~/.config/hypr/keybinds.conf${NC}"
echo "• Edit Hyprland config: ${YELLOW}nvim ~/.config/hypr/hyprland.conf${NC}"
echo "• Toggle gaming mode: ${YELLOW}SUPER + G${NC}"
echo "• Open settings: ${YELLOW}SUPER + COMMA${NC}"
echo ""
echo -e "${CYAN}Documentation:${NC}"
echo "• GitHub: ${YELLOW}https://github.com/Crowdrocker/Hypr-Snaps${NC}"
echo "• Twitch: ${YELLOW}https://twitch.tv/WehttamSnaps${NC}"
echo "• YouTube: ${YELLOW}https://youtube.com/@WehttamSnaps${NC}"
echo ""
echo -e "${PURPLE}Enjoy your new setup! 🎉${NC}"
echo ""