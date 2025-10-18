# WehttamSnaps Hyprland Setup

![WehttamSnaps](https://img.shields.io/badge/WehttamSnaps-Hyprland-blue?style=for-the-badge)
![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-00ADD8?style=for-the-badge)

> A professional Arch Linux Hyprland configuration optimized for photography, gaming, and content creation.

## 🎯 Overview

**WehttamSnaps Hyprland Setup** is a carefully crafted desktop environment that combines the best of multiple worlds:

- **🎨 Jakoolit's Theming** - Beautiful, cohesive visual design
- **⚡ Omarchy's Workflow** - Efficient, productivity-focused features
- **🚀 Noctalia Shell** - Modern Quickshell-based UI (replaces Waybar)
- **💻 Ghostty Terminal** - Fast, GPU-accelerated terminal emulator

### Author Information
- **GitHub**: [@Crowdrocker](https://github.com/Crowdrocker)
- **Twitch/YouTube**: WehttamSnaps
- **Focus**: Photography, Gaming, Streaming

### Hardware Specs
- **CPU**: Intel i5-4430
- **GPU**: AMD RX 580 (recommended for Wayland/Hyprland)
- **Use Case**: Budget build optimized for content creation

## ✨ Features

### Core Components
- 🪟 **Hyprland** - Dynamic tiling Wayland compositor
- 🎨 **Noctalia Shell** - Quickshell-based status bar and widgets
- 🖥️ **Ghostty** - Primary terminal emulator
- 🎭 **Material Design 3** - Color scheme generation via Matugen
- 🌊 **PipeWire** - Advanced audio routing for streaming

### Workflow Features
- 📱 **Webapps Integration** - Quick access to web applications
- 🎮 **Gaming Mode** - Performance optimizations and toggles
- 📸 **Photography Tools** - Optimized for photo editing workflow
- 🎙️ **Streaming Setup** - Audio routing and OBS integration
- 🤖 **J.A.R.V.I.S. Sounds** - Custom audio feedback system

### Customization
- 🎨 Multiple color schemes (Tokyonight, Nord, Catppuccin, etc.)
- 🖼️ Dynamic wallpaper management
- 🔧 Modular configuration system
- 📦 Widget system for easy customization

## 📁 Repository Structure

```
WehttamSnaps-Hyprland/
├── README.md                    # This file
├── logo.txt                     # ASCII branding
├── docs/                        # Documentation
│   ├── INSTALL.md              # Installation guide
│   ├── QUICKSTART.md           # Quick start guide
│   ├── KEYBINDINGS.md          # Keyboard shortcuts
│   ├── CUSTOMIZATION.md        # Customization guide
│   ├── NOCTALIA.md             # Noctalia shell guide
│   └── TROUBLESHOOTING.md      # Common issues
├── configs/                     # Configuration files
│   ├── hyprland/               # Hyprland configs
│   │   ├── hyprland.conf       # Main config
│   │   └── conf.d/             # Modular configs
│   ├── noctalia/               # Noctalia shell
│   │   └── widgets/            # Custom widgets
│   ├── scripts/                # Utility scripts
│   ├── webapps/                # Web application launchers
│   └── sounds/                 # J.A.R.V.I.S. audio files
├── packages/                    # Package lists
│   ├── core.txt                # Essential packages
│   ├── optional.txt            # Optional packages
│   └── aur.txt                 # AUR packages
├── assets/                      # Visual assets
│   ├── wallpapers/             # Wallpaper collection
│   ├── themes/                 # GTK/Qt themes
│   └── images/                 # Icons and images
└── tools/                       # Installation tools
    ├── install.sh              # Main installer
    ├── backup.sh               # Backup script
    └── update.sh               # Update script
```

## 🚀 Quick Start

### Prerequisites
- Fresh Arch Linux installation
- Internet connection
- Basic terminal knowledge

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Crowdrocker/WehttamSnaps-Hyprland.git
   cd WehttamSnaps-Hyprland
   ```

2. **Run the installer**
   ```bash
   chmod +x tools/install.sh
   ./tools/install.sh
   ```

3. **Reboot and enjoy!**
   ```bash
   reboot
   ```

For detailed installation instructions, see [docs/INSTALL.md](docs/INSTALL.md).

## ⌨️ Essential Keybindings

| Key Combination | Action | Description |
|----------------|--------|-------------|
| `SUPER + ENTER` | Terminal | Launch Ghostty terminal |
| `SUPER + D` | Launcher | Application launcher |
| `SUPER + B` | Browser | Open default browser |
| `SUPER + E` | Files | File manager |
| `SUPER + Q` | Close | Close active window |
| `SUPER + H` | Help | Show keybindings |
| `SUPER + C` | Control | Noctalia control center |
| `SUPER + L` | Lock | Lock screen |

For complete keybindings, see [docs/KEYBINDINGS.md](docs/KEYBINDINGS.md).

## 🎨 Customization

### Changing Themes
```bash
# Open Noctalia settings
SUPER + COMMA

# Navigate to Color Scheme tab
# Select your preferred theme
```

### Adding Widgets
```bash
# Open Bar settings
SUPER + COMMA → Bar → Widgets

# Click "Add" and select widget
# Drag to reorder
```

### Wallpaper Management
```bash
# Random wallpaper
SUPER + CTRL + SPACE

# Wallpaper selector
SUPER + W
```

For detailed customization, see [docs/CUSTOMIZATION.md](docs/CUSTOMIZATION.md).

## 🎮 Gaming Mode

Toggle gaming mode for optimal performance:

```bash
SUPER + SHIFT + G
```

Gaming mode:
- Disables animations
- Switches to performance profile
- Optimizes resource allocation
- Plays J.A.R.V.I.S. gaming sound

## 📸 Photography Workflow

Optimized tools for photography:
- **Darktable** - RAW processing
- **GIMP** - Image editing
- **Digikam** - Photo management
- **RawTherapee** - RAW conversion

Quick access via application launcher or custom keybindings.

## 🎙️ Streaming Setup

### Audio Routing
- PipeWire with virtual sinks
- qpwgraph for visual routing
- Per-application audio control
- OBS integration

### OBS Configuration
- Hardware acceleration (VAAPI)
- Optimized encoding settings
- Scene templates included

## 🌐 Webapps

Quick access to web applications:

| Webapp | Keybinding | Description |
|--------|-----------|-------------|
| YouTube | `SUPER + SHIFT + Y` | YouTube in webapp |
| Twitch | `SUPER + SHIFT + T` | Twitch streaming |
| Discord | `SUPER + SHIFT + D` | Discord web client |
| Spotify | `SUPER + SHIFT + S` | Spotify web player |

## 🔧 Noctalia Shell

Noctalia is a modern Quickshell-based shell that replaces Waybar:

### Features
- Material Design 3 theming
- Custom widget system
- Dynamic color generation
- Modular configuration

### IPC Commands
```bash
# Toggle launcher
qs -c noctalia-shell ipc call launcher toggle

# Toggle control center
qs -c noctalia-shell ipc call controlCenter toggle

# Volume control
qs -c noctalia-shell ipc call volume increase
qs -c noctalia-shell ipc call volume decrease
```

For complete Noctalia documentation, see [docs/NOCTALIA.md](docs/NOCTALIA.md).

## 📦 Package Management

### Core Packages
Essential packages for basic functionality (see `packages/core.txt`)

### Optional Packages
Additional tools for enhanced experience (see `packages/optional.txt`)

### AUR Packages
Community packages from AUR (see `packages/aur.txt`)

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📝 Credits & Inspiration

This setup is inspired by and builds upon:

- **[JaKooLit](https://github.com/JaKooLit)** - Theming and visual design
- **[Omarchy](https://github.com/Omarchy)** - Workflow and functionality
- **[Noctalia](https://github.com/noctalia-dev/noctalia-shell)** - Shell implementation

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🐛 Troubleshooting

Having issues? Check out:
- [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)
- [GitHub Issues](https://github.com/Crowdrocker/WehttamSnaps-Hyprland/issues)

## 💬 Support

- **GitHub Issues**: Bug reports and feature requests
- **Discussions**: Questions and community support
- **Twitch**: Live setup and configuration streams

## 🌟 Star History

If you find this setup useful, please consider giving it a star! ⭐

---

**Made with ❤️ by WehttamSnaps**

*Optimized for photography, gaming, and content creation on Arch Linux*