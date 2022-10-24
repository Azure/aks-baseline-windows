# Data From Existing Infrastructure

data "terraform_remote_state" "existing-hub" {
  backend = "azurerm"

  config = {
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key                  = "hub-net"
  }
}












