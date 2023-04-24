resource "azurerm_subnet" "bastionhost" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnet_cidr]
}

resource "azurerm_public_ip" "bastionhost" {
  name                = replace(var.caf_basename.azurerm_public_ip, "pip", "bastpip")
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastionhost" {
  name                = var.caf_basename.azurerm_bastion_host
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastionhost.id
    public_ip_address_id = azurerm_public_ip.bastionhost.id
  }
}

# Diagnostic setting for Bastion host
resource "azurerm_monitor_diagnostic_setting" "bastion" {
  name                       = replace(var.caf_basename.azurerm_monitor_diagnostic_setting, "amds", "bastamds")
  target_resource_id         = azurerm_bastion_host.bastionhost.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"

    retention_policy {
      enabled = true
      days    = "30"
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = "30"
    }
  }
}
