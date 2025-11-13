# Dotfiles Structure Diagram

## Repository Organization

```
dotfiles/
│
├── 📄 README.md              # English documentation
├── 📄 README_CN.md           # Chinese documentation  
├── 📄 ORGANIZATION.md        # Organization summary
├── 🔧 install.sh             # Installation script
├── 📄 .gitignore             # Excludes local overrides
│
├── 🌍 Universal Configurations (tracked in git)
│   │
│   ├── bash/                 # Bash shell configurations
│   │   ├── .bashrc           # Main bash config (loads modules)
│   │   ├── .bash_profile     # Login shell setup
│   │   ├── .bash_logout      # Logout script
│   │   └── .config/bash/     # Modular bash configs
│   │       ├── aliases.bash  # Command aliases
│   │       ├── exports.bash  # Environment variables
│   │       ├── path.bash     # PATH configuration
│   │       ├── plugins.bash  # Plugin initialization
│   │       ├── prompt.bash   # Shell prompt
│   │       ├── settings.bash # General settings
│   │       └── starship.toml # Starship prompt theme
│   │
│   ├── vim/                  # Vim editor configuration
│   │   └── .vimrc            # Complete vim config
│   │
│   ├── tmux/                 # Tmux configuration
│   │   └── .tmux.conf        # Tmux settings
│   │
│   └── git/                  # Git configuration
│       └── .gitignore_global # Universal ignore patterns
│
├── 📋 Machine-Specific Templates (need customization)
│   │
│   ├── git/.gitconfig        # Template: Add your name/email
│   ├── conda/.condarc        # Template: Choose your mirrors
│   └── bash/.blerc           # Template: Platform-specific
│
└── 💻 Local Overrides (not tracked, user creates)
    │
    ├── ~/.config/bash/.bashrc_local  # Machine-specific bash
    └── ~/.vimrc_local                 # Machine-specific vim

```

## Configuration Flow

### Universal Configuration Flow

```
User opens shell
    ↓
~/.bash_profile (loads environment)
    ↓
~/.bashrc (loads modules)
    ↓
├── settings.bash    (general settings)
├── exports.bash     (environment variables)
├── path.bash        (PATH configuration)
├── aliases.bash     (command aliases)
├── plugins.bash     (zoxide, nvm, starship)
└── .bashrc_local    (if exists - machine-specific)
    ↓
Shell ready with all configurations
```

### Machine-Specific Setup Flow

```
Clone repository
    ↓
Run ./install.sh
    ↓
├── Creates symlinks for universal configs
│   ├── ~/.bashrc → ~/dotfiles/bash/.bashrc
│   ├── ~/.vimrc → ~/dotfiles/vim/.vimrc
│   └── ~/.tmux.conf → ~/dotfiles/tmux/.tmux.conf
│
└── Copies templates for customization
    ├── ~/dotfiles/git/.gitconfig → ~/.gitconfig
    ├── ~/dotfiles/conda/.condarc → ~/.condarc
    └── ~/dotfiles/bash/.blerc → ~/.blerc
    ↓
User customizes templates
    ↓
├── Edit ~/.gitconfig (add name/email)
├── Edit ~/.condarc (choose mirrors)
└── Edit ~/.blerc (platform settings)
    ↓
Installation complete
```

## File Type Classification

### ✅ Universal Files (Safe to Share)

**Characteristics:**
- No personal information
- No machine-specific paths
- No regional settings
- Work across all platforms

**Examples:**
```bash
# aliases.bash - Universal command aliases
alias ll='ls -alFh'
alias ..='cd .. && la'

# settings.bash - Universal bash settings
HISTSIZE=32768
shopt -s histappend
```

### ⚙️ Software-Specific Files (Documented)

**Characteristics:**
- Require specific software installed
- Configuration is universal
- Dependencies documented

**Examples:**
```bash
# plugins.bash - Requires external tools
eval "$(zoxide init bash)"     # Requires: zoxide
eval "$(starship init bash)"   # Requires: starship
source "$NVM_DIR/nvm.sh"       # Requires: nvm
```

### 🔧 Machine-Specific Templates (Need Customization)

**Characteristics:**
- Contain personal information (commented out)
- Have machine-specific paths
- Include regional settings
- Provided as templates

**Examples:**
```bash
# .gitconfig template
[user]
    # CUSTOMIZE: Replace with your name and email
    # name = Your Name
    # email = your.email@example.com

# .condarc template
# OPTIONAL: For users in China, uncomment:
# default_channels:
#   - https://mirrors.ustc.edu.cn/anaconda/pkgs/main
```

### 💻 Local Override Files (Not Tracked)

**Characteristics:**
- Created by user per machine
- Never tracked in git
- Listed in .gitignore
- Loaded automatically if present

**Examples:**
```bash
# ~/.config/bash/.bashrc_local
alias work='cd /specific/machine/path'
export MACHINE_SPECIFIC_VAR='value'

# ~/.vimrc_local
set background=light
colorscheme personal-preference
```

## Installation Patterns

### Pattern 1: Symlink (Universal Configs)

```bash
# Universal files are symlinked to track changes
ln -sf ~/dotfiles/bash/.bashrc ~/.bashrc

# Benefits:
# - Changes in repo immediately available
# - Easy to sync across machines
# - Version controlled
```

### Pattern 2: Copy (Machine-Specific Configs)

```bash
# Templates are copied and customized
cp ~/dotfiles/git/.gitconfig ~/.gitconfig

# Benefits:
# - Each machine has unique settings
# - No risk of committing personal info
# - Template provides starting point
```

### Pattern 3: Local Override (Optional Customization)

```bash
# User creates local files as needed
cat > ~/.config/bash/.bashrc_local << 'EOF'
# My custom settings
EOF

# Benefits:
# - No changes to tracked files
# - Machine-specific without templates
# - Automatically loaded if exists
```

## Maintenance Workflow

### Updating Universal Configs

```bash
# On any machine:
cd ~/dotfiles
vim bash/.config/aliases.bash  # Make changes
git add bash/.config/aliases.bash
git commit -m "Add new alias"
git push

# On other machines:
cd ~/dotfiles
git pull
# Changes automatically available (symlinked)
```

### Updating Machine-Specific Configs

```bash
# Each machine maintains its own:
vim ~/.gitconfig        # Edit machine-specific config
# No git operations needed
# Each machine keeps its own version
```

### Adding New Software Config

Decision tree:
```
Is it universal?
├── Yes → Add to repo directly
│   └── Example: Add new bash alias
│
└── No → Does it contain personal info?
    ├── Yes → Create template
    │   └── Example: New tool with API key
    │
    └── No → Is it required?
        ├── Yes → Add with documentation
        │   └── Example: New plugin
        │
        └── No → Add as optional
            └── Example: Platform-specific tool
```

## Quick Reference

### What Goes Where?

| Configuration Type | Location | Tracked? | Symlinked? |
|-------------------|----------|----------|------------|
| Universal settings | `~/dotfiles/bash/` | ✅ Yes | ✅ Yes |
| Personal info | Template in repo → `~/` | ❌ No | ❌ No |
| Regional settings | Template in repo → `~/` | ❌ No | ❌ No |
| Machine-specific | `~/.bashrc_local` | ❌ No | ❌ No |
| Software configs | `~/dotfiles/vim/` etc | ✅ Yes | ✅ Yes |

### Command Quick Reference

```bash
# Setup new machine
git clone <repo> ~/dotfiles && cd ~/dotfiles && ./install.sh

# Sync universal configs
cd ~/dotfiles && git pull

# Add machine-specific setting
echo "alias myalias='cmd'" >> ~/.config/bash/.bashrc_local

# Update universal config
cd ~/dotfiles && vim <file> && git add <file> && git commit && git push

# Check what's customized
ls -la ~ | grep -v "^l"  # Show non-symlinked files in home
```
