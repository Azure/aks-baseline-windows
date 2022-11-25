terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.9.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = var.resource_group_name  # Partial configuration, provided during "terraform init"
    storage_account_name = var.storage_account_name # Partial configuration, provided during "terraform init"
    container_name       = var.container_name       # Partial configuration, provided during "terraform init"
    key                  = "lz-net"
  }

}

provider "azurerm" {
  features {}
}

provider "azuread" {
}
