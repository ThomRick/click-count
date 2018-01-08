#!/bin/sh

ENVIRONMENT=$1
VERSION=$2

echo "Refresh environment ${ENVIRONMENT} with click-count version ${VERSION}"

cd 01-infrastructure
echo "- - - - inside 01-infrastructure - - - -"
./main.sh ${ENVIRONMENT} ${VERSION}

cd ../
mv ./01-infrastructure/terraform.tfvars ./02-applications/terraform.tfvars

cd 02-applications
echo "- - - - inside 02-applications - - - -"
./main.sh ${ENVIRONMENT} ${VERSION}