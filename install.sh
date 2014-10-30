#!/bin/sh

SOFTWARE_DOWNLOAD=~/auto/software

detach_volume() {

VOLUME=/Volumes/$@
if [ -d "$VOLUME" ]
then
    hdiutil detach "$VOLUME"
fi
}

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

# install grand perspective

if [ ! -d "/Applications/GrandPerspective.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/GrandPerspective-1_5_1.dmg
    cp -r /Volumes/GrandPerspective\ 1.5.1/GrandPerspective.app /Applications
    detach_volume "GrandPerspective 1.5.1"
fi

# install thunderbird

if [ ! -d "/Applications/Thunderbird.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/Thunderbird\ 31.2.0.dmg
    cp -r /Volumes/Thunderbird/Thunderbird.app /Applications
    detach_volume "Thunderbird"
fi

# install xquartz (for vim client server)

if [ ! -d /Applications/Utilities/XQuartz.app ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/XQuartz-2.7.7.dmg
    installer -verbose -target / -pkg /Volumes/XQuartz-2.7.7/XQuartz.pkg
    detach_volume XQuartz-2.7.7
fi

# install skype

if [ ! -d "/Applications/Skype.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/Skype_7.0.653.dmg
    cp -r /Volumes/Skype/Skype.app /Applications
    detach_volume "Skype"
fi

# install neooffice

if [ ! -d "/Applications/NeoOffice.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/NeoOffice-2014.5_Free_Edition-Intel.dmg
    installer -verbose -target / -pkg /Volumes/Install\ NeoOffice\ 2014.5\ Free\ Edition/Install\ NeoOffice\ 2014.5\ Free\ Edition.pkg
    detach_volume "Install NeoOffice 2014.5 Free Edition"
fi



