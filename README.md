# Henry's dotfiles

This is a highly opinionated configuration suitable for use on Mac OS X, Linux, and WSL as quickly as possible.

Direct installation of these configuration files is not recommended due to making zero attempts at non-permanent alterations. This repository is provided as a potential inspiration source for creating your own dotfiles.

## Dependency Overview

This CLI environment major components consists of the following projects:

* ZSH
* [oh-my-zsh](https://ohmyz.sh/)
* [powerlevel10k](https://github.com/romkatv/powerlevel10k)
* [Homebrew](https://brew.sh/)/[LinuxBrew](https://docs.brew.sh/Homebrew-on-Linux)
* [Neovim](https://neovim.io/)
* [LazyVim Starter](https://github.com/LazyVim/starter)
* [LazyVim](https://www.lazyvim.org/)
* A collection of [rust alternative system/cli tools](https://github.com/rust-unofficial/awesome-rust?tab=readme-ov-file#system-tools)

## Installation

These steps assume you already have HomeBrew/LinuxBrew installed and working.

1. `brew install bundle`
   * Downloads the required packages and utilities
2. Add the zsh configuration files to your `~/.zshrc`

```bash
echo '# Define the type of environment: personal, work, etc. Enables/Disables permitted functionality
export SYSTEM_USAGE_TYPE="work"
source <PATH_TO_THIS_REPOSITORY>/dotfiles/zsh/init.zsh' >> ~/.zshrc
source ~/.zshrc
```

3. Link Custom Configuration files to XDG_CONFIG_HOME

```bash
for i in .config/* ; do ; ln -s "$(pwd)/.config/$(basename $i)" "$XDG_CONFIG_HOME/"; done
```

4. Update the terminal editor to use [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
