#!/bin/sh

detach_volume() {

VOLUME=/Volumes/$@
if [ -d "$VOLUME" ]
then
    hdiutil detach "$VOLUME"
fi
}

detach_volume Tunnelblick
detach_volume "Adobe Flash Player Installer"
detach_volume "Dropbox Installer"
