# Noctalia Shell Guide - WehttamSnaps Hyprland Setup

> Complete guide to using and customizing Noctalia shell in WehttamSnaps Hyprland configuration

## 📋 Overview

Noctalia is a modern Quickshell-based shell that replaces traditional status bars like Waybar. It provides a beautiful, customizable interface with Material Design 3 theming and dynamic color generation.

### Key Features
- 🎨 Material Design 3 theming
- 🌈 Dynamic color generation from wallpapers
- 🧩 Modular widget system
- ⚡ Fast and lightweight
- 🎯 IPC control for scripting

## 🚀 Getting Started

### Basic Usage

Noctalia starts automatically with Hyprland. You can interact with it using:

**Keyboard Shortcuts:**
- `SUPER + SPACE` - Toggle launcher
- `SUPER + C` - Toggle control center
- `SUPER + COMMA` - Open settings
- `SUPER + V` - Clipboard history
- `SUPER + SHIFT + C` - Calculator

**IPC Commands:**
```bash
# Toggle launcher
qs -c noctalia-shell ipc call launcher toggle

# Toggle control center
qs -c noctalia-shell ipc call controlCenter toggle

# Open settings
qs -c noctalia-shell ipc call settings toggle
```

## 🎨 Theming

### Color Schemes

Noctalia supports two color generation modes:

#### 1. Wallpaper-Based Colors (Dynamic)
Colors are automatically generated from your wallpaper using Matugen:

```bash
# Enable wallpaper colors in settings
SUPER + COMMA → Color Scheme → Use Wallpaper Colors

# Change wallpaper to update colors
SUPER + W  # Select wallpaper
SUPER + CTRL + SPACE  # Random wallpaper
```

#### 2. Predefined Color Schemes
Choose from curated color schemes:

Available schemes:
- **Tokyonight** - Dark, vibrant theme
- **Nord** - Cool, minimal theme
- **Catppuccin** - Pastel, soothing theme
- **Dracula** - Dark, high contrast
- **Gruvbox** - Warm, retro theme
- **Monokai** - Classic coding theme

To change:
```bash
SUPER + COMMA → Color Scheme → Predefined Schemes
```

### Dark/Light Mode

Toggle between dark and light themes:

```bash
# Toggle dark mode
qs -c noctalia-shell ipc call darkMode toggle

# Set dark mode
qs -c noctalia-shell ipc call darkMode setDark

# Set light mode
qs -c noctalia-shell ipc call darkMode setLight
```

Keyboard shortcut:
```bash
SUPER + SHIFT + T  # Toggle dark/light mode
```

## 🧩 Widgets

### Available Widgets

Noctalia comes with several built-in widgets:

1. **Clock** - Time and date display
2. **System Tray** - System icons
3. **Workspaces** - Workspace indicator
4. **Volume** - Audio control
5. **Brightness** - Screen brightness
6. **Battery** - Battery status (laptops)
7. **Network** - Network status
8. **Bluetooth** - Bluetooth control
9. **Media Player** - Music controls
10. **Notifications** - Notification indicator

### Managing Widgets

**Add/Remove Widgets:**
```bash
SUPER + COMMA → Bar → Widgets Positioning
```

1. Select section (Left/Center/Right)
2. Click "Add" to add a widget
3. Drag to reorder
4. Click gear icon to configure
5. Click X to remove

### Creating Custom Widgets

See the Noctalia documentation for creating custom widgets:

```bash
~/.config/quickshell/noctalia-shell/widgets/
```

Example widget structure:
```
widgets/
├── MyWidget/
│   ├── MyWidget.qml
│   ├── manifest.json
│   └── style.css
```

## 🎛️ Control Center

The control center provides quick access to system controls:

**Open Control Center:**
```bash
SUPER + C
```

**Features:**
- Volume control
- Brightness control
- Network management
- Bluetooth management
- Power profiles
- Night light
- Do Not Disturb
- Screen recording

## 🔔 Notifications

### Notification Center

View and manage notifications:

```bash
# Toggle notification history
SUPER + N
qs -c noctalia-shell ipc call notifications toggleHistory

# Toggle Do Not Disturb
SUPER + SHIFT + N
qs -c noctalia-shell ipc call notifications toggleDND

# Clear all notifications
SUPER + CTRL + N
qs -c noctalia-shell ipc call notifications clear
```

### Notification Settings

Configure notifications:
```bash
SUPER + COMMA → Notifications
```

Options:
- Enable/disable notifications
- Do Not Disturb schedule
- Notification timeout
- Sound settings
- Position on screen

## 🔊 Audio Control

### Volume Control

**IPC Commands:**
```bash
# Increase volume
qs -c noctalia-shell ipc call volume increase

# Decrease volume
qs -c noctalia-shell ipc call volume decrease

# Mute output
qs -c noctalia-shell ipc call volume muteOutput

# Increase input (mic) volume
qs -c noctalia-shell ipc call volume increaseInput

# Decrease input (mic) volume
qs -c noctalia-shell ipc call volume decreaseInput

# Mute input (mic)
qs -c noctalia-shell ipc call volume muteInput
```

**Keyboard Shortcuts:**
```bash
# Volume
XF86AudioRaiseVolume  # Volume up
XF86AudioLowerVolume  # Volume down
XF86AudioMute         # Mute

# Alternative
SUPER + =  # Volume up
SUPER + -  # Volume down
SUPER + M  # Mute

# Microphone
SUPER + SHIFT + =  # Mic volume up
SUPER + SHIFT + -  # Mic volume down
SUPER + SHIFT + M  # Mute mic
```

## 💡 Brightness Control

### Screen Brightness

**IPC Commands:**
```bash
# Increase brightness
qs -c noctalia-shell ipc call brightness increase

# Decrease brightness
qs -c noctalia-shell ipc call brightness decrease
```

**Keyboard Shortcuts:**
```bash
XF86MonBrightnessUp    # Brightness up
XF86MonBrightnessDown  # Brightness down

# Alternative
SUPER + ]  # Brightness up
SUPER + [  # Brightness down
```

## 🖼️ Wallpaper Management

### Wallpaper Selector

**IPC Commands:**
```bash
# Toggle wallpaper selector
qs -c noctalia-shell ipc call wallpaper toggle

# Set specific wallpaper
qs -c noctalia-shell ipc call wallpaper set /path/to/image.jpg monitor-name

# Random wallpaper
qs -c noctalia-shell ipc call wallpaper random

# Toggle automation
qs -c noctalia-shell ipc call wallpaper toggleAutomation

# Enable automation
qs -c noctalia-shell ipc call wallpaper enableAutomation

# Disable automation
qs -c noctalia-shell ipc call wallpaper disableAutomation
```

**Keyboard Shortcuts:**
```bash
SUPER + W           # Wallpaper selector
SUPER + CTRL + SPACE  # Random wallpaper
```

### Wallpaper Automation

Automatically change wallpapers at intervals:

```bash
SUPER + COMMA → Wallpaper → Automation
```

Options:
- Enable/disable automation
- Change interval (minutes)
- Wallpaper directory
- Transition effects

## 📹 Screen Recording

### Recording Control

**IPC Commands:**
```bash
# Toggle recording
qs -c noctalia-shell ipc call screenRecorder toggle
```

**Keyboard Shortcuts:**
```bash
SUPER + ALT + R  # Toggle recording
SUPER + SHIFT + R  # Region recording
```

**Settings:**
```bash
SUPER + COMMA → Screen Recorder
```

Options:
- Output directory
- Video quality
- Audio source
- Frame rate
- Encoder settings

## 🔒 Lock Screen

### Screen Lock

**IPC Commands:**
```bash
# Toggle lock screen
qs -c noctalia-shell ipc call lockScreen toggle
```

**Keyboard Shortcuts:**
```bash
SUPER + L      # Lock screen
CTRL + ALT + L  # Lock screen (alternative)
```

## 🎮 Idle Inhibitor

Prevent system from going idle:

**IPC Commands:**
```bash
# Toggle idle inhibitor
qs -c noctalia-shell ipc call idleInhibitor toggle
```

**Keyboard Shortcuts:**
```bash
SUPER + I  # Toggle idle inhibitor
```

**Use Cases:**
- Watching videos
- Presentations
- Long downloads
- Gaming

## 📊 Bar Configuration

### Bar Visibility

**IPC Commands:**
```bash
# Toggle bar visibility
qs -c noctalia-shell ipc call bar toggle
```

**Keyboard Shortcuts:**
```bash
SUPER + CTRL + ALT + B  # Toggle bar
```

### Bar Position

Configure bar position:
```bash
SUPER + COMMA → Bar → Position
```

Options:
- Top
- Bottom
- Left (vertical)
- Right (vertical)

### Bar Styling

Customize bar appearance:
```bash
SUPER + COMMA → Bar → Appearance
```

Options:
- Height/width
- Padding
- Margin
- Transparency
- Blur
- Border radius

## 🔧 Advanced Configuration

### Configuration Files

Noctalia configuration is stored in:
```
~/.config/noctalia/
├── config.json       # Main configuration
├── widgets/          # Widget settings
├── themes/           # Custom themes
└── scripts/          # Custom scripts
```

### Cache Files

Cache and temporary files:
```
~/.cache/noctalia/
├── colors/           # Generated colors
├── wallpapers/       # Wallpaper cache
└── logs/             # Log files
```

### Editing Configuration

**Manual Editing:**
```bash
# Edit main config
nano ~/.config/noctalia/config.json

# Edit widget settings
nano ~/.config/noctalia/widgets/widget-name.json
```

**Reset Configuration:**
```bash
# Backup current config
cp -r ~/.config/noctalia ~/.config/noctalia.backup

# Remove config (will regenerate on next start)
rm -rf ~/.config/noctalia

# Restart Noctalia
killall quickshell
qs -c noctalia-shell
```

## 🐛 Troubleshooting

### Common Issues

**Noctalia Not Starting:**
```bash
# Check if running
pgrep -a quickshell

# Start manually
qs -c noctalia-shell

# Check logs
journalctl --user -u noctalia.service
```

**Widgets Not Showing:**
```bash
# Reload Noctalia
killall quickshell
qs -c noctalia-shell

# Check widget configuration
cat ~/.config/noctalia/widgets/widget-name.json
```

**Colors Not Updating:**
```bash
# Regenerate colors
SUPER + COMMA → Color Scheme → Regenerate

# Or via IPC
qs -c noctalia-shell ipc call colorScheme regenerate
```

**Bar Not Visible:**
```bash
# Toggle bar visibility
qs -c noctalia-shell ipc call bar toggle

# Check bar settings
SUPER + COMMA → Bar
```

### Debug Mode

Enable debug logging:
```bash
# Start with debug output
QT_LOGGING_RULES="*.debug=true" qs -c noctalia-shell

# View logs
tail -f ~/.cache/noctalia/logs/noctalia.log
```

## 📚 Additional Resources

### Documentation
- [Noctalia Official Docs](https://noctalia.dev)
- [Quickshell Documentation](https://quickshell.outfoxxed.me)
- [Material Design 3](https://m3.material.io)

### Community
- [GitHub Discussions](https://github.com/Crowdrocker/WehttamSnaps-Hyprland/discussions)
- [Discord Server](#)
- [Reddit Community](#)

### Related Projects
- [Hyprland](https://hyprland.org)
- [Matugen](https://github.com/InioX/matugen)
- [Quickshell](https://github.com/outfoxxed/quickshell)

---

**Master Noctalia for a beautiful, efficient desktop experience! 🎨**

*Made with ❤️ by WehttamSnaps*