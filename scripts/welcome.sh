#!/bin/bash
# WehttamSnaps Welcome
fastfetch --logo-type small --color "#8A2BE2"  # Custom with logo
notify-send "Welcome, Sir! (J.A.R.V.I.S.)" "Systems operational. Run 'update' for packages."
zenity --info --text="Keybinds: See cheatsheet alias\nMount 1TB: udisksctl mount -b /dev/sdX1\nWidgets: Super+W (Work), Super+G (Gaming)"
./scripts/update-cheatsheet.sh  # Generate
~/.scripts/jarvis-sounds.sh startup
