#!/usr/bin/env bash

# Creates passwords, keys, etc

# Import common functions
source scripts/common.sh

# Create a directory to store passwords
if [ -e secrets ]
then
    echo "secrets directory already exists"
else
    echo "Creating secrets directory"
    mkdir secrets
    check_errs $? "Failed creating secrets directory"
fi
chmod 660 secrets
check_errs $? "Failed setting secret directory permissions"

# Create passwords
echo "Setting jenkins user"
echo "manager" > secrets/jenkins-user.txt
create_password secrets/jenkins-pass.txt 27

# Ensure docker is running
service docker start
check_errs $? "Failed starting docker"

# Create docker main network if not present
if [ -z "$(docker network ls | grep nginx_main)" ]
then
    echo "creating docker network 'nginx_main'"
    docker network create --subnet 172.16.0.0/16 nginx_main
    check_errs $? "Failed creating docker network"
else
    echo "docker network 'nginx_main' already present"
fi
check_errs $? "Failed creating docker network"
