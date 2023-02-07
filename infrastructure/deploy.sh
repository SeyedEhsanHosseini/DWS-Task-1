#!/usr/bin/bash

export TF_VAR_MAAS_API_URL=$MAAS_API_URL
export TF_VAR_MAAS_API_KEY=$MAAS_API_KEY

terraform init
terraform fmt
terraform validate
terraform apply --auto-approve

terraform show -json | python3 -m maasta

ansible-playbook -i inventory.yaml -b deploy.yaml
