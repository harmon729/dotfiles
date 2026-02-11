#!/usr/bin/env bash

# Make vim the default editor.
export EDITOR='nvim'

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

export PAGER='less -RFX'

# Origin icon for Starship
if [ -f /etc/wsl.conf ]; then
  export CUSTOM_ORIGIN_SYMBOL=""
elif [ -n "$SSH_CLIENT" ]; then
  export CUSTOM_ORIGIN_SYMBOL=""
else
  export CUSTOM_ORIGIN_SYMBOL=""
fi
