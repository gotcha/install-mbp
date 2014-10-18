#!/bin/sh

SOFTWARE_DOWNLOAD=~/auto/software

hdiutil attach $SOFTWARE_DOWNLOAD/Tunnelblick_3.4.1_r3054.dmg
open /Volumes/Tunnelblick/Tunnelblick.app
