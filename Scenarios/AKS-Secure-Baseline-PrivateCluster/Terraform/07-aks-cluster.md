# Create resources for the AKS Private Cluster

The following will be created:
* [AKS Private Cluster](./07-AKS-cluster/aks-cluster.tf)
* [Log Analytics Workspace](./07-AKS-cluster/aks-cluster.tf)
* [Managed Identity for AKS Control Plane](./07-AKS-cluster/aks-cluster.tf)
* [AKS Pod Identity Assignments - OPTIONAL](./07-AKS-cluster/aks-pod-identity.tf)

Navigate to "/Scenarios/AKS-Secure-Baseline-PrivateCluster/Terraform/07-AKS-cluster" folder
```PowerShell
cd ../07-AKS-cluster
```

This deployment will need to reference data objects from the Hub deployment and will need access to the pre-existing state file, update the variables as needed.  This deployment will also need to use a storage access key (from Azure) to read the storage account data.  This is a sensitive variable and should not be committed to the code repo.

### Following values will require inputs in the terraform.tfvars file:
```
# wnp_count = true # if set to true windows node pools will be deployed.
# private_dns_zone_name = "privatelink.centralus.azmk8s.io" # default value is set to centralus region, change the dns region to your desired location, must match to the earlier resource regions. 
```

Once again, A sample terraform.tfvars.sample file is included. Update the required variables, save it and rename it to **terraform.tfvars**.

### Deploy the cluster
Using the same PowerShell session from the previous step, update the state file name that will be used for this part of the deployment.

```PowerShell
  $layerNametfstate="aks" # same as state file name provided in provider.tf 
  $access_key = "" # TF state file Azure storage account access key, it will be used to access exisiitng state files.
```

Once the files are updated, deploy using Terraform Init, Plan and Apply.

```PowerShell
terraform init -input=false -backend-config="resource_group_name=$backendResourceGroupName" -backend-config="storage_account_name=$backendStorageAccountName" -backend-config="container_name=$backendContainername" -backend-config="key=$layerNametfstate" -backend-config="subscription_id=$ARM_SUBSCRIPTION_ID" -backend-config="tenant_id=$tenantId" -backend-config="client_id=$servicePrincipalId" -backend-config="client_secret=$servicePrincipalKey"
```

```PowerShell
terraform plan -out $layerNametfstate -input=false -var="subscription_id=$ARM_SUBSCRIPTION_ID" -var="tenant_id=$tenantId" -var="client_id=$servicePrincipalId" -var="client_secret=$servicePrincipalKey" -var="resource_group_name=$backendResourceGroupName" -var="storage_account_name=$backendStorageAccountName" -var="container_name=$backendContainername" -var="access_key=$access_key" -var="state_sa_name=$backendStorageAccountName" 
```

```PowerShell
terraform apply -var="subscription_id=$ARM_SUBSCRIPTION_ID" -var="tenant_id=$tenantId" -var="client_id=$servicePrincipalId" -var="client_secret=$servicePrincipalKey" -var="resource_group_name=$backendResourceGroupName" -var="storage_account_name=$backendStorageAccountName" -var="container_name=$backendContainername" -var="access_key=$access_key" 
```

If you get an error about changes to the configuration, go with the `-reconfigure` flag option.

### Grant access from the hub network to the private link created for Key Vault

For the jumpbox you created in the hub network to have access to Key Vault's private link you need to add the network to the access.

1. Find the Private DNS zone created for Key Vault. This should be in the landing zone resource group (escs-lz01-rg for example)
2. Click on **Virtual network links** in the left blade under **Settings**
3. Click on **+ Add** in the in the top left of the next screen
4. enter a name for the link eg *hub_to_kv*
5. Select the hub virtual network for the **Virtual network** field
6. Click on **OK** at the bottom

# Next Step
:arrow_forward: [Deploy a Basic Workload](./08-workload.md)
