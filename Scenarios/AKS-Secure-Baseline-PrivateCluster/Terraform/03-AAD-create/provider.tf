# Update the variables in the BACKEND block to refrence the
# storage account created out of band for TF statemanagement.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.9.0"
    }

  }

  backend "azurerm" {
    resource_group_name  = var.resource_group_name  #"tfstateashi"   # Partial configuration, provided during "terraform init"
    storage_account_name = var.storage_account_name #"aksashi001tfsa"   # Partial configuration, provided during "terraform init"
    container_name       = var.container_name       #"akscs"   # Partial configuration, provided during "terraform init"
    key                  = "aad"                    # Value set here because multiple state files are used in this example.
  }

}

provider "azurerm" {
  features {}
}

provider "azuread" {
}
