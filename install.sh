#!/bin/sh

set -e # -e: exit on error

GITHUB_USERNAME="pdotl"

# Install Homebrew if mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi]

# Ensure neovim is installed. brew works on both Codespaces and mac
if ! command -v nvim &> /dev/null; then
  brew install neovim
fi

# Install and apply chezmoi regardless
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

# Install ripgrep, lazygit, shellcheck on codespaces
[[ ! -z "$CODESPACES" ]] && apt install -y ripgrep lazygit shellcheck

# Change shell to zsh
if ! grep -q "root.*/bin/zsh" /etc/passwd; then
	chsh -s /bin/zsh root
fi
