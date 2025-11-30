#!/bin/bash
echo "🚀 Xpanse deployment script"

read -p "🔑 CleverCloud Token: " CC_TOKEN
echo
read -p "🔑 CleverCloud Secret: " CC_SECRET
echo
read -p "📌 CleverCloud Org ID: " CC_ORG
echo
read -p "🧪 Is this the final environment? (true/false) [default: false]: " IS_FINAL_ENV
IS_FINAL_ENV=${IS_FINAL_ENV:-false}

CUSTOM_DOMAIN=""
if [ "$IS_FINAL_ENV" = "true" ]; then
  read -p "🌐 Enter custom domain name (e.g. xpanse.dev): " CUSTOM_DOMAIN
fi

echo ""
echo "⚙️ Applying Terraform configuration..."

terraform init

if [ "$IS_FINAL_ENV" = "true" ]; then
  terraform apply \
    -var="clevercloud_token=${CC_TOKEN}" \
    -var="clevercloud_secret=${CC_SECRET}" \
    -var="clevercloud_organisation=${CC_ORG}" \
    -var="is_final_environment=true" \
    -var="custom_domain_name=${CUSTOM_DOMAIN}" \
    -auto-approve
else
  terraform apply \
    -var="clevercloud_token=${CC_TOKEN}" \
    -var="clevercloud_secret=${CC_SECRET}" \
    -var="clevercloud_organisation=${CC_ORG}" \
    -var="is_final_environment=false" \
    -auto-approve
fi