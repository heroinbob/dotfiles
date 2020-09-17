#!/bin/bash
# NOTE: You must restore the public and private SSH keys from another secure source.

#
# Install Dependencies
#

sudo apt install fonts-powerline \
    hub \
	kitty \
	rbenv \
	silversearcher-ag \
	tmux \
	vim \
	zsh

# Visit https://github.com/JetBrains/JetBrainsMono and download the font.
unzip ~/Downloads/JetBrains.Mono.2.001.zip -d ~/.local/share/fonts && fc-cache -fv

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

# Only necessary if you use dnsmasq for custom domains like test, dev, etc.

#
# This gives us the ability to host ".test" domain locally
#
brew install dnsmasq
cp dnsmasq.conf /usr/local/etc/
echo "nameserver 127.0.0.1" > /etc/resolver/test
sudo brew services start dnsmasq

# This will update ruby-build because the binary itself will be horribly out of
# date!
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
