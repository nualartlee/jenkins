#!/usr/bin/env bash

# Run any necessary commands after deployment

# Import common functions
source scripts/common.sh

echo ""
echo "Jenkins public key:"
docker exec -u root jenkins_jenkins_1 /usr/share/jenkins/ref/print_public_key.sh
check_errs $? "Failed printing jenkins public key"
echo ""
