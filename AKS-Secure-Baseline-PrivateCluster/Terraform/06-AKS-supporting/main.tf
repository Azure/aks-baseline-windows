########
# DATA #
########

# Data From Existing Infrastructure

data "terraform_remote_state" "existing-lz" {
  backend = "azurerm"

  config = {
    storage_account_name = "aksashi001tfsa"
    container_name       = "akscs"
    key                  = "05-network-lz-tf"
    access_key = "DZYrBI0UymOYFqyjHs2Wcv8RsJgDv9K02sU/zFzp4e2D8otXuQ6NV56LsmO7sV8ysByJZ1I74LQK+ASt5NQs1Q=="
  }
}

data "azurerm_client_config" "current" {}


output "key_vault_id" {
  value = module.create_kv.kv_id
}

output "container_registry_id" {
  value = module.create_acr.acr_id
}











