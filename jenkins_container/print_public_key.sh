#!/usr/bin/env bash


# Print jenkins public key

kfile=/var/jenkins_home/.ssh/jenkins-key.pub
if [ -e $kfile ]
then
    cat $kfile
else
    echo "Public key not present"
fi
