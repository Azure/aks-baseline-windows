# Create resources that support AKS

The following will be created:
* Azure Container Registry (supporting-infra.tf)
* Azure Key Vault (supporting-infra.tf)
* Private Link Endpoints for ACR and Key Vault

Navigate to "/Scenarios/AKS-Secure-Baseline-PrivateCluster/Terraform/06-AKS-supporting" folder
```
cd ../06-AKS-supporting
```

This deployment will need to reference data objects from the Hub deployment and will need access to the pre-existing state file, update the variables as needed in the .tfvars sample file.  This deployment will also need to use a storage access key (from Azure) to read the storage account data.  This is a sensitive variable and should not be committed to the code repo. 

Once again, A sample terraform.tfvars.sample file is included. Update the required variables, save it and rename it to **terraform.tfvars**.

### Add the Access key variable to terraform.tfvars

1. Open the *terraform.tfvars.sample* file and add the access key as the value of the access_key variable.  Update the other storage related variables. 
1. Rename the file to *terraform.tfvars* or use the existing terraform.tfvars file.

## Deploy the Supporting Services 

```
$backendResourceGroupName=""
$backendStorageAccountName=""
$backendContainername=""
$layerNametfstate="aks-sup" # same as state file name provided in provider.tf 
$ARM_SUBSCRIPTION_ID=""
$tenantId=""
$servicePrincipalId=""
$servicePrincipalKey=""
$access_key = "" # accesskey for the storage account where tf state files are stored.
```

Once the files are updated, deploy using Terraform Init, Plan and Apply. 

```
terraform init -input=false -backend-config="resource_group_name=$backendResourceGroupName" -backend-config="storage_account_name=$backendStorageAccountName" -backend-config="container_name=$backendContainername" -backend-config="key=$layerNametfstate" -backend-config="subscription_id=$ARM_SUBSCRIPTION_ID" -backend-config="tenant_id=$tenantId" -backend-config="client_id=$servicePrincipalId" -backend-config="client_secret=$servicePrincipalKey"
```

```
terraform plan -out $layerNametfstate -input=false -var="subscription_id=$ARM_SUBSCRIPTION_ID" -var="tenant_id=$tenantId" -var="client_id=$servicePrincipalId" -var="client_secret=$servicePrincipalKey" -var="resource_group_name=$backendResourceGroupName" -var="storage_account_name=$backendStorageAccountName" -var="container_name=$backendContainername" -var="access_key=$access_key" -var="state_sa_name=$backendStorageAccountName" 
```

```
terraform apply -var="subscription_id=$ARM_SUBSCRIPTION_ID" -var="tenant_id=$tenantId" -var="client_id=$servicePrincipalId" -var="client_secret=$servicePrincipalKey" -var="resource_group_name=$backendResourceGroupName" -var="storage_account_name=$backendStorageAccountName" -var="container_name=$backendContainername" -var="access_key=$access_key" 
```

If you get an error about changes to the configuration, go with the `-reconfigure` flag option.

:arrow_forward: [Creation of AKS & enabling Addons](./07-win-aks-cluster.md)
