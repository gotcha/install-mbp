#!/bin/sh

SOFTWARE_DOWNLOAD=~/auto/software

#configure git
git config --global user.name "Godefroid Chapelle"
git config --global user.email gotcha@bubblenet.be

#ssh key
if [ ! -f /Users/gotcha/.ssh/id_dsa ]
then
    ssh-keygen -q -t dsa -f /Users/gotcha/.ssh/id_dsa -N ""
fi
