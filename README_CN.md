# Dotfiles 配置文件

个人开发工具和环境的配置文件集合。

## 📁 目录结构

本仓库将**通用配置**（可在所有机器上共享）与**机器特定设置**（需要根据机器定制）分开管理。

### 通用配置（在 git 中跟踪）

这些配置在所有机器上都可以工作，可以安全共享：

- **bash/**: Bash shell 配置
  - `.bashrc`: 主要的 bash 配置，采用模块化结构
  - `.bash_profile`: 登录 shell 配置
  - `.bash_logout`: 登出脚本
  - `.config/bash/`: 模块化的 bash 配置文件
    - `aliases.bash`: 命令别名
    - `exports.bash`: 环境变量
    - `path.bash`: PATH 配置
    - `plugins.bash`: 第三方插件初始化（zoxide, nvm, starship）
    - `prompt.bash`: Shell 提示符配置
    - `settings.bash`: 通用 bash 设置（历史记录、补全等）

- **vim/**: Vim 编辑器配置
  - `.vimrc`: 完整的 vim 配置及插件

- **tmux/**: 终端多路复用器配置
  - `.tmux.conf`: Tmux 设置和快捷键绑定

- **git/**: Git 版本控制配置
  - `.gitignore_global`: 全局 gitignore 模式（仅通用模式）

### 机器特定配置（需要定制）

这些配置包含机器特定或个人设置，应该根据每台机器进行定制：

- **git/.gitconfig**: 包含需要定制的个人信息：
  - 用户名和邮箱（需要根据机器定制）
  - 核心编辑器偏好
  - 凭证助手
  - 本地文件路径（例如 excludesfile）

- **conda/.condarc**: 包含地区特定的镜像设置：
  - 镜像 URL（当前设置为中国 USTC 镜像）
  - 应根据你的位置进行定制

- **bash/.blerc**: 包含平台特定的设置：
  - WSL 特定的 PATH 修改
  - 应根据你的平台进行定制

### 本地覆盖模式

多个配置文件支持本地覆盖以便进行机器特定的定制：

1. **Bash**: 创建 `~/.config/bash/.bashrc_local` 用于本地 bash 定制
2. **Vim**: 创建 `~/.vimrc_local` 用于本地 vim 定制

这些本地文件：
- 如果存在会自动加载
- 不在版本控制中跟踪（在 `.gitignore` 中列出）
- 适合用于机器特定的别名、路径或设置

## 🚀 安装

### 初始设置

1. 克隆本仓库：
   ```bash
   git clone https://github.com/harmon729/dotfiles.git ~/dotfiles
   ```

2. 为通用配置创建符号链接：
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
   
   # Git 全局忽略
   ln -sf ~/dotfiles/git/.gitignore_global ~/.gitignore_global
   ```

3. **定制机器特定配置**：

   **对于 Git**：复制模板并定制：
   ```bash
   cp ~/dotfiles/git/.gitconfig ~/.gitconfig
   # 然后编辑 ~/.gitconfig 添加你的个人信息：
   # - 将 user.name 改为你的名字
   # - 将 user.email 改为你的邮箱
   # - 如果需要，更新 core.excludesfile 路径
   ```

   **对于 Conda**：复制并根据你的地区定制：
   ```bash
   cp ~/dotfiles/conda/.condarc ~/.condarc
   # 然后编辑 ~/.condarc 使用适合你所在位置的镜像
   ```

   **对于 ble.sh（可选）**：复制并根据你的平台定制：
   ```bash
   cp ~/dotfiles/bash/.blerc ~/.blerc
   # 然后编辑 ~/.blerc 进行平台特定设置
   ```

4. 安装所需依赖：

   **Bash 依赖**：
   ```bash
   # ble.sh (Bash 行编辑器)
   git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
   make -C ble.sh install PREFIX=~/.local
   
   # zoxide (智能 cd 命令)
   curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
   
   # starship (跨 shell 提示符)
   curl -sS https://starship.rs/install.sh | sh
   
   # nvm (Node 版本管理器)
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   ```

   **Vim 依赖**：
   ```bash
   # vim-plug (插件管理器)
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   
   # 安装插件
   vim +PlugInstall +qall
   
   # The Silver Searcher (用于更快的搜索)
   # Ubuntu/Debian:
   sudo apt install silversearcher-ag
   # macOS:
   brew install the_silver_searcher
   ```

### 使用安装脚本（推荐）

我们提供了一个自动化安装脚本：

```bash
cd ~/dotfiles
./install.sh
```

该脚本会：
- 自动创建所有必要的符号链接
- 复制模板文件到你的主目录
- 备份现有文件
- 提供下一步的指导

## 📝 定制指南

### 添加机器特定设置

**对于 Bash**：创建 `~/.config/bash/.bashrc_local`：
```bash
# 示例：添加机器特定别名
alias work='cd /path/to/work/directory'
export SPECIAL_VAR='machine-specific-value'
```

**对于 Vim**：创建 `~/.vimrc_local`：
```vim
" 示例：机器特定的 vim 设置
set background=light
colorscheme different-theme
```

### 不应包含在本仓库中的内容

❌ **不要包含**：
- 个人信息（真实姓名、邮箱地址）
- 机器特定路径（例如 `/home/username/specific/path`）
- 组织/公司特定配置
- API 密钥、令牌或凭证
- 地区特定设置（镜像 URL、语言偏好）
- 平台特定配置（除非有明确文档说明且可选）

✅ **应该包含**：
- 在任何地方都能工作的通用设置
- 可移植的软件特定配置
- 文档和设置说明
- 机器特定配置的模板

## 🔧 维护

### 更新配置

1. 在克隆的仓库中编辑文件
2. 测试更改
3. 提交并推送以保持各机器间的 dotfiles 同步

### 同步到新机器

```bash
cd ~/dotfiles
git pull
# 根据需要重新运行安装步骤
```

## 🌏 地区特定说明

### 中国大陆用户

对于在中国大陆的用户，建议使用国内镜像以获得更快的下载速度：

**Conda 镜像**（已在模板中提供，取消注释即可使用）：
- USTC 镜像（中国科学技术大学）
- 清华镜像
- 北外镜像

**其他工具的国内镜像**：
- npm: `npm config set registry https://registry.npmmirror.com`
- pip: 在 `~/.pip/pip.conf` 中配置清华或阿里云镜像

## 📚 其他资源

- [Dotfiles GitHub 主题](https://dotfiles.github.io/)
- [GNU Stow](https://www.gnu.org/software/stow/) - 替代的符号链接管理工具
- [Dotbot](https://github.com/anishathalye/dotbot) - 自动化 dotfiles 安装

## 📄 许可证

这是个人配置仓库。可根据需要自由使用和改编。
