#!/bin/sh
# Basic Installation Script to install dotfiles on a new system.

# Stop the script if any command fails
set -e

# Install Vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Make sure to run :PlugUpdate once the Vim-Plug installation completes
