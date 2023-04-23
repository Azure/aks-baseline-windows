# CAF
module "CAFResourceNames" {
  source      = "../"
  workload    = "gsma"
  environment = "dev"
  region      = "weu"
  instance    = "001"
}

output "azurerm_route_table" {
  value = module.CAFResourceNames.names.azurerm_route_table
}

output "azurerm_example1" {
  value = module.CAFResourceNames.names.azurerm_example1
}

output "azurerm_example2" {
  value = module.CAFResourceNames.names.azurerm_example2
}

output "all_resources" {
  value = module.CAFResourceNames.names
}
