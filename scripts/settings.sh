  #!/bin/bash
  choice=$(zenity --list --title="WehttamSnaps Settings" --text="Choose:" --column="Option" "Quickshell Widgets" "Rofi Themes" "Audio Routes" "Power Menu" "Update System")
  case $choice in
    "Quickshell Widgets") code $CONFIG_DIR/quickshell/init.lua ;;  # Edit
    "Rofi Themes") ~/.scripts/theme-switcher.sh ;;
    "Audio Routes") qpwgraph ;;
    "Power Menu") rofi -show power-menu ;;
    "Update System") yay -Syu && notify-send "Updated!" ;;
  esac
