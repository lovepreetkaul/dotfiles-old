#!/bin/bash
# Basic Installation Script to install dotfiles on a new system.
# Zsh check taken from Robby Russell OMZ install script
# Stop the script if any command fails
set -e

#
# OS Detection
#

UNAME=`uname`

# Fallback info
CURRENT_OS='Linux'
DISTRO=''

if [[ $UNAME == 'Darwin' ]]; then
    CURRENT_OS='OS X'
else
    # Must be Linux, determine distro
    if [[ -f /etc/redhat-release ]]; then
        # CentOS or Redhat?
        if grep -q "CentOS" /etc/redhat-release; then
            DISTRO='CentOS'
        else
            DISTRO='RHEL'
        fi
    fi
fi

echo $DISTRO



# Check if zsh is installed.
CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)
  if [ ! $CHECK_ZSH_INSTALLED -ge 1 ]; then
    printf "Zsh is not installed! Please install zsh first!\n"
    exit
  fi
unset CHECK_ZSH_INSTALLED


# Install Vim-plug if not installed
FILE=~/.vim/autoload/plug.vim
if [ ! -f "$FILE" ]
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


# Make sure to run :PlugUpdate once the Vim-Plug installation completes
