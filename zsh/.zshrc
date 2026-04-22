# ~/.zhsrc

# [begin] zsh-profiler
# zmodload zsh/zprof

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# OMZ config

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode auto      # update automatically without asking
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$HOME/.config/zsh"

# Plugins
plugins=(git zoxide vi-mode vi-mode-fix zsh-autosuggestions zsh-syntax-highlighting)
VI_MODE_SET_CURSOR=true

# Load OMZ
source $ZSH/oh-my-zsh.sh

# User config

# Starship init
(( $+commands[starship] )) && eval "$(starship init zsh)"

# [end] Pair with `zmodload zsh/zprof`
# zprof
