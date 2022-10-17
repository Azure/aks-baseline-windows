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
    resource_group_name  = var.resource_group_name #"tfstateashi"   # Partial configuration, provided during "terraform init"
    storage_account_name = var.storage_account_name #"aksashi001tfsa"   # Partial configuration, provided during "terraform init"
    container_name       = var.container_name #"akscs"   # Partial configuration, provided during "terraform init"
    key  = "aad"
  }

}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id #"82e70289-bf40-45f9-8476-eab93d2031f4"
    tenant_id = var.tenant_id #"449fbe1d-9c99-4509-9014-4fd5cf25b014"
    client_id  = var.client_id #"f5174545-d5ae-49ab-be0a-48eed78a9c5c"
    client_secret = var.client_secret #"F8U8~bmRCb4Lu7l.25r6ETc928ZPzBaqzw"

}

provider "azuread" {
  tenant_id = var.tenant_id #"449fbe1d-9c99-4509-9014-4fd5cf25b014"
}
