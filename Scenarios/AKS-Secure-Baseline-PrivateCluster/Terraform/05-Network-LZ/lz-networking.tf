# Resource Group for Landing Zone Networking
# This RG uses the same region location as the Hub.
resource "azurerm_resource_group" "spoke-rg" {
  name     = "${var.lz_prefix}-SPOKE"
  location = data.terraform_remote_state.existing-hub.outputs.hub_rg_location
}

output "lz_rg_location" {
  value = azurerm_resource_group.spoke-rg.location
}

output "lz_rg_name" {
  value = azurerm_resource_group.spoke-rg.name
}


# Virtual Network

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.lz_prefix}-vnet"
  resource_group_name = azurerm_resource_group.spoke-rg.name
  location            = azurerm_resource_group.spoke-rg.location
  address_space       = ["10.240.0.0/16"]
  dns_servers         = ["10.240.6.4"]
  tags                = var.tags

}

resource "azurerm_subnet" "priv-link" {
  name                                           = "priv-subnet"
  resource_group_name                            = azurerm_resource_group.spoke-rg.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = ["10.240.4.32/28"]
  enforce_private_link_endpoint_network_policies = true

}

output "lz_vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "lz_vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "priv_subnet_id" {
  value = azurerm_subnet.priv-link.id
}

# # Create Route Table for Landing Zone
# (All subnets in the landing zone will need to connect to this Route Table)
resource "azurerm_route_table" "route_table" {
  name                          = "rt-${var.lz_prefix}"
  resource_group_name           = azurerm_resource_group.spoke-rg.name
  location                      = azurerm_resource_group.spoke-rg.location
  disable_bgp_route_propagation = false

  route {
    name                   = "route_to_firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.200.0.4"
  }
}

output "lz_rt_id" {
  value = azurerm_route_table.route_table.id
}
