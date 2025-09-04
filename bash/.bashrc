# ~/.bashrc

[[ $- = *i* ]] || return

source -- "${HOME}/.local/share/blesh/ble.sh" --attach=none

BASH_MODULES_DIR="$HOME/.config/bash"

# Functions
if [[ -f "$BASH_MODULES_DIR/functions.bash" && -r "$BASH_MODULES_DIR/functions.bash" ]] ; then
    # shellcheck source=./.config/bash/functions.bash
    source "$BASH_MODULES_DIR/functions.bash"
fi

# Allow local customizations in the ~/.bashrc_local_before file
if [[ -f "$BASH_MODULES_DIR/.bashrc_local" && -r "$BASH_MODULES_DIR/.bashrc_local" ]] ; then
    # shellcheck source=./.config/bash/.bashrc_local
    source "$BASH_MODULES_DIR/.bashrc_local"
fi

# Settings
if [[ -f "$BASH_MODULES_DIR/settings.bash" && -r "$BASH_MODULES_DIR/settings.bash" ]] ; then
    # shellcheck source=./.config/bash/settings.bash
    source "$BASH_MODULES_DIR/settings.bash"
fi

# # Bootstrap
# if [[ -f "$BASH_MODULES_DIR/bootstrap.bash" && -r "$BASH_MODULES_DIR/bootstrap.bash" ]] ; then
#     # shellcheck source=./.config/bash/bootstrap.bash
#     source "$BASH_MODULES_DIR/bootstrap.bash"
# fi

# # External settings
# if [[ -f "$BASH_MODULES_DIR/external.bash" && -r "$BASH_MODULES_DIR/external.bash" ]] ; then
#     # shellcheck source=./.config/bash/external.bash
#     source "$BASH_MODULES_DIR/external.bash"
# fi

# Aliases
if [[ -f "$BASH_MODULES_DIR/aliases.bash" && -r "$BASH_MODULES_DIR/aliases.bash" ]] ; then
    # shellcheck source=./.config/bash/aliases.bash
    source "$BASH_MODULES_DIR/aliases.bash"
fi

# Custom prompt
if [[ -f "$BASH_MODULES_DIR/prompt.bash" && -r "$BASH_MODULES_DIR/prompt.bash" ]] ; then
    # shellcheck source=./.config/bash/prompt.bash
    source "$BASH_MODULES_DIR/prompt.bash"
fi

# Plugins
if [[ -f "$BASH_MODULES_DIR/plugins.bash" && -r "$BASH_MODULES_DIR/plugins.bash" ]] ; then
    # shellcheck source=./.config/bash/plugins.bash
    source "$BASH_MODULES_DIR/plugins.bash"
fi

# # Allow local customizations in the ~/.shell_local_after file
# if [[ -f "$BASH_MODULES_DIR/.shell_local_after" && -r "$BASH_MODULES_DIR/.shell_local_after" ]] ; then
#     # shellcheck source=./.config/bash/.shell_local_after
#     source "$BASH_MODULES_DIR/.shell_local_after"
# fi

# # Allow local customizations in the ~/.bashrc_local_after file
# if [[ -f "$BASH_MODULES_DIR/.bashrc_local_after" && -r "$BASH_MODULES_DIR/.bashrc_local_after" ]] ; then
#     # shellcheck source=./.config/bash/.bashrc_local_after
#     source "$BASH_MODULES_DIR/.bashrc_local_after"
# fi

# # Allow private customizations (not checked in to version control)
# if [[ -f "$BASH_MODULES_DIR/.shell_private" && -r "$BASH_MODULES_DIR/.shell_private" ]] ; then
#     # shellcheck source=./.config/bash/.shell_private
#     source "$BASH_MODULES_DIR/.shell_private"
# fi

[[ ! ${BLE_VERSION-} ]] || ble-attach
