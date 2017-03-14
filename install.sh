#!/bin/sh
# Basic Installation Script to install dotfiles on a new system.

# Stop the script if any command fails
set -e

# Install Vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Backup current .zshrc and .vimrc
if [ -f ~/.zshrc ]; then mv -vf ~/.zshrc ~/.zshrc.backup.$(date)
if [ -f ~/.vimrc ]; then mv -vf ~/.vimrc ~/.vimrc.backup
if [ -f ~/.alias ]; then mv -vf  ~/.alias ~/.alias.backup

# Symlink the zshrc and vimrc files
ln -sv "~/dotfiles/zshrc" ~/.zshrc
ln -sv "~/dotfiles/vimrc" ~/.vimrc
ln -sv "~/dotfiles/alias" ~/.alias
