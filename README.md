# Henry's dotfiles

This is a highly opinionated configuration suitable for use on Mac OS X, Linux, and WSL as quickly as possible.

This repository is provided as a potential inspiration source for creating your own dotfiles.

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

These steps assume you already have Nix/Home-Manager installed and working.

```bash
ln -s "$(pwd)/home.nix" "$XDG_CONFIG_HOME/home-manager/home.nix"
```
