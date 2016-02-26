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
export CELLAR_PATH=/usr/local/Cellar             # Files for brew installed kegs
export RBENV_PATH="$CELLAR_PATH/rbenv/0.4.0/bin" # rbenv executable path
export QT5_PATH="$CELLAR_PATH/qt5/5.3.2/bin"     # qt5 executable path
export NODE_PATH=/usr/local/lib/node_modules     # Node modules path
export GIT_PATH="$CELLAR_PATH/git/2.2.1/bin"
export MY_SCRIPTS_PATH="$HOME/scripts"           # my custom scripts

# Include your github api token here!
export HOMEBREW_GITHUB_API_TOKEN=!!!YOUR_TOKEN!!!

export PATH="$MY_SCRIPTS_PATH:$RBENV_PATH:$QT5_PATH:$GIT_PATH/bin:/usr/local/bin:$PATH"

# RBENV bootstrapping
if which rbenv > /dev/null
    then eval "$(rbenv init -)"
fi

# Alias'
alias ghf='git hf'
alias v='mvim -v'
alias ll='ls -l'
alias bes='bundle exec spring'
alias comp='docker-compose'

export ARCANIST_INSTALL_DIR=/Users/jeffm/.evbdevtools
source $ARCANIST_INSTALL_DIR/devtools/scripts/devenv_bash/arcanist_helpers.sh

# Configure Docker host for rails VM (Queue!)
eval "$(docker-machine env rails)"
