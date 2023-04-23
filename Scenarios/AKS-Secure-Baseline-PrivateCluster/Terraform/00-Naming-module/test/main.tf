# CAF
module "CAFResourceNames" {
  source      = "../"
  workload    = "gsma"
  environment = "dev"
  region      = "weu"
  instance    = "001"
}

output "azurerm_key_vault" {
  value = module.CAFResourceNames.names.azurerm_key_vault
}

output "all_resources" {
  value = module.CAFResourceNames.names
}
