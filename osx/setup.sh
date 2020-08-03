#!/bin/bash
# NOTE: You must restore the public and private SSH keys from another secure source.

#
# Install Dependencies
#
# OSX Comes with brew...
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install the_silver_searcher
# NOTE: This is not needed in OSX Catalina...
#brew install reattach-to-user-namespace
brew install tmux
brew install vim
brew install kitty
brew tap homebrew/cask-fonts
brew cask install font-inconsolata-for-powerline
brew install rbenv

# Install oh my zsh and make it the default - this switches to ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#
# Config files
#
cp .gitconfig ~/
cp .tmux.conf ~/
cp .zshrc ~/
cp -R .config ~/
cp .ssh/config ~/.ssh

# ssh-keygen -t rsa -b 4096 -C "mackenzie.luceononuro@gmail.com"
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub

eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa

# Various 3rd Party Dependencies
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


# Set the color scheme for everything.
base16_atelier-lakeside
