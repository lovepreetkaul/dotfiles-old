#
# Global fixes
#

# Ensure languages are set
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Ensure editor is set
export EDITOR=vim

# This fixes using SSH in urxvt
if [[ $TERM == 'rxvt-unicode' ]] ; then
    export TERM='xterm'
fi

# Use zsh-completions if it exists
if [[ -d "/usr/local/share/zsh-completions" ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

unset GREP_OPTIONS

# Adding .local/bin and bin to $PATH
export PATH=~/.local/bin:~/bin:$PATH

#
# Antigen 
#

source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle mercurial
#antigen bundle heroku
#antigen bundle pip
#antigen bundle lein
antigen bundle command-not-found

# Zsh completions
antigen bundle zsh-users/zsh-completions

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme lovepreetkaul/zsh-themes themes/senti.zsh-theme
#antigen theme steeef
# Tell antigen that you're done.
antigen apply

if [ -f ~/.alias ]
    then
    source ~/.alias
fi

if [ -f ~/.alias_spec ]
    then
    source ~/.alias_spec
fi




[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
