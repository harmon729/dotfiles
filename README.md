# Dotfiles

Personal configuration files for various development tools and environments.

## 📁 Structure

This repository is organized to separate **universal configurations** (shareable across all machines) from **machine-specific settings** (should be customized per machine).

### Universal Configurations (tracked in git)

These configurations work across all machines and are safe to share:

- **bash/**: Bash shell configuration
  - `.bashrc`: Main bash configuration with modular structure
  - `.bash_profile`: Login shell configuration
  - `.bash_logout`: Logout script
  - `.config/bash/`: Modular bash configuration files
    - `aliases.bash`: Command aliases
    - `exports.bash`: Environment variables
    - `path.bash`: PATH configuration
    - `plugins.bash`: Third-party plugin initialization (zoxide, nvm, starship)
    - `prompt.bash`: Shell prompt configuration
    - `settings.bash`: General bash settings (history, completion, etc.)

- **vim/**: Vim editor configuration
  - `.vimrc`: Complete vim configuration with plugins

- **tmux/**: Terminal multiplexer configuration
  - `.tmux.conf`: Tmux settings and key bindings

- **git/**: Git version control configuration
  - `.gitignore_global`: Global gitignore patterns (universal patterns only)

### Machine-Specific Configurations (need customization)

These configurations contain machine-specific or personal settings that should be customized per machine:

- **git/.gitconfig**: Contains personal information that should be customized:
  - User name and email (customize per machine)
  - Core editor preference
  - Credential helper
  - Local file paths (e.g., excludesfile)

- **conda/.condarc**: Contains region-specific mirror settings:
  - Mirror URLs (currently set to China USTC mirrors)
  - Should be customized based on your location

- **bash/.blerc**: Contains platform-specific settings:
  - WSL-specific PATH modifications
  - Should be customized based on your platform

### Local Override Pattern

Several configuration files support local overrides for machine-specific customizations:

1. **Bash**: Create `~/.config/bash/.bashrc_local` for local bash customizations
2. **Vim**: Create `~/.vimrc_local` for local vim customizations

These local files are:
- Automatically loaded if they exist
- Not tracked in version control (listed in `.gitignore`)
- Perfect for machine-specific aliases, paths, or settings

## 🚀 Installation

### Initial Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/harmon729/dotfiles.git ~/dotfiles
   ```

2. Create symbolic links for universal configurations:
   ```bash
   # Bash
   ln -sf ~/dotfiles/bash/.bashrc ~/.bashrc
   ln -sf ~/dotfiles/bash/.bash_profile ~/.bash_profile
   ln -sf ~/dotfiles/bash/.bash_logout ~/.bash_logout
   ln -sf ~/dotfiles/bash/.config ~/.config/bash
   
   # Vim
   ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
   
   # Tmux
   ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
   
   # Git global ignore
   ln -sf ~/dotfiles/git/.gitignore_global ~/.gitignore_global
   ```

3. **Customize machine-specific configurations**:

   **For Git**: Copy the template and customize it:
   ```bash
   cp ~/dotfiles/git/.gitconfig ~/.gitconfig
   # Then edit ~/.gitconfig to add your personal information:
   # - Change user.name to your name
   # - Change user.email to your email
   # - Update core.excludesfile path if needed
   ```

   **For Conda**: Copy and customize for your region:
   ```bash
   cp ~/dotfiles/conda/.condarc ~/.condarc
   # Then edit ~/.condarc to use mirrors appropriate for your location
   ```

   **For ble.sh (optional)**: Copy and customize for your platform:
   ```bash
   cp ~/dotfiles/bash/.blerc ~/.blerc
   # Then edit ~/.blerc for platform-specific settings
   ```

4. Install required dependencies:

   **Bash dependencies**:
   ```bash
   # ble.sh (Bash Line Editor)
   git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
   make -C ble.sh install PREFIX=~/.local
   
   # zoxide (smart cd command)
   curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
   
   # starship (cross-shell prompt)
   curl -sS https://starship.rs/install.sh | sh
   
   # nvm (Node Version Manager)
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   ```

   **Vim dependencies**:
   ```bash
   # vim-plug (plugin manager)
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   
   # Install plugins
   vim +PlugInstall +qall
   
   # The Silver Searcher (for faster searching)
   # Ubuntu/Debian:
   sudo apt install silversearcher-ag
   # macOS:
   brew install the_silver_searcher
   ```

## 📝 Customization Guide

### Adding Machine-Specific Settings

**For Bash**: Create `~/.config/bash/.bashrc_local`:
```bash
# Example: Add machine-specific aliases
alias work='cd /path/to/work/directory'
export SPECIAL_VAR='machine-specific-value'
```

**For Vim**: Create `~/.vimrc_local`:
```vim
" Example: Machine-specific vim settings
set background=light
colorscheme different-theme
```

### What Should NOT Be in This Repository

❌ **Don't include**:
- Personal information (real names, email addresses)
- Machine-specific paths (e.g., `/home/username/specific/path`)
- Organization/company-specific configurations
- API keys, tokens, or credentials
- Region-specific settings (mirror URLs, language preferences)
- Platform-specific configurations (unless clearly documented and optional)

✅ **Do include**:
- Universal settings that work everywhere
- Software-specific configurations that are portable
- Documentation and setup instructions
- Templates for machine-specific configurations

## 🔧 Maintenance

### Updating Configurations

1. Edit files in the cloned repository
2. Test changes
3. Commit and push to keep dotfiles synchronized across machines

### Syncing to a New Machine

```bash
cd ~/dotfiles
git pull
# Re-run installation steps as needed
```

## 📚 Additional Resources

- [Dotfiles GitHub Topic](https://dotfiles.github.io/)
- [GNU Stow](https://www.gnu.org/software/stow/) - Alternative symlink management
- [Dotbot](https://github.com/anishathalye/dotbot) - Automated dotfiles installation

## 📄 License

This is a personal configuration repository. Feel free to use and adapt as needed.
