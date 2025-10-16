# 🎮 Gaming Guide

```
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
```

> Complete gaming setup guide for WehttamSnaps Hyprland Setup

---

## 📋 Table of Contents

- [Gaming Optimizations](#gaming-optimizations)
- [Steam Setup](#steam-setup)
- [Game Launch Options](#game-launch-options)
- [Game Modding](#game-modding)
- [Performance Tuning](#performance-tuning)
- [Troubleshooting](#troubleshooting)

---

## 🚀 Gaming Optimizations

### AMD GPU Optimizations (RX 580)

Your RX 580 is well-supported on Linux with the open-source AMDGPU driver. The setup includes:

#### Driver Configuration

```bash
# Check current driver
lspci -k | grep -A 3 -E "(VGA|3D)"

# Verify AMDGPU is loaded
lsmod | grep amdgpu

# Check Vulkan support
vulkaninfo | grep "deviceName"
```

#### Mesa Optimizations

Environment variables are already configured in `~/.config/hypr/env.conf`:

```bash
# AMD GPU Driver
AMD_VULKAN_ICD=RADV

# Mesa Configuration
MESA_LOADER_DRIVER_OVERRIDE=radeonsi
RADV_PERFTEST=gpl,nggc

# Vulkan
VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
```

### Gamemode

Gamemode automatically optimizes system performance when games are running.

#### Enable Gamemode

```bash
# Enable gamemode daemon
systemctl --user enable --now gamemoded

# Test gamemode
gamemoded -t

# Check gamemode status
gamemoded -s
```

#### Toggle Gaming Mode

Use the keyboard shortcut or script:

```bash
# Keyboard: SUPER + G
# Or run manually:
~/.local/bin/toggle-gaming-mode.sh
```

This script:
- Enables/disables gamemode
- Switches GPU profile (CoreCtrl)
- Plays J.A.R.V.I.S. sound
- Shows notification

### GPU Control

#### CoreCtrl Setup

```bash
# Install CoreCtrl
paru -S corectrl

# Enable service
sudo systemctl enable --now corectrl

# Add user to group
sudo usermod -aG corectrl $USER

# Reboot to apply
sudo reboot
```

#### Create Gaming Profile

1. Open CoreCtrl
2. Create new profile: "Gaming"
3. Set GPU to performance mode
4. Set fan curve for optimal cooling
5. Save profile

#### LACT (Alternative)

```bash
# Install LACT
paru -S lact

# Enable daemon
sudo systemctl enable --now lactd

# Open GUI
lact gui
```

---

## 🎮 Steam Setup

### Install Steam

```bash
# Install Steam and dependencies
paru -S steam lib32-gamemode lib32-vulkan-radeon lib32-mesa
```

### Steam Configuration

#### Enable Proton

1. Open Steam
2. Go to Settings → Steam Play
3. Enable "Enable Steam Play for all other titles"
4. Select Proton version (Proton Experimental or GE-Proton)

#### Install Proton GE

```bash
# Install Proton GE
paru -S proton-ge-custom-bin

# Or use ProtonUp-Qt
paru -S protonup-qt
protonup-qt
```

### Steam Launch Options

General optimizations for all games:

```bash
# In Steam → Game Properties → Launch Options:

# Basic optimization
PROTON_USE_WINED3D=0 DXVK_ASYNC=1 %command%

# With gamemode
gamemoderun %command%

# With mangohud
mangohud %command%

# Combined
gamemoderun mangohud DXVK_ASYNC=1 %command%
```

---

## 🎯 Game Launch Options

### Cyberpunk 2077

```bash
gamemoderun mangohud PROTON_USE_WINED3D=0 DXVK_ASYNC=1 DXVK_HUD=fps %command%
```

**Recommended Settings:**
- Resolution: 1920x1080
- Graphics: Medium-High
- FSR 2.0: Quality mode
- Ray Tracing: Off (RX 580 limitation)

### The Division 2

```bash
gamemoderun PROTON_USE_WINED3D=0 DXVK_ASYNC=1 %command%
```

**Notes:**
- Runs well on Proton
- Enable DX11 mode
- Disable DX12 for better compatibility

### Fallout 4

```bash
gamemoderun PROTON_USE_WINED3D=0 %command%
```

**Modding:**
- Use Steam Tinker Launch for mod support
- See [Game Modding](#game-modding) section

### Far Cry 5

```bash
gamemoderun mangohud DXVK_ASYNC=1 %command%
```

**Settings:**
- Resolution: 1920x1080
- Graphics: High
- Anti-aliasing: SMAA

### Ghost Recon Breakpoint

```bash
gamemoderun PROTON_USE_WINED3D=0 DXVK_ASYNC=1 %command%
```

**Notes:**
- Requires Ubisoft Connect
- May need to run Ubisoft Connect separately first

### The First Descendant

```bash
gamemoderun mangohud DXVK_ASYNC=1 PROTON_ENABLE_NVAPI=1 %command%
```

**Settings:**
- Resolution: 1920x1080
- Graphics: Medium
- Enable FSR for better performance

### Warframe

```bash
gamemoderun PROTON_USE_WINED3D=0 %command%
```

**Notes:**
- Native Linux version available
- Runs excellently on Linux
- No special launch options needed for native version

### Watch Dogs Series

```bash
# Watch Dogs
gamemoderun DXVK_ASYNC=1 %command%

# Watch Dogs 2
gamemoderun mangohud DXVK_ASYNC=1 %command%

# Watch Dogs Legion
gamemoderun mangohud DXVK_ASYNC=1 PROTON_ENABLE_NVAPI=1 %command%
```

---

## 🔧 Game Modding

### Steam Tinker Launch

Steam Tinker Launch enables mod managers like Vortex and MO2 on Linux.

#### Install Steam Tinker Launch

```bash
paru -S steamtinkerlaunch
```

#### Configure for Fallout 4

1. Launch game once through Steam
2. Right-click game → Properties → Launch Options:
   ```bash
   STLGAMEID=377160 %command%
   ```
3. Launch game - STL menu will appear
4. Select "Vortex" or "MO2"
5. Install mods through mod manager

#### Supported Games

- Fallout 4
- Fallout: New Vegas
- Skyrim Special Edition
- The Witcher 3
- Cyberpunk 2077

### Nexus Mods App

Official Nexus Mods app for Linux (currently Cyberpunk 2077 only):

```bash
# Download from nexusmods.com/app
# Install AppImage
chmod +x NexusModsApp.AppImage
./NexusModsApp.AppImage
```

**Features:**
- Native Linux support
- No Wine required
- Automatic mod installation
- Mod conflict resolution

---

## ⚡ Performance Tuning

### CPU Governor

```bash
# Set CPU to performance mode
sudo cpupower frequency-set -g performance

# Or use auto-cpufreq (already installed)
sudo systemctl enable --now auto-cpufreq
```

### ZRAM Configuration

ZRAM is already configured for better memory management:

```bash
# Check ZRAM status
zramctl

# View ZRAM stats
cat /proc/swaps
```

### Fan Control

#### Using CoreCtrl

1. Open CoreCtrl
2. Go to Fan tab
3. Create custom fan curve:
   - 30°C: 30%
   - 50°C: 50%
   - 70°C: 70%
   - 80°C: 90%
   - 90°C: 100%

#### Using LACT

```bash
# Open LACT
lact gui

# Set fan curve in GUI
```

### Monitor GPU Performance

```bash
# Real-time GPU monitoring
radeontop

# Or use nvtop
nvtop

# Check GPU temperature
sensors | grep edge
```

---

## 🐛 Troubleshooting

### Game Won't Launch

```bash
# Check Proton logs
cat ~/.steam/steam/steamapps/compatdata/[GAME_ID]/pfx/drive_c/users/steamuser/Temp/proton_log.txt

# Try different Proton version
# Steam → Game Properties → Compatibility → Force Proton version

# Clear shader cache
rm -rf ~/.steam/steam/steamapps/shadercache/[GAME_ID]
```

### Poor Performance

```bash
# Enable gamemode
gamemoderun %command%

# Check if gamemode is active
gamemoded -s

# Monitor GPU usage
radeontop

# Check CPU usage
htop

# Verify Vulkan is being used
DXVK_HUD=full %command%
```

### Stuttering

```bash
# Enable DXVK async
DXVK_ASYNC=1 %command%

# Increase shader cache size
# Add to launch options:
__GL_SHADER_DISK_CACHE_SIZE=1073741824 %command%

# Disable compositor (already done in gaming mode)
```

### Audio Issues

```bash
# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse wireplumber

# Check audio devices
wpctl status

# Set default output
wpctl set-default [DEVICE_ID]
```

### Controller Not Working

```bash
# Check controller detection
ls /dev/input/js*

# Test controller
jstest /dev/input/js0

# Install Steam Input support
# Steam → Settings → Controller → Enable Steam Input
```

---

## 📊 Performance Expectations (RX 580)

### 1080p Gaming Performance

| Game | Settings | Expected FPS |
|------|----------|--------------|
| Cyberpunk 2077 | Medium + FSR | 45-60 |
| The Division 2 | High | 60-75 |
| Fallout 4 | Ultra | 60+ |
| Far Cry 5 | High | 55-70 |
| Warframe | High | 90-120 |
| The First Descendant | Medium | 50-60 |
| Watch Dogs 2 | High | 50-65 |

---

## 🎯 Gaming Workspace Setup

### Workspace 6 - Gaming

Workspace 6 is configured for fullscreen gaming:

```bash
# In windowrules.conf:
workspace = 6, monitor:DP-3, gapsin:0, gapsout:0, border:false
```

**Features:**
- No gaps for true fullscreen
- No borders
- Dedicated to games
- Automatic gamemode activation

### Quick Launch Games

```bash
# Steam
SUPER + G + S

# Lutris
SUPER + G + L

# Heroic
SUPER + G + H
```

---

## 📚 Additional Resources

- [ProtonDB](https://www.protondb.com/) - Game compatibility database
- [Steam Tinker Launch Wiki](https://github.com/sonic2kk/steamtinkerlaunch/wiki)
- [DXVK GitHub](https://github.com/doitsujin/dxvk)
- [Gamemode GitHub](https://github.com/FeralInteractive/gamemode)

---

<div align="center">

**Happy Gaming! 🎮**

[← Back to README](../../README.md)

</div>