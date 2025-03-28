#!/bin/bash
echo "Xpanse deployment script"

read -p "🔑 CleverCloud Token: " CC_TOKEN
echo
read -p "🔑 CleverCloud Secret: " CC_SECRET
echo
read -p "📌 CleverCloud Org ID: " CC_ORG

terraform init
terraform apply \
  -var="clevercloud_token=${CC_TOKEN}" \
  -var="clevercloud_secret=${CC_SECRET}" \
  -var="clevercloud_organisation=${CC_ORG}" \
  -auto-approve