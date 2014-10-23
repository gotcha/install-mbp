#!/bin/sh

SOFTWARE_DOWNLOAD=~/auto/software
USR=gotcha

# install brew

if [ ! -f "/usr/local/bin/brew" ]
then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
fi

# install brew packages

BREW_FORMULA="tmux stow jpeg openjpeg vifm ssh-copy-id mutt"

brew install $BREW_FORMULA

# dotfiles

if [ ! -d $HOME/dotfiles ]
then
    git clone git@github.com:gotcha/dotfiles.git $HOME/dotfiles
fi
stow -d $HOME/dotfiles -t /$HOME stow
stow -d $HOME/dotfiles -t /$HOME git iterm vim tmux buildout

# configure git

git config --global user.name "Godefroid Chapelle"
git config --global user.email gotcha@bubblenet.be
git config --global push.default simple
git config --global core.excludesfile ~/.gitignore_global

# ssh key
SSH_KEY=$HOME/.ssh/id_dsa
if [ ! -f $SSH_KEY ]
then
    ssh-keygen -q -t dsa -f $SSH_KEY -N ""
fi

# configure github

ssh -T git@github.com 2>&1 -i $SSH_KEY >/dev/null | grep $USR > /dev/null
if [ $? -ne 0 ]
then
    echo "Public key should be uploaded to github.com"
    cat $SSH_KEY.pub
fi

# powerline fonts

if [ ! -f "$HOME/Library/Fonts/Droid Sans Mono for Powerline.otf" ]
then
    git clone git@github.com:Lokaltog/powerline-fonts.git $HOME/tmp/powerline-fonts
    $HOME/tmp/powerline-fonts/install.sh
    rm -rf $HOME/tmp/powerline-fonts
fi

# install own python

if [ ! -d "$HOME/software" ]
then
    mkdir $HOME/software
fi

if [ ! -d "$HOME/bin" ]
then
    mkdir $HOME/bin
fi
 
 
BUILDOUT=$HOME/software/buildout.python
if [ ! -d $BUILDOUT ]
then
    git clone git@github.com:collective/buildout.python.git $BUILDOUT
fi

if [ ! -f $BUILDOUT/python27.cfg ]
then
    cat >$BUILDOUT/python27.cfg << endcfg

[buildout]
extends = src/base.cfg src/python27.cfg src/links.cfg
python-buildout-root = \${buildout:directory}/src
parts += install-links

[install-links]
prefix = $HOME

endcfg
fi

if [ ! -f $BUILDOUT/bin/buildout ]
then
    python $BUILDOUT/bootstrap.py -c $BUILDOUT/python27.cfg
    $BUILDOUT/bin/buildout -c $BUILDOUT/python27.cfg
fi

# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
defaults write -g com.apple.keyboard.fnState -boolean true
