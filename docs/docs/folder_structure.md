# WehttamSnaps Hyprland Setup - Complete Folder Structure

## Repository Structure

```
Hypr-Snaps/
│
├── README.md                          # Main documentation (see artifact above)
├── LICENSE
├── VERSION                            # Current version (e.g., 1.0.0)
├── install.sh                         # Interactive installer
├── logo.txt                           # ASCII art logo
│
├── config/                            # All configuration files
│   ├── hypr/                          # Hyprland configs
│   │   ├── hyprland.conf              # Main config (sources modules)
│   │   ├── logo.txt                   # Branding
│   │   └── modules/                   # Modular configs
│   │       ├── animations.conf        # Animation settings
│   │       ├── autostart.conf         # Startup applications
│   │       ├── binds.conf             # All keybindings
│   │       ├── display.conf           # Monitor settings
│   │       ├── environment.conf       # Environment variables
│   │       ├── gaming.conf            # Gaming optimizations
│   │       ├── windowrules.conf       # Window rules (organized)
│   │       └── workspaces.conf        # Workspace configuration
│   │
│   ├── noctalia/                      # Noctalia shell configs
│   │   ├── custom-widgets/            # Custom Quickshell widgets
│   │   │   ├── WorkLauncher.qml       # Photography apps launcher
│   │   │   ├── GamingLauncher.qml     # Gaming platforms launcher
│   │   │   ├── WebApps.qml            # WebApp shortcuts
│   │   │   └── QuickEditor.qml        # Config editor widget
│   │   ├── themes/                    # Custom Noctalia themes
│   │   │   └── wehttamsnaps.json      # WehttamSnaps color scheme
│   │   └── templates/                 # Matugen templates
│   │       ├── ghostty.conf           # Terminal theme template
│   │       ├── rofi.rasi              # Rofi theme template
│   │       └── dunst.conf             # Dunst theme template
│   │
│   ├── ghostty/                       # Ghostty terminal
│   │   └── config                     # Terminal configuration
│   │
│   ├── rofi/                          # Rofi launcher
│   │   ├── config.rasi                # Main config
│   │   └── themes/
│   │       └── tokyonight.rasi        # Custom theme
│   │
│   ├── fuzzel/                        # Fuzzel launcher
│   │   └── fuzzel.ini
│   │
│   ├── dunst/                         # Notifications
│   │   └── dunstrc                    # With J.A.R.V.I.S. sounds
│   │
│   ├── waybar/                        # Waybar (backup/alternative)
│   │   ├── config
│   │   └── style.css
│   │
│   ├── sddm/                          # Login manager
│   │   └── sugar-candy/
│   │       └── theme.conf             # Themed login screen
│   │
│   ├── grub/                          # Bootloader
│   │   └── custom-theme/
│   │
│   ├── qpwgraph/                      # Audio routing
│   │   └── profiles/
│   │       ├── gaming.qpwgraph
│   │       ├── streaming.qpwgraph
│   │       └── default.qpwgraph
│   │
│   ├── zsh/                           # Zsh shell
│   │   ├── .zshrc
│   │   ├── aliases.zsh                # Useful aliases
│   │   └── wehttamsnaps.zsh-theme     # Custom theme
│   │
│   ├── fastfetch/                     # System info
│   │   └── config.jsonc               # With custom logo
│   │
│   ├── corectrl/                      # GPU control
│   │   └── profiles/
│   │       ├── gaming.profile
│   │       └── default.profile
│   │
│   └── gtk/                           # GTK themes
│       ├── gtk-3.0/
│       │   └── settings.ini
│       └── gtk-4.0/
│           └── settings.ini
│
├── scripts/                           # All automation scripts
│   ├── audio/                         # Audio management
│   │   ├── qpwgraph-setup.sh          # Setup audio routing
│   │   ├── switch-profile.sh          # Switch audio profiles
│   │   └── virtual-sinks.sh           # Create virtual audio devices
│   │
│   ├── gaming/                        # Gaming utilities
│   │   ├── toggle-gamemode.sh         # Enable/disable gaming mode
│   │   ├── gpu-performance.sh         # GPU optimization
│   │   ├── steam-launch-gen.sh        # Generate Steam launch options
│   │   └── proton-setup.sh            # Proton-GE setup
│   │
│   ├── jarvis/                        # J.A.R.V.I.S. integration
│   │   ├── jarvis-startup.sh          # Startup greeting
│   │   ├── jarvis-shutdown.sh         # Shutdown message
│   │   ├── jarvis-gaming.sh           # Gaming mode sound
│   │   ├── jarvis-streaming.sh        # Streaming mode sound
│   │   ├── jarvis-notification.sh     # Custom notifications
│   │   └── jarvis-warning.sh          # System warnings
│   │
│   ├── system/                        # System utilities
│   │   ├── cleanup.sh                 # System cleanup
│   │   ├── update-system.sh           # Update all packages
│   │   ├── backup-config.sh           # Backup configurations
│   │   ├── fan-control.sh             # Fan speed management
│   │   └── monitor-temp.sh            # Temperature monitoring
│   │
│   ├── noctalia/                      # Noctalia helpers
│   │   ├── widget-generator.sh        # Create new widgets from template
│   │   ├── theme-switcher.sh          # Switch color schemes
│   │   └── reload-shell.sh            # Reload Noctalia
│   │
│   ├── keybinds/                      # Keybinding utilities
│   │   ├── generate-cheatsheet.sh     # Auto-generate keybind docs
│   │   └── keybind-viewer.sh          # Interactive keybind viewer
│   │
│   └── utils/                         # General utilities
│       ├── wallpaper-cycler.sh        # Cycle wallpapers
│       ├── screenshot.sh              # Screenshot tool
│       ├── color-picker.sh            # Color picker
│       └── quick-edit.sh              # Quick config editor
│
├── themes/                            # Theme files
│   ├── gtk/                           # GTK themes
│   │   ├── tokyonight/
│   │   ├── sweet-dark/
│   │   └── flat-remix/
│   ├── qt/                            # Qt/Kvantum themes
│   │   └── wehttamsnaps-kvantum/
│   ├── cursors/                       # Cursor themes
│   │   └── bibata-modern/
│   └── icons/                         # Icon themes
│       └── papirus-custom/
│
├── assets/                            # Media assets
│   ├── wallpapers/                    # Wallpaper collection
│   │   ├── main/                      # Primary wallpapers
│   │   ├── photography/               # Photography-themed
│   │   ├── gaming/                    # Gaming wallpapers
│   │   └── abstract/                  # Abstract art
│   │
│   ├── sounds/                        # Sound effects
│   │   └── jarvis/                    # J.A.R.V.I.S. sounds
│   │       ├── jarvis-startup.mp3
│   │       ├── jarvis-shutdown.mp3
│   │       ├── jarvis-notification.mp3
│   │       ├── jarvis-warning.mp3
│   │       ├── jarvis-gaming.mp3
│   │       └── jarvis-streaming.mp3
│   │
│   ├── icons/                         # Custom icons
│   │   ├── wehttamsnaps-logo.svg
│   │   ├── app-icons/
│   │   └── widget-icons/
│   │
│   ├── fonts/                         # Custom fonts
│   │   └── (fonts installed system-wide)
│   │
│   └── images/                        # Images
│       ├── welcome-banner.png         # Welcome app banner
│       ├── lockscreen-bg.png          # Lock screen background
│       └── splash.png                 # Boot splash
│
├── webapps/                           # WebApp integration
│   ├── desktop-files/                 # .desktop entries
│   │   ├── youtube-webapp.desktop
│   │   ├── twitch-webapp.desktop
│   │   ├── instagram-webapp.desktop
│   │   ├── chatgpt-webapp.desktop
│   │   └── google-photos-webapp.desktop
│   │
│   ├── scripts/                       # WebApp launchers
│   │   ├── launch-youtube.sh
│   │   ├── launch-twitch.sh
│   │   └── launch-instagram.sh
│   │
│   └── icons/                         # WebApp icons
│       ├── youtube.svg
│       ├── twitch.svg
│       └── instagram.svg
│
├── docs/                              # Documentation
│   ├── KEYBINDS.md                    # Complete keybinding reference
│   ├── GAMING.md                      # Gaming setup & optimization
│   ├── STREAMING.md                   # Streaming guide
│   ├── AUDIO_ROUTING.md               # qpwgraph setup guide
│   ├── NOCTALIA_WIDGETS.md            # Creating custom widgets
│   ├── TROUBLESHOOTING.md             # Common issues & fixes
│   ├── CUSTOMIZATION.md               # Customization guide
│   └── images/                        # Documentation images
│       └── screenshots/
│
├── templates/                         # File templates
│   ├── noctalia-widget-template.qml   # Widget template
│   ├── hypr-module-template.conf      # Hyprland module template
│   └── script-template.sh             # Shell script template
│
└── .github/                           # GitHub specific
    ├── workflows/
    │   └── release.yml                # Auto-release workflow
    ├── ISSUE_TEMPLATE/
    └── PULL_REQUEST_TEMPLATE.md
```

## Logo File (logo.txt)

```
 __        __   _     _   _                    ____                        
 \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _ _ __  ___ 
  \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` | '_ \/ __|
   \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| | |_) \__ \
    \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_| .__/|___/
                                                                  |_|        

 Hyprland Setup for Photography, Gaming & Streaming
 GitHub: https://github.com/Crowdrocker
```

## Hyprland Main Config (config/hypr/hyprland.conf)

```bash
# ╔══════════════════════════════════════════════════════════════════════╗
# ║                                                                      ║
# ║  __        __   _     _   _                    ____                  ║
# ║  \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _    ║
# ║   \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` |   ║
# ║    \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| |   ║
# ║     \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_|   ║
# ║                                                                      ║
# ║  Hyprland Configuration                                              ║
# ║  GitHub: https://github.com/Crowdrocker                              ║
# ║                                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Monitor Configuration
source = ~/.config/hypr/modules/display.conf

# Environment Variables
source = ~/.config/hypr/modules/environment.conf

# Autostart Applications
source = ~/.config/hypr/modules/autostart.conf

# Window Rules
source = ~/.config/hypr/modules/windowrules.conf

# Workspace Configuration
source = ~/.config/hypr/modules/workspaces.conf

# Animations
source = ~/.config/hypr/modules/animations.conf

# Keybindings
source = ~/.config/hypr/modules/binds.conf

# Gaming Optimizations
source = ~/.config/hypr/modules/gaming.conf
```

## Window Rules Example (config/hypr/modules/windowrules.conf)

```bash
# ╔══════════════════════════════════════════════════════════════════════╗
# ║  Window Rules - Organized by Application                             ║
# ╚══════════════════════════════════════════════════════════════════════╝

# ═══════════════════════════════════════════════════════════════════════
# Steam
# ═══════════════════════════════════════════════════════════════════════
windowrulev2 = float, class:^(steam)$, title:^(Friends List)$
windowrulev2 = float, class:^(steam)$, title:^(Steam Settings)$
windowrulev2 = workspace 5, class:^(steam)$

# ═══════════════════════════════════════════════════════════════════════
# MPV Media Player
# ═══════════════════════════════════════════════════════════════════════
windowrulev2 = float, class:^(mpv)$
windowrulev2 = size 800 600, class:^(mpv)$
windowrulev2 = center, class:^(mpv)$

# ═══════════════════════════════════════════════════════════════════════
# Firefox
# ═══════════════════════════════════════════════════════════════════════
windowrulev2 = workspace 2, class:^(firefox)$
windowrulev2 = opacity 0.95, class:^(firefox)$

# ═══════════════════════════════════════════════════════════════════════
# Photography Applications
# ═══════════════════════════════════════════════════════════════════════
windowrulev2 = workspace 3, class:^(Gimp-2.10)$
windowrulev2 = workspace 3, class:^(krita)$
windowrulev2 = workspace 3, class:^(darktable)$
windowrulev2 = workspace 3, class:^(inkscape)$

# ═══════════════════════════════════════════════════════════════════════
# Discord
# ═══════════════════════════════════════════════════════════════════════
windowrulev2 = workspace 4, class:^([Dd]iscord)$
windowrulev2 = opacity 0.95, class:^([Dd]iscord)$

# ═══════════════════════════════════════════════════════════════════════
# File Manager
# ═══════════════════════════════════════════════════════════════════════
windowrulev2 = float, class:^(thunar)$, title:^(File Operation Progress)$
windowrulev2 = size 600 400, class:^(thunar)$, title:^(File Operation Progress)$

# ═══════════════════════════════════════════════════════════════════════
# Terminal
# ═══════════════════════════════════════════════════════════════════════
windowrulev2 = opacity 0.90, class:^(ghostty)$

# ═══════════════════════════════════════════════════════════════════════
# WebApps
# ═══════════════════════════════════════════════════════════════════════
windowrulev2 = workspace 6, title:^(YouTube).*$
windowrulev2 = workspace 6, title:^(Twitch).*$
windowrulev2 = workspace 6, title:^(Instagram).*$

# ═══════════════════════════════════════════════════════════════════════
# Floating Windows
# ═══════════════════════════════════════════════════════════════════════
windowrulev2 = float, class:^(pavucontrol)$
windowrulev2 = float, class:^(qpwgraph)$
windowrulev2 = float, title:^(Picture-in-Picture)$
```

## Essential Package List (Cleaned)

Based on your setup, here are the **essential** packages:

### Core System
```
base base-devel linux-firmware
```

### Hyprland & Wayland
```
hyprland hypridle hyprlock hyprpaper hyprpicker
noctalia-shell quickshell
xdg-desktop-portal-hyprland
```

### Terminal & Shell
```
ghostty zsh starship
zsh-autosuggestions zsh-syntax-highlighting
```

### Audio
```
pipewire pipewire-alsa pipewire-pulse pipewire-jack
wireplumber pavucontrol qpwgraph easyeffects
```

### Graphics (AMD)
```
mesa vulkan-radeon lib32-vulkan-radeon
amdvlk lib32-amdvlk xf86-video-amdgpu
```

### Photography
```
gimp inkscape krita darktable rawtherapee
```

### Gaming
```
steam lutris heroic-games-launcher-bin
gamemode lib32-gamemode
proton-ge-custom-bin
corectrl lact
```

### Utilities
```
thunar rofi fuzzel dunst
brightnessctl networkmanager
bluez bluez-utils
fastfetch btop
```

### Themes & Fonts
```
ttf-jetbrains-mono-nerd ttf-fira-code
papirus-icon-theme
gtk-engine-murrine
kvantum
```

This reduces your 500+ packages to about 100 essential ones!

## Next Steps

1. Create the folder structure shown above
2. Organize your configs into modular files
3. Create the installation script
4. Write documentation for each section
5. Set up GitHub repository with branches

Would you like me to create any specific configuration files or scripts next?