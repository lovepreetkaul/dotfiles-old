#/usr/bin/env ruby

# dotfiles Installation script


def command_exists? (command)
  `sh -c "command -v #{command}"`
end

def linux?
  (/linux/ =~ RUBY_PLATFORM) != nil
end

def ubuntu?
  `uname -a`.downcase.include? "ubuntu"
end

def stow_vim
  dir = "~/.config/nvim"
  system("mkdir -p #{dir}") unless system("[ -d #{dir} ]")
  system("stow -vSt ~ vim")
  system("stow -vSt #{dir} nvim")
end

def stow_zsh
  file = "~/.zshrc"
  system("mv -vf #{file} #{file}.bak") if system("[ -f #{file} ] && [ ! -L #{file} ]")
  system("stow -vSt ~ zsh")
end

def install_packages (packages)
  return true if stow_exists?
  if ubuntu?
    update_cache = "/var/lib/apt/lists"
    `sudo apt update` unless Dir.exists?(update_cache) or Dir.empty?(update_cache)  

    `sudo echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections`
    `sudo apt -y -q install #{packages}`
  end
end 


# Main
exit(127) unless linux?

packages = %w( bat fuse dialog apt-utils libfuse2)
install_packages
install_neovim
if stow?
  stow_vim
  stow_zsh
else
  link_files
end

