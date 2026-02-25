#!/usr/bin/env zsh

alias l='ls -F'
alias la='ls -AF'
alias ll='ls -alFh'

alias c='clear'
alias q='exit'
alias t='type -a'

alias py='python3'
alias lg='lazygit'

alias shc='$EDITOR ${HOME}/.zshrc'
alias shr='omz reload'

# Redirect stderr to /dev/null
alias -g NE='2>/dev/null'

# Redirect stdout to /dev/null
alias -g NO='>/dev/null'

# Redirect both stdout and stderr to /dev/null
alias -g NUL='&>/dev/null'

# Access with ~name syntax, e.g., cd ~dot or ls ~dot
hash -d dot="$HOME/dotfiles/"
