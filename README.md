# Dotfiles

This is my dotfiles repo. The configuration is managed using GNU Stow.

## Installation 

Install GNU Stow.

```bash

$ wget http://ftp.gnu.org/gnu/stow/stow-latest.tar.gz && tar -xvzf stow-latest.tar.gz
$ cd stow-2.3.1\nsudo sh configure && make
$ sudo cp bin/stow  /usr/bin
$ stow --version
```
Clone the repo to a suitable location.

## Usage

```bash
# Call stow to symlink files in the directory to those in repo
$ stow -vSt ~ zsh
$ stow -vSt ~ vim


```
