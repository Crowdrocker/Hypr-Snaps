# 🚀 Next Steps - What To Do Now

```
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┘
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
```

**Your WehttamSnaps Hyprland setup is complete!** Here's what to do next.

---

## 📥 Step 1: Download Everything

All your files are in the `/workspace` directory. Download the entire folder to your local machine.

**What you're getting:**
- 44+ configuration files
- 8 comprehensive documentation files
- 10 executable scripts
- 1 custom welcome app
- Complete Hyprland setup

---

## 📤 Step 2: Upload to GitHub

### Create Your Repository

1. Go to https://github.com/Crowdrocker
2. Click "New Repository"
3. Name it: `Hypr-Snaps`
4. Description: "My Arch Linux Hyprland Setup - Photography, Gaming & Streaming"
5. Make it Public
6. Don't initialize with README (you already have one!)

### Upload Your Files

```bash
# Navigate to your downloaded folder
cd /path/to/Hypr-Snaps

# Initialize git
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - WehttamSnaps Hyprland Setup"

# Add remote
git remote add origin https://github.com/Crowdrocker/Hypr-Snaps.git

# Push
git branch -M main
git push -u origin main
```

---

## 🖥️ Step 3: Install on Your System

### Prerequisites

Make sure you have:
- ✅ Arch Linux installed
- ✅ Internet connection
- ✅ Base-devel installed
- ✅ Git installed

### Installation

```bash
# Clone your repository
git clone https://github.com/Crowdrocker/Hypr-Snaps.git
cd Hypr-Snaps

# Run the installer
chmod +x scripts/install/install.sh
./scripts/install/install.sh

# Choose installation type:
# 1 = Minimal (core only)
# 2 = Gaming (core + gaming)
# 3 = Photography (core + creative)
# 4 = Full (everything)

# Reboot
sudo reboot
```

---

## 🎨 Step 4: Customize (Optional)

### Review Package List

Before installing, review the package list:

```bash
cat docs/references/PACKAGES.md
```

**Remove packages you don't need:**
- Edit `scripts/install/install.sh`
- Comment out packages you won't use
- This saves disk space and installation time

### Adjust Configurations

**Colors:**
- Edit `configs/hyprland/hyprland.conf`
- Change `col.active_border` values

**Keybindings:**
- Edit `configs/hyprland/keybinds.conf`
- Modify to your preference

**Monitor:**
- Edit `configs/hyprland/monitors.conf`
- Adjust if your monitor name differs

---

## 🎵 Step 5: Add J.A.R.V.I.S. Sounds

### Create Sound Files

You mentioned using https://www.101soundboards.com/

1. Go to the soundboard site
2. Use the TTS voices you mentioned:
   - 73296-jarvis-v1-paul-bettany-tts-computer-ai-voice
   - 1023595-idroid-tts-computer-ai-voice

3. Create these sounds:
   - `jarvis-startup.mp3` - "Allow me to introduce myself, I am JARVIS..."
   - `jarvis-gaming.mp3` - "Gaming mode activated. Systems at maximum performance."
   - `jarvis-streaming.mp3` - "Streaming systems online. All feeds operational."
   - `jarvis-warning.mp3` - "Warning: System temperature critical."
   - `jarvis-notification.mp3` - "Matthew, you have a notification."

### Install Sounds

```bash
# Create directory
mkdir -p ~/.local/share/sounds/jarvis

# Copy your sound files
cp /path/to/your/sounds/*.mp3 ~/.local/share/sounds/jarvis/
```

---

## 📸 Step 6: Add Your Content

### Wallpapers

```bash
# Add your photography wallpapers
mkdir -p ~/.config/hypr/wallpapers
cp /path/to/your/photos/*.jpg ~/.config/hypr/wallpapers/
```

### Icon

The `icon.png` file is already included. If you want to update it:

```bash
cp /path/to/your/new/icon.png ~/.config/wehttamsnaps/assets/icon.png
```

---

## 🎮 Step 7: Set Up Gaming

### Mount Gaming Drive

```bash
# Your 1TB gaming drive
sudo mkdir -p /run/media/wehttamsnaps/LINUXDRIVE-1

# Add to /etc/fstab for auto-mount (optional)
# UUID=your-drive-uuid /run/media/wehttamsnaps/LINUXDRIVE-1 ext4 defaults 0 2
```

### Configure Steam

1. Install Steam (included in gaming install)
2. Enable Proton:
   - Settings → Steam Play
   - Enable for all titles
   - Select Proton Experimental

3. Install Proton GE:
   ```bash
   paru -S protonup-qt
   protonup-qt
   ```

### Set Up GPU Control

```bash
# Enable CoreCtrl
sudo systemctl enable --now corectrl

# Or use LACT
sudo systemctl enable --now lactd
lact gui
```

---

## 📺 Step 8: Set Up Streaming

### OBS Configuration

1. Install OBS (included in photography/full install)
2. Configure audio routing with qpwgraph
3. Set up scenes for gaming/photography
4. Test stream to Twitch

### Audio Routing

```bash
# Open qpwgraph
qpwgraph

# Create connections:
# - Game audio → OBS
# - Microphone → OBS
# - Discord → OBS (optional)
# - Music → OBS (optional)
```

---

## 🌐 Step 9: Test WebApps

Try the webapp launchers:

```bash
# YouTube
SUPER + W + Y

# Twitch
SUPER + W + T

# Instagram
SUPER + W + I

# Discord
SUPER + W + D

# ChatGPT
SUPER + W + C
```

---

## 📱 Step 10: Set Up Discord Server

You mentioned creating a Discord server. Here's a structure:

### Channels

**Welcome**
- #welcome
- #rules
- #announcements

**General**
- #general-chat
- #introductions
- #off-topic

**Linux & Hyprland**
- #hyprland-help
- #linux-tips
- #rice-showcase
- #config-sharing

**Gaming**
- #the-division
- #the-first-descendant
- #general-gaming
- #lfg (looking for group)
- #builds-and-loadouts

**Photography**
- #photo-showcase
- #editing-tips
- #gear-discussion

**Streaming**
- #stream-schedule
- #stream-tech
- #clip-sharing

**Voice Channels**
- General Voice
- Gaming Voice
- Streaming Voice

---

## ✅ Verification Checklist

After installation, verify everything works:

- [ ] Hyprland starts successfully
- [ ] Welcome app appears on first boot
- [ ] Keybindings work (test SUPER + SPACE)
- [ ] Terminal opens (SUPER + ENTER)
- [ ] Gaming mode toggles (SUPER + G)
- [ ] WebApps launch correctly
- [ ] Audio works (test with music)
- [ ] GPU is detected (run `radeontop`)
- [ ] Fastfetch shows correct info
- [ ] Noctalia shell is running

---

## 📚 Documentation to Read

1. **Start here**: [QUICKSTART.md](QUICKSTART.md)
2. **Full guide**: [README.md](README.md)
3. **Installation**: [docs/guides/INSTALLATION.md](docs/guides/INSTALLATION.md)
4. **Keybindings**: [docs/references/KEYBINDINGS.md](docs/references/KEYBINDINGS.md)
5. **Gaming**: [docs/guides/GAMING.md](docs/guides/GAMING.md)

---

## 🐛 If Something Goes Wrong

### Check Logs

```bash
# Hyprland logs
cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log

# System logs
journalctl -xe

# Noctalia logs
journalctl --user -u noctalia.service
```

### Common Issues

**Hyprland won't start:**
- Check GPU drivers: `lspci -k | grep -A 3 VGA`
- Verify installation: `hyprctl version`

**Audio not working:**
- Restart PipeWire: `systemctl --user restart pipewire pipewire-pulse wireplumber`
- Check devices: `wpctl status`

**Gaming mode not working:**
- Check gamemode: `gamemoded -t`
- Verify script: `ls -la ~/.local/bin/toggle-gaming-mode.sh`

---

## 🎉 You're All Set!

Your WehttamSnaps Hyprland setup is ready to use. Enjoy your new system!

### Share Your Setup

Once you're happy with it:
1. Take screenshots
2. Share on Reddit (r/unixporn, r/hyprland)
3. Post on your Twitch/YouTube
4. Share in the Hyprland Discord

### Keep Learning

- Customize colors and themes
- Create custom widgets
- Add more keybindings
- Optimize for your workflow

---

<div align="center">

**Questions? Issues? Ideas?**

Open an issue on GitHub or join the Discord!

**Made with ❤️ for WehttamSnaps**

[GitHub](https://github.com/Crowdrocker/Hypr-Snaps) • [Twitch](https://twitch.tv/WehttamSnaps) • [YouTube](https://youtube.com/@WehttamSnaps)

</div>