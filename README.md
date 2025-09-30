# WehttamSnaps Hyprland Configuration

![WehttamSnaps](https://via.placeholder.com/800x200/8A2BE2/FFFFFF?text=WehttamSnaps+J.A.R.V.I.S.+Setup)

A complete Arch Linux configuration for gaming, streaming, and photography work featuring:
- **J.A.R.V.I.S.** themed interface with custom sounds
- **AMD RX 580** gaming optimizations  
- **PipeWire** audio routing (Voicemeeter alternative)
- **Quickshell** widgets for work and gaming
- Modular and maintainable configuration

## 🚀 Quick Start

```bash
git clone https://github.com/Crowdrocker/Hypr-Snaps.git
cd Hypr-Snaps
chmod +x install.sh
./install.sh
```

## 🎮 Features

### Gaming
- AMD FSYNC and Vulkan optimizations
- Gamescope integration
- Gamemode performance tuning
- Steam launch options for popular games
- CoreCtrl GPU management

### Audio
- PipeWire with qpwgraph routing
- Separate audio streams (Game, Music, Voice, Stream)
- J.A.R.V.I.S. sound notifications

### Workflow
- 10 customizable workspaces
- Quickshell widgets and bars
- Rofi application launcher
- Custom power menu
- Photography app shortcuts

## 🛠️ Configuration

### Keybinds
- `Super + Enter`: Terminal
- `Super + Space`: Application launcher  
- `Super + 1-0`: Switch workspaces
- `Super + G`: Gaming mode
- `Super + P`: Power menu

### Audio Routing
Use `qpwgraph` to route:
- Game audio → game_sink
- Music → music_sink
- Voice chat → voice_sink
- Stream mix → stream_sink

## 🎨 Themes

Included themes:
- WehttamSnaps (custom)
- J.A.R.V.I.S. Iron Man
- TokyoNight Dark
- Sweet Ambar Blue Dark

## 🔧 Maintenance

Update configuration:
```bash
cd Hypr-Snaps
git pull
./install.sh
```

## 🤝 Contributing

Feel free to submit issues and pull requests!

## 📞 Support

Join our Discord: [WehttamSnaps Community](your-discord-link)
```

## Discord Server Structure

```
WehttamSnaps Community
├── 📋 welcome-and-rules
│   ├── #welcome
│   ├── #rules
│   └── #roles
├── 💬 general-chat
│   ├── #general
│   ├── #photography
│   └── #memes
├── 🎮 gaming
│   ├── #gaming-general
│   ├── #the-division
│   ├── #the-first-descendant  
│   ├── #cyberpunk-2077
│   ├── #fallout
│   └── #lfg-looking-for-group
├── 🐧 linux-setups
│   ├── #hyprland-configs
│   ├── #gaming-on-linux
│   └── #tech-support
├── 🔧 development
│   ├── #repo-discussion
│   ├── #feature-requests
│   └── #bug-reports
└── 🎥 streaming
    ├── #stream-chat
    ├── #stream-tech
    └── #content-sharing
```

## Quick Cheat Sheet

### Essential Commands:
```bash
# Update system
yay -Syu

# Edit Hyprland config
nano ~/.config/hypr/hyprland.conf

# Audio control
qpwgraph  # Audio routing
pavucontrol  # Volume control

# Gaming
gamemoderun %command%  # Add to Steam launch options

# System info
neofetch
fastfetch
btop
