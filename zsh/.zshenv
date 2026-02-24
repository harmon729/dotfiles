# ~/.zshenv

typeset -U path

[[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Cargo env must sourced in .zshenv
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

path=(
  "$HOME/.pixi/bin"(N)
  "$HOME/bin"(N)
  "$HOME/.local/bin"(N)
  "$HOME/.cargo/bin"(N)
  $path
  "/usr/lib/wsl/lib"(N)
)

# Make nvim the default editor.
export EDITOR='nvim'

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'

export PAGER='less -RFX'

export KEYTIMEOUT=25

# Origin icon for Starship
if [ -f /etc/wsl.conf ]; then
  export CUSTOM_ORIGIN_SYMBOL=""
elif [ -n "$SSH_CLIENT" ]; then
  export CUSTOM_ORIGIN_SYMBOL=""
else
  export CUSTOM_ORIGIN_SYMBOL=""
fi
