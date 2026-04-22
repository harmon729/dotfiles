#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y -- build-essential procps curl file git

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if ! command -v brew; then
  echo "export PATH=\"/home/linuxbrew/.linuxbrew/bin\":\"\$PATH\""
fi
