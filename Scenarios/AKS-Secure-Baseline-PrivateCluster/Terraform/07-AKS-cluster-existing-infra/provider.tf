terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.37.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.53.0"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 3.2.0"
    }
  }
  backend "azurerm" {
    # resource_group_name  = ""   # Partial configuration, provided during "terraform init"
    # storage_account_name = ""   # Partial configuration, provided during "terraform init"
    # container_name       = ""   # Partial configuration, provided during "terraform init"
    key = "aks-existing-infra"
  }
}

provider "azurerm" {
  features {}
}
