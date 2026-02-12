#!/usr/bin/env bash

# extension config: zoxide 0412
eval "$(zoxide init bash)"
# source ~/.local/share/blesh/ble.sh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

eval "$(pixi completion --shell bash)"
