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
    installer -verbose -target / -pkg $SOFTWARE_DOWNLOAD/Boot2Docker-1.5.0.pkg
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
    hdiutil attach $SOFTWARE_DOWNLOAD/Firefox\ 33.1.dmg
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
    hdiutil attach $SOFTWARE_DOWNLOAD/NeoOffice-3.4.1-Intel.dmg
    installer -verbose -target / -pkg /Volumes/Install\ NeoOffice\ 3.4.1/Install\ NeoOffice\ 3.4.1.pkg
    detach_volume "Install NeoOffice 3.4.1"
fi

# install java

if [ ! -f "/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/jdk-8u25-macosx-x64.dmg
    installer -verbose -target / -pkg /Volumes/JDK\ 8\ Update\ 25/JDK\ 8\ Update\ 25.pkg
    detach_volume "JDK 8 Update 25"
fi

# install vagrant

if [ ! -f "/usr/bin/vagrant" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/vagrant_1.6.5.dmg
    installer -verbose -target / -pkg /Volumes/Vagrant/Vagrant.pkg
    detach_volume "Vagrant"
fi

# install vlc

if [ ! -d "/Applications/VLC.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/vlc-2.1.5.dmg
    cp -r /Volumes/vlc-2.1.5/VLC.app /Applications
    detach_volume "vlc-2.1.5"
fi

# install dash

if [ ! -d "/Applications/Dash.app" ]
then
    unzip $SOFTWARE_DOWNLOAD/Dash.zip -d /Applications
fi

# install brother scanner

if [ ! -d "/Applications/Brother/ControlCenter.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/Brother_ScannerDrivers_1_0_0.dmg
    installer -verbose -target / -pkg /Volumes/Brother_ScannerDrivers/Brother_ScannerDrivers.pkg
    detach_volume "Brother_ScannerDrivers"
fi

# install electrum

if [ ! -d "/Applications/Electrum.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/electrum-1.9.8.dmg
    cp -r /Volumes/Electrum/Electrum.app /Applications
    detach_volume "Electrum"
fi

# install lighthouse

if [ ! -d "/Applications/Lighthouse.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/Lighthouse.dmg
    cp -r /Volumes/Lighthouse/Lighthouse.app /Applications
    detach_volume "Lighthouse"
fi

# install teamviewer

if [ ! -d "/Applications/TeamViewer.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/TeamViewer.dmg
    installer -verbose -target / -pkg "/Volumes/TeamViewer/Install TeamViewer.pkg"
    detach_volume "TeamViewer"
fi

