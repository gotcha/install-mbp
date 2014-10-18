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

ssh -T git@github.com 2>&1 >/dev/null | grep gotcha
if [ $? -ne 0 ]
then
    echo "Public key should be uploaded to github.com"
    cat /Users/gotcha/.ssh/id_dsa.pub
fi
