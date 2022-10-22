# Create or Import Azure Active Directory Groups for AKS
Before creating the Azure Active Directory integrated cluster, groups must be created that can be later mapped to the Built-In Roles of "Azure Kubernetes Service Cluster User Role" and "Azure Kubernetes Service RBAC Cluster Admin".

Depending on the needs of your organization, you may have a choice of existing groups to use or a new groups may need to be created for each cluster deployment.  

Navigate to "/Scenarios/AKS-Secure-Baseline-PrivateCluster/Terraform/03-AAD" folder, either "03-AAD-create" or "03-AAD-import"
```
cd ./Scenarios/AKS-Secure-Baseline-PrivateCluster/Terraform/03-AAD-import
```

In the "variables.tf" file, update the defaults to reflect the display names as needed to either match existing groups or create names that fit your requirements.  

### Update the following values to your powershell instance:
```
$backendResourceGroupName ="" 
$backendStorageAccountName =""
$backendContainername =""
$layerNametfstate ="aad-import"
$ARM_CLIENT_ID =""
$ARM_CLIENT_SECRET =""
$ARM_TENANT_ID =""
$ARM_SUBSCRIPTION_ID =""
$ARM_ACCESS_KEY =""
```

Deploy using Terraform Init, Plan and Apply. 

```bash
terraform init -input=false -backend-config="resource_group_name=$backendResourceGroupName" -backend-config="storage_account_name=$backendStorageAccountName" -backend-config="container_name=$backendContainername" -backend-config="key=$layerNametfstate"
```

```
terraform plan -out $layerNametfstate -input=false -var="resource_group_name=$backendResourceGroupName" -var="storage_account_name=$backendStorageAccountName" -var="container_name=$backendContainername" -var="key=$layerNametfstate"
```

```
terraform apply -var="resource_group_name=$backendResourceGroupName" -var="storage_account_name=$backendStorageAccountName" -var="container_name=$backendContainername" -var="key=$layerNametfstate"
```

If you get an error about changes to the configuration, go with the `-reconfigure` flag option.

## Ensure you are part of the AAD group you just created or pointed to

1. Go to Azure portal and type AAD
2. Select **Azure Active Directory**
3. Click on **Groups** in the left blade
4. Select the Admin User group you just created. For the default name, this should be *AKS App Admin Team*
5. Click on **Members** in the left blade
6. ![Location of private link for keyvault](../media/adding-to-aad-group.png)
7. Click **+ Add members**
8. Enter your name in the search bar and select your user(s)
9. Click **Select**

### Next step

:arrow_forward: [Creation of Hub Network & its respective Components](./04-win-network-hub.md)


end of the file.
