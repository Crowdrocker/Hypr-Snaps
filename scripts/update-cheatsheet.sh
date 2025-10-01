#!/bin/bash
CHEAT="$HOME/cheatsheet.md"
cat > $CHEAT << EOF
# WehttamSnaps Cheat Sheet (Auto-Generated $(date))

## Keybinds (From hyprland.conf)
$(grep "^bind" $CONFIG_DIR/hypr/hyprland.conf | sed 's/bind = / - /; s/,/ | /g')

## Audio
- pavucontrol: Volumes
- qpwgraph: Routes (Load audio-routes.wehttam)

## Gaming
- Super+G: Gamemode + Steam
- Mount Drive: udisksctl mount -b /dev/sdX1 (/run/media/wehttamsnaps/LINUXDRIVE-1)

## J.A.R.V.I.S.
- Temp Alert: Auto on >80°C

Run 'aliases cheatsheet' to view.
EOF
notify-send "Cheat Sheet Updated!" "See ~/cheatsheet.md"
cat $CHEAT  # Or open in terminal
