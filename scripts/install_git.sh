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
sudo apt-get install -y software-properties-common stow
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get install -y git

DOTFILES="${HOME}/dotfiles"
if [[ ! -d "${DOTFILES}" ]]; then
  git clone --recursive "https://github.com/harmon729/dotfiles.git" "${DOTFILES}"
  info "clone dotfiles repo to ${DOTFILES}"
fi

stow --adopt -d "${DOTFILES}" -t "${HOME}" -- git

(
  cd "${DOTFILES}"
  git checkout .
)

info "solve probably problem"

stow -d "${DOTFILES}" -t "${HOME}" -- git

info "install git successfully"
