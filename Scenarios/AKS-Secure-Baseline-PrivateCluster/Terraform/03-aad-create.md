# Create Azure Active Directory Groups for AKS
Before creating the Azure Active Directory integrated cluster, groups must exist that can be later mapped to the Built-In Roles of "Azure Kubernetes Service Cluster User Role" and "Azure Kubernetes Service RBAC Cluster Admin".

Navigate to "/Scenarios/AKS-Secure-Baseline-PrivateCluster/Terraform/03-AAD-create" folder.
```
cd ./Scenarios/AKS-Secure-Baseline-PrivateCluster/Terraform/03-AAD-create
```

In the "variables.tf" file, update the security group and defaults to reflect the display names as needed to match existing groups. Also, update Terraform State variables to match storage account used for state file backend config. Key value is set in provider.tf.

### Update the following values to your PowerShell instance:
We will be running the commands using the service principal you created in [prerequisites/step 1](./01-prerequisites.md). You will need your SPN client ID, SPN tenant id and client secret. 
Create the following variables for ease of use during deployment. 

```PowerShell
$backendResourceGroupName=""
$backendStorageAccountName=""
$backendContainername=""
$layerNametfstate="aad-create"
$ARM_SUBSCRIPTION_ID=""
$tenantId=""
$servicePrincipalId=""
$servicePrincipalKey=""
```
Deploy using Terraform Init, Plan and Apply. 

```PowerShell 
terraform init -input=false -backend-config="resource_group_name=$backendResourceGroupName" -backend-config="storage_account_name=$backendStorageAccountName" -backend-config="container_name=$backendContainername" -backend-config="key=$layerNametfstate" -backend-config="subscription_id=$ARM_SUBSCRIPTION_ID" -backend-config="tenant_id=$tenantId" -backend-config="client_id=$servicePrincipalId" -backend-config="client_secret=$servicePrincipalKey"
```

``` PowerShell 
terraform plan -out $layerNametfstate -input=false -var="subscription_id=$ARM_SUBSCRIPTION_ID" -var="tenant_id=$tenantId" -var="client_id=$servicePrincipalId" -var="client_secret=$servicePrincipalKey" -var="resource_group_name=$backendResourceGroupName" -var="storage_account_name=$backendStorageAccountName" -var="container_name=$backendContainername" -var="access_key=$layerNametfstate"
```

```PowerShell 
terraform apply -var="subscription_id=$ARM_SUBSCRIPTION_ID" -var="tenant_id=$tenantId" -var="client_id=$servicePrincipalId" -var="client_secret=$servicePrincipalKey" -var="resource_group_name=$backendResourceGroupName" -var="storage_account_name=$backendStorageAccountName" -var="container_name=$backendContainername" -var="access_key=$layerNametfstate"
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