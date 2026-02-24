#!/usr/bin/env zsh

# Pixi
eval "$(pixi completion --shell zsh)"

# Vim
bindkey -M viins 'jk' vi-cmd-mode
