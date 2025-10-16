# 🚀 Quick Start Guide

```
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
```

> Get up and running in minutes!

---

## ⚡ Installation (5 minutes)

### 1. Clone the Repository

```bash
git clone https://github.com/Crowdrocker/Hypr-Snaps.git
cd Hypr-Snaps
```

### 2. Run the Installer

```bash
chmod +x scripts/install/install.sh
./scripts/install/install.sh
```

### 3. Choose Installation Type

- **1. Minimal** - Core system only (~2GB)
- **2. Gaming** - Core + Gaming packages (~8GB)
- **3. Photography** - Core + Creative packages (~5GB)
- **4. Full** - Everything (~12GB)

### 4. Reboot

```bash
sudo reboot
```

### 5. Select Hyprland

At the login screen, select **Hyprland** from the session menu.

---

## 🎯 Essential Keybindings

### Must Know

| Keybind | Action |
|---------|--------|
| `SUPER + SPACE` | Application Launcher |
| `SUPER + ENTER` | Terminal |
| `SUPER + Q` | Close Window |
| `SUPER + B` | Browser |
| `SUPER + F` | File Manager |

### Navigation

| Keybind | Action |
|---------|--------|
| `SUPER + 1-9` | Switch Workspace |
| `SUPER + LEFT/RIGHT` | Focus Window |
| `SUPER + SHIFT + LEFT/RIGHT` | Move Window |

### Gaming

| Keybind | Action |
|---------|--------|
| `SUPER + G` | Toggle Gaming Mode |
| `SUPER + G + S` | Launch Steam |

### WebApps

| Keybind | Action |
|---------|--------|
| `SUPER + W + Y` | YouTube |
| `SUPER + W + T` | Twitch |
| `SUPER + W + I` | Instagram |

---

## 📁 Important Files

### Configuration

```bash
~/.config/hypr/hyprland.conf    # Main config
~/.config/hypr/keybinds.conf    # Keybindings
~/.config/hypr/windowrules.conf # Window rules
```

### Edit Configs

```bash
# Edit main config
nvim ~/.config/hypr/hyprland.conf

# Edit keybindings
nvim ~/.config/hypr/keybinds.conf

# Reload Hyprland
hyprctl reload
```

---

## 🎮 Gaming Setup

### Enable Gaming Mode

```bash
SUPER + G
```

This activates:
- Gamemode for performance
- GPU performance profile
- J.A.R.V.I.S. sound effect

### Launch Games

```bash
SUPER + G + S  # Steam
SUPER + G + L  # Lutris
SUPER + G + H  # Heroic
```

---

## 🎨 Customization

### Change Wallpaper

```bash
SUPER + CTRL + SPACE  # Random wallpaper
SUPER + CTRL + W      # Wallpaper selector
```

### Toggle Dark Mode

```bash
SUPER + CTRL + D
```

### Change Colors

Edit `~/.config/hypr/hyprland.conf`:

```bash
col.active_border = rgba(8A2BE2ee) rgba(00FFFFee) 45deg
```

---

## 🔧 Common Tasks

### Update System

```bash
paru -Syu
```

### Install Package

```bash
paru -S package-name
```

### Check GPU

```bash
radeontop  # Monitor GPU
nvtop      # Alternative
```

### Audio Issues

```bash
# Restart audio
systemctl --user restart pipewire pipewire-pulse wireplumber

# Check devices
wpctl status
```

---

## 📚 Learn More

- **Full Documentation**: [README.md](README.md)
- **Installation Guide**: [docs/guides/INSTALLATION.md](docs/guides/INSTALLATION.md)
- **Keybindings**: [docs/references/KEYBINDINGS.md](docs/references/KEYBINDINGS.md)
- **Gaming Guide**: [docs/guides/GAMING.md](docs/guides/GAMING.md)

---

## 🆘 Need Help?

1. Check the [documentation](README.md)
2. Open an [issue](https://github.com/Crowdrocker/Hypr-Snaps/issues)
3. Join the [Discord](https://discord.gg/nTaknDvdUA)

---

## 🎉 You're Ready!

Your WehttamSnaps Hyprland setup is ready to use. Enjoy! 🚀

---

<div align="center">

**Made with ❤️ by Matthew (WehttamSnaps)**

[GitHub](https://github.com/Crowdrocker) • [Twitch](https://twitch.tv/WehttamSnaps) • [YouTube](https://youtube.com/@WehttamSnaps)

</div>