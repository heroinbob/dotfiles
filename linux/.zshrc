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
    direnv
    docker
    docker-compose
    gh
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

#export TERM='xterm-256color'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

base16_atelier-lakeside

#
# PATHS
#
# Github Container Registry Personal Access Token
export GHCR_PAT="YOUR_GH_TOKEN"
# API Auth Token - personal access token
export GH_TOKEN="<VALUE>"
export MY_SCRIPTS_PATH="$HOME/scripts" # my custom scripts
export NPM_BIN_PATH="/home/jeff/.asdf/installs/nodejs/20.9.0/bin"
# The shims path somehow disappeared from my ENV after a system update.
# This had to be added manually. See https://asdf-vm.com/guide/getting-started.html
# NOTE: 12/1/2015 - The ASDF_DATA_DIR is /home/jeff/.asdf
export ASDF_SHIMS_PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
# export PATH="$MY_SCRIPTS_PATH:/usr/local/sbin:/usr/local/bin:$PATH"

# This was added when I installed aider
export MY_LOCAL_BIN="/home/jeff/.local/bin"

# The user local paths are in multiple places for some reason so for
# now do this instead.
export PATH="$MY_SCRIPTS_PATH:$ASDF_SHIMS_PATH:$NPM_BIN_PATH:$MY_LOCAL_BIN:$PATH"

# Alias'
alias ll='ls -l'
# alias develop_cli="kubectl -n develop exec -it deploy/veeps-web -- /app/bin/veeps_web remote console@{$MY_POD_IP}"
# alias onstage_cli="kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{\"\\n\"}}{{end}}' | grep onstage | xargs shuf -n1 -e | xargs -o -I{} kubectl exec -it {} -- /onstage/bin/onstage_web remote console@${MY_POD_IP}"
alias product_tracker_cli="kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{\"\\n\"}}{{end}}' | grep product-tracker | xargs shuf -n1 -e | xargs -o -I{} kubectl exec -it {} -- / remote console@${MY_POD_IP}"
# alias veeps_cli="kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{\"\\n\"}}{{end}}' | grep veeps-web | xargs shuf -n1 -e | xargs -o -I{} kubectl exec -it {} -- /app/bin/veeps_web remote console@${MY_POD_IP}"
alias veeps_pods_status="kubectl get pods -o wide | grep veeps"
alias ss="docker exec -it veeps-scylla-node1 nodetool status"
alias v=nvim
alias bless_caddy="sudo setcap cap_net_bind_service=+ep $(which caddy)"

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

. "$HOME/.local/bin/env"

# Pi
export PATH="/home/jeff/.asdf/installs/nodejs/24.13.1/bin:$PATH"
