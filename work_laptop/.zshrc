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
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

#
# PATHS
#
export CELLAR_PATH=/usr/local/Cellar             # Files for brew installed kegs
export RBENV_PATH="$CELLAR_PATH/rbenv/1.1.1/bin" # rbenv executable path
export QT5_PATH="$CELLAR_PATH/qt5/5.3.2/bin"     # qt5 executable path
export NODE_PATH=/usr/local/lib/node_modules     # Node modules path
export GIT_PATH="$CELLAR_PATH/git/2.15.1/bin"
# Removed during EB env attempt to fix
#export PY_PATH=/usr/local/opt/python/libexec/bin
export MY_SCRIPTS_PATH="$HOME/scripts"           # my custom scripts
#export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem

# Include your github api token here!
export HOMEBREW_GITHUB_API_TOKEN=<YOUR TOKEN>

#export PATH="$PY_PATH:$MY_SCRIPTS_PATH:$RBENV_PATH:$QT5_PATH:$GIT_PATH/bin:/usr/local/bin:$PATH"
export PATH="$MY_SCRIPTS_PATH:$RBENV_PATH:$QT5_PATH:$GIT_PATH/bin:/usr/local/bin:$PATH"

# RBENV bootstrapping
if which rbenv > /dev/null
    then eval "$(rbenv init -)"
fi

# Alias'
alias attachq='bay attach queue-core'
alias ghf='git hf'
alias v='mvim -v'
alias ll='ls -l'
alias comp='docker-compose'

# Added for EB archanist!
export ARCANIST_INSTALL_DIR=/Users/jeffm/.evbdevtools
source $ARCANIST_INSTALL_DIR/devtools/scripts/devenv_bash/arcanist_helpers.sh

# I use neovim. There. I said it.
export EDITOR=nvim

# Soz we can run the bay command
export BAY_HOME=/Users/jeffm/eventbrite/docker-dev

# then make ZSH load virtualenvwrapper automatically
#source /Users/jeffm/Library/Python/2.7/bin/virtualenvwrapper.sh

#
export EB_WHEELHOUSE_HOST="jenkins.evbhome.com"
export EB_WHEELHOUSE_URL="https://$EB_WHEELHOUSE_HOST/view/wheelhouses/job/wheelhouse-index/lastSuccessfulBuild/artifact/16.04/index.html"

#alias eb-pip2-install="python2 -m pip install -U --find-links $EB_WHEELHOUSE_URL --trusted-host $EB_WHEELHOUSE_HOST"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
