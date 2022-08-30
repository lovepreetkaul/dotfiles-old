#!/bin/bash

set -x

RELEASE=${1:-0.7}

logfile=$(mktemp)
exec 3<> "$logfile"
source_dir=$(mktemp -d)

echo "===> Installing prequisites"
sudo apt update >&3 2>&1
sudo apt-get install --no-install-recommends -y stow ripgrep ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen >&3 2>&1

echo "===> Cloning neovim"
pushd "$source_dir" &>/dev/null
git clone https://github.com/neovim/neovim >&3 2>&1

echo "===> Building neovim $RELEASE and its dependencies"
cd neovim
git checkout release-"$RELEASE" >&3 2>&1
make -j"$(nproc)" >&3 2>&1

echo "===> Installing the new neovim"
sudo make install >&3 2>&1

popd &>/dev/null
exec 3>&-
echo "Please see $logfile for additional output"

echo "===> Cleaning existing config."
rm -f $HOME/.zshrc
rm -rf $HOME/.config

echo "===> Installing dotfiles"
dir="$HOME/.config/nvim"
echo $dir
return
if [ ! -d $dir ]; then 
    mkdir -p $dir
fi
stow -vSt $HOME vim
stow -vSt $dir nvim
stow -vSt $HOME zsh

nvim +'PlugInstall --sync' 

# vim -Es -u $HOME/.vimrc -c "PlugInstall | qa"

sudo chsh -s "$(which zsh)" "$(whoami)"

