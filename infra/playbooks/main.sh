#!/bin/sh

ENVIRONMENT=$1
BRANCH=$2
VERSION=$3

echo "Refresh environment ${ENVIRONMENT} branch ${BRANCH} with click-count version ${VERSION}"

cd 01-infrastructure
echo "- - - - inside 01-infrastructure - - - -"
./main.sh ${ENVIRONMENT}

cd ../
mv ./01-infrastructure/terraform.tfvars ./02-applications/terraform.tfvars

cd 02-applications
echo "- - - - inside 02-applications - - - -"
./main.sh ${ENVIRONMENT} ${BRANCH} ${VERSION}