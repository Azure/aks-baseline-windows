resource "azurerm_cdn_frontdoor_profile" "cdn-fd" {
  name                = var.name
  resource_group_name = var.rg
  sku_name            = "Premium_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "cdn-ep" {
  name                     = "${var.prefix}-ep"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn-fd.id
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