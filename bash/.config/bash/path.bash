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

if [ -d "/home/harmon/.pixi/bin" ]; then
  PATH="/home/harmon/.pixi/bin:$PATH"
fi

export PATH
