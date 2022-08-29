# Update the variables in the BACKEND block to refrence the
# storage account created out of band for TF statemanagement.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.11.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = ">=2.25.0"
    }

  }

  backend "azurerm" {
    resource_group_name  = "tfstateashi"   # Partial configuration, provided during "terraform init"
    storage_account_name = "aksashi001tfsa"   # Partial configuration, provided during "terraform init"
    container_name       = "akscs"   # Partial configuration, provided during "terraform init"
    access_key = "DZYrBI0UymOYFqyjHs2Wcv8RsJgDv9K02sU/zFzp4e2D8otXuQ6NV56LsmO7sV8ysByJZ1I74LQK+ASt5NQs1Q=="
    key = "aad-import"
  }

}

provider "azurerm" {
  features {}
}

provider "azuread" {
  tenant_id = "449fbe1d-9c99-4509-9014-4fd5cf25b014"
}