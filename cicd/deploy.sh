#!/usr/bin/bash

terraform init
terraform fmt
terraform validate
terraform apply --auto-approve

