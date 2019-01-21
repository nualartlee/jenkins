#!/usr/bin/env bash

# Creates ssh keys for jenkins
# First argument is used as passphrase

# Create an ssh directory
if [ -e /var/jenkins_home/.ssh ]
then
    echo "ssh directory already exists"
else
    echo "Creating ssh directory"
    mkdir /var/jenkins_home/.ssh
fi

# Create key
if [ -e /var/jenkins_home/.ssh/jenkins-key ]
then
    echo "jenkins ssh key already exists"
else
    echo "creating jenkins ssh key"
    ssh-keygen -f /var/jenkins_home/.ssh/jenkins-key -q -N "$1"
fi
