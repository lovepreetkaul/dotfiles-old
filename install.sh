#!/bin/bash

set -x

#RELEASE=${1:-0.7}

#logfile=$(mktemp)
#exec 3<> "$logfile"
#source_dir=$(mktemp -d)

echo "===> Installing prequisites"
sudo apt update 2>&1
sudo apt-get install --no-install-recommends -y stow ripgrep ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen  2>&1

#echo "===> Cloning neovim"
#pushd "$source_dir" &>/dev/null
#git clone https://github.com/neovim/neovim >&3 2>&1
#
#echo "===> Building neovim $RELEASE and its dependencies"
#cd neovim
#git checkout release-"$RELEASE" >&3 2>&1
#make -j"$(nproc)" >&3 2>&1
#
#echo "===> Installing the new neovim"
#sudo make install >&3 2>&1
#
#popd &>/dev/null
#exec 3>&-
#echo "Please see $logfile for additional output"

echo "===> Cleaning existing config."
rm -f $HOME/.zshrc
rm -rf $HOME/.config
rm -f $HOME/.tmux.conf

echo "===> Installing dotfiles"
NVIM_DIR="$HOME/.config/nvim"

if [ ! -d $NVIM_DIR ]; then 
    mkdir -p $NVIM_DIR
fi
stow -vSt $HOME vim
stow -vSt $NVIM_DIR nvim
stow -vSt $HOME zsh
stow -vSt $HOME tmux

nvim +'PlugInstall --sync' 

# vim -Es -u $HOME/.vimrc -c "PlugInstall | qa"

#sudo chsh -s "$(which zsh)" "$(whoami)"
