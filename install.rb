#/usr/bin/env ruby

# Script to ensure stow runs all config post installation

def stow_exists?
  system('sh -c "command -v stow"')
end

def stow_vim
  dir = "~/.config/nvim"
  system("mkdir -p #{dir}") unless system("[ -d #{dir} ]")
  system("stow -vSt ~ vim")
  system("stow -vSt #{dir} nvim")
end

def stow(name)
  system("stow -vSt ~ #{name}")
end

# Steps
# Check if stow is installed. Exit if not
# Run stow on files in the repo and symlink to correct locations
# Ensure files don't already exist there, backup them if they do.
# Ensure directories exist, create them if they don't
exit(127) unless stow_exists?
stow_vim
stow "zsh"
