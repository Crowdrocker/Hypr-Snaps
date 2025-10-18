#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# WehttamSnaps Hyprland Setup - Keybindings Helper
# GitHub: https://github.com/Crowdrocker
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# GDK BACKEND
BACKEND=wayland

# Check if rofi or yad is running and kill them
if pidof rofi > /dev/null; then
  pkill rofi
fi

if pidof yad > /dev/null; then
  pkill yad
fi

# Launch yad with keybindings
GDK_BACKEND=$BACKEND yad \
    --center \
    --title="WehttamSnaps Keybindings" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
"ESC" "Close this app" "" \
"" "" "" \
"⊞ = SUPER" "SUPER KEY (Windows Key)" "(Main Modifier)" \
"" "" "" \
"━━━ CORE APPLICATIONS ━━━" "" "" \
"⊞ ENTER" "Terminal" "(Ghostty)" \
"⊞ SHIFT ENTER" "Dropdown Terminal" "" \
"⊞ D" "Application Launcher" "(rofi)" \
"⊞ SPACE" "Noctalia Launcher" "(Noctalia)" \
"⊞ B" "Browser" "(Firefox)" \
"⊞ E" "File Manager" "(Thunar)" \
"⊞ Q" "Close Window" "" \
"⊞ SHIFT Q" "Kill Window" "(Force)" \
"" "" "" \
"━━━ NOCTALIA SHELL ━━━" "" "" \
"⊞ C" "Control Center" "(Noctalia)" \
"⊞ COMMA" "Settings" "(Noctalia)" \
"⊞ V" "Clipboard History" "(cliphist)" \
"⊞ SHIFT C" "Calculator" "" \
"⊞ H" "Help / Keybindings" "(This screen)" \
"⊞ SHIFT K" "Searchable Keybinds" "(rofi search)" \
"" "" "" \
"━━━ WEBAPPS ━━━" "" "" \
"⊞ SHIFT Y" "YouTube" "(Webapp)" \
"⊞ SHIFT T" "Twitch" "(Webapp)" \
"⊞ SHIFT D" "Discord" "(Webapp)" \
"⊞ SHIFT S" "Spotify" "(Webapp)" \
"⊞ SHIFT G" "Gmail" "(Webapp)" \
"⊞ SHIFT M" "Google Maps" "(Webapp)" \
"⊞ SHIFT N" "Netflix" "(Webapp)" \
"" "" "" \
"━━━ WINDOW MANAGEMENT ━━━" "" "" \
"⊞ F" "Fullscreen" "" \
"⊞ SHIFT F" "Fullscreen (Fake)" "" \
"⊞ SPACEBAR" "Toggle Float" "" \
"⊞ P" "Pin Window" "" \
"⊞ J" "Toggle Split" "" \
"⊞ R" "Resize Mode" "" \
"" "" "" \
"━━━ WINDOW FOCUS ━━━" "" "" \
"⊞ ←/→/↑/↓" "Focus Direction" "(Arrow keys)" \
"⊞ H/J/K/L" "Focus Direction" "(Vim keys)" \
"" "" "" \
"━━━ WINDOW MOVEMENT ━━━" "" "" \
"⊞ SHIFT ←/→/↑/↓" "Move Window" "(Arrow keys)" \
"⊞ SHIFT H/J/K/L" "Move Window" "(Vim keys)" \
"" "" "" \
"━━━ WORKSPACES ━━━" "" "" \
"⊞ 1-9" "Switch Workspace" "" \
"⊞ SHIFT 1-9" "Move to Workspace" "" \
"⊞ CTRL ←/→" "Cycle Workspaces" "" \
"⊞ Mouse Scroll" "Cycle Workspaces" "" \
"" "" "" \
"━━━ SCREENSHOTS ━━━" "" "" \
"PRINT" "Full Screenshot" "" \
"⊞ PRINT" "Full Screenshot" "(grim)" \
"⊞ SHIFT PRINT" "Region Screenshot" "(slurp)" \
"⊞ SHIFT S" "Screenshot + Edit" "(swappy)" \
"ALT PRINT" "Window Screenshot" "" \
"⊞ CTRL PRINT" "Timer 5s" "" \
"⊞ CTRL SHIFT PRINT" "Timer 10s" "" \
"" "" "" \
"━━━ SCREEN RECORDING ━━━" "" "" \
"⊞ ALT R" "Toggle Recording" "" \
"⊞ SHIFT R" "Region Recording" "" \
"" "" "" \
"━━━ AUDIO CONTROLS ━━━" "" "" \
"Volume Up/Down" "Volume Control" "(Media keys)" \
"⊞ =/−" "Volume Control" "(Alternative)" \
"⊞ M" "Mute Output" "" \
"⊞ SHIFT M" "Mute Input" "(Microphone)" \
"⊞ P" "Play/Pause" "" \
"" "" "" \
"━━━ BRIGHTNESS ━━━" "" "" \
"Brightness Up/Down" "Brightness" "(Media keys)" \
"⊞ [/]" "Brightness" "(Alternative)" \
"" "" "" \
"━━━ SYSTEM CONTROLS ━━━" "" "" \
"⊞ L" "Lock Screen" "(hyprlock)" \
"CTRL ALT L" "Lock Screen" "(Alternative)" \
"CTRL ALT P" "Power Menu" "(wlogout)" \
"⊞ SHIFT L" "Logout Menu" "" \
"CTRL ALT DEL" "Exit Hyprland" "(Immediate)" \
"⊞ ALT R" "Reload Config" "" \
"" "" "" \
"━━━ NOTIFICATIONS ━━━" "" "" \
"⊞ N" "Notification Center" "" \
"⊞ SHIFT N" "Do Not Disturb" "" \
"⊞ CTRL N" "Clear Notifications" "" \
"" "" "" \
"━━━ APPEARANCE ━━━" "" "" \
"⊞ W" "Wallpaper Selector" "" \
"⊞ CTRL SPACE" "Random Wallpaper" "" \
"⊞ SHIFT W" "Wallpaper Effects" "" \
"⊞ SHIFT T" "Toggle Dark Mode" "" \
"⊞ SHIFT A" "Animations Menu" "" \
"⊞ ALT O" "Toggle Blur" "" \
"⊞ CTRL O" "Toggle Opacity" "" \
"⊞ CTRL ALT B" "Toggle Bar" "" \
"" "" "" \
"━━━ GAMING MODE ━━━" "" "" \
"⊞ SHIFT G" "Toggle Gaming Mode" "(Disable animations)" \
"" "" "" \
"━━━ UTILITIES ━━━" "" "" \
"⊞ S" "Google Search" "(rofi)" \
"⊞ ALT E" "Emoji Picker" "" \
"⊞ ALT C" "Color Picker" "" \
"⊞ I" "Idle Inhibitor" "" \
"" "" "" \
"━━━ MOUSE BINDINGS ━━━" "" "" \
"⊞ + Left Click" "Move Window" "(Drag)" \
"⊞ + Right Click" "Resize Window" "(Drag)" \
"⊞ + Scroll" "Cycle Workspaces" "" \
"⊞ ALT + Scroll" "Desktop Zoom" "" \
"" "" "" \
"More info:" "https://github.com/Crowdrocker/WehttamSnaps-Hyprland" ""