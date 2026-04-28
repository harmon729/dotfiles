#!/usr/bin/env bash

set -e

# Color Output Helpers
info() { echo -e "\e[32m[INFO] $*\e[0m"; }
warn() { echo -e "\e[33m[WARN] $*\e[0m"; }
error() {
  echo -e "\e[31m[ERROR] $*\e[0m"
  exit 1
}

if ! command -v brew; then
  export PATH="/home/linuxbrew/.linuxbrew/bin":"$PATH"
fi

if ! command -v pixi; then
  export PATH="${HOME}/.pixi/bin":"$PATH"
fi

sudo apt-get update
sudo apt-get install -y git

DOTFILES="${HOME}/dotfiles"
if [[ ! -d "${DOTFILES}" ]]; then
  git clone --recursive "https://github.com/harmon729/dotfiles.git" "${DOTFILES}"
  info "clone dotfiles repo to ${DOTFILES}"
fi

bash "${DOTFILES}/scripts/install_git.sh"
bash "${DOTFILES}/scripts/install_brew.sh"
bash "${DOTFILES}/scripts/install_zsh.sh"
bash "${DOTFILES}/scripts/install_nvim.sh"
bash "${DOTFILES}/scripts/install_tmux.sh"

info "install successfully"
