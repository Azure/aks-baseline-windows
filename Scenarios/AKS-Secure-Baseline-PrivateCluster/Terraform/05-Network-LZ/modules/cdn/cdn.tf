resource "azurerm_cdn_frontdoor_profile" "cdn-fd" {
  name                = var.name
  resource_group_name = var.rg
  sku_name            = "Premium_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "cdn-ep" {
  name                     = "${var.prefix}-ep"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn-fd.id
}

resource "azurerm_monitor_diagnostic_setting" "cdn" {
  name               = "cdndiagnostics"
  target_resource_id = azurerm_cdn_frontdoor_profile.cdn-fd.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"

    retention_policy {
      enabled = true
      days = "30"
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days = "30"
    }
  }
}
  ####
  #### Input variables
  ####

variable "name" {
  
}

variable "rg" {
  
}

variable "prefix" {
  
}

variable "log_analytics_workspace_id" {
  
}