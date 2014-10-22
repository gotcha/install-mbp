#!/bin/sh

SOFTWARE_DOWNLOAD=~/auto/software
USR=gotcha

detach_volume() {

VOLUME=/Volumes/$@
if [ -d "$VOLUME" ]
then
    hdiutil detach "$VOLUME"
fi
}

# install brew

if [ ! -f "/usr/local/bin/brew" ]
then
    su $USR -c 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
    su $USR -c 'brew doctor'
fi

# install brew packages

BREW_FORMULA="tmux stow"

su $USR -c "brew install $BREW_FORMULA"

# dotfiles

if [ ! -d /Users/$USR/dotfiles ]
then
    git clone git@github.com:gotcha/dotfiles.git /Users/$USR/dotfiles
fi
su $USR -c "stow -d /Users/$USR/dotfiles -t /USERS/$USR git iterm vim tmux"

# configure git

git config --global user.name "Godefroid Chapelle"
git config --global user.email gotcha@bubblenet.be
git config --global push.default simple
git config --global core.excludesfile ~/.gitignore_global

# ssh key
SSH_KEY=/Users/$USR/.ssh/id_dsa
if [ ! -f $SSH_KEY ]
then
    ssh-keygen -q -t dsa -f $SSH_KEY -N ""
fi

# configure github

su $USR -c "ssh -T git@github.com 2>&1 -i $SSH_KEY >/dev/null | grep $USR > /dev/null"
if [ $? -ne 0 ]
then
    echo "Public key should be uploaded to github.com"
    cat $SSH_KEY.pub
fi

# powerline fonts

if [ ! -f "/Users/$USR/Library/Fonts/Droid Sans Mono for Powerline.otf ]
then
    su $USR -c "git clone git@github.com:Lokaltog/powerline-fonts.git /Users/$USR/tmp/powerline-fonts"
    su $USR -c "/Users/$USR/tmp/powerline-fonts/install.sh"
    su $USR -c "rm -rf /Users/$USR/tmp/powerline-fonts"
fi


# install virtual box 

if [ ! -d /Applications/VirtualBox.app ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/VirtualBox-4.3.18-96516-OS.dmg
    installer -verbose -target / -pkg /Volumes/VirtualBox/VirtualBox.pkg
    detach_volume VirtualBox
fi

# install docker

if [ ! -d /Applications/boot2docker.app ]
then
    installer -verbose -target / -pkg $SOFTWARE_DOWNLOAD/Boot2Docker-1.3.0.pkg
fi

# install chrome

if [ ! -d "/Applications/Google Chrome.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/googlechrome.dmg
    cp -r /Volumes/Google\ Chrome/Google\ Chrome.app /Applications
    detach_volume "Google Chrome"
fi

# install firefox

if [ ! -d "/Applications/Firefox.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/Firefox\ 33.0.dmg
    cp -r /Volumes/Firefox/Firefox.app /Applications
    detach_volume Firefox
fi

# install iterm

if [ ! -d "/Applications/iTerm.app" ]
then
    unzip $SOFTWARE_DOWNLOAD/iTerm2_v2_0.zip -d /Applications
fi

# install onepassword

if [ ! -d "/Applications/1Password 4.app" ]
then
    unzip $SOFTWARE_DOWNLOAD/1Password-4.4.3.zip -d /Applications
fi

