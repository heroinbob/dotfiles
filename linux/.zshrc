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
plugins=(
    brew
    bundler
    docker
    git
    git-prompt
    gem
    git-hubflow
    rails
)

source $ZSH/oh-my-zsh.sh

#
# == My Customizations ==
#

# Non zero state means yes
export GIT_PS1_SHOWDIRTYSTATE=1

export TERM='xterm-256color'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

#
# PATHS
#
# Set NPM global path to a place I have control over (permissions)
export NPM_GLOBAL_PATH="$HOME/.npm-global/bin"
export MY_SCRIPTS_PATH="$HOME/scripts" # my custom scripts
export PATH="$MY_SCRIPTS_PATH:$NPM_GLOBAL_PATH:/usr/local/sbin:/usr/local/bin:$PATH"

# RBENV bootstrapping
if which rbenv > /dev/null
    then eval "$(rbenv init -)"
fi

# Alias'
alias ll='ls -l'

# I use vim. There. I said it.
export EDITOR=vim

#
# ================= My fun lil functions ==================================
#
function refresh_branch {
    git fetch origin
    git checkout $1
    git pull
}

function refresh_develop {
    refresh_branch develop
}

function refresh_master {
    refresh_branch master
}

function refresh_main_branches {
    refresh_develop
    refresh_master
}
