#!/usr/bin/env bash
# WehttamSnaps Key Cheatsheet (adapted from JaKooLit)
# Uses yad for quick GUI list; falls back to rofi/echo if yad unavailable.
# Adjusts for Noctalia (Quickshell), Ghostty terminal, and Webapps.

BACKEND=wayland
YAD=$(command -v yad || true)
ROFI=$(command -v rofi || true)

# Basic function to show plaintext fallback
show_plain(){
  cat <<'EOF'
WehttamSnaps Quick Cheat Sheet

SUPER = Windows / Meta key

SUPER + ENTER    → Ghostty terminal
SUPER + SPACE    → Noctalia launcher (Quickshell)
SUPER + B        → Browser / default webapp
SUPER + H        → This cheatsheet
SUPER + F        → WebApps menu
SUPER + SHIFT + G → Toggle Gaming Mode (animations off)
SUPER + CTRL + S  → Save configs (scripts/save-configs.sh)
CTRL ALT P       → Power Menu (wlogout)
CTRL ALT L       → Lock screen (hyprlock)
Print / Shift+Print → Screenshots (grim + slurp)
EOF
}

if [[ -n "$YAD" ]]; then
  yad --center --title="WehttamSnaps Quick Cheat Sheet" --no-buttons --text-info --width=780 --height=480 <<'EOF'
WehttamSnaps Quick Cheat Sheet

SUPER = Windows / Meta key

SUPER + ENTER    → Ghostty terminal
SUPER + SPACE    → Noctalia launcher (Quickshell)
SUPER + B        → Browser / default webapp
SUPER + H        → This cheatsheet
SUPER + F        → WebApps menu
SUPER + SHIFT + G → Toggle Gaming Mode (animations off)
SUPER + CTRL + S  → Save configs (scripts/save-configs.sh)
CTRL ALT P       → Power Menu (wlogout)
CTRL ALT L       → Lock screen (hyprlock)
Print / Shift+Print → Screenshots (grim + slurp)

More tips and keybinds available in configs/noctalia/keybinds.json
Repo: https://github.com/Crowdrocker/Hypr-Snaps.git
EOF
  exit 0
elif [[ -n "$ROFI" ]]; then
  echo "WehttamSnaps Quick Cheat Sheet" | rofi -dmenu -p "Key Hints" -no-show-match -no-sort
  exit 0
else
  show_plain
fi
