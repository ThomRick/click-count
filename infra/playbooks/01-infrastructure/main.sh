#!/bin/sh

ENVIRONMENT=$1

rm -rf ./.terraform/
rm -rf terraform.tfstate
rm -rf terraform.tfstate.backup
rm -rf terraform.tfvars
rm -rf config.tfplan
ls /usr/local/.terraform.d/plugins/

terraform init

terraform import google_container_cluster.cluster europe-west1-d/${ENVIRONMENT}
terraform import google_dns_managed_zone.dns-managed-zone ${ENVIRONMENT}

terraform refresh -state=terraform.tfstate
terraform output -state=terraform.tfstate >> terraform.tmp
awk '{split($0, tab, " = "); printf("%s = \"%s\"\n", tab[1], tab[2])}' terraform.tmp >> terraform.tfvars
rm -rf terraform.tmp

terraform plan -detailed-exitcode -out=config.tfplan -var environment=${ENVIRONMENT}
if [ $? == 2 ]
then
    echo "apply terraform plan to build infrastructure"
    terraform apply config.tfplan
fi
