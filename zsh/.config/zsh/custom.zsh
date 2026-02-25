#!/usr/bin/env zsh

# Pixi
eval "$(pixi completion --shell zsh)"

# Vim
bindkey -M viins 'jk' vi-cmd-mode

# auto-cmd
function auto_la() {
  la
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd auto_la
