#!/bin/sh

set -e # -e: exit on error

GITHUB_USERNAME="pdotl"

# Install and apply chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
