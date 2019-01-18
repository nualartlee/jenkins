#!/usr/bin/env bash

#
# Rollback To Previous Version
#
# Pulls and deploys the previous version of the current branch from remote origin.
#

# Import common functions
source scripts/common.sh

# Print header
clear
echo "====================================="
echo "      Revert To Previous Version"
echo

# Check user is root
check_errs $EUID "This script must be run as root"

# Check if required packages are installed
echo "Checking required packages"
check_package pwgen
check_package docker
check_package docker-compose
echo

# Determine previous version git hash
previous=$(git log --format=%H | sed -n 2p)
check_errs $? "Unable to determine previous git version hash"

# Rollback previous version
git reset $previous
check_errs $? "Unable to git-reset previous version from repository"

# Stash current changes
git stash
check_errs $? "Unable to stash changes in repository"

# Run any custom build script
if [ -e scripts/build.sh ]
then
    echo "Running custom build script"
    scripts/build.sh
    check_errs $? "Custom build script failed"
else
    echo "No custom build scripts"
fi

# Ensure docker is running
service docker start
check_errs $? "Failed starting docker"

# Stop containers
docker-compose down
check_errs $? "Failed stopping containers"

# Rebuild containers
echo
echo "Building containers"
docker-compose build
check_errs $? "Failed building containers"

# Run containers in background
echo
echo "Starting containers"
docker-compose up -d &
check_errs $? "Failed starting containers"

# Allow for startup
sleep 5

echo
echo "Rollback Completed"
echo "Project is running"
echo
