#!/usr/bin/env bash

set -e

# Color Output Helpers
info() { echo -e "\e[32m[INFO] $*\e[0m"; }
warn() { echo -e "\e[33m[WARN] $*\e[0m"; }
error() {
  echo -e "\e[31m[ERROR] $*\e[0m"
  exit 1
}

sudo apt-get update && sudo apt-get install -y -- zsh curl stow fzf

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

mkdir -p "${HOME}/.config"
stow -d "${DOTFILES}" -t "${HOME}" -- "zsh" "starship"

info "install zsh successfully"

if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  sh -c "KEEP_ZSHRC=yes $(curl -fsSL https://install.ohmyz.sh)" "" --unattended
fi

info "omz installed"

# ZSH_CUSTOM="${HOME}/.config/zsh/plugins/"
# if [[ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]]; then
#   git clone https://github.com/zsh-users/zsh-autosuggestions "${CUSTOM_PLUG}/zsh-autosuggestions"
# fi
# if [[ ! -d "${CUSTOM_PLUG}/plugins/zsh-syntax-highlighting" ]]; then
#   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${CUSTOM_PLUG}/zsh-syntax-highlighting"
# fi
if ! command -v zoxide; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi
if ! command -v pixi; then
  curl -fsSL https://pixi.sh/install.sh | PIXI_NO_PATH_UPDATE=1 sh
fi

chsh -s "$(which zsh)"

info "set default login shell to $(which zsh)"
