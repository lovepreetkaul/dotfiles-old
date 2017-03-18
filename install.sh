#!/bin/bash
# Basic Installation Script to install dotfiles on a new system.
# 
# Stop the script if any command fails
set -e

#
# OS Detection
#
CURRENT_OS='Linux'
DISTRO=''
INFO=$(cat /etc/[A-Za-z]*[_-][rv]e[lr]*)

# Assuming Linux, determine distro
# 
if [[ $(echo $INFO | grep -q "CentOS") -eq 0 ]]; then
    DISTRO="CentOS"
fi

if [[ $(echo $INFO | grep -q "Fedora") -eq 0 ]]; then
    DISTRO="Fedora"
fi

if [[ $(echo $INFO | grep -q "RHEL" ) -eq 0 ]]; then
    DISTRO="RHEL"
fi

if [[ $(echo $INFO | grep -q "Debian" ) -eq 0 ]]; then
    DISTRO="Debian"
fi

if [[ $(echo $INFO |  grep -q "Ubuntu" ) -eq 0 ]]; then
    DISTRO="Ubuntu"
fi


# Check if zsh is installed.
INSTALL_ZSH=1
CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)
  if [  $CHECK_ZSH_INSTALLED -ge 1 ]; then # Add the ! back after testing
    printf "Zsh is not installed! Do you want to install zsh?[y/N]!\n"
    read decision
    case "$decision" in
       [yY][eE][sS]|[yY])
			INSTALL_ZSH=0
			;;
		*)
			INSTALL_ZSH=1
			exit 1
			;;
    esac
  fi
unset CHECK_ZSH_INSTALLED

# Installation of ZSH

if [[ $INSTALL_ZSH -eq 0 ]]; then
	if [[ $DISTRO -eq "Ubuntu" ]]; then
		sudo apt install zsh -y
	fi
fi

# Install Vim-plug if not installed
FILE=~/.vim/autoload/plug.vim
if [ ! -f "$FILE" ]
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


# Make sure to run :PlugUpdate once the Vim-Plug installation completes
