#! /bin/bash

# Input arguments
azure_storage_account_name=$1
azure_storage_account_rg=$2
tls_version=$3


# Check if exactly 3 arguments are provided
if [[ $# -ne 3 ]]; then
  echo "Error: Exactly 3 arguments are required."
  echo "Usage: $0 <param1> <param2> <tlv_ver>"
  exit 1
fi

# Print the inputs
echo "Provided inputs are as follows:"
echo "Storage Account Name: $azure_storage_account_name"
echo "Resource Group: $azure_storage_account_rg"
echo "TLS Version: $tls_version"

# verifying tls version
old_tls_version=$(az resource show --name $azure_storage_account_name --resource-group $azure_storage_account_rg --resource-type Microsoft.Storage/storageAccounts --query properties.minimumTlsVersion --output tsv)
echo "The storage account $azure_storage_account_name in resource group $azure_storage_account_rg has a TLS version of $old_tls_version"

# Update minimum tls version
echo "Updating TLS version to $tls_version for storage account $azure_storage_account_name in resource group $azure_storage_account_rg..."

az storage account update --min-tls-version $tls_version --name $azure_storage_account_name --resource-group $azure_storage_account_rg --output none

# Verify tls version
current_tls_version=$(az resource show --name $azure_storage_account_name --resource-group $azure_storage_account_rg --resource-type Microsoft.Storage/storageAccounts --query properties.minimumTlsVersion --output tsv)

# Display the custom message
echo "The storage account $azure_storage_account_name in resource group $azure_storage_account_rg has a TLS version of $current_tls_version"