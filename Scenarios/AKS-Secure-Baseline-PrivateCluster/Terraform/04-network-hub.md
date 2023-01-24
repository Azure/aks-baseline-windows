# Create the Hub Network

The following will be created:
* [Resource Group for Hub Networking](./04-Network-Hub/hub-networking.tf)
* [Hub Network](./04-Network-Hub/hub-networking.tf)
* [Azure Firewall](./04-Network-Hub/firewall.tf)
* [Azure Bastion Host](./04-Network-Hub/hub-networking.tf)
* [Virtual Machine](./04-Network-Hub/dev-setup.tf)
* [Domain Controller](./04-Network-Hub/dev-setup-dc.tf)



Navigate to "/Scenarios/AKS-Secure-Baseline-PrivateCluster/Terraform/04-Network-Hub" folder
```
cd ../04-Network-Hub
```

In the "variables.tf" file, update the defaults to reflect the tags  you'd like to use throughout the rest of the deployment.  There are a group of "sensitive" variables for the username and password of the jumpbox.  It is not recommended that these variables be committed to code in a public repo, you should instead create a separate terraform.tfvars file (not committed via gitignore) or use GitHub secrets (with a workflow) to pass those values in at deployment time. (A sample terraform.tfvars.sample file is included for reference. Enter your values and rename it **terraform.tfvars**)

If using **terraform.tfvars**, then update the following in the file.

```
admin_password = ""
admin_username = ""
location = ""
hub_prefix = "" 
```

### Deploy the hub networking and Windows domain controller

Using the same PowerShell session from the previous step, update the state file name that will be used for this part of the deployment.

```PowerShell

$layerNametfstate="hub-net"

```

Deploy using Terraform Init, Plan and Apply. 

```PowerShell
terraform init -input=false -backend-config="resource_group_name=$backendResourceGroupName" -backend-config="storage_account_name=$backendStorageAccountName" -backend-config="container_name=$backendContainername" -backend-config="key=$layerNametfstate" -backend-config="subscription_id=$ARM_SUBSCRIPTION_ID" -backend-config="tenant_id=$tenantId" -backend-config="client_id=$servicePrincipalId" -backend-config="client_secret=$servicePrincipalKey"
```

> Enter terraform init -reconfigure if you get an error saying there was a change in the backend configuration which may require migrating existing state

```PowerShell
terraform plan -out $layerNametfstate -input=false -var="subscription_id=$ARM_SUBSCRIPTION_ID" -var="tenant_id=$tenantId" -var="client_id=$servicePrincipalId" -var="client_secret=$servicePrincipalKey" -var="resource_group_name=$backendResourceGroupName" -var="storage_account_name=$backendStorageAccountName" -var="container_name=$backendContainername" -var="access_key=$layerNametfstate"  
```

```PowerShell
terraform apply -var="subscription_id=$ARM_SUBSCRIPTION_ID" -var="tenant_id=$tenantId" -var="client_id=$servicePrincipalId" -var="client_secret=$servicePrincipalKey" -var="resource_group_name=$backendResourceGroupName" -var="storage_account_name=$backendStorageAccountName" -var="container_name=$backendContainername" -var="access_key=$layerNametfstate"
```

### Configure DNS on the hub network

After the domain controller is up and running, you will need to update the DNS on the virtual network to use the domain controller for resolution.

1. To check your domain controller is up, verify that the VM is in a running state by going to the Portal, clicking on the domain controller VM and verifying that the "Status" property says "Running". You should also verify that the Networking property "Private IP address" has a value. 
2. Locate the private IP address of your domain controller. (It should be a 10.X IP address)
   ```PowerShell
    $nicId = (az vm show -g "aks-HUB" -n <name of Domain Controller VM> --query "networkProfile.networkInterfaces[0].id")
    az network nic show --id $nicId --query "ipConfigurations[0].privateIpAddress"
   ```
3. In the portal, navigate to Settings-> DNS servers
4. Choose Custom, input your domain controller's IP address and hit Save. 
5. Restart your domain controller first and then the jumpbox VM to propagate the new DNS settings. Default values for the network resource group and VM names used in example below. 
   ```PowerShell
   az vm restart -g "aks-HUB" -n "svr-dev-dc"
   ```

### Windows client for system to manage the cluster
The 04-Network-Hub module will deploy a Windows client system to run the administrative and operational tasks for the Azure Kubernetes Service (AKS) cluster. The sub-module, compute-Win, will have a client system preconfigured with the minimum required tools, such as Azure CLI and Kubectl.
To connect to the client system, the Bastion service can be utilized and the virtual machine name or IP address can be provided in the Bastion service. The username and password for the client system will be retrieved from the variable.tf file. The following screenshot illustrates the process of accessing the Bastion service.
![architecture diagram](../../media/Screenshot_BastionService.jpg)


## Next Step

:arrow_forward: [Creation of Spoke Network & its respective Components](./05-network-lz.md)
