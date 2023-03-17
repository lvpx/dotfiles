#!/bin/bash

set -e # -e: exit on error

GITHUB_USERNAME="pdotl"

# Install Homebrew if mac
if [[ "$OSTYPE" = "darwin"* ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure neovim is installed.
# TODO

# Install and apply chezmoi regardless
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

# Install ripgrep, lazygit, shellcheck on codespaces
if [[ -n "$CODESPACES" ]]; then
	sudo apt update 2>&1 && sudo apt-get install --no-install-recommends -y ripgrep lazygit >&1
fi

# Change shell to zsh
if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
	chsh -s "$(which zsh)"
fi
