
<h3 align="center">
  <img src="https://github.com/JaKooLit/Telegram-Animated-Emojis/blob/main/Activity/Sparkles.webp" alt="Sparkles" width="38" height="38" />
  # 🎬 Snaps-Dots - WehttamSnaps J.A.R.V.I.S. Configuration
  <img src="https://github.com/JaKooLit/Telegram-Animated-Emojis/blob/main/Activity/Sparkles.webp" alt="Sparkles" width="38" height="38" />
</h3>

<h3 align="center">
<img align="center" width="80%" src=https://raw.githubusercontent.com/Crowdrocker/Snaps-Dots/main/assets/github-header.png />
</h3>

<p align="center">
  <img src="https://raw.githubusercontent.com/JaKooLit/Hyprland-Dots/main/assets/latte.png" width="400" />
</p>

<div align="center">
  
[![Twitch](https://img.shields.io/badge/Twitch-WehttamSnaps-9146FF?style=for-the-badge&logo=twitch)](https://www.twitch.tv/wehttamsnaps)
[![YouTube](https://img.shields.io/badge/YouTube-WehttamSnaps-FF0000?style=for-the-badge&logo=youtube)](https://www.youtube.com/@WehttamSnaps)
[![GitHub](https://img.shields.io/badge/GitHub-Crowdrocker-181717?style=for-the-badge&logo=github)](https://github.com/Crowdrocker)

</div>

</div><br>

<div align="center">

![GitHub Repo stars](https://img.shields.io/github/stars/Crowdrocker/Hypr-Snaps?style=for-the-badge&color=cba6f7) ![GitHub last commit](https://img.shields.io/github/last-commit/Crowdrocker/Hypr-Snaps?style=for-the-badge&color=b4befe) ![GitHub repo size](https://img.shields.io/github/repo-size/Crowdrocker/Hypr-Snaps?style=for-the-badge&color=cba6f7) <a href="https://discord.gg/9bAVTCNZ"> <img src="https://img.shields.io/discord/1151869464405606400?style=for-the-badge&logo=discord&color=cba6f7&link=https%3A%2F%2Fdiscord.gg%9bAVTCNZ"> </a>

<br/>
</div>


![WehttamSnaps Logo](screenshots/logo.png)

**A complete Arch Linux Hyprland configuration for Photography • Gaming • Streaming**

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-00D9FF?logo=wayland&logoColor=white)](https://hyprland.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

*Matthew's (WehttamSnaps) complete workstation setup with J.A.R.V.I.S. theming*

[🚀 Quick Install](#-quick-installation) • [📸 Screenshots](#-screenshots) • [⌨️ Keybinds](#-keybindings) • [🎮 Gaming](#-gaming-setup) • [🎵 Audio](#-audio-setup)

</div>

---

## 🌟 Features

### 🎨 **Visual Design**
- **J.A.R.V.I.S. inspired theme** with violet-to-cyan gradients
- **Custom Waybar** with brand colors and animations
- **Smooth animations** and blur effects
- **TokyoNight terminal** theme
- **Sugar Candy SDDM** login theme

### 🎮 **Gaming Optimized**
- **AMD RX 580 optimizations** (RADV, SAM, DXVK Async)
- **GameMode integration** with audio notifications
- **Steam/Lutris ready** with optimized launch options
- **MangoHUD** performance overlay
- **SteamTinkerLaunch** for mod support

### 📸 **Creative Workflow**
- **Photography suite**: GIMP, RAW processors, Krita
- **Vector graphics**: Inkscape with custom shortcuts
- **File organization** for WehttamSnaps brand projects
- **Color-coded workspaces** for different tasks

### 🎵 **Pro Audio**
- **PipeWire** with advanced routing (VoiceMeeter alternative)
- **Separate audio streams** for gaming, Discord, streaming
- **Visual audio patching** with Helvum
- **OBS integration** with virtual sinks
- **Noise suppression** for streaming

### 🤖 **J.A.R.V.I.S. Integration**
- **Custom sound pack** with character voice lines
- **Smart notifications** for system events
- **Gaming mode announcements**
- **Temperature warnings** with themed alerts

---

## 📋 System Requirements

| Component | Requirement | Status |
|-----------|-------------|--------|
| **OS** | Arch Linux | ✅ |
| **DE** | Hyprland | ✅ |
| **GPU** | AMD RX 580 (or similar) | ✅ |
| **RAM** | 8GB+ (16GB recommended) | ✅ |
| **Storage** | 20GB+ free space | ✅ |

---

## 🚀 Quick Installation

### Method 1: Automated Setup (Recommended)
```bash
# Clone the repository
git clone https://github.com/Crowdrocker/Snaps-Dots.git
cd Snaps-Dots

# Run the installer
chmod +x install.sh
./install.sh
```

### Method 2: Manual Installation
```bash
# Install dependencies
sudo pacman -S hyprland waybar kitty thunar

# Copy configurations
cp -r configs/* ~/.config/

# Install custom scripts
cp -r scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*

# Set up themes
cp -r themes/* ~/.local/share/themes/
```

---

## 📸 Screenshots

<details>
<summary>Click to expand screenshots</summary>

### Desktop Overview
![Desktop](screenshots/desktop.png)

### Gaming Setup
![Gaming](screenshots/gaming.png)

### Creative Workflow
![Creative](screenshots/creative.png)

### Audio Routing
![Audio](screenshots/audio-routing.png)

### Terminal
![Terminal](screenshots/terminal.png)

</details>

---

## ⌨️ Keybindings

### 🖥️ System Control
| Shortcut | Action |
|----------|--------|
| `Super + Return` | Terminal (Kitty) |
| `Super + E` | File Manager |
| `Super + R` | App Launcher |
| `Super + Q` | Close Window |
| `Super + Shift + Q` | Exit Hyprland |

### 🎮 Gaming
| Shortcut | Action |
|----------|--------|
| `Super + G` | Steam |
| `Super + Shift + G` | Lutris |
| `Super + Ctrl + G` | Gaming Mode Toggle |
| `Super + H` | Heroic Games |

### 📸 Creative
| Shortcut | Action |
|----------|--------|
| `Super + I` | Inkscape |
| `Super + Shift + I` | GIMP |
| `Super + Ctrl + I` | Krita |
| `Super + B` | Blender |

### 🎥 Streaming
| Shortcut | Action |
|----------|--------|
| `Super + O` | OBS Studio |
| `Super + Shift + O` | Streaming Mode |
| `Super + M` | Audio Mixer |

### 🖼️ Screenshots
| Shortcut | Action |
|----------|--------|
| `Print` | Full Screenshot |
| `Super + Print` | Area Screenshot |
| `Super + Shift + S` | Screen Recording |

---

## 🎮 Gaming Setup

### Steam Configuration
1. **Enable Proton for all titles**
2. **Add launch options**:
   ```bash
   # For most games
   gamemoderun mangohud RADV_PERFTEST=sam %command%
   
   # For Proton games  
   gamemoderun mangohud DXVK_ASYNC=1 RADV_PERFTEST=sam %command%
   ```

### Lutris Setup
- **DXVK Async**: Enabled
- **RADV optimizations**: Active
- **Esync/Fsync**: Enabled
- **GameMode**: Auto-activation

### Performance Tips
- **AMD RX 580**: Optimized RADV drivers
- **Temperature monitoring**: Automatic warnings
- **Fan control**: CoreCtrl integration
- **Memory**: ZRAM configuration

---

## 🎵 Audio Setup

### PipeWire Configuration
The setup includes advanced audio routing similar to VoiceMeeter:

```bash
# Available virtual sinks
- Games Audio (for gaming sounds)
- Discord Audio (voice chat)
- Spotify Audio (music)
- Browser Audio (web content)
```

### Visual Audio Routing
- **Helvum**: Easy drag-and-drop connections
- **qpwgraph**: Advanced routing control
- **pavucontrol**: Traditional mixer interface

### Streaming Integration
- **OBS ready**: Pre-configured audio sources
- **Noise suppression**: Real-time processing
- **Multiple outputs**: Hardware + virtual routing

---

## 📁 File Structure

```
Snaps-Dots/
├── configs/
│   ├── hypr/           # Hyprland configuration
│   ├── waybar/         # Status bar themes
│   ├── kitty/          # Terminal configuration
│   ├── fuzzel/         # App launcher
│   └── ...
├── scripts/
│   ├── install.sh      # Main installer
│   ├── jarvis-sound    # Sound system
│   ├── gaming-mode     # Gaming optimizations
│   └── ...
├── wallpapers/         # WehttamSnaps branded wallpapers
├── sounds/             # J.A.R.V.I.S. sound pack
├── themes/             # GTK/Qt themes
└── screenshots/        # Setup screenshots
```

---

## 🛠️ Customization

### Brand Colors
```css
/* WehttamSnaps Color Palette */
--primary: #8A2BE2;    /* Blue Violet */
--secondary: #00FFFF;  /* Cyan */
--accent: #0066CC;     /* Deep Blue */
--highlight: #FF69B4;  /* Hot Pink */
```

### Wallpapers
Custom gradient wallpapers are auto-generated using your brand colors. Add your own to `wallpapers/` directory.

### Sounds
Replace J.A.R.V.I.S. sounds in `sounds/jarvis/` with your own audio files.

---

## 🆘 Troubleshooting

### Common Issues

<details>
<summary>Hyprland won't start</summary>

```bash
# Check logs
journalctl --user -u hyprland

# Reset configuration
cp configs/hypr/hyprland.conf ~/.config/hypr/
```
</details>

<details>
<summary>Audio not working</summary>

```bash
# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse

# Run audio setup
./scripts/setup-audio-routing
```
</details>

<details>
<summary>Gaming performance issues</summary>

```bash
# Check GameMode status
gamemoderun --help

# Verify GPU drivers
lspci -k | grep -A 3 VGA

# Monitor temperatures
sensors
```
</details>

---

## 🤝 Contributing

Contributions are welcome! Whether it's:
- 🐛 **Bug fixes**
- ✨ **New features**  
- 📚 **Documentation improvements**
- 🎨 **Theme variations**

### How to Contribute
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **JaKooLit** - Base Hyprland configuration inspiration
- **Hyprland Community** - Amazing window manager
- **Arch Linux** - The foundation of it all
- **AMD** - Great open-source GPU drivers

---

## 📞 Contact

- **GitHub**: [@Crowdrocker](https://github.com/Crowdrocker)
- **Twitch**: [WehttamSnaps](https://twitch.tv/wehttamsnaps)
- **YouTube**: [WehttamSnaps](https://youtube.com/@wehttamsnaps)

---

<div align="center">
  
**⭐ Star this repo if you found it helpful!**

*Built with ❤️ for the Linux community*

</div>
## 🫰	Thank you for the stars 🩷
## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Crowdrocker/Hypr-Snaps.git&type=Date)](https://www.star-history.com/#Crowdrocker/Hypr-Snaps.git&Date)
