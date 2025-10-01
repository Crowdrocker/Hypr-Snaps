# ❓ WehttamSnaps Setup - Frequently Asked Questions

## 📋 Table of Contents

1. [General Questions](#general-questions)
2. [Installation Issues](#installation-issues)
3. [Gaming Questions](#gaming-questions)
4. [Audio & Streaming](#audio--streaming)
5. [Hardware & Performance](#hardware--performance)
6. [Customization](#customization)
7. [Troubleshooting](#troubleshooting)

---

## General Questions

### Q: What is WehttamSnaps?

**A:** WehttamSnaps is my brand name (Matthew spelled backwards) for my photography business, gaming content, and Linux setup. This repository contains my complete Arch Linux + Hyprland configuration with J.A.R.V.I.S. theming.

### Q: Do I need the exact same hardware to use this setup?

**A:** No! While it's optimized for my hardware (i5-4430, RX 580, 16GB RAM), you can use it on any system. You may need to adjust some settings for NVIDIA GPUs or different CPUs.

### Q: Is this setup suitable for beginners?

**A:** Partially. The installer makes it easier, but you should have basic Linux knowledge. If you're completely new to Linux, I recommend starting with a beginner-friendly distro first, then trying this setup.

### Q: Can I use this on Ubuntu/Fedora/etc?

**A:** This is designed for Arch Linux. You could adapt it to other distros, but you'd need to change package managers and some configuration paths. I recommend using Arch or an Arch-based distro like EndeavourOS.

### Q: How much disk space do I need?

**A:** 
- Minimum: 40GB for base system
- Recommended: 120GB+ (my setup)
- For gaming: Additional 1TB (I use a separate drive)

---

## Installation Issues

### Q: The installer fails with "package not found" errors

**A:** Make sure your system is up to date first:
```bash
sudo pacman -Syu
```

Then run the installer again. If specific packages are missing, they might be in the AUR. Make sure yay is installed.

### Q: Do I need to install Arch Linux first?

**A:** Yes! This is a configuration for Arch Linux. You need a working Arch installation before running the installer.

**Steps:**
1. Install Arch Linux (or use archinstall)
2. Boot into your new system
3. Clone this repository
4. Run the installer

### Q: Can I dual boot with Windows?

**A:** Absolutely! I dual boot Windows 11 and Arch. Just make sure to:
- Install Windows first
- Then install Arch on a separate partition/drive
- GRUB will detect Windows automatically

### Q: The installer says "not enough space"

**A:** Check your disk space:
```bash
df -h
```

You need at least 20GB free for the base setup. Consider cleaning old packages:
```bash
sudo pacman -Sc
```

### Q: Hyprland won't start after installation

**A:** Check the logs:
```bash
cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log
```

Common fixes:
- Make sure you have a GPU (Hyprland needs hardware acceleration)
- Try starting from TTY: `Hyprland`
- Check if you have the correct drivers installed

---

## Gaming Questions

### Q: Which GPU is better for Linux gaming: RX 580 or GTX 1650?

**A:** RX 580, hands down. Better Linux drivers (open-source AMDGPU), more VRAM, better performance, and no NVIDIA driver headaches.

### Q: Do I need to do anything special for Steam games?

**A:** Most games work out of the box with Proton. For best results:
1. Enable Steam Play for all titles (Settings > Steam Play)
2. Use Proton Experimental or Proton GE
3. Apply the launch options from my guide
4. Check ProtonDB for game-specific issues

### Q: Why do some games not work?

**A:** Common reasons:
- **Anti-cheat**: Games with kernel-level anti-cheat often don't work (e.g., Valorant, Genshin Impact)
- **DRM**: Some DRM systems don't work on Linux
- **Old games**: May need specific Proton versions or tweaks

Check ProtonDB before buying games!

### Q: Can I use mods on Linux?

**A:** Yes! Options:
- **Nexus Mods App**: Now has native Linux support for Cyberpunk 2077
- **SteamTinkerLaunch**: Works with Vortex and MO2
- **Manual installation**: Always works, just more tedious

### Q: Does gamemode really help?

**A:** Yes! It:
- Sets CPU governor to performance
- Adjusts scheduling priorities
- Disables screen savers
- Can give 5-15% FPS boost in some games

### Q: My game crashes on startup

**A:** Try these steps:
1. Remove all launch options except `%command%`
2. Try different Proton versions
3. Check ProtonDB for known issues
4. Look at the game's log files in `~/.steam/steam/steamapps/compatdata/[APPID]/pfx/`

---

## Audio & Streaming

### Q: How do I separate audio like Voicemeter on Windows?

**A:** Use PipeWire + qpwgraph! See my [Audio Routing Guide](docs/AUDIO_ROUTING.md) for step-by-step instructions.

Quick summary:
1. Create virtual sinks for different apps
2. Route apps to those sinks using qpwgraph
3. Route sinks to your outputs and OBS

### Q: Why can't I hear any sound?

**A:** Check these:
```bash
# Check if PipeWire is running
systemctl --user status pipewire pipewire-pulse

# List audio outputs
pactl list sinks short

# Test audio
speaker-test -c 2
```

Most common fix: Right-click volume icon → select correct output device.

### Q: OBS is laggy on Wayland

**A:** Use these OBS settings:
- Use PipeWire for audio capture
- Use `wlrobs` plugin for screen capture
- Set Output to "Advanced" → Use "VAAPI" for encoding on AMD GPU

### Q: Discord has no sound/mic not working

**A:** 
1. Open pavucontrol
2. Go to "Recording" tab while Discord is running
3. Make sure Discord is using the correct input device
4. Go to "Playback" tab
5. Make sure Discord is using the correct output device

### Q: Can I use a virtual camera?

**A:** Yes! Install `v4l2loopback`:
```bash
sudo pacman -S v4l2loopback-dkms
sudo modprobe v4l2loopback
```

Then in OBS: Tools → V4L2 Video Output

---

## Hardware & Performance

### Q: My CPU runs hot!

**A:** Normal for older CPUs like the i5-4430. Tips:
- Reapply thermal paste (I did this and temps dropped 15-25°C!)
- Improve case airflow
- Use CoreCtrl to create a custom fan curve
- Monitor with: `sensors` or `btop`

### Q: How do I control my AMD GPU?

**A:** Use LACT (Linux AMDGPU Controller):
```bash
yay -S lact
sudo systemctl enable --now lactd
lact gui
```

You can:
- Create performance profiles
- Adjust power limits
- Control fan speeds
- Monitor temperatures

### Q: Should I use linux-zen or linux-lts kernel?

**A:** For your use case: **linux-zen**

**Why:**
- Optimized for desktop/gaming performance
- Better responsiveness
- More aggressive performance settings
- Still stable enough for daily use

Use linux-lts only if you have stability issues.

### Q: My games stutter/freeze

**A:** Try these:
1. Enable gamemode
2. Use `DXVK_ASYNC=1` in launch options
3. Check if you have enough RAM (16GB minimum for modern games)
4. Close background apps
5. Check temps with `btop` or `sensors`

### Q: How much VRAM does the RX 580 have?

**A:** The RX 580 comes in 4GB and 8GB versions. The 8GB version is much better for gaming. Check yours:
```bash
lspci -v | grep VGA -A 12 | grep Memory
```

### Q: Can I overclock my GPU?

**A:** Yes, using CoreCtrl or LACT. But be careful:
- The RX 580 is an older card
- Overclocking may not give significant gains
- Monitor temperatures closely
- Start with small increments

---

## Customization

### Q: How do I change the color scheme?

**A:** Edit `~/.config/hypr/colors.conf`:
```conf
$primary = rgb(YOUR_COLOR)
$secondary = rgb(YOUR_COLOR)
```

Then reload Hyprland: `SUPER + SHIFT + R`

### Q: Can I use Waybar instead of Quickshell?

**A:** Yes! The installer includes Waybar as a fallback. To switch:
```bash
killall quickshell
waybar &
```

To make it permanent, edit `~/.config/hypr/startup.sh`

### Q: How do I add my own wallpapers?

**A:** Two options:

**Option 1: Local**
```bash
cp your-wallpaper.png ~/.local/share/wallpapers/
```

**Option 2: To the repo**
```bash
cd ~/Documents/Configs/Wallpaper-Bank
cp /path/to/wallpaper.png ./
git add . && git commit -m "Added new wallpaper"
git push
```

### Q: Can I change the J.A.R.V.I.S. sounds?

**A:** Yes! Replace the MP3 files in `~/.local/share/sounds/jarvis/` with your own. Keep the same filenames or edit `jarvis-sound.sh` to reference your new files.

### Q: How do I modify keybindings?

**A:** Edit `~/.config/hypr/keybinds.conf`. After making changes, reload with `SUPER + SHIFT + R`.

---

## Troubleshooting

### Q: Screen tearing in games

**A:** Add to Hyprland config:
```conf
windowrulev2 = immediate, class:^(steam_app)
```

This is already in my config, but if you still see tearing:
- Make sure VRR is enabled
- Check if your monitor supports FreeSync
- Try capping FPS to monitor refresh rate

### Q: Cursor disappears in some apps

**A:** Known Wayland issue with some XWayland apps. Try:
```bash
env -u WAYLAND_DISPLAY app-name
```

Or add to `~/.config/hypr/windowrules.conf`:
```conf
windowrulev2 = forcexwayland, class:^(problematic-app)$
```

### Q: Notifications don't show

**A:** Check if dunst is running:
```bash
pgrep dunst
```

If not, start it:
```bash
dunst &
```

Test notifications:
```bash
notify-send "Test" "This is a test notification"
```

### Q: Can't take screenshots

**A:** Make sure grim and slurp are installed:
```bash
sudo pacman -S grim slurp
```

Test:
```bash
grim ~/test-screenshot.png
```

### Q: SDDM doesn't show my custom theme

**A:** Check SDDM configuration:
```bash
sudo nano /etc/sddm.conf.d/theme.conf
```

Should have:
```conf
[Theme]
Current=sugar-candy
```

Then:
```bash
sudo systemctl restart sddm
```

### Q: Bluetooth doesn't work

**A:** Enable Bluetooth service:
```bash
sudo systemctl enable --now bluetooth
```

Then use blueman-manager to pair devices.

### Q: WiFi keeps disconnecting

**A:** Common power management issue:
```bash
sudo nano /etc/NetworkManager/conf.d/wifi-powersave.conf
```

Add:
```conf
[connection]
wifi.powersave = 2
```

Restart NetworkManager:
```bash
sudo systemctl restart NetworkManager
```

### Q: Where are the log files?

**A:** Key locations:
- **Hyprland**: `/tmp/hypr/*/hyprland.log`
- **Startup**: `/tmp/wehttamsnaps-startup.log`
- **System**: `journalctl -xe`
- **Steam**: `~/.steam/steam/logs/`

---

## Still Need Help?

1. **Check the documentation**: All docs are in the `docs/` folder
2. **Search existing issues**: [GitHub Issues](https://github.com/Crowdrocker/Hypr-Snaps/issues)
3. **Join Discord**: Ask in #🐧-linux-help
4. **Open an issue**: Include your system info, logs, and what you've tried

**System Info Template:**
```bash
neofetch
uname -r
hyprctl version
```

---

## Quick Tips

💡 **Pro Tips for Success:**

1. **Always backup before major changes**
   ```bash
   ~/.config/hypr/scripts/backup-config.sh
   ```

2. **Read ProtonDB before buying games**

3. **Join the community** - Discord, Reddit, etc.

4. **Keep your system updated**
   ```bash
   yay -Syu
   ```

5. **Take notes** of what works for you

6. **Be patient** - Linux gaming has a learning curve

7. **Share your success** - Help others in the community!

---

**Remember:** "Good morning, Sir. All systems operational." - J.A.R.V.I.S.
