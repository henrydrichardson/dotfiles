# oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
eval "$(pyenv init --path)"
eval "$(zoxide init zsh)"

ZSH_THEME="powerlevel10k/powerlevel10k"

custom_plugins_directory="$ZSH/custom/plugins/"

# Custom plugins
# A dictionary of plugin name to github project
declare -A custom_plugins=(
  ["you-should-use"]="MichaelAquilina/zsh-you-should-use.git"
  ["zsh-autosuggestions"]="zsh-users/zsh-autosuggestions"
  ["zsh-bat"]="fdellwing/zsh-bat.git"
  ["zsh-syntax-highlighting"]="zsh-users/zsh-syntax-highlighting.git"
  ["zsh-eza"]="z-shell/zsh-eza.git"
)

for key val in "${(@kv)custom_plugins}";
do
  # install or update custom plugins
  if [ ! -d "${custom_plugins_directory}/${key}" ]; then
    git clone https://github.com/${val} $custom_plugins_directory/${key} &> /dev/null
  else
    # Lauch a subshell to perform git updates
    $(cd "$custom_plugins_directory/${key}" && git pull &> /dev/null)
  fi
done

# Load plugins into oh-my-zsh
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
  zsh-eza
)

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# ZSH Completion Settings
LISTMAX=200
source $ZSH/oh-my-zsh.sh
