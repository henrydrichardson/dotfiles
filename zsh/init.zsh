# Determines the current working directory of init.zsh
local working_directory="${funcsourcetrace[1]%/*}"

# LazyGit Configuration
export XDG_CONFIG_HOME="$HOME/.config"
export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/config.yml,$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/lazygit/tokyonight_moon.yml"

# eza Configuration
source "$working_directory/eza_configuration.zsh"

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  aws
  docker
  docker-compose
  fzf
  git
  git-prompt
  gitfast
  helm
  kubectl
  minikube
  pyenv
  rbenv
  you-should-use
  zsh-autosuggestions
  zsh-bat
  zsh-syntax-highlighting
)

alias vim="nvim"

# Update Frequency Settings
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# ZSH Completion Settings
LISTMAX=200

eval "$(pyenv init --path)"
eval "$(zoxide init zsh)"
