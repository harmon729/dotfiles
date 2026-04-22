#!/usr/bin/env bash

set -e

# Color Output Helpers
info() { echo -e "\e[32m[INFO] $*\e[0m"; }
warn() { echo -e "\e[33m[WARN] $*\e[0m"; }
error() {
  echo -e "\e[31m[ERROR] $*\e[0m"
  exit 1
}

sudo apt-get update
sudo apt-get install -y -- git stow

pixi global install python=3.12 nodejs=24

brew install neovim ripgrep fd lazygit tree-sitter-cli

DOTFILES="${HOME}/dotfiles"
if [[ ! -d "${DOTFILES}" ]]; then
  git clone --recursive "https://github.com/harmon729/dotfiles.git" "${DOTFILES}"
  info "clone dotfiles repo to ${DOTFILES}"
fi

stow --adopt -d "${DOTFILES}" -t "${HOME}" -- nvim

(
  cd "${DOTFILES}"
  git checkout .
)

info "solve probably problem"

stow -d "${DOTFILES}" -t "${HOME}" -- nvim

info "install nvim successfully"
