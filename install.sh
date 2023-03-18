#!/bin/bash

set -e # -e: exit on error

function install_neovim() {
	if command -v nvim; then return 1; fi
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	./nvim.appimage --appimage-extract
	./squashfs-root/AppRun --version
	sudo mv squashfs-root /
	sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
}

if [ -z "$USER" ]; then
	USER=$(id -un)
fi

cd "$HOME"

# Make passwordless sudo work
export SUDO_ASKPASS=/bin/true

GITHUB_USERNAME="pdotl"

# Ensure neovim is installed.
if ! command -v nvim; then
	install_neovim
fi

# Install packages
# if [[ -n "$CODESPACES" ]]; then
# 	sudo apt update 1>/dev/null &
# 	sudo apt-get install --no-install-recommends -y ripgrep >&1 1>/dev/null
# fi

# Install asdf and ruby

# Change shell to zsh
if [[ "$SHELL" != "/bin/zsh" ]]; then
	sudo chsh -s "/bin/zsh" "$USER"
fi

# Install and apply chezmoi regardless
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
