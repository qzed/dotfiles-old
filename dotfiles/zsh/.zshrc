# ZSH main configuration file.

# Common paths
ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

# Load configuration files.
source "${ZSH_CONFIG_DIR}/misc.zsh"
source "${ZSH_CONFIG_DIR}/zle.zsh"
source "${ZSH_CONFIG_DIR}/history.zsh"
source "${ZSH_CONFIG_DIR}/theme.zsh"
source "${ZSH_CONFIG_DIR}/completion.zsh"
source "${ZSH_CONFIG_DIR}/directories.zsh"
source "${ZSH_CONFIG_DIR}/aliases.zsh"
