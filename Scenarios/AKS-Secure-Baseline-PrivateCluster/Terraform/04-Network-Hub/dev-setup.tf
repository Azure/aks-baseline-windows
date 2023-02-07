####################################
# These resources will create an addtional subnet for Domain Controller and JumpBox
# Use Bastion Service to connect with JumpBox VM.
####################################

# Dev Subnet
# (Additional subnet for Developer DC and Jumpbox)
resource "azurerm_subnet" "devSubnetdc" {
  name                                           = "devSubnetdc"
  resource_group_name                            = azurerm_resource_group.rg.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = ["10.200.0.96/27"]
  private_endpoint_network_policies_enabled      = false


}

resource "azurerm_network_security_group" "dev-nsg-dc" {
  name                = "${azurerm_virtual_network.vnet.name}-${azurerm_subnet.devSubnetdc.name}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

}

resource "azurerm_subnet_network_security_group_association" "subnetdc" {
  subnet_id                 = azurerm_subnet.devSubnetdc.id
  network_security_group_id = azurerm_network_security_group.dev-nsg-dc.id
}

# Domain Controller Server VM
module "create_windows_DC" {
  source = "./modules/compute-win-DC"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_subnet_id      = azurerm_subnet.devSubnetdc.id

  server_name         = "svr-dev-dc"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

# JumpBox Server VM
module "create_windows_jump" {
  source = "./modules/compute-win-jump"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_subnet_id      = azurerm_subnet.devSubnetdc.id

  server_name         = "svr-dev-win"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

}

#############
## OUTPUTS ##
#############
# These outputs are used by later deployments
output "lz-devSubnetdc_id" {
  value = azurerm_subnet.devSubnetdc.id
}