# 📦 Installation Guide

```
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
```

> Complete installation guide for WehttamSnaps Hyprland Setup

---

## 📋 Prerequisites

Before installing, ensure you have:

1. **Arch Linux** installed and updated
2. **Internet connection** active
3. **Base-devel** package group installed
4. **Git** installed
5. **AUR helper** (yay or paru) installed

### Install Prerequisites

```bash
# Update system
sudo pacman -Syu

# Install base-devel and git
sudo pacman -S base-devel git

# Install paru (AUR helper)
cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

---

## 🚀 Quick Installation

### Option 1: Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/Crowdrocker/Hypr-Snaps.git
cd Hypr-Snaps

# Make installation script executable
chmod +x scripts/install/install.sh

# Run the installation script
./scripts/install/install.sh
```

The installation script will:
1. Install all required packages
2. Set up configuration files
3. Install Noctalia Shell
4. Configure Hyprland
5. Set up custom themes
6. Install J.A.R.V.I.S. sounds
7. Configure gaming optimizations

### Option 2: Manual Installation

Follow the steps below for manual installation.

---

## 📦 Package Installation

### Core Packages

```bash
# Hyprland and Wayland essentials
paru -S hyprland hyprpaper hyprlock hypridle hyprpicker hyprshot \
        xdg-desktop-portal-hyprland qt5-wayland qt6-wayland

# Noctalia Shell dependencies
paru -S quickshell noctalia-shell ttf-roboto inter-font \
        gpu-screen-recorder brightnessctl ddcutil

# Terminal and shell
paru -S ghostty zsh zsh-autosuggestions zsh-syntax-highlighting \
        zsh-completions starship fastfetch

# File manager and utilities
paru -S thunar thunar-archive-plugin thunar-media-tags-plugin \
        thunar-volman gvfs gvfs-mtp gvfs-smb

# Audio
paru -S pipewire pipewire-alsa pipewire-pulse pipewire-jack \
        wireplumber pavucontrol qpwgraph easyeffects

# Theming
paru -S matugen-git gtk-engine-murrine lxappearance qt5ct qt6ct \
        kvantum papirus-icon-theme

# Utilities
paru -S rofi fuzzel dunst mako cliphist wl-clipboard \
        grim slurp swappy polkit-gnome
```

### Gaming Packages

```bash
# Gaming essentials
paru -S steam lutris heroic-games-launcher-bin gamemode gamescope \
        mangohud goverlay

# Proton and compatibility
paru -S proton-ge-custom-bin wine-staging winetricks dxvk-bin

# AMD GPU support
paru -S mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
        amdvlk lib32-amdvlk

# GPU control and monitoring
paru -S corectrl lact nvtop radeontop

# Game modding
paru -S steamtinkerlaunch
```

### Photography & Creative

```bash
# Photo editing
paru -S gimp krita inkscape darktable rawtherapee

# Video editing
paru -S kdenlive obs-studio obs-vaapi obs-vkcapture

# 3D and design
paru -S blender
```

### Optional Packages

```bash
# Additional utilities
paru -S btop htop neofetch cava ranger yazi \
        firefox chromium discord spotify-launcher

# Development tools
paru -S code neovim github-desktop-plus-bin docker docker-compose

# System monitoring
paru -S mission-center coolercontrol
```

---

## ⚙️ Configuration Setup

### 1. Clone Configuration Files

```bash
# Backup existing configs (if any)
mkdir -p ~/.config-backup
cp -r ~/.config/hypr ~/.config-backup/ 2>/dev/null || true
cp -r ~/.config/noctalia ~/.config-backup/ 2>/dev/null || true

# Copy new configurations
cd ~/Hypr-Snaps
cp -r configs/hyprland/* ~/.config/hypr/
cp -r configs/noctalia/* ~/.config/noctalia/
cp -r configs/terminal/ghostty ~/.config/
cp -r configs/audio/* ~/.config/
```

### 2. Install Noctalia Shell

```bash
# If not using AUR package, install manually
mkdir -p ~/.config/quickshell/noctalia-shell
curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz | \
tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell
```

### 3. Set Up Shell

```bash
# Install Oh My Zsh (optional but recommended)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy shell configuration
cp configs/terminal/.zshrc ~/
cp configs/terminal/.bashrc ~/

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh
cp configs/terminal/starship.toml ~/.config/
```

### 4. Configure Fastfetch

```bash
# Copy fastfetch config with custom logo
mkdir -p ~/.config/fastfetch
cp configs/terminal/fastfetch/config.jsonc ~/.config/fastfetch/
cp assets/logos/logo.txt ~/.config/fastfetch/
```

### 5. Set Up Themes

```bash
# GTK themes
mkdir -p ~/.themes
cp -r themes/gtk/* ~/.themes/

# Icon themes
mkdir -p ~/.icons
cp -r themes/icons/* ~/.icons/

# Kvantum themes
mkdir -p ~/.config/Kvantum
cp -r themes/kvantum/* ~/.config/Kvantum/
```

---

## 🎵 J.A.R.V.I.S. Sound Setup

```bash
# Create sounds directory
mkdir -p ~/.local/share/sounds/jarvis

# Copy J.A.R.V.I.S. sounds
cp assets/sounds/jarvis/* ~/.local/share/sounds/jarvis/

# Make sound scripts executable
chmod +x scripts/jarvis/*.sh

# Copy sound scripts
cp scripts/jarvis/* ~/.local/bin/
```

---

## 🎮 Gaming Optimizations

### 1. Enable Gamemode

```bash
# Enable gamemode service
systemctl --user enable --now gamemoded

# Test gamemode
gamemoded -t
```

### 2. Configure CoreCtrl

```bash
# Enable CoreCtrl service
sudo systemctl enable --now corectrl

# Add user to corectrl group
sudo usermod -aG corectrl $USER

# Copy CoreCtrl profiles
mkdir -p ~/.config/corectrl/profiles
cp configs/gaming/corectrl/* ~/.config/corectrl/profiles/
```

### 3. Set Up LACT (AMD GPU Control)

```bash
# Enable LACT service
sudo systemctl enable --now lactd

# Configure LACT
lact gui
```

### 4. Configure ZRAM

```bash
# Install zram-generator
paru -S zram-generator

# Configure ZRAM
sudo cp configs/gaming/zram-generator.conf /etc/systemd/zram-generator.conf

# Restart to apply
sudo systemctl daemon-reload
```

---

## 🖥️ Display Manager Setup

### SDDM Configuration

```bash
# Install SDDM and theme
paru -S sddm sddm-sugar-candy-git

# Enable SDDM
sudo systemctl enable sddm

# Copy theme configuration
sudo cp configs/sddm/theme.conf /usr/share/sddm/themes/sugar-candy/
sudo cp assets/wallpapers/login-bg.png /usr/share/sddm/themes/sugar-candy/

# Set SDDM theme
sudo cp configs/sddm/sddm.conf /etc/sddm.conf
```

---

## 🔧 System Configuration

### 1. Enable Services

```bash
# Enable essential services
sudo systemctl enable NetworkManager bluetooth cups

# Enable user services
systemctl --user enable pipewire pipewire-pulse wireplumber
```

### 2. Configure Environment Variables

```bash
# Copy environment variables
sudo cp configs/hyprland/env.conf /etc/environment.d/hyprland.conf
```

### 3. Set Up Polkit

```bash
# Copy polkit configuration
sudo cp configs/system/polkit-1/rules.d/* /etc/polkit-1/rules.d/
```

---

## 🌐 WebApps Setup

```bash
# Make webapp scripts executable
chmod +x scripts/webapps/*.sh

# Copy webapp scripts
cp scripts/webapps/* ~/.local/bin/

# Create webapp desktop entries
mkdir -p ~/.local/share/applications
cp apps/webapps/*.desktop ~/.local/share/applications/
```

---

## ✅ Post-Installation

### 1. Reboot System

```bash
sudo reboot
```

### 2. First Login

After rebooting:

1. Select **Hyprland** from SDDM session menu
2. Log in with your credentials
3. The Welcome app should appear automatically
4. Follow the on-screen instructions

### 3. Verify Installation

```bash
# Check Hyprland version
hyprctl version

# Check Noctalia Shell
qs -c noctalia-shell --version

# Test audio
wpctl status

# Test gaming
gamemoded -t
```

---

## 🔄 Updating

### Update System

```bash
# Update all packages
paru -Syu

# Update Noctalia Shell (if installed manually)
cd ~/.config/quickshell/noctalia-shell
git pull
```

### Update Configuration

```bash
# Pull latest configs
cd ~/Hypr-Snaps
git pull

# Backup current configs
cp -r ~/.config/hypr ~/.config/hypr.backup

# Copy new configs
cp -r configs/hyprland/* ~/.config/hypr/
```

---

## 🐛 Troubleshooting

### Hyprland Won't Start

```bash
# Check logs
cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log

# Verify Hyprland installation
which Hyprland
hyprctl version
```

### Noctalia Shell Issues

```bash
# Check Quickshell logs
journalctl --user -u noctalia.service

# Restart Noctalia
killall qs
qs -c noctalia-shell &
```

### Audio Not Working

```bash
# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse wireplumber

# Check audio status
wpctl status
pactl info
```

### GPU Issues

```bash
# Check GPU driver
lspci -k | grep -A 3 -E "(VGA|3D)"

# Verify Vulkan
vulkaninfo | grep "deviceName"

# Check Mesa version
glxinfo | grep "OpenGL version"
```

---

## 📚 Next Steps

After installation:

1. Read the [Configuration Guide](CONFIGURATION.md)
2. Learn the [Keybindings](../references/KEYBINDINGS.md)
3. Set up [Gaming](GAMING.md)
4. Configure [Streaming](STREAMING.md)
5. Customize [Widgets](WIDGETS.md)

---

## 🆘 Getting Help

If you encounter issues:

1. Check the [Troubleshooting Guide](TROUBLESHOOTING.md)
2. Search [GitHub Issues](https://github.com/Crowdrocker/Hypr-Snaps/issues)
3. Join our [Discord](https://discord.gg/nTaknDvdUA)
4. Ask on [Reddit r/hyprland](https://reddit.com/r/hyprland)

---

<div align="center">

**Installation complete! Enjoy your new setup! 🎉**

[← Back to README](../../README.md)

</div>