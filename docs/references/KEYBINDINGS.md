# ⌨️ Keybindings Reference

```
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
```

> Complete keybinding reference for WehttamSnaps Hyprland Setup

---

## 📋 Table of Contents

- [Core Functions](#core-functions)
- [Window Management](#window-management)
- [Workspace Management](#workspace-management)
- [Noctalia Shell](#noctalia-shell)
- [Audio Controls](#audio-controls)
- [Display & Brightness](#display--brightness)
- [Screenshots & Recording](#screenshots--recording)
- [Gaming & Streaming](#gaming--streaming)
- [WebApps](#webapps)
- [System Controls](#system-controls)
- [J.A.R.V.I.S. Controls](#jarvis-controls)

---

## 🎯 Core Functions

### Application Launcher & Menus

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + SPACE` | Application Launcher | Open Noctalia launcher |
| `SUPER + D` | App Launcher (Alt) | Alternative launcher (Rofi/Fuzzel) |
| `SUPER + S` | Control Center | Toggle Noctalia control center |
| `SUPER + COMMA` | Settings | Open Noctalia settings |
| `SUPER + H` | Help Screen | Show keybindings help |
| `SUPER + ESC` | Power Menu | Logout/Reboot/Shutdown menu |

### Applications

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + ENTER` | Terminal | Open Ghostty terminal |
| `SUPER + B` | Browser | Open default browser |
| `SUPER + F` | File Manager | Open Thunar file manager |
| `SUPER + E` | Text Editor | Open text editor |
| `SUPER + M` | Music Player | Open Spotify |
| `SUPER + N` | Notes | Open Obsidian |

---

## 🪟 Window Management

### Basic Window Controls

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + Q` | Close Window | Close active window |
| `SUPER + W` | Close Window (Alt) | Alternative close |
| `SUPER + V` | Toggle Floating | Float/tile active window |
| `SUPER + P` | Toggle Pseudo | Pseudo-tile mode |
| `SUPER + J` | Toggle Split | Toggle split direction |
| `SUPER + SHIFT + SPACE` | Toggle Fullscreen | Fullscreen active window |

### Window Focus

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + LEFT` | Focus Left | Move focus to left window |
| `SUPER + RIGHT` | Focus Right | Move focus to right window |
| `SUPER + UP` | Focus Up | Move focus to window above |
| `SUPER + DOWN` | Focus Down | Move focus to window below |
| `SUPER + H` | Focus Left (Vim) | Vim-style left |
| `SUPER + L` | Focus Right (Vim) | Vim-style right |
| `SUPER + K` | Focus Up (Vim) | Vim-style up |
| `SUPER + J` | Focus Down (Vim) | Vim-style down |

### Window Movement

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + SHIFT + LEFT` | Move Left | Move window left |
| `SUPER + SHIFT + RIGHT` | Move Right | Move window right |
| `SUPER + SHIFT + UP` | Move Up | Move window up |
| `SUPER + SHIFT + DOWN` | Move Down | Move window down |
| `SUPER + SHIFT + H` | Move Left (Vim) | Vim-style move left |
| `SUPER + SHIFT + L` | Move Right (Vim) | Vim-style move right |
| `SUPER + SHIFT + K` | Move Up (Vim) | Vim-style move up |
| `SUPER + SHIFT + J` | Move Down (Vim) | Vim-style move down |

### Window Resizing

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + CTRL + LEFT` | Resize Left | Shrink width |
| `SUPER + CTRL + RIGHT` | Resize Right | Grow width |
| `SUPER + CTRL + UP` | Resize Up | Shrink height |
| `SUPER + CTRL + DOWN` | Resize Down | Grow height |
| `SUPER + R` | Resize Mode | Enter resize mode |

### Mouse Controls

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + LMB` | Move Window | Drag to move window |
| `SUPER + RMB` | Resize Window | Drag to resize window |
| `SUPER + MMB` | Toggle Float | Middle-click to float |

---

## 🗂️ Workspace Management

### Workspace Navigation

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + 1-9` | Switch Workspace | Go to workspace 1-9 |
| `SUPER + 0` | Switch to Workspace 10 | Go to workspace 10 |
| `SUPER + TAB` | Next Workspace | Cycle to next workspace |
| `SUPER + SHIFT + TAB` | Previous Workspace | Cycle to previous workspace |
| `SUPER + CTRL + LEFT` | Previous Workspace | Go to previous workspace |
| `SUPER + CTRL + RIGHT` | Next Workspace | Go to next workspace |

### Move Windows to Workspaces

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + SHIFT + 1-9` | Move to Workspace | Move window to workspace 1-9 |
| `SUPER + SHIFT + 0` | Move to Workspace 10 | Move window to workspace 10 |
| `SUPER + ALT + LEFT` | Move & Follow Left | Move window and follow |
| `SUPER + ALT + RIGHT` | Move & Follow Right | Move window and follow |

### Special Workspaces

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + S` | Scratchpad | Toggle scratchpad |
| `SUPER + SHIFT + S` | Move to Scratchpad | Send window to scratchpad |

---

## 🎨 Noctalia Shell

### Core Noctalia Functions

| Keybind | Action | Command |
|---------|--------|---------|
| `SUPER + SPACE` | Toggle Launcher | `qs -c noctalia-shell ipc call launcher toggle` |
| `SUPER + S` | Toggle Control Center | `qs -c noctalia-shell ipc call controlCenter toggle` |
| `SUPER + COMMA` | Toggle Settings | `qs -c noctalia-shell ipc call settings toggle` |

### Quick Access

| Keybind | Action | Command |
|---------|--------|---------|
| `SUPER + V` | Clipboard History | `qs -c noctalia-shell ipc call launcher clipboard` |
| `SUPER + C` | Calculator | `qs -c noctalia-shell ipc call launcher calculator` |
| `SUPER + L` | Lock Screen | `qs -c noctalia-shell ipc call lockScreen toggle` |
| `SUPER + ESC` | Session Menu | `qs -c noctalia-shell ipc call sessionMenu toggle` |

### Appearance

| Keybind | Action | Command |
|---------|--------|---------|
| `SUPER + CTRL + B` | Toggle Bar | `qs -c noctalia-shell ipc call bar toggle` |
| `SUPER + CTRL + D` | Toggle Dark Mode | `qs -c noctalia-shell ipc call darkMode toggle` |
| `SUPER + CTRL + W` | Wallpaper Selector | `qs -c noctalia-shell ipc call wallpaper toggle` |
| `SUPER + CTRL + SPACE` | Random Wallpaper | `qs -c noctalia-shell ipc call wallpaper random` |

---

## 🔊 Audio Controls

### Volume Control

| Keybind | Action | Command |
|---------|--------|---------|
| `XF86AudioRaiseVolume` | Volume Up | `qs -c noctalia-shell ipc call volume increase` |
| `XF86AudioLowerVolume` | Volume Down | `qs -c noctalia-shell ipc call volume decrease` |
| `XF86AudioMute` | Mute Output | `qs -c noctalia-shell ipc call volume muteOutput` |
| `SUPER + =` | Volume Up (Alt) | Alternative volume up |
| `SUPER + -` | Volume Down (Alt) | Alternative volume down |
| `SUPER + M` | Mute Toggle (Alt) | Alternative mute |

### Microphone Control

| Keybind | Action | Command |
|---------|--------|---------|
| `XF86AudioMicMute` | Mute Input | `qs -c noctalia-shell ipc call volume muteInput` |
| `SUPER + SHIFT + M` | Mute Mic (Alt) | Alternative mic mute |
| `SUPER + SHIFT + =` | Input Volume Up | `qs -c noctalia-shell ipc call volume increaseInput` |
| `SUPER + SHIFT + -` | Input Volume Down | `qs -c noctalia-shell ipc call volume decreaseInput` |

### Media Controls

| Keybind | Action | Description |
|---------|--------|-------------|
| `XF86AudioPlay` | Play/Pause | Toggle media playback |
| `XF86AudioNext` | Next Track | Skip to next track |
| `XF86AudioPrev` | Previous Track | Go to previous track |
| `SUPER + P` | Play/Pause (Alt) | Alternative play/pause |
| `SUPER + .` | Next Track (Alt) | Alternative next |
| `SUPER + ,` | Previous Track (Alt) | Alternative previous |

---

## 💡 Display & Brightness

### Brightness Control

| Keybind | Action | Command |
|---------|--------|---------|
| `XF86MonBrightnessUp` | Brightness Up | `qs -c noctalia-shell ipc call brightness increase` |
| `XF86MonBrightnessDown` | Brightness Down | `qs -c noctalia-shell ipc call brightness decrease` |
| `SUPER + F2` | Brightness Down (Alt) | Alternative brightness down |
| `SUPER + F3` | Brightness Up (Alt) | Alternative brightness up |

### Display Management

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + SHIFT + D` | Display Settings | Open display configuration |
| `SUPER + CTRL + M` | Mirror Displays | Toggle display mirroring |

---

## 📸 Screenshots & Recording

### Screenshots

| Keybind | Action | Description |
|---------|--------|-------------|
| `PRINT` | Screenshot Area | Select area to capture |
| `SUPER + PRINT` | Screenshot Window | Capture active window |
| `SUPER + SHIFT + S` | Screenshot Area | Alternative area capture |
| `CTRL + PRINT` | Screenshot Full | Capture entire screen |
| `ALT + PRINT` | Screenshot to Clipboard | Copy to clipboard |

### Screen Recording

| Keybind | Action | Command |
|---------|--------|---------|
| `SUPER + SHIFT + R` | Toggle Recording | `qs -c noctalia-shell ipc call screenRecorder toggle` |
| `SUPER + ALT + R` | Stop Recording | Stop active recording |

---

## 🎮 Gaming & Streaming

### Gaming Mode

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + G` | Toggle Gaming Mode | Enable/disable gaming optimizations |
| `SUPER + SHIFT + G` | Gaming Launcher | Open gaming widget |
| `SUPER + ALT + G` | Gamemode Status | Check gamemode status |

### Game Launchers

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + G + S` | Steam | Launch Steam |
| `SUPER + G + L` | Lutris | Launch Lutris |
| `SUPER + G + H` | Heroic | Launch Heroic Games Launcher |
| `SUPER + G + T` | Twitch | Launch Twitch |

### Streaming Controls

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + SHIFT + O` | Start/Stop Stream | Toggle OBS streaming |
| `SUPER + SHIFT + R` | Start/Stop Recording | Toggle OBS recording |
| `SUPER + SHIFT + M` | Mute Microphone | Mute mic for streaming |
| `SUPER + SHIFT + C` | Toggle Camera | Toggle webcam |

---

## 🌐 WebApps

### Social Media

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + W + Y` | YouTube | Open YouTube webapp |
| `SUPER + W + T` | Twitch | Open Twitch webapp |
| `SUPER + W + I` | Instagram | Open Instagram webapp |
| `SUPER + W + X` | Twitter/X | Open Twitter webapp |

### Communication

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + W + D` | Discord | Open Discord webapp |
| `SUPER + W + S` | Slack | Open Slack webapp |
| `SUPER + W + M` | Email | Open email webapp |

### Productivity

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + W + N` | Notion | Open Notion webapp |
| `SUPER + W + G` | Google Drive | Open Google Drive |
| `SUPER + W + C` | ChatGPT | Open ChatGPT webapp |

---

## 🖥️ System Controls

### Session Management

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + ESC` | Power Menu | Logout/Reboot/Shutdown |
| `SUPER + L` | Lock Screen | Lock the screen |
| `SUPER + SHIFT + E` | Exit Hyprland | Exit to login screen |
| `SUPER + SHIFT + Q` | Quit Session | Quit Hyprland session |

### System Utilities

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + I` | System Info | Show system information |
| `SUPER + U` | System Update | Check for updates |
| `SUPER + SHIFT + I` | Idle Inhibitor | Toggle idle inhibitor |

### Notifications

| Keybind | Action | Command |
|---------|--------|---------|
| `SUPER + N` | Notification History | `qs -c noctalia-shell ipc call notifications toggleHistory` |
| `SUPER + SHIFT + N` | Clear Notifications | `qs -c noctalia-shell ipc call notifications clear` |
| `SUPER + CTRL + N` | Do Not Disturb | `qs -c noctalia-shell ipc call notifications toggleDND` |

---

## 🤖 J.A.R.V.I.S. Controls

### J.A.R.V.I.S. System

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + J + S` | J.A.R.V.I.S. Status | Check J.A.R.V.I.S. status |
| `SUPER + J + G` | Gaming Mode Sound | Play gaming mode activation |
| `SUPER + J + T` | Streaming Mode Sound | Play streaming mode activation |
| `SUPER + J + W` | Warning Sound | Play warning sound |
| `SUPER + J + N` | Notification Sound | Play notification sound |

---

## 🛠️ Custom Keybinds

### Work Launcher

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + SHIFT + W` | Work Launcher | Open work applications widget |
| `SUPER + SHIFT + W + G` | GIMP | Launch GIMP |
| `SUPER + SHIFT + W + K` | Krita | Launch Krita |
| `SUPER + SHIFT + W + I` | Inkscape | Launch Inkscape |
| `SUPER + SHIFT + W + D` | Darktable | Launch Darktable |

### Quick Editor

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + CTRL + E` | Quick Editor | Open config editor |
| `SUPER + CTRL + H` | Edit Hyprland Config | Edit hyprland.conf |
| `SUPER + CTRL + K` | Edit Keybinds | Edit keybinds.conf |
| `SUPER + CTRL + W` | Edit Window Rules | Edit windowrules.conf |

---

## 📝 Notes

### Modifier Keys

- `SUPER` = Windows/Command key
- `CTRL` = Control key
- `SHIFT` = Shift key
- `ALT` = Alt key

### Customization

All keybindings can be customized by editing:
```
~/.config/hypr/keybinds.conf
```

### Auto-Generated Documentation

This keybinding reference is automatically generated from your configuration. To regenerate:

```bash
~/.local/bin/generate-keybinds-doc.sh
```

---

## 🔄 Keybind Conflicts

If you experience keybind conflicts:

1. Check for duplicate bindings in `~/.config/hypr/keybinds.conf`
2. Verify application-specific keybinds don't conflict
3. Use `hyprctl binds` to list all active bindings

---

## 📚 Additional Resources

- [Hyprland Wiki - Binds](https://wiki.hyprland.org/Configuring/Binds/)
- [Noctalia Shell Documentation](https://noctalia.dev/docs)
- [Custom Keybinds Guide](../guides/KEYBINDS.md)

---

<div align="center">

**Master these keybinds for maximum productivity! ⚡**

[← Back to README](../../README.md)

</div>