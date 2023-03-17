#!/bin/bash

set -e # -e: exit on error

if [ -z "$USER" ]; then
	USER=$(id -un)
fi
cd "$HOME"
# Make passwordless sudo work
export SUDO_ASKPASS=/bin/true

GITHUB_USERNAME="pdotl"

# Install Homebrew if mac
if [[ "$OSTYPE" = "darwin"* ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure neovim is installed.
# TODO

# Install ripgrep, lazygit, shellcheck on codespaces
if [[ -n "$CODESPACES" ]]; then
	sudo apt update 2>&1 1>/dev/null && sudo apt-get install --no-install-recommends -y ripgrep >&1 1>/dev/null
fi

# Change shell to zsh
if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
	sudo chsh -s "/bin/zsh" "$USER"
fi

# Install and apply chezmoi regardless
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
