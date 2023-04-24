# Update the variables in the BACKEND block to refrence the
# storage account created out of band for TF statemanagement.

terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.37.2"
    }
  }

  backend "azurerm" {
    resource_group_name  = var.resource_group_name  #   Partial configuration, provided during "terraform init"
    storage_account_name = var.storage_account_name #  Partial configuration, provided during "terraform init"
    container_name       = var.container_name       #   Partial configuration, provided during "terraform init"
    key                  = "aad"                    # Value set here because multiple state files are used in this example.
  }
}

provider "azuread" {
}
