# WehttamSnaps Zsh Configuration

# Starship prompt
eval "$(starship init zsh)"

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Aliases
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias cat='bat'
alias grep='rg'
alias find='fd'

# System aliases
alias update='sudo pacman -Syu && yay -Syu'
alias clean='yay -Sc --noconfirm && sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null'
alias mirrors='sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# J.A.R.V.I.S. aliases
alias jarvis-gaming='~/.local/bin/jarvis/gaming-mode.sh'
alias jarvis-streaming='~/.local/bin/jarvis/streaming-mode.sh'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# WehttamSnaps specific
alias game-drive='cd /run/media/wehttamsnaps/LINUXDRIVE-1'
alias steam-fix='steam -clearbeta && steam'

# Show fastfetch on new terminal
fastfetch
