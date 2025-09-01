#!/usr/bin/env bash
# ~/.bash_profile
# Executed by login shells. Its main purpose is to set up the environment.

BASH_MODULES_DIR="$HOME/.config/bash"

if [ -f "$BASH_MODULES_DIR/path.bash" ] && [ -r "$BASH_MODULES_DIR/path.bash" ] ; then
    # shellcheck source=./.config/bash/path.bash
    source "$BASH_MODULES_DIR/path.bash"
fi

# Load ~/.exports for environment variables.
if [ -r "$BASH_MODULES_DIR/exports.bash" ] && [ -f "$BASH_MODULES_DIR/exports.bash" ] ; then
    # shellcheck source=./.config/bash/exports.bash
    source "$BASH_MODULES_DIR/exports.bash"
fi

# Load ~/.bashrc files for interactive settings.
if [ -r "$HOME/.bashrc" ] && [ -f "$HOME/.bashrc" ] ; then
    source "$HOME/.bashrc"
fi
