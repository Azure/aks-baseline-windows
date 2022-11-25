########
# DATA #
########

# Data From Existing Infrastructure

data "terraform_remote_state" "existing-lz" {
  backend = "azurerm"

  config = {
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key                  = "lz-net"
    access_key = var.access_key
  }
}

data "terraform_remote_state" "aks-support" {
  backend = "azurerm"

  config = {
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key                  = "aks-sup"
    access_key = var.access_key
  }
}

data "terraform_remote_state" "aad" {
  backend = "azurerm"

  config = {
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key                  = "aad"
    access_key = var.access_key
  }
}

data "terraform_remote_state" "existing-hub" {
  backend = "azurerm"

  config = {
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key                  = "hub-net"
    access_key = var.access_key
  }
}

data "azurerm_client_config" "current" {}

resource "azuread_group" "appdevs" {
  display_name     = var.aks_admin_group
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

resource "azuread_group" "aksops" {
  display_name     = var.aks_user_group
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}


