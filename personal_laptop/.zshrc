# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew bundler gem git-hubflow rails)

source $ZSH/oh-my-zsh.sh

#
# == My Customizations ==
#

# Non zero state means yes
export GIT_PS1_SHOWDIRTYSTATE=1

export TERM='xterm-256color'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

#
# PATHS
#
export RBENV_PATH="$HOME/.rbenv/bin" # rbenv executable path
export GIT_PATH="$CELLAR_PATH/git/2.2.1/bin"
export PATH="$RBENV_PATH:$PATH"

# RBENV bootstrapping
if which rbenv > /dev/null
    then eval "$(rbenv init -)"
fi

# Alias'
alias ghf='git hf'
alias ll='ls -l'
alias bes='bundle exec spring'
