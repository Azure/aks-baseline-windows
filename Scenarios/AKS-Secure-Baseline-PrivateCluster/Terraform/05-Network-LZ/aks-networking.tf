
# This section create a subnet for AKS along with an associated NSG.
resource "azurerm_subnet" "aks" {
  name                                           = "aksSubnet"
  resource_group_name                            = azurerm_resource_group.spoke-rg.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = ["10.240.0.0/22"]
  private_endpoint_network_policies_enabled      = true

}

# Subnet for AKS Load Blancer 
resource "azurerm_subnet" "lb" {
  name                                           = "lbSubnet"
  resource_group_name                            = azurerm_resource_group.spoke-rg.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = ["10.240.4.0/28"]
  private_endpoint_network_policies_enabled      = true

}

# Subnet for AKS Windows Nodepool 
resource "azurerm_subnet" "windowsnp" {
  name                                           = "windowsNpSubnet"
  resource_group_name                            = azurerm_resource_group.spoke-rg.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = ["10.240.5.0/24"]
  private_endpoint_network_policies_enabled      = true

}

resource "azurerm_network_security_group" "aks-nsg" {
  name                = "${azurerm_virtual_network.vnet.name}-${azurerm_subnet.aks.name}-nsg"
  resource_group_name = azurerm_resource_group.spoke-rg.name
  location            = azurerm_resource_group.spoke-rg.location
}

resource "azurerm_subnet_network_security_group_association" "subnet" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks-nsg.id
}

# Associate Route Table to AKS Subnet
resource "azurerm_subnet_route_table_association" "rt_association" {
  subnet_id      = azurerm_subnet.aks.id
  route_table_id = azurerm_route_table.route_table.id
}

#############
## OUTPUTS ##
#############
# These outputs are used by later deployments
output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}
output "aks_windowsnp_subnet_id" {
  value = azurerm_subnet.windowsnp.id
}