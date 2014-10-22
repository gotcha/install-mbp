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

# configure git

git config --global user.name "Godefroid Chapelle"
git config --global user.email gotcha@bubblenet.be
git config --global push.default simple

# ssh key
SSH_KEY=/Users/$USR/.ssh/id_dsa
if [ ! -f $SSH_KEY ]
then
    ssh-keygen -q -t dsa -f $SSH_KEY -N ""
fi

# configure github

su $USR -c "ssh -T git@github.com 2>&1 -i$SSH_KEY >/dev/null | grep $USR > /dev/null"
if [ $? -ne 0 ]
then
    echo "Public key should be uploaded to github.com"
    cat $SSH_KEY.pub
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
