# Dotfiles Organization Summary

## 问题和解决方案 / Problem and Solution

### 问题 (Problem)
原始的 dotfiles 仓库混合了三种类型的配置：
1. 通用配置（可在所有机器上使用）
2. 软件特定配置（需要特定软件才能使用）
3. 机器特定配置（个人信息、本地路径、地区设置）

The original dotfiles repository mixed three types of configurations:
1. Universal configurations (work on all machines)
2. Software-specific configurations (require specific software)
3. Machine-specific configurations (personal info, local paths, regional settings)

### 解决方案 (Solution)
重新组织仓库，明确区分配置类型，并为机器特定配置提供模板。

Reorganized the repository to clearly separate configuration types and provide templates for machine-specific configurations.

## 变更详情 / Changes Made

### 1. 文档 / Documentation

**新增文件 / New Files:**
- `README.md` - 英文文档，详细说明仓库结构和使用方法
- `README_CN.md` - 中文文档，方便中文用户理解
- `ORGANIZATION.md` - 本文件，总结组织结构
- `install.sh` - 自动化安装脚本

### 2. 通用配置 / Universal Configurations

**保持不变（已经是通用的）/ Kept Universal:**
- `bash/.bashrc` - Bash 主配置
- `bash/.bash_profile` - Bash 登录配置
- `bash/.bash_logout` - Bash 登出脚本
- `bash/.config/bash/*.bash` - 模块化 Bash 配置
- `bash/.config/starship.toml` - Starship 提示符配置（已添加注释）
- `vim/.vimrc` - Vim 配置
- `tmux/.tmux.conf` - Tmux 配置
- `git/.gitignore_global` - 全局 Git 忽略模式

### 3. 机器特定配置模板 / Machine-Specific Templates

**转换为模板 / Converted to Templates:**

#### `git/.gitconfig`
**之前 / Before:**
- 包含个人邮箱：`xhx1719@gmail.com`
- 包含个人姓名：`Harmon Hsu`
- 包含机器特定路径：`/home/devcontainers/.gitignore_global`

**现在 / Now:**
- 移除了个人信息
- 添加了详细的安装说明
- 提供了配置模板和示例
- 用户需要复制并自定义此文件

#### `conda/.condarc`
**之前 / Before:**
- 硬编码了中国 USTC 镜像

**现在 / Now:**
- 使用默认 conda channels
- 将中国镜像设置作为注释提供
- 添加了其他地区镜像的说明
- 用户可以根据地区选择合适的镜像

#### `bash/.blerc`
**之前 / Before:**
- 包含 WSL 特定配置（直接执行）

**现在 / Now:**
- 将 WSL 配置改为可选（注释）
- 添加了平台自定义说明
- 适合所有平台使用

### 4. 本地覆盖支持 / Local Override Support

**更新的 `.gitignore` / Updated `.gitignore`:**
添加了以下模式以排除本地配置文件：
- `*_local` - 所有本地配置文件
- `*_local_*` - 所有本地配置变体
- `*.local` - 所有 .local 文件
- 编辑器和系统临时文件

**已支持的本地覆盖 / Supported Local Overrides:**
- `~/.config/bash/.bashrc_local` - Bash 本地自定义
- `~/.vimrc_local` - Vim 本地自定义

### 5. 安装脚本 / Installation Script

**`install.sh` 功能 / Features:**
- 自动创建符号链接
- 复制模板文件
- 备份现有文件
- 彩色输出和提示
- 提供下一步指导

## 配置分类 / Configuration Categories

### ✅ 通用配置（保留在仓库中）/ Universal (Keep in Repo)

这些配置可以安全地在所有机器上共享：
- Bash 设置和别名
- Vim 插件和键绑定
- Tmux 配置
- Git 通用忽略规则
- Starship 提示符主题

These configurations are safe to share across all machines:
- Bash settings and aliases
- Vim plugins and keybindings
- Tmux configuration
- Git universal ignore rules
- Starship prompt theme

### ⚙️ 软件特定配置（已文档化）/ Software-Specific (Documented)

需要安装特定软件才能使用：
- ble.sh (Bash Line Editor)
- zoxide (智能 cd)
- starship (提示符)
- nvm (Node 版本管理)
- vim-plug (Vim 插件管理)

Require specific software to be installed:
- ble.sh (Bash Line Editor)
- zoxide (smart cd)
- starship (prompt)
- nvm (Node version management)
- vim-plug (Vim plugin management)

### 🔧 机器特定配置（使用模板）/ Machine-Specific (Use Templates)

需要根据每台机器自定义：
- Git 用户信息（姓名、邮箱）
- Git 本地路径
- Conda 镜像设置（根据地区）
- 平台特定设置（WSL、Linux、macOS）

Need customization per machine:
- Git user info (name, email)
- Git local paths
- Conda mirror settings (based on region)
- Platform-specific settings (WSL, Linux, macOS)

## 使用指南 / Usage Guide

### 新机器设置 / New Machine Setup

```bash
# 1. 克隆仓库 / Clone repository
git clone https://github.com/harmon729/dotfiles.git ~/dotfiles

# 2. 运行安装脚本 / Run installation script
cd ~/dotfiles
./install.sh

# 3. 自定义机器特定配置 / Customize machine-specific configs
# 编辑 ~/.gitconfig 添加你的信息
# Edit ~/.gitconfig to add your information

# 编辑 ~/.condarc 选择合适的镜像
# Edit ~/.condarc to choose appropriate mirrors

# 如需要，编辑 ~/.blerc
# Edit ~/.blerc if needed

# 4. 安装依赖软件 / Install dependencies
# 参见 README.md 中的说明
# See instructions in README.md
```

### 本地自定义 / Local Customizations

对于机器特定的设置，创建本地覆盖文件：

For machine-specific settings, create local override files:

```bash
# Bash 本地设置 / Bash local settings
cat > ~/.config/bash/.bashrc_local << 'EOF'
# My machine-specific aliases
alias work='cd /path/to/my/work'
export MY_CUSTOM_VAR='value'
EOF

# Vim 本地设置 / Vim local settings
cat > ~/.vimrc_local << 'EOF'
" My machine-specific vim settings
set background=light
EOF
```

## 最佳实践 / Best Practices

### ✅ 应该提交到仓库 / Should Commit to Repo
- 通用配置和设置
- 可移植的别名和函数
- 文档和注释
- 配置模板

- Universal configurations and settings
- Portable aliases and functions
- Documentation and comments
- Configuration templates

### ❌ 不应该提交到仓库 / Should NOT Commit to Repo
- 个人信息（姓名、邮箱）
- 机器特定路径
- API 密钥和令牌
- 公司/组织特定配置
- 地区特定设置

- Personal information (name, email)
- Machine-specific paths
- API keys and tokens
- Company/organization-specific configs
- Region-specific settings

## 维护 / Maintenance

### 同步更新 / Syncing Updates

在一台机器上更新配置后：
After updating configurations on one machine:

```bash
cd ~/dotfiles
git add .
git commit -m "Update configuration"
git push
```

在其他机器上同步：
Sync on other machines:

```bash
cd ~/dotfiles
git pull
# 如果有新的通用配置，可能需要重新创建符号链接
# May need to recreate symlinks if there are new universal configs
```

### 添加新配置 / Adding New Configurations

添加新软件的配置时，考虑：
When adding configurations for new software, consider:

1. 这个配置是通用的吗？→ 直接添加到仓库
   Is this configuration universal? → Add directly to repo

2. 包含个人信息吗？→ 创建模板
   Contains personal info? → Create a template

3. 是地区特定的吗？→ 提供选项或模板
   Is it region-specific? → Provide options or template

4. 需要特定软件吗？→ 在文档中说明依赖
   Requires specific software? → Document dependencies

## 总结 / Summary

通过这次重组：
This reorganization achieves:

1. **清晰的结构** - 每个配置的用途都很明确
   **Clear Structure** - Purpose of each configuration is clear

2. **易于分享** - 可以安全地公开分享仓库
   **Easy Sharing** - Safe to publicly share the repository

3. **灵活定制** - 支持本地覆盖和机器特定设置
   **Flexible Customization** - Supports local overrides and machine-specific settings

4. **完善文档** - 中英文文档和自动化脚本
   **Complete Documentation** - Bilingual docs and automation scripts

5. **最佳实践** - 遵循 dotfiles 社区的最佳实践
   **Best Practices** - Follows dotfiles community best practices
