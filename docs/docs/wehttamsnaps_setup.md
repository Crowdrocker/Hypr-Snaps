# WehttamSnaps Hyprland Setup

```
 __        __   _     _   _                    ____                        
 \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _ _ __  ___ 
  \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` | '_ \/ __|
   \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| | |_) \__ \
    \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_| .__/|___/
                                                                  |_|        
```

**GitHub:** [Crowdrocker](https://github.com/Crowdrocker)  
**Twitch:** [WehttamSnaps](https://twitch.tv/WehttamSnaps)  
**YouTube:** [WehttamSnaps](https://youtube.com/@WehttamSnaps)

---

## 📋 Table of Contents

1. [About](#about)
2. [System Specifications](#system-specifications)
3. [Installation Structure](#installation-structure)
4. [Core Components](#core-components)
5. [Brand Identity](#brand-identity)
6. [Quick Start Guide](#quick-start-guide)
7. [Feature Overview](#feature-overview)
8. [Gaming Setup](#gaming-setup)
9. [Streaming Setup](#streaming-setup)
10. [Customization](#customization)

---

## 🎯 About

Welcome to **WehttamSnaps** - a personalized Arch Linux Hyprland setup designed for photography, gaming, and streaming. This setup combines the beautiful aesthetics of JaKooLit's theming with the functional workflow of Omarchy, powered by the elegant Noctalia shell.

**Creator:** Matthew (WehttamSnaps)  
**Primary Use:** Wedding/Photobooth Photography, Gaming, Streaming  
**Philosophy:** "It just works!"

### Design Goals

- ✨ Beautiful, minimal desktop environment
- ⚡ Enhanced productivity and faster responsiveness
- 🎮 Optimized for gaming and content creation
- 🎨 Smooth animations with vibrant color schemes
- 🤖 Full J.A.R.V.I.S. theme integration
- 📸 Professional workflow for photography

---

## 💻 System Specifications

### Hardware

- **CPU:** Intel i5-4430 (Haswell, 4 cores/4 threads, 3.0–3.2 GHz)
- **GPU:** AMD RX 580 (recommended over GTX 1650 for Linux)
- **RAM:** 16GB DDR3
- **Storage:**
  - 1TB SSD - Games/Photos/Videos (`/run/media/wehttamsnaps/LINUXDRIVE-1`)
  - 120GB SSD - Linux System
  - 120GB SSD - Windows Dual Boot
- **PSU:** 750W
- **Monitor:** Single DP-3 @ 1920x1080

### System Info

- **Username:** `wehttamsnaps`
- **Hostname:** `snaps-pc`
- **Timezone:** America/Chicago
- **Locale:** en_US.UTF-8

---

## 📁 Installation Structure

### Repository Organization

```
Hypr-Snaps/
├── README.md
├── install.sh
├── config/
│   ├── hypr/
│   │   ├── hyprland.conf
│   │   ├── modules/
│   │   │   ├── animations.conf
│   │   │   ├── autostart.conf
│   │   │   ├── binds.conf
│   │   │   ├── display.conf
│   │   │   ├── environment.conf
│   │   │   ├── gaming.conf
│   │   │   ├── windowrules.conf
│   │   │   └── workspaces.conf
│   │   └── scripts/
│   ├── noctalia/
│   │   ├── custom-widgets/
│   │   ├── themes/
│   │   └── templates/
│   ├── ghostty/
│   │   └── config
│   ├── rofi/
│   ├── dunst/
│   └── qpwgraph/
├── scripts/
│   ├── audio/
│   ├── gaming/
│   ├── jarvis/
│   ├── system/
│   └── utils/
├── themes/
│   ├── gtk/
│   ├── qt/
│   └── cursors/
├── assets/
│   ├── wallpapers/
│   ├── sounds/
│   │   └── jarvis/
│   ├── icons/
│   └── fonts/
├── webapps/
│   └── desktop-files/
└── docs/
    ├── KEYBINDS.md
    ├── GAMING.md
    ├── STREAMING.md
    └── TROUBLESHOOTING.md
```

### Separate Branches

- `main` - Stable release
- `wallpapers` - Wallpaper collection
- `jarvis-sounds` - J.A.R.V.I.S. audio pack
- `themes` - Theme variants
- `dev` - Development/testing

---

## 🔧 Core Components

### Desktop Environment

- **Compositor:** Hyprland
- **Shell:** Noctalia (Quickshell-based)
- **Terminal:** Ghostty with TokyoNight theme
- **File Manager:** Thunar with custom plugins
- **App Launcher:** Rofi/Fuzzel (TokyoNight-styled)
- **Notifications:** Dunst with J.A.R.V.I.S. sounds

### Display & Session

- **Display Manager:** SDDM with SugarCandy theme
- **Lock Screen:** Gtklock with custom modules
- **Bootloader:** GRUB (styled to match theme)
- **Wallpaper:** Swww/Hyprpaper

### Audio System

- **Audio Server:** PipeWire
- **Routing:** qpwgraph (Voicemeter alternative)
- **Control:** Pavucontrol
- **Effects:** EasyEffects

### Development Tools

- **Shell:** Zsh with Powerlevel10k
- **Prompt:** Starship
- **Editor:** Neovim, VSCode
- **Fetch:** Fastfetch with custom logo

---

## 🎨 Brand Identity

### Color Palette

**Primary Gradient:** Violet to Cyan  
- Violet: `#8A2BE2`
- Cyan: `#00FFFF`

**Secondary Colors:**
- Deep Blue: `#0066CC`
- Hot Pink: `#FF69B4`

### Themes

**GTK Themes:**
- Flat-Remix-GTK-Blue-Dark-Solid
- Sweet-Ambar-Blue-Dark-v40
- Tokyonight-Dark

**Qt Theme:** Kvantum with custom colors

**Icon Theme:** Papirus (custom folder colors)

**Cursor Theme:** Bibata-Modern-Classic

### Fonts

- **UI:** Roboto
- **Headers:** Inter
- **Terminal:** JetBrains Mono Nerd Font
- **Code:** Fira Code
- **Symbols:** Nerd Fonts Complete

---

## 🚀 Quick Start Guide

### Installation

```bash
# Clone the repository
git clone https://github.com/Crowdrocker/Hypr-Snaps.git
cd Hypr-Snaps

# Make install script executable
chmod +x install.sh

# Run interactive installer
./install.sh
```

### Essential Keybindings

#### System Controls

| Keybind | Action |
|---------|--------|
| `SUPER + Space` | Open application launcher |
| `SUPER + S` | Toggle control center |
| `SUPER + ,` | Open settings |
| `SUPER + Enter` | Open terminal (Ghostty) |
| `SUPER + F` | Open file manager |
| `SUPER + Q` | Close window |
| `SUPER + L` | Lock screen |
| `SUPER + Shift + E` | Power menu |

#### Noctalia Controls

| Keybind | Action |
|---------|--------|
| `SUPER + V` | Clipboard history |
| `SUPER + C` | Calculator |
| `SUPER + Ctrl + Space` | Cycle wallpapers |
| `SUPER + Shift + N` | Toggle Do Not Disturb |

#### Gaming Mode

| Keybind | Action |
|---------|--------|
| `SUPER + G` | Toggle gaming mode |
| `SUPER + F11` | Toggle gamemode performance |

#### Streaming

| Keybind | Action |
|---------|--------|
| `SUPER + Shift + S` | Toggle streaming mode |
| `SUPER + Shift + R` | Start/stop screen recording |

#### WebApps

| Keybind | Action |
|---------|--------|
| `SUPER + W` | YouTube webapp |
| `SUPER + Shift + W` | Twitch webapp |
| `SUPER + I` | Instagram webapp |
| `SUPER + A` | AI Chat webapp |

#### Audio

| Keybind | Action |
|---------|--------|
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86AudioMute` | Toggle mute |

---

## ✨ Feature Overview

### Noctalia Custom Widgets

#### Work Launcher
Quick access to photography and design tools:
- Inkscape
- GIMP
- Krita
- Darktable
- RawTherapee
- Discord

#### Gaming Launcher
One-click access to gaming platforms:
- Steam
- Lutris
- Heroic Games Launcher
- Spotify
- Discord

#### WebApps Integration
Browser-based apps with desktop integration:
- YouTube
- Twitch
- Instagram
- ChatGPT/Claude
- Google Photos

### J.A.R.V.I.S. Theme Integration

**Sound Events:**
- `jarvis-startup.mp3` - "Allow me to introduce myself, I am JARVIS..."
- `jarvis-shutdown.mp3` - "Shutting down. Have a good day, Matthew."
- `jarvis-notification.mp3` - "Matthew, you have a notification."
- `jarvis-warning.mp3` - "Warning: System temperature critical."
- `jarvis-gaming.mp3` - "Gaming mode activated. Systems at maximum performance."
- `jarvis-streaming.mp3` - "Streaming systems online. All feeds operational."

**Visual Elements:**
- Custom SDDM login animation
- Boot splash screen
- Themed notification style
- Power menu with J.A.R.V.I.S. aesthetics

### Audio Routing (Voicemeter Alternative)

Using PipeWire + qpwgraph for advanced audio routing:

1. **Game Audio** → Dedicated sink
2. **Browser Audio** → Separate sink
3. **Discord** → Independent sink
4. **Spotify** → Music sink
5. **Mix all** → Headphones/Speakers

Scripts included for quick audio profile switching.

---

## 🎮 Gaming Setup

### Optimizations

- **AMD GPU:** Mesa drivers with RADV (Vulkan)
- **Performance:** Gamemode integration
- **Compatibility:** FSYNC, Esync enabled
- **Proton:** Latest Proton-GE installed
- **Gamescope:** HDR and upscaling support

### GPU Management

- **CoreCtrl** - Advanced AMD GPU control
- **LACT** - Linux AMDGPU Controller
- **MangoHud** - Performance overlay
- **Auto fan curves** - Temperature-based

### Steam Launch Options Template

```bash
# General AMD optimization
RADV_PERFTEST=gpl,nggc,sam %command%

# With gamemode
gamemoderun %command%

# With gamescope
gamescope -w 1920 -h 1080 -f -- %command%

# Complete setup
RADV_PERFTEST=gpl,nggc,sam gamemoderun gamescope -w 1920 -h 1080 -f -- %command%
```

### Mod Management

**Nexus Mods App** - Official Linux support
- Cyberpunk 2077 (native)
- More games coming soon

**SteamTinkerLaunch** - For Vortex/MO2
- Fallout 4
- Fallout: New Vegas
- Skyrim/Skyrim SE

### Supported Games

Games tested and optimized:
- Call of Duty HQ
- Cyberpunk 2077
- Fallout 4
- The Division / Division 2
- The First Descendant
- Warframe
- Watch Dogs series
- Tomb Raider series

---

## 📹 Streaming Setup

### OBS Studio Configuration

**Scene Collections:**
- Gaming (webcam + game)
- Just Chatting (webcam focus)
- Photography Work (screen share)
- BRB/Starting Soon

**Audio Routing via qpwgraph:**
```
Game Audio → OBS Desktop Audio
Mic → OBS Mic/Aux
Discord → OBS Discord (optional)
Music → Spotify sink (ducked during speech)
```

### Keybindings

- Start/Stop Streaming: `SUPER + Shift + S`
- Start/Stop Recording: `SUPER + Shift + R`
- Mute Mic: `SUPER + M`
- Toggle Sources: `SUPER + 1-5`

### Resources

**Free Stream Assets:**
- [OBS Resources](https://obsproject.com/forum/resources/)
- [Own3d.tv Free Templates](https://www.own3d.tv/free)
- [Nerd or Die](https://nerdordie.com/)

---

## 🎨 Customization

### Creating Noctalia Widgets

Follow the guide in `docs/NOCTALIA_WIDGETS.md` to create custom widgets for your workflow.

### Matugen Templates

Create custom color schemes that sync with your wallpaper. Templates included for:
- Ghostty terminal
- Rofi
- Dunst
- GTK apps
- Qt apps

### Custom Scripts

All scripts are modular and documented in `scripts/`:
- Audio profile switcher
- Gaming mode toggle
- Keybind generator
- System cleanup utilities

### Wallpaper Management

```bash
# Cycle to next wallpaper
SUPER + Ctrl + Space

# Random wallpaper
./scripts/wallpaper-random.sh

# Set specific wallpaper
./scripts/wallpaper-set.sh /path/to/image.jpg
```

---

## 📚 Additional Documentation

- **[Complete Keybinds Reference](docs/KEYBINDS.md)**
- **[Gaming Optimization Guide](docs/GAMING.md)**
- **[Streaming Setup Guide](docs/STREAMING.md)**
- **[Creating Noctalia Widgets](docs/NOCTALIA_WIDGETS.md)**
- **[Audio Routing with qpwgraph](docs/AUDIO_ROUTING.md)**
- **[Troubleshooting](docs/TROUBLESHOOTING.md)**

---

## 🤝 Contributing

This is a personal setup, but suggestions and improvements are welcome!

### How to Contribute

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

### Discord Community

Join the WehttamSnaps community: [Discord Server](https://discord.gg/nTaknDvdUA)

Channels:
- 🐧 Linux help
- 🎮 Gaming (Division, First Descendant, etc.)
- 📸 Photography tips
- 🎥 Streaming support
- 💻 Setup showcase

---

## 📝 License

This configuration is free to use and modify for personal use.

---

## 🙏 Credits

**Inspiration:**
- [JaKooLit](https://github.com/JaKooLit) - Theming inspiration
- [Omarchy](https://github.com/omarchy) - Workflow and functionality
- [Noctalia](https://github.com/noctalia-dev/noctalia-shell) - Beautiful shell

**Tools:**
- Hyprland community
- Arch Linux community
- All the amazing open-source developers

---

**Made with ❤️ by Matthew (WehttamSnaps)**  
*"It just works!"*
