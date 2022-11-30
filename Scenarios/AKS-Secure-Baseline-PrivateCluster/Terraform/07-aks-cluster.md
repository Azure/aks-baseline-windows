# Create resources for the AKS Private Cluster

The following will be created:
* AKS Private Cluster
* Log Analytics Workspace
* Managed Identity for AKS Control Plane
* Managed Identity for Application Gateway Ingress Controller
* AKS Pod Identity Assignments - OPTIONAL

Navigate to "/Scenarios/AKS-Secure-Baseline-PrivateCluster/Terraform/07-AKS-cluster" folder
```bash
cd ../07-AKS-cluster
```

This deployment will need to reference data objects from the Hub deployment and will need access to the pre-existing state file, update the variables as needed.  This deployment will also need to use a storage access key (from Azure) to read the storage account data.  This is a sensitive variable and should not be committed to the code repo.

Once again, A sample terraform.tfvars.sample file is included. Update the required variables, including `private_dns_zone_name` save it and rename it to **terraform.tfvars**. Remember to update your private dns zone name variable with the appropriate location.

Once the files are updated, deploy using Terraform Init, Plan and Apply.

### Update the following values to your powershell instance:
```
$TFSTATE_RG =""
$STORAGEACCOUNTNAME = ""
$CONTAINERNAME = ""
$ARM_CLIENT_ID =""
$ARM_CLIENT_SECRET =""
$ARM_TENANT_ID =""
$ARM_SUBSCRIPTION_ID =""
$ARM_ACCESS_KEY =""

```Powershell
terraform init -backend-config="resource_group_name=$TFSTATE_RG" -backend-config="storage_account_name=$STORAGEACCOUNTNAME" -backend-config="container_name=$CONTAINERNAME"
```

```Powershell
terraform plan 
```

```Powershell
terraform apply 
```

If you get an error about changes to the configuration, go with the `-reconfigure` flag option.