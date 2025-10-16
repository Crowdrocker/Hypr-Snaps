# 📦 Package List

```
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
```

> Complete package list for WehttamSnaps Hyprland Setup

---

## 🎯 Essential Packages

These packages are required for the core functionality of the setup.

### Hyprland & Wayland Core

```bash
hyprland
hyprpaper
hyprlock
hypridle
hyprpicker
hyprshot
xdg-desktop-portal-hyprland
qt5-wayland
qt6-wayland
```

### Noctalia Shell

```bash
quickshell
noctalia-shell
ttf-roboto
inter-font
gpu-screen-recorder
brightnessctl
matugen-git
```

### Terminal & Shell

```bash
ghostty
zsh
zsh-autosuggestions
zsh-syntax-highlighting
zsh-completions
starship
fastfetch
```

### Audio (PipeWire)

```bash
pipewire
pipewire-alsa
pipewire-pulse
pipewire-jack
wireplumber
pavucontrol
qpwgraph
```

### File Management

```bash
thunar
thunar-archive-plugin
thunar-volman
gvfs
gvfs-mtp
gvfs-smb
```

### System Utilities

```bash
polkit-gnome
dunst
cliphist
wl-clipboard
grim
slurp
rofi
fuzzel
```

### Theming

```bash
gtk-engine-murrine
lxappearance
qt5ct
qt6ct
kvantum
papirus-icon-theme
```

---

## 🎮 Gaming Packages

### Gaming Essentials

```bash
steam
gamemode
gamescope
mangohud
```

### Game Launchers

```bash
lutris
heroic-games-launcher-bin
```

### Proton & Compatibility

```bash
proton-ge-custom-bin
wine-staging
winetricks
dxvk-bin
vkd3d
```

### AMD GPU Support

```bash
mesa
lib32-mesa
vulkan-radeon
lib32-vulkan-radeon
amdvlk
lib32-amdvlk
vulkan-mesa-layers
```

### GPU Control & Monitoring

```bash
corectrl
lact
nvtop
radeontop
```

### Game Modding

```bash
steamtinkerlaunch
```

---

## 📸 Photography & Creative

### Photo Editing

```bash
gimp
krita
inkscape
darktable
rawtherapee
```

### Video Editing

```bash
kdenlive
obs-studio
obs-vaapi
obs-vkcapture
```

### 3D & Design

```bash
blender
```

---

## 🌐 Browsers & Communication

### Browsers

```bash
firefox
chromium
```

### Communication

```bash
discord
telegram-desktop
signal-desktop
```

### Media

```bash
spotify-launcher
mpv
vlc
```

---

## 💻 Development (Optional)

```bash
code
neovim
github-desktop-plus-bin
docker
docker-compose
git
```

---

## 🛠️ System Tools (Optional)

### Monitoring

```bash
btop
htop
mission-center
```

### Utilities

```bash
ranger
yazi
bat
eza
fd
ripgrep
fzf
```

---

## ❌ Packages to Remove/Review

These packages from your original list may not be necessary:

### Duplicate/Alternative Terminals
- `alacritty` (using ghostty)
- `kitty` (using ghostty)
- `foot` (using ghostty)
- `konsole` (using ghostty)
- `xfce4-terminal` (using ghostty)

### Duplicate File Managers
- `dolphin` (using thunar)
- `nautilus` (using thunar)

### Duplicate Bars/Shells
- `waybar` (using noctalia-shell)
- `eww` (using noctalia-shell)
- `nwg-drawer` (using noctalia-shell launcher)
- `nwg-launchers` (using noctalia-shell launcher)
- `wofi` (using noctalia-shell launcher)

### Duplicate Lock Screens
- `swaylock-effects` (using hyprlock)
- `gtklock` (using hyprlock)

### Duplicate Wallpaper Managers
- `swaybg` (using hyprpaper)
- `azote` (using noctalia wallpaper selector)
- `waypaper` (using noctalia wallpaper selector)

### Duplicate Notification Daemons
- `mako` (using dunst)
- `swaync` (using dunst)

### Unnecessary Window Managers
- `awesome-terminal-fonts` (not using awesome)

### Duplicate System Monitors
- `gnome-system-monitor` (using mission-center)
- `glances` (using btop)

### Duplicate Package Managers
- `octopi` (using paru)
- `pacseek` (using paru)
- `trizen` (using paru)
- `yay-bin` (using paru)

### Duplicate Themes
- Multiple GTK themes (choose 1-2 favorites)
- Multiple icon themes (using papirus)

### Unused Services
- `chrony` (if using systemd-timesyncd)
- `ntp` (if using systemd-timesyncd)

---

## 📋 Installation Commands

### Minimal Install (Core Only)

```bash
paru -S hyprland hyprpaper hyprlock hypridle hyprpicker hyprshot \
        xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
        quickshell noctalia-shell ttf-roboto inter-font \
        gpu-screen-recorder brightnessctl matugen-git \
        ghostty zsh zsh-autosuggestions zsh-syntax-highlighting \
        zsh-completions starship fastfetch \
        pipewire pipewire-alsa pipewire-pulse pipewire-jack \
        wireplumber pavucontrol qpwgraph \
        thunar thunar-archive-plugin thunar-volman \
        gvfs gvfs-mtp gvfs-smb \
        polkit-gnome dunst cliphist wl-clipboard \
        grim slurp rofi fuzzel \
        gtk-engine-murrine lxappearance qt5ct qt6ct \
        kvantum papirus-icon-theme
```

### Gaming Add-on

```bash
paru -S steam gamemode gamescope mangohud \
        lutris heroic-games-launcher-bin \
        proton-ge-custom-bin wine-staging winetricks \
        dxvk-bin vkd3d \
        mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
        amdvlk lib32-amdvlk vulkan-mesa-layers \
        corectrl lact nvtop radeontop \
        steamtinkerlaunch
```

### Photography Add-on

```bash
paru -S gimp krita inkscape darktable rawtherapee \
        kdenlive obs-studio obs-vaapi obs-vkcapture \
        blender
```

### Full Install (Everything)

```bash
# Run the installation script
./scripts/install/install.sh
```

---

## 🔄 Package Maintenance

### Update All Packages

```bash
paru -Syu
```

### Clean Package Cache

```bash
paru -Sc
```

### Remove Orphaned Packages

```bash
paru -Rns $(paru -Qtdq)
```

### List Explicitly Installed Packages

```bash
paru -Qe
```

---

<div align="center">

**Keep your system lean and efficient! 🚀**

[← Back to README](../../README.md)

</div>