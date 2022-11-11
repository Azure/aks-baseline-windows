terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.11.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.25.0"
    }

  }

  backend "azurerm" {
    resource_group_name  = var.resource_group_name  # Partial configuration, provided during "terraform init"
    storage_account_name = var.storage_account_name # Partial configuration, provided during "terraform init"
    container_name       = var.container_name       # Partial configuration, provided during "terraform init"
    key                  = "aks"
  }

}

provider "azurerm" {
  features {}
  # subscription_id = var.subscription_id 
  # tenant_id = var.tenant_id
  # client_id  = var.client_id
  # client_secret = var.client_secret 
}

provider "azuread" {
  # tenant_id = var.tenant_id
}
