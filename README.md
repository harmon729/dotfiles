# Dotfiles Configuration

Personal configuration files (dotfiles) for bash, git, vim, tmux, and conda.

## ⚠️ Privacy Notice

**Before using these dotfiles, please be aware:**

This repository contains personal information that should be customized for your own use:

### Files Requiring Customization

#### 1. Git Configuration (`git/.gitconfig`)
Contains personal user information:
```ini
[user]
    email = xhx1719@gmail.com  # ← Change this to your email
    name = Harmon Hsu           # ← Change this to your name
```

**Action Required:** Update lines 4-5 in `git/.gitconfig` with your own email and name.

#### 2. Git Credential Storage
The git configuration uses `credential.helper = store` which stores credentials in **plaintext**. Consider using a more secure alternative:

- **macOS:** `git config --global credential.helper osxkeychain`
- **Windows:** `git config --global credential.helper wincred`
- **Linux:** `git config --global credential.helper libsecret` or `cache`

## 📋 What's Included

### Bash Configuration
- `.bashrc` - Main bash configuration
- `.bash_profile` - Login shell configuration
- `.config/bash/` - Modular bash configurations:
  - `aliases.bash` - Command aliases
  - `exports.bash` - Environment variables
  - `path.bash` - PATH configuration
  - `settings.bash` - Shell settings
  - `prompt.bash` - Custom prompt
  - `plugins.bash` - Plugin initializations (zoxide, nvm, starship)

### Git Configuration
- `.gitconfig` - Git user configuration and aliases
- `.gitignore_global` - Global gitignore patterns

### Vim Configuration
- `.vimrc` - Comprehensive vim configuration with plugins

### Tmux Configuration
- `.tmux.conf` - Tmux settings and keybindings

### Conda Configuration
- `.condarc` - Conda package manager settings (configured with USTC mirrors)

## 🚀 Installation

1. **Clone this repository:**
   ```bash
   git clone https://github.com/harmon729/dotfiles.git
   cd dotfiles
   ```

2. **⚠️ IMPORTANT: Customize personal information:**
   ```bash
   # Edit git config with your information
   nano git/.gitconfig
   # Update email and name fields
   ```

3. **Create symbolic links** (example for bash):
   ```bash
   ln -sf ~/dotfiles/bash/.bashrc ~/.bashrc
   ln -sf ~/dotfiles/bash/.bash_profile ~/.bash_profile
   # ... repeat for other configs as needed
   ```

4. **Source the new configuration:**
   ```bash
   source ~/.bashrc
   ```

## 🔒 Privacy & Security

A comprehensive privacy audit has been performed on this repository. See [PRIVACY_AUDIT.md](PRIVACY_AUDIT.md) for details.

### Summary
- ✅ No passwords, API keys, or credentials are stored in this repository
- ⚠️ Contains personal email address and name in git configuration
- ℹ️ Credential helper is set to "store" (plaintext storage)

### Recommendations
1. Update personal information in `.gitconfig` before use
2. Consider more secure credential storage methods
3. Review all configuration files for personal preferences
4. Keep sensitive data in local config files (e.g., `.gitconfig.local`)

## 📦 Dependencies

Some configurations require external tools to be installed:

### Bash
- [ble.sh](https://github.com/akinomyoga/ble.sh) - Bash Line Editor
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Smarter cd command
- [starship](https://starship.rs/) - Cross-shell prompt
- [nvm](https://github.com/nvm-sh/nvm) - Node Version Manager (optional)

### Vim
- [vim-plug](https://github.com/junegunn/vim-plug) - Plugin manager
- [ag (The Silver Searcher)](https://github.com/ggreer/the_silver_searcher) - For faster searching

Install vim plugins after setting up `.vimrc`:
```bash
vim +PlugInstall +qall
```

## 🛠️ Customization

Feel free to customize these dotfiles for your own needs. The configurations are modular and well-commented.

### Adding Local Customizations

You can add machine-specific settings without modifying tracked files:

**Bash:** Create `~/.config/bash/.bashrc_local`  
**Vim:** Create `~/.vimrc_local`

These files are sourced by the main configs but can be kept private.

## 📝 License

Feel free to use and modify these configurations for your personal use.

## 🔗 Resources

- [Dotfiles GitHub](https://dotfiles.github.io/) - Community dotfiles resources
- [Git Configuration Documentation](https://git-scm.com/docs/git-config)
- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)

---

**Note:** These are personal configuration files. Always review and understand configuration files before using them on your system.
