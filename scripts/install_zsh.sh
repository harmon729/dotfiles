#!/usr/bin/env bash

set -e

# Color Output Helpers
info() { echo -e "\e[32m[INFO] $*\e[0m"; }
warn() { echo -e "\e[33m[WARN] $*\e[0m"; }
error() {
  echo -e "\e[31m[ERROR] $*\e[0m"
  exit 1
}

sudo apt-get update && sudo apt-get install -y -- zsh curl stow
brew install fzf starship

DOTFILES="${HOME}/dotfiles"
if [[ ! -d "${DOTFILES}" ]]; then
  git clone --recursive "https://github.com/harmon729/dotfiles.git" "${DOTFILES}"
  info "clone dotfiles repo to ${DOTFILES}"
fi

stow --adopt -d "${DOTFILES}" -t "${HOME}" -- "zsh" "starship"

(
  cd "${DOTFILES}"
  git checkout .
)

info "solve probably problem"

stow -d "${DOTFILES}" -t "${HOME}" -- "zsh" "starship"

info "install zsh successfully"

if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  sh -c "KEEP_ZSHRC=yes $(curl -fsSL https://install.ohmyz.sh)" "" --unattended
fi

info "omz installed"

if ! command -v zoxide; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi
if ! command -v pixi; then
  curl -fsSL https://pixi.sh/install.sh | PIXI_NO_PATH_UPDATE=1 sh
fi

chsh -s "$(which zsh)"

info "set default login shell to $(which zsh)"
