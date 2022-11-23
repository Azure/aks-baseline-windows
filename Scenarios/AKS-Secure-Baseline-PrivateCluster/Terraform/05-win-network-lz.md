# Create the Landing Zone Network

The following will be created:
* Resource Group for Landing Zone Networking (lz-networking.tf)
* Route Table (lz-networking.tf)
* Peering of Hub and Spoke Networks (hub-spoke-peering.tf)
* Private DNS Zones (dns-zones.tf)
* Application Gateway (app-gateway.tf)
* Subnet for AKS (aks-networking.tf)

Navigate to "/Scenarios/AKS-Secure-Baseline-PrivateCluster/Terraform/05-Network-LZ" folder
```
cd ../05-Network-LZ
```

In the "variables.tf" file, update the defaults to reflect the tags you'd like to use.  
This deployment will need to reference data objects from the Hub deployment and will need access to the pre-existing state file, update the variables as needed.  

This deployment will also need to use a storage access key (from Azure) to read the storage account data.  This is a sensitive variable and should not be committed to the code repo. 

Once again, A sample terraform.tfvars.sample file is included. Update the required variables, save it and rename it to **terraform.tfvars**.

To get the access key:

1. Go to Azure portal and find the storage account that was created for Terraform
2. Under **Security + networking** section in the left blade, click on **Access keys**
3. Click on **Show keys** at the top of the resulting page 
4. Copy the string under **Key** from one of the two keys provided
5. Update your the terraform.tfvars.sample file with this as the value for access_key or update the existing terraform.tfvars file. 
6. If using terraform.tfvars.sample then Rename the file to terraform.tfvars

### Update the rest of the variables in the new terraform.tfvars file as well.
Update following variable
```
$backendResourceGroupName=""
$backendStorageAccountName=""
$backendContainername=""
$layerNametfstate="lz-net" # same as state file name provided in provider.tf 
$ARM_SUBSCRIPTION_ID=""
$tenantId=""
$servicePrincipalId=""
$servicePrincipalKey=""
$access_key = "" # TF state file Azure storage account access key, it will be used to access exisiitng state files.
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

:arrow_forward: [Creation of Supporting Components for AKS](./06-win-aks-supporting.md)

