#!/bin/sh

SOFTWARE_DOWNLOAD=~/auto/software

if [ ! -d "/Applications/Tunnelblick.app" ]
then
	hdiutil attach $SOFTWARE_DOWNLOAD/Tunnelblick_3.4.1_r3054.dmg
	open /Volumes/Tunnelblick/Tunnelblick.app
fi

if [ ! -d "/Library/PreferencePanes/Flash Player.prefPane" ]
then
	hdiutil attach $SOFTWARE_DOWNLOAD/AdobeFlashPlayerInstaller_15_ltrosxd_aaa_aih.dmg
	open /Volumes/Adobe\ Flash\ Player\ Installer/Install\ Adobe\ Flash\ Player.app
fi
