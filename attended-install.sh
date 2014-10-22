#!/bin/sh

SOFTWARE_DOWNLOAD=~/auto/software

# install tunnelblick

if [ ! -d "/Applications/Tunnelblick.app" ]
then
	hdiutil attach $SOFTWARE_DOWNLOAD/Tunnelblick_3.4.1_r3054.dmg
	open /Volumes/Tunnelblick/Tunnelblick.app
fi

# install flash

if [ ! -d "/Library/PreferencePanes/Flash Player.prefPane" ]
then
	hdiutil attach $SOFTWARE_DOWNLOAD/AdobeFlashPlayerInstaller_15_ltrosxd_aaa_aih.dmg
	open /Volumes/Adobe\ Flash\ Player\ Installer/Install\ Adobe\ Flash\ Player.app
fi

# install dropbox

if [ ! -d "/Applications/Dropbox.app" ]
then
    hdiutil attach $SOFTWARE_DOWNLOAD/DropboxInstaller.dmg
    open /Volumes/Dropbox\ Installer/Dropbox.app
fi
