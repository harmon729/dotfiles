#!/usr/bin/env bash

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "/usr/lib/wsl/lib" ]; then
  PATH="/usr/lib/wsl/lib:$PATH"
fi

export PATH
