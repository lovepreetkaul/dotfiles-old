#!/bin/sh
# Basic Installation Script to install dotfiles on a new system.

# Stop the script if any command fails
set -e

# Backup current .zshrc and .vimrc
if [ -f ~/.zshrc ]; then cp -vf ~/.zshrc ~/.zshrc.backup
if [ -f ~/.vimrc ]; then cp -vf ~/.vimrc ~/.vimrc.backup
if [ -f ~/.alias ]; then cp -vf  ~/.alias ~/.alias.backup

rm -v .zshrc .vimrc .alias

# Symlink the zshrc and vimrc files
ln -sv "~/dotfiles/zshrc" ~/.zshrc
ln -sv "~/dotfiles/vimrc" ~/.vimrc
ln -sv "~/dotfiles/alias" ~/.alias
