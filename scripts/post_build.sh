#!/usr/bin/env bash

# Run any necessary commands after deployment

# Import common functions
source scripts/common.sh

echo ""
echo "Jenkins public key:"
docker exec jenkins_jenkins_1 cat /var/jenkins_home/.ssh/jenkins-key.pub
check_errs $? "Failed printing jenkins public key"
echo ""
