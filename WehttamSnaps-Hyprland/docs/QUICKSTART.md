# Quick Start Guide - WehttamSnaps Hyprland Setup

> Get up and running with WehttamSnaps Hyprland in minutes

## 🎯 First Boot

After installation and first login to Hyprland, you'll see:

1. **Welcome Screen** - Introduction and basic info
2. **Noctalia Bar** - Status bar at the top/bottom
3. **Wallpaper** - Default wallpaper applied
4. **J.A.R.V.I.S. Sound** - Startup sound (if enabled)

## ⌨️ Essential Shortcuts

### Must-Know Keybindings

| Key | Action |
|-----|--------|
| `SUPER + H` | **Show this help** |
| `SUPER + ENTER` | Open terminal (Ghostty) |
| `SUPER + D` | Application launcher |
| `SUPER + B` | Open browser |
| `SUPER + Q` | Close window |
| `SUPER + L` | Lock screen |

> **Tip:** Press `SUPER + H` anytime to see all keybindings!

## 🚀 Quick Actions

### Opening Applications

```bash
SUPER + D          # Application launcher (rofi)
SUPER + SPACE      # Noctalia launcher
SUPER + ENTER      # Terminal
SUPER + B          # Browser
SUPER + E          # File manager
```

### Window Management

```bash
SUPER + Q          # Close window
SUPER + F          # Fullscreen
SUPER + SPACEBAR   # Toggle floating
SUPER + 1-9        # Switch workspace
```

### System Controls

```bash
SUPER + L          # Lock screen
SUPER + C          # Control center
SUPER + COMMA      # Settings
```

## 🎨 Customization Basics

### Change Wallpaper

```bash
SUPER + W                # Wallpaper selector
SUPER + CTRL + SPACE     # Random wallpaper
```

### Change Theme

```bash
SUPER + COMMA            # Open settings
# Navigate to Color Scheme tab
# Select your preferred theme
```

### Toggle Dark Mode

```bash
SUPER + SHIFT + T        # Toggle dark/light mode
```

## 🌐 Webapps

Quick access to web applications:

```bash
SUPER + SHIFT + Y        # YouTube
SUPER + SHIFT + T        # Twitch
SUPER + SHIFT + D        # Discord
SUPER + SHIFT + S        # Spotify
```

## 🎮 Gaming Mode

Optimize for gaming:

```bash
SUPER + SHIFT + G        # Toggle gaming mode
```

Gaming mode:
- Disables animations
- Switches to performance profile
- Optimizes resource allocation

## 📸 Screenshots

```bash
PRINT                    # Full screenshot
SUPER + SHIFT + PRINT    # Region screenshot
SUPER + SHIFT + S        # Screenshot with annotation
```

Screenshots are saved to: `~/Pictures/Screenshots/`

## 🔊 Audio Control

```bash
# Volume
XF86AudioRaiseVolume     # Volume up
XF86AudioLowerVolume     # Volume down
XF86AudioMute            # Mute

# Alternative
SUPER + =                # Volume up
SUPER + -                # Volume down
SUPER + M                # Mute
```

## 💡 Brightness

```bash
XF86MonBrightnessUp      # Brightness up
XF86MonBrightnessDown    # Brightness down

# Alternative
SUPER + ]                # Brightness up
SUPER + [                # Brightness down
```

## 🔔 Notifications

```bash
SUPER + N                # Notification center
SUPER + SHIFT + N        # Do Not Disturb
SUPER + CTRL + N         # Clear notifications
```

## 📁 File Management

### Opening Files

```bash
SUPER + E                # File manager (Thunar)
```

### Common Locations

- **Home**: `~` or `/home/username`
- **Documents**: `~/Documents`
- **Pictures**: `~/Pictures`
- **Downloads**: `~/Downloads`
- **Config**: `~/.config`

## 🖥️ Workspaces

### Switching Workspaces

```bash
SUPER + 1-9              # Switch to workspace 1-9
SUPER + CTRL + ←/→       # Cycle workspaces
SUPER + Mouse Scroll     # Scroll through workspaces
```

### Moving Windows

```bash
SUPER + SHIFT + 1-9      # Move window to workspace
```

### Workspace Tips

Organize by task:
- **Workspace 1**: Browser
- **Workspace 2**: Terminal/Development
- **Workspace 3**: Communication (Discord, etc.)
- **Workspace 4**: Media (Music, Videos)
- **Workspace 5**: Gaming

## 🎯 Noctalia Shell

### Control Center

```bash
SUPER + C                # Open control center
```

Features:
- Volume control
- Brightness control
- Network management
- Bluetooth
- Power profiles
- Night light

### Settings

```bash
SUPER + COMMA            # Open settings
```

Configure:
- Color schemes
- Bar widgets
- Notifications
- Wallpapers
- Audio devices

## 🔧 Common Tasks

### Installing Software

```bash
# Open terminal
SUPER + ENTER

# Install package
paru -S package-name

# Search for package
paru -Ss search-term

# Update system
paru -Syu
```

### Updating System

```bash
# Full system update
paru -Syu

# Update AUR packages
paru -Sua
```

### Managing Services

```bash
# Start service
sudo systemctl start service-name

# Enable service (start on boot)
sudo systemctl enable service-name

# Check service status
systemctl status service-name
```

## 📚 Next Steps

### Learn More

1. **Keybindings**: Press `SUPER + H` or read [KEYBINDINGS.md](KEYBINDINGS.md)
2. **Customization**: See [CUSTOMIZATION.md](CUSTOMIZATION.md)
3. **Noctalia**: Read [NOCTALIA.md](NOCTALIA.md)
4. **Troubleshooting**: Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

### Customize Your Setup

1. **Change wallpaper**: `SUPER + W`
2. **Select theme**: `SUPER + COMMA` → Color Scheme
3. **Add widgets**: `SUPER + COMMA` → Bar → Widgets
4. **Configure keybindings**: Edit `~/.config/hypr/conf.d/20-keybinds.conf`

### Join the Community

- **GitHub**: https://github.com/Crowdrocker/WehttamSnaps-Hyprland
- **Twitch**: https://twitch.tv/WehttamSnaps
- **Issues**: Report bugs and request features

## 💡 Pro Tips

### Productivity

1. **Use workspaces** - Organize apps by task
2. **Learn vim keys** - H/J/K/L for window navigation
3. **Master the launcher** - `SUPER + SPACE` for quick access
4. **Use clipboard history** - `SUPER + V` for recent clips

### Performance

1. **Enable gaming mode** - `SUPER + SHIFT + G` when gaming
2. **Close unused apps** - Free up resources
3. **Monitor system** - Use `btop` or `htop` in terminal
4. **Update regularly** - Keep system optimized

### Workflow

1. **Pin important windows** - `SUPER + P` to keep on all workspaces
2. **Use floating windows** - `SUPER + SPACEBAR` for calculators, etc.
3. **Lock screen before AFK** - `SUPER + L`
4. **Use DND mode** - `SUPER + SHIFT + N` when focusing

## 🆘 Quick Troubleshooting

### Something Not Working?

1. **Reload Hyprland**: `SUPER + ALT + R`
2. **Restart Noctalia**: `killall quickshell && qs -c noctalia-shell`
3. **Check logs**: `cat ~/.local/share/hyprland/hyprland.log`
4. **Reboot**: `reboot`

### Common Issues

**Bar not showing:**
```bash
SUPER + CTRL + ALT + B   # Toggle bar visibility
```

**Audio not working:**
```bash
systemctl --user restart pipewire pipewire-pulse wireplumber
```

**Wallpaper not changing:**
```bash
killall swww && swww-daemon
```

## 🎉 You're Ready!

You now know the basics of WehttamSnaps Hyprland setup. Explore, customize, and make it your own!

**Remember:**
- `SUPER + H` - Show keybindings
- `SUPER + COMMA` - Open settings
- `SUPER + C` - Control center

---

**Enjoy your new desktop environment! 🚀**

*Made with ❤️ by WehttamSnaps*