# Log Analytics for AKS
resource "azurerm_log_analytics_workspace" "spokeLA" {
  name                = "spoke-la"
  location            = azurerm_resource_group.spoke-rg.location
  resource_group_name = azurerm_resource_group.spoke-rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30 # has to be between 30 and 730

  daily_quota_gb = 10

  tags = var.tags
}