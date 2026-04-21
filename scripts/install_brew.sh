#!/usr/bin/env bash

info "installing essential utilazations..."
sudo apt-get update -q &&
  sudo apt-get install build-essential procps curl file git -q -y &&
  info "utilazations install successfully"

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
