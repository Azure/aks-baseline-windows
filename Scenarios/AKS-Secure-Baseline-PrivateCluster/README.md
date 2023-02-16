# Windows Secure Baseline Private Cluster
This folder contains Windows AKS secure baseline private cluster creation process. The architecture of the final deployment will look like the diagram below:

![architecture diagram](../../media/aks-windows-baseline-architecture.png)

For more information about private clusters and why they are recommended, check out the [Private cluster scenario](https://github.com/Azure/AKS-Landing-Zone-Accelerator/tree/main/Scenarios/AKS-Secure-Baseline-PrivateCluster) in AKS Landing Zone Accelerator.

Core architecture components
* AKS Private Cluster
* Azure Virtual Networks (hub-spoke)
* Azure Firewall managed egress
* AKS-managed Internal Load Balancer
* Azure CNI
* Azure Keyvault
* Azure Container Registry
* Azure Bastion
* Azure Monitor for Containers
* Azure Firewall
* [Group managed service accounts](https://learn.microsoft.com/en-us/azure/aks/use-group-managed-service-accounts) (GMSA)
* [Secret store CSI driver](https://learn.microsoft.com/azure/aks/csi-secrets-store-driver)

## Next
Follow the instructions below to deploy the AKS reference implementation.

:arrow_forward: [Terraform](./Terraform)

