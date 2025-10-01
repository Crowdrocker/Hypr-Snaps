# WehttamSnaps Zsh
export EDITOR=vim
export QT_QPA_PLATFORMTHEME=qt5ct
eval \$(/usr/bin/starship init zsh)
plugins=(git zsh-autosuggestions)
source /usr/share/oh-my-zsh/oh-my-zsh.sh

# Aliases
alias update='yay -Syu'
alias gamelaunch='gamemoderun'
alias mount-drive='udisksctl mount -b /dev/sdX1'  # For 1TB SSD
alias cheatsheet='$DOTS_DIR/scripts/update-cheatsheet.sh'

# GPG tweaks (improved)
export GPG_TTY=\$(tty)
