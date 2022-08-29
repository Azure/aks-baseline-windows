# Data From Existing Infrastructure

data "terraform_remote_state" "existing-hub" {
  backend = "azurerm"

  config = {
    storage_account_name = var.state_sa_name
    container_name       = var.container_name
    key                  = var.network-tf-state-key
    access_key           = var.access_key
  }
}

#output "hub_rg_location" {
 # value = terraform_remote_state.existing-hub.location
#}












