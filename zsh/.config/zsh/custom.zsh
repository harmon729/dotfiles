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

# zmv
# Usage examples:
# zmv '(*).log' '$1.txt'           # Rename .log to .txt
# zmv -w '*.log' '*.txt'           # Same thing, simpler syntax
# zmv -n '(*).log' '$1.txt'        # Dry run (preview changes)
# zmv -i '(*).log' '$1.txt'        # Interactive mode (confirm each)
# Enable zmv
autoload -Uz zmv
# Helpful aliases for zmv
alias zcp='zmv -C'  # Copy with patterns
alias zln='zmv -L'  # Link with patterns
