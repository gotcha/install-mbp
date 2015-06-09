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

BREW_FORMULA="tmux stow jpeg openjpeg vifm ssh-copy-id mutt wget shellcheck gnu-sed vim hg git go bazaar pv sqlite poppler gstreamer gst-plugins-good tig wv pygobject3 libffi gtk+3 dbus gst-libav gdb openconnect"

brew install $BREW_FORMULA

# use gnu-sed as sed
if [ ! -f /usr/local/bin/sed ]
then
    ln -s /usr/local/bin/gsed /usr/local/bin/sed
fi

# dotfiles

if [ ! -d $HOME/dotfiles ]
then
    git clone git@github.com:gotcha/dotfiles.git $HOME/dotfiles
fi
stow -d $HOME/dotfiles -t /$HOME stow
stow -d $HOME/dotfiles -t /$HOME git iterm vim tmux buildout mutt zsh ssh bash hg

# configure git

git config --global user.name "Godefroid Chapelle"
git config --global user.email gotcha@bubblenet.be
git config --global push.default simple
git config --global core.excludesfile ~/.gitignore_global
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.lol 'log --graph --decorate --pretty=oneline --abbrev-commit'
git config --global alias.lola 'log --graph --decorate --pretty=oneline --abbrev-commit --all'

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

if [ ! -f $BUILDOUT/python.cfg ]
then
    cat >$BUILDOUT/python.cfg << endcfg

[buildout]
extends = src/base.cfg src/python34.cfg src/python27.cfg src/links.cfg
python-buildout-root = \${buildout:directory}/src
parts = python-2.7-build
        python-2.7
        python-2.7-PIL
        python-2.7-test
        python-3.4-build
        python-3.4
        python-3.4-PIL
        python-3.4-test
        install-links

[install-links]
prefix = $HOME

endcfg
fi

if [ ! -f $BUILDOUT/bin/buildout ]
then
    python $BUILDOUT/bootstrap.py -c $BUILDOUT/python.cfg
fi

if [ ! -d $BUILDOUT/python-3.4 ]
then
    $BUILDOUT/bin/buildout -c $BUILDOUT/python.cfg
fi

if [ ! -d $BUILDOUT/python-2.7 ]
then
    $BUILDOUT/bin/buildout -c $BUILDOUT/python.cfg
fi

if [ ! -f $HOME/bin/python3.4 ]
then
    $BUILDOUT/bin/install-links
fi

if [ ! -f $HOME/bin/python2.7 ]
then
    $BUILDOUT/bin/install-links
fi

# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
# make fn keys function rather than default mac
defaults write -g com.apple.keyboard.fnState -boolean true


if [ ! -d $HOME/.oh-my-zsh ]
then
    curl -L http://install.ohmyz.sh | sh
fi

# install packer
PACKER=$HOME/software/packer
if [ ! -d "$PACKER" ]
then
    unzip $SOFTWARE_DOWNLOAD/packer_0.7.5_darwin_amd64.zip -d $PACKER
fi

# install terraform
TERRAFORM=$HOME/software/terraform
if [ ! -d "$TERRAFORM" ]
then
    unzip $SOFTWARE_DOWNLOAD/terraform_0.3.6_darwin_amd64.zip -d $TERRAFORM
fi

# install rvm
RVM=$HOME/.rvm
if [ ! -d "$RVM" ]
then
    curl -sSL https://get.rvm.io | bash -s stable --ruby
fi

# install fig
FIG=$HOME/software/fig
if [ ! -f /usr/local/bin/fig ]
then
    curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > $FIG
    chmod +x $FIG
    ln -s $FIG /usr/local/bin/fig
fi

# install zest.releaser
FULLRELEASE=$HOME/software/fullrelease
if [ ! -f /usr/local/bin/fullrelease ]
then
    virtualenv-2.7 "$FULLRELEASE"
    "$FULLRELEASE/bin/pip" install zest.releaser pyroma check-manifest gocept.zestreleaser.customupload
    ln -s $FULLRELEASE/bin/fullrelease /usr/local/bin/fullrelease
fi

# install flake8
FLAKE8=$HOME/software/flake8

if [ ! -f $FLAKE8/bin/flake8 ]
then
    virtualenv-2.7 "$FLAKE8"
    "$FLAKE8/bin/pip" install flake8
fi

# install docker-compose
COMPOSE=$HOME/software/docker-compose

if [ ! -f $COMPOSE/bin/docker-compose ]
then
    virtualenv-2.7 "$COMPOSE"
    "$COMPOSE/bin/pip" install docker-compose
fi

