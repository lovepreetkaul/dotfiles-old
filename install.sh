# Basic Installation Script

# Backup current .zshrc and .vimrc
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.backup

# Symlink the zshrc and vimrc files
ln -sv "~/dotfiles/zshrc" ~/.zshrc
ln -sv "~/dotfiles/vimrc" ~/.vimrc
