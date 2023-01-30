# Firewall Policy

resource "azurerm_firewall_policy" "aks" {
  name                = "AKSpolicy"
  resource_group_name = var.resource_group_name
  location            = var.location
}

output "fw_policy_id" {
    value = azurerm_firewall_policy.aks.id
}

# Rules Collection Group

resource "azurerm_firewall_policy_rule_collection_group" "AKS" {
  name               = "aks-rcg"
  firewall_policy_id = azurerm_firewall_policy.aks.id
  priority           = 200
  application_rule_collection {
    name     = "aks_app_rules"
    priority = 205
    action   = "Allow"
    rule {
      name = "aks_service"
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses      = ["10.240.0.0/16"]
      destination_fqdn_tags = ["AzureKubnernetesService"]
    }
  }

  application_rule_collection {
    name     = "app_rule_collection2"
    priority = 206
    action   = "Allow"
    rule {
      name = "app_rule_collection1_rule2"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = ["10.240.0.0/16"]
      destination_fqdns = [
      "*.cdn.mscr.io",
      "mcr.microsoft.com",
      "*.data.mcr.microsoft.com",
      "management.azure.com",
      "login.microsoftonline.com",
      "acs-mirror.azureedge.net",
      "dc.services.visualstudio.com",
      "*.opinsights.azure.com",
      "*.oms.opinsights.azure.com",
      "*.microsoftonline.com",
      "*.monitoring.azure.com",
      ]
    }
  }


application_rule_collection {
    name     = "app_rule_collection3"
    priority = 207
    action   = "Allow"
    rule {
      name = "app_rule_collection1_rule3"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = ["10.240.0.0/16"]
      destination_fqdns = [
      "download.opensuse.org",
      "security.ubuntu.com",
      "ntp.ubuntu.com",
      "packages.microsoft.com",
      "snapcraft.io"
      ]
    }
  }

  network_rule_collection {
    name     = "aks_network_rules"
    priority = 201
    action   = "Allow"
    rule {
      name                  = "https"
      protocols             = ["TCP"]
      source_addresses      = ["10.240.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["443"]
    }
    rule {
      name                  = "dns"
      protocols             = ["UDP"]
      source_addresses      = ["10.240.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
    }
    rule {
      name                  = "time"
      protocols             = ["UDP"]
      source_addresses      = ["10.240.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["123"]
    }
    rule {
      name                  = "tunnel_udp"
      protocols             = ["UDP"]
      source_addresses      = ["10.240.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["1194"]
    }
    rule {
      name                  = "tunnel_tcp"
      protocols             = ["TCP"]
      source_addresses      = ["10.240.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["9000"]
    }
  }

}

variable "resource_group_name" {}
variable "location" {}
variable "firewallName" {}


