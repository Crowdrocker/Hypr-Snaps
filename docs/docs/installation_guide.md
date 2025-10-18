# WehttamSnaps Hyprland Setup - Complete Installation Guide

```
 __        __   _     _   _                    ____                        
 \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _ _ __  ___ 
  \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` | '_ \/ __|
   \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| | |_) \__ \
    \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_| .__/|___/
                                                                  |_|        
```

**GitHub:** [Crowdrocker](https://github.com/Crowdrocker)

---

## 📋 Table of Contents

1. [Pre-Installation](#pre-installation)
2. [Installation Methods](#installation-methods)
3. [Post-Installation Setup](#post-installation-setup)
4. [Configuration](#configuration)
5. [Troubleshooting](#troubleshooting)
6. [Updating](#updating)

---

## 🔧 Pre-Installation

### System Requirements

**Minimum:**
- Arch Linux or Arch-based distribution
- 4GB RAM (8GB recommended)
- 20GB free disk space
- AMD or Intel GPU (AMD RX 580 for full optimization)

**Your System:**
- CPU: Intel i5-4430
- GPU: AMD RX 580
- RAM: 16GB DDR3
- Monitor: 1920x1080 (DP-3)

### Before You Begin

1. **Backup your data**
   ```bash
   # The installer creates automatic backups, but better safe than sorry
   tar -czf ~/my-backup-$(date +%Y%m%d).tar.gz ~/.config
   ```

2. **Update your system**
   ```bash
   sudo pacman -Syu
   ```

3. **Install base-devel if not present**
   ```bash
   sudo pacman -S --needed base-devel git
   ```

4. **Install paru (AUR helper)**
   ```bash
   git clone https://aur.archlinux.org/paru.git
   cd paru
   makepkg -si
   ```

---

## 🚀 Installation Methods

### Method 1: Interactive Installer (Recommended)

The easiest way to install everything:

```bash
# 1. Clone the repository
git clone https://github.com/Crowdrocker/Hypr-Snaps.git
cd Hypr-Snaps

# 2. Make installer executable
chmod +x install.sh

# 3. Run the installer
./install.sh
```

**Installation Flow:**
```
┌─────────────────────────────────────┐
│     Welcome Screen                  │
│  - Introduction                     │
│  - What will be installed           │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  System Requirements Check          │
│  - Arch Linux verification          │
│  - paru AUR helper check            │
│  - Disk space check                 │
│  - AMD GPU detection                │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  Interactive Options Menu           │
│  ☑ Core (Required)                  │
│  ☐ Gaming                           │
│  ☐ Streaming                        │
│  ☐ Photography                      │
│  ☐ WebApps                          │
│  ☐ J.A.R.V.I.S.                     │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  Backup Existing Configs            │
│  ~/.config-backup-YYYYMMDD-HHMMSS   │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  Install Packages                   │
│  - Core packages                    │
│  - Optional components              │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  Copy Configuration Files           │
│  - Hyprland configs                 │
│  - Noctalia shell                   │
│  - Scripts & themes                 │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  Setup Services & Shell             │
│  - Enable services                  │
│  - Configure autostart              │
│  - Generate keybinds                │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  Installation Complete!             │
│  - Reboot system                    │
│  - Select Hyprland at login         │
└─────────────────────────────────────┘
```

### Method 2: Manual Installation

If you prefer manual control:

```bash
# 1. Install core packages
paru -S hyprland noctalia-shell ghostty zsh

# 2. Copy configs
git clone https://github.com/Crowdrocker/Hypr-Snaps.git
cd Hypr-Snaps
cp -r config/* ~/.config/

# 3. Install scripts
cp -r scripts/* ~/.config/hypr/scripts/
chmod +x ~/.config/hypr/scripts/**/*.sh

# 4. Setup shell
chsh -s /usr/bin/zsh
cp config/zsh/.zshrc ~/

# 5. Enable services
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

---

## 🎯 Post-Installation Setup

### First Login

1. **Select Hyprland** at your display manager
2. **Welcome app** will automatically launch
3. Press `SUPER + /` to view keybindings

### Essential First Steps

#### 1. Configure Display
```bash
# Check your monitor name
hyprctl monitors

# Edit display config
nvim ~/.config/hypr/modules/display.conf

# Set your monitor (already configured for DP-3)
monitor = DP-3, 1920x1080@60, 0x0, 1
```

#### 2. Set Wallpaper
```bash
# Place wallpapers in
~/.config/hypr-snaps/assets/wallpapers/

# Cycle wallpapers
SUPER + Ctrl + Space

# Or edit directly
nvim ~/.config/hypr/modules/autostart.conf
```

#### 3. Configure Audio
```bash
# Test audio
speaker-test -c2

# Open audio mixer
pavucontrol

# For advanced routing (gaming/streaming)
qpwgraph
```

#### 4. Setup Gaming Mode (if installed)
```bash
# Test gaming mode
SUPER + G

# Check status
~/.config/hypr/scripts/gaming/toggle-gamemode.sh status

# Setup LACT for GPU control
sudo systemctl enable --now lactd
systemctl --user enable --now lact
```

#### 5. Setup Streaming (if installed)
```bash
# Test streaming mode
SUPER + Shift + S

# This will:
# - Launch OBS
# - Create virtual audio sinks
# - Enable DND mode

# Configure audio routing
qpwgraph
# Save profile: File → Save As → ~/.config/qpwgraph/profiles/streaming.qpwgraph
```

---

## ⚙️ Configuration

### Customizing Hyprland

All configs are modular and located in:
```
~/.config/hypr/
├── hyprland.conf          # Main config (sources modules)
└── modules/
    ├── animations.conf    # Animation settings
    ├── autostart.conf     # Startup applications
    ├── binds.conf         # Keybindings
    ├── display.conf       # Monitor config
    ├── environment.conf   # Environment variables
    ├── gaming.conf        # Gaming optimizations
    ├── windowrules.conf   # Window rules
    └── workspaces.conf    # Workspace setup
```

#### Common Customizations

**Change Animation Speed:**
```bash
nvim ~/.config/hypr/modules/animations.conf

# Adjust speed values
animation = windows, 1, 5, default  # Change 5 to your preference
```

**Add Custom Keybinds:**
```bash
nvim ~/.config/hypr/modules/binds.conf

# Add your keybind
bind = SUPER, Y, exec, your-command

# Reload Hyprland
SUPER + Shift + R
```

**Modify Window Rules:**
```bash
nvim ~/.config/hypr/modules/windowrules.conf

# Add rule for your app
windowrulev2 = workspace 7, class:^(yourapp)$
```

### Customizing Noctalia Shell

Noctalia configs are in:
```
~/.config/noctalia/
├── custom-widgets/    # Your custom widgets
├── themes/            # Color schemes
└── templates/         # Matugen templates
```

#### Creating Custom Widgets

See `~/.config/hypr-snaps/docs/NOCTALIA_WIDGETS.md` for detailed guide.

### Customizing Themes

**GTK Theme:**
```bash
# Edit GTK settings
nvim ~/.config/gtk-3.0/settings.ini

# Available themes
ls ~/.local/share/themes/
```

**Icon Theme:**
```bash
# Change Papirus folder colors
papirus-folders -C violet
```

**Terminal Theme:**
```bash
nvim ~/.config/ghostty/config

# Or use Matugen for auto-theming
matugen image /path/to/wallpaper.jpg
```

---

## 🔧 Troubleshooting

### Display Issues

**Black screen after login:**
```bash
# Switch to TTY (Ctrl + Alt + F2)
# Check Hyprland logs
cat ~/.local/share/hyprland/hyprland.log

# Try starting manually
Hyprland
```

**Wrong resolution:**
```bash
# List available modes
hyprctl monitors

# Edit display config
nvim ~/.config/hypr/modules/display.conf
```

### Audio Issues

**No sound:**
```bash
# Check PipeWire status
systemctl --user status pipewire pipewire-pulse

# Restart audio
systemctl --user restart pipewire pipewire-pulse wireplumber

# Check outputs
pactl list sinks short
```

**Microphone not working:**
```bash
# List inputs
pactl list sources short

# Test microphone
arecord -f cd test.wav
# Press Ctrl+C to stop
aplay test.wav
```

### Noctalia Shell Issues

**Noctalia not loading:**
```bash
# Check if running
pgrep -f "noctalia-shell"

# Restart manually
killall qs
qs -c noctalia-shell &

# Check for errors
journalctl --user -u noctalia-shell
```

### Gaming Mode Issues

**Gamemode not activating:**
```bash
# Check gamemode status
systemctl --user status gamemoded

# Enable if not active
systemctl --user enable --now gamemoded

# Test gamemode
gamemoderun glxgears
```

**LACT not controlling GPU:**
```bash
# Check LACT daemon
sudo systemctl status lactd

# Restart LACT
sudo systemctl restart lactd
systemctl --user restart lact

# Open LACT GUI
lact gui
```

### Performance Issues

**High CPU usage:**
```bash
# Check running processes
btop

# Disable animations temporarily
hyprctl keyword animations:enabled false
```

**Screen tearing:**
```bash
# Edit Hyprland config
nvim ~/.config/hypr/hyprland.conf

# Add/uncomment
misc {
    vrr = 1  # Variable refresh rate
}
```

---

## 🔄 Updating

### Update WehttamSnaps Setup

```bash
# Navigate to repo
cd ~/Hypr-Snaps

# Pull latest changes
git pull

# Backup current config
tar -czf ~/config-backup-$(date +%Y%m%d).tar.gz ~/.config/hypr ~/.config/noctalia

# Copy new configs (be careful, this overwrites)
cp -r config/* ~/.config/

# Or selectively copy what you need
cp config/hypr/modules/binds.conf ~/.config/hypr/modules/

# Reload Hyprland
SUPER + Shift + R
```

### Update Packages

```bash
# Update system and AUR packages
paru -Syu

# Update Noctalia shell
paru -S noctalia-shell

# Restart Noctalia
SUPER + Ctrl + Shift + N
```

---

## 📚 Additional Resources

### Documentation

- **Main README:** `~/.config/hypr-snaps/README.md`
- **Keybindings:** `~/.config/hypr-snaps/docs/KEYBINDS.md`
- **Gaming Setup:** `~/.config/hypr-snaps/docs/GAMING.md`
- **Streaming Guide:** `~/.config/hypr-snaps/docs/STREAMING.md`
- **Audio Routing:** `~/.config/hypr-snaps/docs/AUDIO_ROUTING.md`
- **Troubleshooting:** `~/.config/hypr-snaps/docs/TROUBLESHOOTING.md`

### Quick Commands Reference

```bash
# View keybindings
SUPER + /

# Edit Hyprland config
SUPER + .

# Reload Hyprland
SUPER + Shift + R

# Toggle gaming mode
SUPER + G

# Toggle streaming mode
SUPER + Shift + S

# Audio profile switcher
SUPER + Alt + A

# System monitor
SUPER + Ctrl + Escape
```

### Community & Support

- **GitHub:** https://github.com/Crowdrocker/Hypr-Snaps
- **Discord:** https://discord.gg/nTaknDvdUA
- **Twitch:** https://twitch.tv/WehttamSnaps
- **YouTube:** https://youtube.com/@WehttamSnaps

### Getting Help

If you encounter issues:

1. Check the troubleshooting section above
2. Review logs: `~/wehttamsnaps-install.log`
3. Check Hyprland logs: `~/.local/share/hyprland/hyprland.log`
4. Join Discord for community support
5. Open an issue on GitHub

---

## 🎓 Learning Resources

### Hyprland

- Official Wiki: https://wiki.hyprland.org/
- Awesome Hyprland: https://github.com/hyprland-community/awesome-hyprland

### Noctalia Shell

- Documentation: https://noctalia.dev/
- GitHub: https://github.com/noctalia-dev/noctalia-shell

### Wayland

- Wayland Book: https://wayland-book.com/
- Arch Wiki: https://wiki.archlinux.org/title/Wayland

---

## 🌟 Tips for New Users

### First Week Checklist

- [ ] Learn basic keybindings (SUPER + /)
- [ ] Customize wallpaper
- [ ] Set up your favorite apps
- [ ] Configure workspaces for your workflow
- [ ] Test gaming mode
- [ ] Explore Noctalia widgets

### Power User Tips

1. **Use VIM keybinds** for window management (SUPER + H/J/K/L)
2. **Leverage workspaces** - assign apps to specific workspaces
3. **Custom scripts** - add your own to `~/.config/hypr/scripts/utils/`
4. **Audio profiles** - create profiles for different scenarios
5. **Scratchpad** - use `` SUPER + ` `` for quick access to terminals

### Productivity Workflows

**Photography Session:**
```
SUPER + 3          → Switch to photography workspace
SUPER + Alt + D    → Open Darktable
SUPER + Alt + G    → Open GIMP
SUPER + F          → File manager for photos
```

**Gaming:**
```
SUPER + G          → Enable gaming mode
SUPER + 5          → Switch to gaming workspace
SUPER + Alt + 1    → Launch Steam
```

**Streaming:**
```
SUPER + Shift + S  → Enable streaming mode
SUPER + Shift + O  → Open OBS
SUPER + Shift + A  → Configure audio routing
```

---

**Made with ❤️ by Matthew (WehttamSnaps)**  
*"It just works!"*

**GitHub:** [Crowdrocker](https://github.com/Crowdrocker) | **Twitch:** [WehttamSnaps](https://twitch.tv/WehttamSnaps) | **YouTube:** [WehttamSnaps](https://youtube.com/@WehttamSnaps)