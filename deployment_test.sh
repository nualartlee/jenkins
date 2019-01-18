#!/usr/bin/env bash

#
# Test Current Deployment
#
#

# Import common functions
source scripts/common.sh

# Print header
clear
echo "====================================="
echo "           Testing Deployment"
echo

# Test that jenkins is responding on port 80
echo "Requesting site..."
curl -I 172.16.0.11:8080 2>&1 | egrep "HTTP"
check_errs $? "Bad HTTP response when requesting the site"

echo
echo "Deployment passed all tests"
echo "Project is running"
echo
