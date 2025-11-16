#!/usr/bin/env bash
# ~/.bash_profile
# Executed by login shells. Its main purpose is to set up the environment.

# Load ~/.bashrc files for interactive settings.
if [ -r "$HOME/.bashrc" ] && [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi
