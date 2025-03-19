# Determines the current working directory of init.zsh
local working_directory="${funcsourcetrace[1]%/*}"

# LazyGit Configuration
export XDG_CONFIG_HOME="$HOME/.config"
export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/config.yml,$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/lazygit/tokyonight_moon.yml"

# oh-my-zsh Configuration
source "$working_directory/oh-my-zsh-loader.zsh"

# eza Configuration
source "$working_directory/eza_configuration.zsh"

# SystemCtl Configuration
export SYSTEMD_EDITOR=nvim

# Custom Alias
alias vim="nvim"
