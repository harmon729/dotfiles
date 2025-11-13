#!/usr/bin/env bash
# Dotfiles Installation Script
# This script helps set up symbolic links and machine-specific configurations

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Dotfiles Installation${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Function to create symlink with backup
create_symlink() {
    local source=$1
    local target=$2
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            echo -e "${YELLOW}Removing existing symlink: $target${NC}"
            rm "$target"
        else
            echo -e "${YELLOW}Backing up existing file: $target -> $target.backup${NC}"
            mv "$target" "$target.backup"
        fi
    fi
    
    echo -e "${GREEN}Creating symlink: $target -> $source${NC}"
    ln -sf "$source" "$target"
}

# Function to copy template file
copy_template() {
    local source=$1
    local target=$2
    local message=$3
    
    if [ -e "$target" ]; then
        echo -e "${YELLOW}File already exists: $target${NC}"
        read -p "Overwrite? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Skipping $target${NC}"
            return
        fi
        echo -e "${YELLOW}Backing up: $target -> $target.backup${NC}"
        mv "$target" "$target.backup"
    fi
    
    echo -e "${GREEN}Copying template: $source -> $target${NC}"
    cp "$source" "$target"
    
    if [ -n "$message" ]; then
        echo -e "${YELLOW}⚠️  $message${NC}"
    fi
}

echo -e "${GREEN}Installing universal configurations...${NC}"
echo ""

# Bash configurations
echo "📁 Setting up Bash..."
create_symlink "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"
create_symlink "$DOTFILES_DIR/bash/.bash_logout" "$HOME/.bash_logout"
create_symlink "$DOTFILES_DIR/bash/.config" "$HOME/.config/bash"

# Vim configuration
echo ""
echo "📁 Setting up Vim..."
create_symlink "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

# Tmux configuration
echo ""
echo "📁 Setting up Tmux..."
create_symlink "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Git global ignore
echo ""
echo "📁 Setting up Git global ignore..."
create_symlink "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Machine-Specific Configurations${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "The following configurations need to be customized for this machine:"
echo ""

# Git configuration
echo "📝 Git Configuration"
copy_template "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig" \
    "Remember to customize user.name, user.email, and core.excludesfile"

# Conda configuration
echo ""
echo "📝 Conda Configuration"
copy_template "$DOTFILES_DIR/conda/.condarc" "$HOME/.condarc" \
    "Customize channel mirrors based on your region"

# ble.sh configuration
echo ""
echo "📝 ble.sh Configuration"
copy_template "$DOTFILES_DIR/bash/.blerc" "$HOME/.blerc" \
    "Customize for your platform (WSL, Linux, macOS)"

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Next Steps${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "1. Customize machine-specific configurations:"
echo "   - Edit ~/.gitconfig (add your name and email)"
echo "   - Edit ~/.condarc (set appropriate mirrors)"
echo "   - Edit ~/.blerc (configure for your platform)"
echo ""
echo "2. Install dependencies:"
echo "   - ble.sh: See README.md for installation instructions"
echo "   - zoxide: curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash"
echo "   - starship: curl -sS https://starship.rs/install.sh | sh"
echo "   - nvm: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
echo "   - vim-plug: See README.md for installation instructions"
echo ""
echo "3. Create local override files if needed:"
echo "   - ~/.config/bash/.bashrc_local (for machine-specific bash settings)"
echo "   - ~/.vimrc_local (for machine-specific vim settings)"
echo ""
echo -e "${GREEN}Installation complete! ✨${NC}"
echo "Please restart your shell or run: source ~/.bashrc"
