####################################
# These resources will create an addtional subnet for Domain Controller
# Use Bastion Service to connect with VM.
####################################

# Dev Subnet
# (Additional subnet for Developer Jumpbox)
resource "azurerm_subnet" "devSubnetdc" {
  name                                           = "devSubnetdc"
  resource_group_name                            = azurerm_resource_group.rg.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = ["10.0.5.0/24"]
  enforce_private_link_endpoint_network_policies = false

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


#######################
# SENSITIVE VARIABLES #
#######################

variable "admin_password" {

}

variable "admin_username" {

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





