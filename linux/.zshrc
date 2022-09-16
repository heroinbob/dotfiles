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
    asdf
    bundler
    docker
    git
    git-prompt
    gem
    mix
    npm
    rails
    tmux
)

source $ZSH/oh-my-zsh.sh

#
# == My Customizations ==
#

# Non zero state means yes
#export GIT_PS1_SHOWDIRTYSTATE=1

export TERM='xterm-256color'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

#
# PATHS
#
# Github Container Registry Personal Access Token
export GHCR_PAT="YOUR_GH_TOKEN"
export MY_SCRIPTS_PATH="$HOME/scripts" # my custom scripts
export PATH="$MY_SCRIPTS_PATH:/usr/local/sbin:/usr/local/bin:$PATH"

# Alias'
alias ll='ls -l'
alias onstage_cli="kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{\"\\n\"}}{{end}}' | grep onstage | xargs shuf -n1 -e | xargs -o -I{} kubectl exec -it {} -- /onstage/bin/onstage_web remote console@${MY_POD_IP}"
alias veeps_cli="kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{\"\\n\"}}{{end}}' | grep veeps-web | xargs shuf -n1 -e | xargs -o -I{} kubectl exec -it {} -- /veeps/bin/veeps_web remote console@${MY_POD_IP}"
alias veeps_export_env="export $(cat .env | xargs)"

# I use vim. There. I said it.
export EDITOR=vim

export GPG_TTY=$(tty)

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

function refresh_main {
    refresh_branch main
}

function refresh_main_branches {
    refresh_develop
    refresh_main
}
