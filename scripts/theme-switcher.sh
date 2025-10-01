#!/bin/bash
theme=$(rofi -dmenu -p "Theme:" << EOF
Flat-Remix-GTK-Blue-Dark-Solid
Sweet-Ambar-Blue-Dark-v40
Tokyonight-Dark
MateriaDark
EOF
)
lxappearance --theme $theme
notify-send "Theme: $theme"
# Update Quickshell CSS if needed
