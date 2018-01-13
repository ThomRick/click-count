#!/bin/sh

ENVIRONMENT=$1
BRANCH=$2
VERSION=$3

rm -rf ./.terraform/
rm -rf terraform.tfstate
rm -rf terraform.tfstate.backup
rm -rf config.tfplan

terraform init -plugin-dir=/usr/local/.terraform.d/plugins/

terraform import kubernetes_service.redis default/redis
terraform import kubernetes_pod.redis default/redis

terraform import kubernetes_service.click-count default/click-count
terraform import kubernetes_pod.click-count default/click-count

terraform import google_dns_record_set.record ${ENVIRONMENT}/${BRANCH}.click-count.thomrick.com./A
terraform import google_dns_record_set.cname ${ENVIRONMENT}/www.${BRANCH}.click-count.thomrick.com./CNAME

terraform plan -detailed-exitcode -out=config.tfplan -var environment=${ENVIRONMENT} -var branch=${BRANCH} -var version=${VERSION}
if [ $? == 2 ]
then
    echo "apply terraform plan to deploy application"
    terraform apply config.tfplan
fi