# Installation Guide - WehttamSnaps Hyprland Setup

> Complete step-by-step installation guide for WehttamSnaps Hyprland configuration

## 📋 Prerequisites

### System Requirements
- **OS**: Fresh Arch Linux installation
- **CPU**: Intel i5-4430 or equivalent
- **GPU**: AMD RX 580 (or compatible AMD/NVIDIA GPU)
- **RAM**: 8GB minimum, 16GB recommended
- **Storage**: 50GB minimum free space
- **Internet**: Active connection required

### Before You Begin
- Backup any existing configurations
- Ensure you have a working internet connection
- Have basic terminal knowledge
- Know your GPU type (AMD/NVIDIA)

## 🚀 Installation Methods

### Method 1: Automated Installation (Recommended)

This is the easiest and fastest method.

```bash
# Clone the repository
git clone https://github.com/Crowdrocker/WehttamSnaps-Hyprland.git
cd WehttamSnaps-Hyprland

# Make installer executable
chmod +x tools/install.sh

# Run the installer
./tools/install.sh
```

The installer will:
1. Check system compatibility
2. Install required packages
3. Configure Hyprland
4. Set up Noctalia shell
5. Apply theming
6. Configure audio routing
7. Set up webapps

### Method 2: Manual Installation

For advanced users who want more control.

#### Step 1: Install Core Packages

```bash
# Update system
sudo pacman -Syu

# Install paru (AUR helper)
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..

# Install core packages
paru -S --needed - < packages/core.txt
```

#### Step 2: Install Optional Packages

```bash
# Photography tools
paru -S --needed - < packages/photography.txt

# Gaming packages
paru -S --needed - < packages/gaming.txt

# Streaming tools
paru -S --needed - < packages/streaming.txt

# Optional utilities
paru -S --needed - < packages/optional.txt
```

#### Step 3: Configure Hyprland

```bash
# Create config directory
mkdir -p ~/.config/hypr

# Copy Hyprland configs
cp -r configs/hyprland/* ~/.config/hypr/

# Make scripts executable
chmod +x ~/.config/hypr/scripts/*
```

#### Step 4: Set Up Noctalia Shell

```bash
# Install Noctalia
paru -S noctalia-shell quickshell

# Copy Noctalia configs
mkdir -p ~/.config/quickshell/noctalia-shell
cp -r configs/noctalia/* ~/.config/quickshell/noctalia-shell/
```

#### Step 5: Configure Audio

```bash
# Enable PipeWire services
systemctl --user enable --now pipewire
systemctl --user enable --now pipewire-pulse
systemctl --user enable --now wireplumber

# Copy audio routing script
cp configs/scripts/audio-setup.sh ~/.config/hypr/scripts/
chmod +x ~/.config/hypr/scripts/audio-setup.sh
```

#### Step 6: Set Up Webapps

```bash
# Copy webapp launchers
mkdir -p ~/.local/share/applications
cp configs/webapps/*.desktop ~/.local/share/applications/
```

#### Step 7: Install Themes

```bash
# Copy GTK themes
mkdir -p ~/.themes
cp -r assets/themes/* ~/.themes/

# Copy wallpapers
mkdir -p ~/Pictures/Wallpapers
cp -r assets/wallpapers/* ~/Pictures/Wallpapers/
```

#### Step 8: Configure Shell

```bash
# Set zsh as default shell
chsh -s $(which zsh)

# Install Oh My Zsh (optional)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy shell configs
cp configs/shell/.zshrc ~/
```

## 🎨 Post-Installation Setup

### 1. Configure Display Manager

If using SDDM:

```bash
# Install SDDM theme
paru -S sddm-sugar-candy-git

# Enable SDDM
sudo systemctl enable sddm
```

### 2. Set Up Ghostty Terminal

```bash
# Create Ghostty config directory
mkdir -p ~/.config/ghostty

# Copy Ghostty config
cp configs/ghostty/config ~/.config/ghostty/
```

### 3. Configure Noctalia Autostart

Add to `~/.config/hypr/hyprland.conf`:

```conf
exec-once = qs -c noctalia-shell
```

### 4. Set Up J.A.R.V.I.S. Sounds

```bash
# Copy sound files
mkdir -p ~/.config/sounds
cp configs/sounds/* ~/.config/sounds/
```

### 5. Configure Webapps

Edit webapp keybindings in `~/.config/hypr/conf.d/20-keybinds.conf`

## 🔧 GPU-Specific Configuration

### For AMD GPUs (RX 580)

Already configured! The setup is optimized for AMD GPUs.

Verify installation:
```bash
# Check Vulkan
vulkaninfo | grep "deviceName"

# Check Mesa
glxinfo | grep "OpenGL renderer"
```

### For NVIDIA GPUs

If using NVIDIA instead:

```bash
# Install NVIDIA drivers
paru -S nvidia-dkms nvidia-utils lib32-nvidia-utils

# Add to kernel parameters
sudo nano /etc/default/grub
# Add: nvidia_drm.modeset=1

# Regenerate grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Add to mkinitcpio
sudo nano /etc/mkinitcpio.conf
# MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)

# Regenerate initramfs
sudo mkinitcpio -P
```

## 🎮 Gaming Setup

### Enable Gamemode

```bash
# Gamemode is already installed
# Test it with:
gamemoded -t
```

### Configure Steam

```bash
# Launch Steam
steam

# In Steam settings:
# - Enable Steam Play for all titles
# - Select Proton Experimental or GE-Proton
```

### Set Up Gamescope

```bash
# Launch games with gamescope
gamescope -W 1920 -H 1080 -f -- %command%
```

## 📸 Photography Setup

### Configure Darktable

```bash
# Launch Darktable
darktable

# Import your photo library
# Configure color management in preferences
```

### Set Up Color Management

```bash
# Install color profiles
sudo pacman -S colord

# Enable colord service
systemctl --user enable --now colord
```

## 🎙️ Streaming Setup

### Configure OBS

```bash
# Launch OBS
obs

# Settings → Output:
# - Encoder: FFMPEG VAAPI (for AMD)
# - Rate Control: CBR
# - Bitrate: 6000 (adjust for your upload speed)

# Settings → Video:
# - Base Resolution: 1920x1080
# - Output Resolution: 1920x1080
# - FPS: 60
```

### Set Up Audio Routing

```bash
# Run audio setup script
~/.config/hypr/scripts/audio-setup.sh

# Open qpwgraph to visualize routing
qpwgraph
```

## ✅ Verification

After installation, verify everything works:

```bash
# Check Hyprland
hyprctl version

# Check Noctalia
qs -c noctalia-shell ipc call launcher toggle

# Check audio
pactl info

# Check GPU
glxinfo | grep "OpenGL renderer"
```

## 🔄 First Boot

1. **Reboot your system**
   ```bash
   reboot
   ```

2. **Log in to Hyprland**
   - Select Hyprland from display manager
   - Log in with your credentials

3. **Initial Setup**
   - Press `SUPER + H` to see keybindings
   - Press `SUPER + COMMA` to open settings
   - Press `SUPER + W` to select wallpaper

4. **Test Features**
   - Open terminal: `SUPER + ENTER`
   - Launch apps: `SUPER + D`
   - Toggle control center: `SUPER + C`

## 🐛 Troubleshooting

### Hyprland Won't Start

```bash
# Check logs
cat ~/.local/share/hyprland/hyprland.log

# Try starting manually
Hyprland
```

### Noctalia Not Showing

```bash
# Check if running
pgrep -a quickshell

# Start manually
qs -c noctalia-shell

# Check logs
journalctl --user -u noctalia.service
```

### Audio Issues

```bash
# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse wireplumber

# Check audio devices
pactl list sinks
```

### GPU Issues

```bash
# Check GPU driver
lspci -k | grep -A 3 VGA

# For AMD, check AMDGPU
dmesg | grep amdgpu
```

## 📚 Next Steps

After successful installation:

1. Read [QUICKSTART.md](QUICKSTART.md) for basic usage
2. Review [KEYBINDINGS.md](KEYBINDINGS.md) for shortcuts
3. Explore [CUSTOMIZATION.md](CUSTOMIZATION.md) for personalization
4. Check [NOCTALIA.md](NOCTALIA.md) for shell customization

## 🆘 Getting Help

If you encounter issues:

1. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Search [GitHub Issues](https://github.com/Crowdrocker/WehttamSnaps-Hyprland/issues)
3. Create a new issue with:
   - System information
   - Error messages
   - Steps to reproduce

---

**Installation complete! Welcome to WehttamSnaps Hyprland Setup! 🎉**

*Made with ❤️ by WehttamSnaps*