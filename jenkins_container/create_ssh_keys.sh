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
    ssh-keygen -t rsa -b 4096 -o -a 100 -f /var/jenkins_home/.ssh/jenkins-key -q -N "$1"
    # If elliptic is required
    #ssh-keygen -t ed25519 -a 100 -f /var/jenkins_home/.ssh/jenkins-key -q -N "$1"
fi
