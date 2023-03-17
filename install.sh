#!/bin/sh

set -e # -e: exit on error

GITHUB_USERNAME="pdotl"

# Check which OS

# Install Homebrew if mac

# Install Neovim based on OS

# Install and apply chezmoi regardless
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

# Take action based on codespace or not
# Install ripgrep, lazygit

# Ensure zsh is used
chsh -s /bin/zsh
source ~/.zshrc
