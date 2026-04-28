#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y -- build-essential procps curl file git

BREW_ROOT="/home/linuxbrew/.linuxbrew"
if [[ -d "${BREW_ROOT}" ]]; then
  sudo chown -R "$(whoami)" "${BREW_ROOT}"
fi

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if ! command -v brew; then
  echo "export PATH=\"/home/linuxbrew/.linuxbrew/bin\":\"\$PATH\""
fi
