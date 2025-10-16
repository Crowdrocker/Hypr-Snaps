# WehttamSnaps Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Starship prompt
eval "$(starship init zsh)"

# Environment
export EDITOR="nvim"
export TERMINAL="ghostty"
export BROWSER="firefox"

# Aliases
alias update='paru -Syu'
alias ls='eza --icons'
alias ll='eza -l --icons'
alias sysinfo='fastfetch'

# Show fastfetch
fastfetch
