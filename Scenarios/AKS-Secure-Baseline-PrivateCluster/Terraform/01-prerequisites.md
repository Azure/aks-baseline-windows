# Prerequisites

1. An Azure subscription
   The subscription used in this deployment cannot be a free account; it must be a standard EA, pay-as-you-go, or Visual Studio benefit subscription. This is because the resources deployed here are beyond the quotas of free subscriptions.

    The user or service principal initiating the deployment process must have the following minimal set of Azure Role-Based Access Control (RBAC) roles:

        - Contributor role is required at the subscription level to have the ability to create resource groups and perform deployments.
        - User Access Administrator role is required at the subscription level since you'll be performing role assignments to managed identities across various resource groups.
2. Bash or PowerShell terminal. This reference reference implementation can be deployed using either a Bash or PowerShell terminal. In later steps of the deployment such as setting up your AKS cluster for Group Managed Service Accounts with Windows Integrated, you must use a PowerShell terminal on your jumpbox to use PowerShell modules. For the purposes of this reference implementation, instructions will be written using PowerShell. 
3. Latest [Azure CLI installed](https://learn.microsoft.com/cli/azure/install-azure-cli-windows?tabs=powershell#powershell)
4. [Terraform version 3.9.0 or greater](https://learn.microsoft.com/azure/developer/terraform/get-started-windows-bash?tabs=bash#4-install-terraform-for-windows)
5. Clone/download this repo locally using a Git Bash terminal, GitHub Desktop app or VSCode.
    ``` Git Bash
    git clone https://github.com/Azure/aks-baseline-windows.git
    cd aks-baseline-windows
    ```

    [VSCode](https://learn.microsoft.com/azure/developer/javascript/how-to/with-visual-studio-code/clone-github-repository?tabs=create-repo-command-palette%2Cinitialize-repo-activity-bar%2Ccreate-branch-command-palette%2Ccommit-changes-command-palette%2Cpush-command-palette#clone-repository)
    
    [GitHub Desktop app](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository?tool=desktop#cloning-a-repository)

# Next Step
:arrow_forward: [Setup state storage for Terraform](./02-state-storage.md)