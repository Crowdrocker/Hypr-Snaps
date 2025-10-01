  #!/bin/bash
  choice=$(rofi -dmenu -p "WehttamSnaps Power" -theme ~/dotfiles/rofi/power.rasi << EOF
  Lock
  Logout
  Suspend
  Reboot
  Shutdown
  EOF
  )
  case $choice in
    Lock) swaylock ;;  # Or hyprlock
    Logout) hyprctl dispatch exit ;;
    Suspend) systemctl suspend ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
  esac
  # Sound: paplay jarvis-shutdown on shutdown
