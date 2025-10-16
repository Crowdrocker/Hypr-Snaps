```
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
```

# 🎮 WehttamSnaps Hyprland Setup

> *A complete Arch Linux Hyprland configuration optimized for photography, gaming, and streaming*

[![GitHub](https://img.shields.io/badge/GitHub-Crowdrocker-8A2BE2?style=for-the-badge&logo=github)](https://github.com/Crowdrocker/Hypr-Snaps)
[![Twitch](https://img.shields.io/badge/Twitch-WehttamSnaps-9146FF?style=for-the-badge&logo=twitch)](https://twitch.tv/WehttamSnaps)
[![YouTube](https://img.shields.io/badge/YouTube-WehttamSnaps-FF0000?style=for-the-badge&logo=youtube)](https://youtube.com/@WehttamSnaps)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [System Specifications](#system-specifications)
- [Installation](#installation)
- [Configuration](#configuration)
- [Keybindings](#keybindings)
- [Gaming Setup](#gaming-setup)
- [Streaming Setup](#streaming-setup)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Credits](#credits)

---

## 🌟 Overview

**WehttamSnaps Hyprland Setup** is a meticulously crafted Arch Linux environment designed for content creators who demand both aesthetics and performance. This setup combines the power of Hyprland with the elegance of Noctalia Shell, creating a workflow optimized for:

- 📸 **Photography & Photo Editing** (GIMP, Krita, Inkscape, Darktable)
- 🎮 **Gaming** (Steam, Lutris, Heroic, with AMD optimizations)
- 🎥 **Streaming** (OBS Studio with advanced audio routing)
- 💼 **Content Creation** (Video editing, graphic design)

### Design Philosophy

This setup draws inspiration from two excellent configurations:
- **JaKooLit** - Beautiful theming and visual aesthetics
- **Omarchy** - Efficient workflow and functionality

The result is a hybrid system that looks stunning while maintaining productivity-focused workflows.

---

## ✨ Features

### 🎨 Visual & Theming
- **Noctalia Shell** - Beautiful, minimal desktop shell for Wayland
- **Material Design 3** color schemes with Matugen
- **Custom color schemes** - Violet-to-cyan gradient (#8A2BE2 to #00FFFF)
- **Dynamic wallpapers** with automatic color extraction
- **Smooth animations** and transitions
- **Custom SDDM theme** (SugarCandy) with matching aesthetics

### 🚀 Performance & Gaming
- **AMD GPU optimizations** (RX 580)
- **Gamemode** integration with automatic activation
- **FSYNC & Vulkan** optimizations
- **ZRAM** configuration for better memory management
- **CoreCtrl & LACT** for GPU control and monitoring
- **Fan control** setup for optimal cooling

### 🎵 Audio & Multimedia
- **PipeWire** with advanced routing capabilities
- **qpwgraph** for visual audio routing (like Voicemeter)
- **EasyEffects** for audio processing
- **J.A.R.V.I.S. sound pack** integration for system events
- **OBS Studio** with VAAPI and VKCapture support

### 🛠️ Productivity
- **Modular Hyprland configs** - Easy to navigate and customize
- **Custom keybindings** with webapp support
- **Quickshell widgets** for work and gaming
- **Auto-generated keybind cheatsheet**
- **Welcome app** with setup guidance
- **Settings app** for easy configuration

### 🌐 WebApps Integration
Pre-configured webapp launchers for:
- YouTube
- Twitch
- Instagram
- Discord Web
- AI Chat interfaces

---

## 💻 System Specifications

### Hardware
- **CPU**: Intel i5-4430 (Haswell, 4 cores/4 threads, 3.0-3.2 GHz)
- **GPU**: AMD RX 580 (8GB VRAM)
- **RAM**: 16GB DDR3
- **Storage**: 
  - 120GB SSD (Arch Linux)
  - 120GB SSD (Windows dual-boot)
  - 1TB SSD (Games & Files - `/run/media/wehttamsnaps/LINUXDRIVE-1`)
- **PSU**: 750W
- **Monitor**: Single 1920x1080 (DP-3)

### System Info
- **Username**: wehttamsnaps
- **Hostname**: snaps-pc
- **Timezone**: America/Chicago
- **Locale**: en_US.UTF-8

---

## 📦 Installation

### Prerequisites

Before installing, ensure you have a working Arch Linux installation with internet connectivity.

### Quick Install

```bash
# Clone the repository
git clone https://github.com/Crowdrocker/Hypr-Snaps.git
cd Hypr-Snaps

# Run the installation script
chmod +x scripts/install/install.sh
./scripts/install/install.sh
```

### Manual Installation

For step-by-step manual installation, see [Installation Guide](docs/guides/INSTALLATION.md).

---

## ⚙️ Configuration

### Directory Structure

```
~/.config/
├── hypr/                    # Hyprland configuration
│   ├── hyprland.conf       # Main config (sources others)
│   ├── keybinds.conf       # Keybindings
│   ├── windowrules.conf    # Window rules
│   ├── monitors.conf       # Monitor configuration
│   ├── startup.conf        # Autostart applications
│   └── env.conf            # Environment variables
├── noctalia/               # Noctalia shell configuration
├── ghostty/                # Ghostty terminal config
├── fastfetch/              # Fastfetch with custom logo
└── obs-studio/             # OBS configuration
```

### Key Configuration Files

- **Hyprland**: `~/.config/hypr/hyprland.conf`
- **Noctalia**: `~/.config/noctalia/`
- **Terminal**: `~/.config/ghostty/config`
- **Shell**: `~/.zshrc` or `~/.bashrc`

For detailed configuration options, see [Configuration Guide](docs/guides/CONFIGURATION.md).

---

## ⌨️ Keybindings

### Core Shortcuts

| Keybind | Action |
|---------|--------|
| `SUPER + SPACE` | Application Launcher |
| `SUPER + S` | Control Center |
| `SUPER + COMMA` | Settings |
| `SUPER + ENTER` | Terminal (Ghostty) |
| `SUPER + B` | Browser |
| `SUPER + Q` | Close Window |
| `SUPER + L` | Lock Screen |

### Noctalia Shell

| Keybind | Action |
|---------|--------|
| `SUPER + V` | Clipboard History |
| `SUPER + C` | Calculator |
| `SUPER + CTRL + SPACE` | Cycle Wallpapers |

### Gaming & Streaming

| Keybind | Action |
|---------|--------|
| `SUPER + G` | Gaming Mode Toggle |
| `SUPER + SHIFT + S` | Screenshot |
| `SUPER + SHIFT + R` | Screen Recording |

### WebApps

| Keybind | Action |
|---------|--------|
| `SUPER + W + Y` | YouTube |
| `SUPER + W + T` | Twitch |
| `SUPER + W + I` | Instagram |
| `SUPER + W + D` | Discord Web |

For complete keybinding reference, see [Keybindings Guide](docs/references/KEYBINDINGS.md).

---

## 🎮 Gaming Setup

### Supported Games

This setup includes optimized launch options for:

- Call of Duty HQ
- Cyberpunk 2077
- Fallout 4
- Far Cry 5
- Ghost Recon Breakpoint
- Marvel's Avengers
- Need for Speed Payback
- Rise of the Tomb Raider
- Shadow of the Tomb Raider
- The First Descendant
- Tom Clancy's The Division
- Tom Clancy's The Division 2
- Warframe
- Watch Dogs series

### Gaming Optimizations

- **Gamemode** - Automatic activation when games launch
- **AMD GPU optimizations** - RADV drivers with ACO compiler
- **Vulkan** - Latest Mesa drivers
- **DXVK** - DirectX to Vulkan translation
- **Proton GE** - Latest compatibility layer
- **Steam Tinker Launch** - For modding support

### Game Modding

- **Nexus Mods App** - Official Linux app for mod management
- **Steam Tinker Launch** - Vortex/MO2 integration
- **Mod Organizer 2** - Via Wine/Proton

For detailed gaming setup, see [Gaming Guide](docs/guides/GAMING.md).

---

## 🎥 Streaming Setup

### OBS Studio Configuration

- **VAAPI encoding** for AMD GPU
- **VKCapture** for game capture
- **PipeWire integration** for audio
- **Advanced audio routing** with qpwgraph

### Audio Routing

This setup uses **qpwgraph** to create a Voicemeter-like experience on Linux:

- Separate audio channels for:
  - Game audio
  - Browser audio
  - Discord/communication
  - Spotify/music
  - Microphone input

### Streaming Keybinds

| Keybind | Action |
|---------|--------|
| `SUPER + SHIFT + O` | Start/Stop Streaming |
| `SUPER + SHIFT + R` | Start/Stop Recording |
| `SUPER + SHIFT + M` | Mute Microphone |

For detailed streaming setup, see [Streaming Guide](docs/guides/STREAMING.md).

---

## 🎨 Customization

### Color Schemes

This setup uses Material Design 3 color schemes with Matugen. You can:

1. **Use wallpaper colors** - Automatically extract colors from your wallpaper
2. **Use predefined schemes** - Choose from built-in color schemes
3. **Create custom schemes** - Define your own color palette

### Creating Custom Widgets

Noctalia Shell makes it easy to create custom widgets. See [Widget Creation Guide](docs/guides/WIDGETS.md).

### Custom Matugen Templates

Create templates for any application that supports theming. See [Matugen Templates Guide](docs/guides/MATUGEN.md).

---

## 🐛 Troubleshooting

### Common Issues

#### Hyprland won't start
```bash
# Check logs
cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log

# Verify installation
hyprctl version
```

#### Audio not working
```bash
# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse wireplumber

# Check audio devices
wpctl status
```

#### Games not launching
```bash
# Check Proton version
steam

# Verify gamemode
gamemoded -t
```

For more troubleshooting, see [Troubleshooting Guide](docs/guides/TROUBLESHOOTING.md).

---

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

### How to Contribute

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 🙏 Credits

### Inspiration & Resources

- **[JaKooLit](https://github.com/JaKooLit)** - Theming inspiration and visual design
- **[Omarchy](https://github.com/omarchy)** - Workflow and functionality concepts
- **[Noctalia](https://github.com/noctalia-dev/noctalia-shell)** - Beautiful Wayland shell
- **[Hyprland](https://hyprland.org/)** - Amazing Wayland compositor

### Tools & Technologies

- Arch Linux
- Hyprland
- Noctalia Shell
- Quickshell
- PipeWire
- Matugen
- And many more amazing open-source projects!

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📞 Contact & Support

- **GitHub**: [@Crowdrocker](https://github.com/Crowdrocker)
- **Twitch**: [WehttamSnaps](https://twitch.tv/WehttamSnaps)
- **YouTube**: [WehttamSnaps](https://youtube.com/@WehttamSnaps)
- **Discord**: [Join our community](https://discord.gg/nTaknDvdUA)

---

<div align="center">

**Made with ❤️ by Matthew (WehttamSnaps)**

*If you find this setup helpful, consider giving it a ⭐ on GitHub!*

</div>