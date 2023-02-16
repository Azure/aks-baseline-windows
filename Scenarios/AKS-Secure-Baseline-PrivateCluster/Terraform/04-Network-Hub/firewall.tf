
# Azure Firewall 
# --------------
# Firewall Rules created via Module

resource "azurerm_public_ip" "firewall" {
  count                = "3"
  name                 = "HUB-${count.index}-firewall-pip"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  allocation_method    = "Static"
  sku                  = "Standard"
  zones = ["1","2","3"]
}

resource "azurerm_firewall" "firewall" {
  name                = "${azurerm_virtual_network.vnet.name}-firewall"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  firewall_policy_id  = module.firewall_rules_aks.fw_policy_id
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  zones = ["1","2","3"]

  ip_configuration {
    name                 = "fw-pip0"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall[0].id
  }

  ip_configuration {
    name                 = "fw-pip1"
    public_ip_address_id = azurerm_public_ip.firewall[1].id
  }

  ip_configuration {
    name                 = "fw-pip2"
    public_ip_address_id = azurerm_public_ip.firewall[2].id
  }
}

module "firewall_rules_aks" {
  source = "./modules/aks-fw-rules"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  firewallName        = azurerm_firewall.firewall.name
}
