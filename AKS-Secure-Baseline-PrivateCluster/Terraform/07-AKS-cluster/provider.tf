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
    access_key  = "DZYrBI0UymOYFqyjHs2Wcv8RsJgDv9K02sU/zFzp4e2D8otXuQ6NV56LsmO7sV8ysByJZ1I74LQK+ASt5NQs1Q=="
    key = "aks"
  }

}

provider "azurerm" {
    features {}
    subscription_id = "82e70289-bf40-45f9-8476-eab93d2031f4"
    tenant_id = "449fbe1d-9c99-4509-9014-4fd5cf25b014"
    # client_id         = "f5174545-d5ae-49ab-be0a-48eed78a9c5c"
    # client_secret     = "F8U8~bmRCb4Lu7l.25r6ETc928ZPzBaqzw"

}

provider "azuread" {
  tenant_id = "449fbe1d-9c99-4509-9014-4fd5cf25b014"
}
