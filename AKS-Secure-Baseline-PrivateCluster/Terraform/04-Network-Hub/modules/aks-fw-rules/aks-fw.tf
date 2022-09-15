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
      source_addresses      = ["10.1.0.0/16"]
      destination_fqdn_tags = ["AzureKubnernetesService"]
    }
  }


  application_rule1_https {
    name     = "akswindows_rule_https"
    priority = 206
    action   = "Allow"
    rule {
      name = "akswindows_rule_https_rule1"

      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = ["10.1.0.0/16"]
      destination_fqdns = ["*.microsoft.com,*.hcp.centralus.azmk8s.io,mcr.microsoft.com,*.data.mcr.microsoft.com,management.azure.com,login.microsoftonline.com,packages.microsoft.com,acs-mirror.azureedge.net,onegetcdn.azureedge.net,go.microsoft.com,*.ods.opinsights.azure.com,*.oms.opinsights.azure.com,vault.azure.net,dc.services.visualstudio.com,*.monitoring.azure.com,data.policy.core.windows.net,store.policy.core.windows.net,centralus.dp.kubernetesconfiguration.azure.com,download.docke.com,docker.io"]
    }
  }

  application_rule2_http {
    name     = "akswindows_rule_http"
    priority = 206
    action   = "Allow"
    rule {
      name = "akswindows_rule_http_rule1"
      protocols {
        type = "Http"
        port = 80
      }

      source_addresses  = ["10.1.0.0/16"]
      destination_fqdns = ["*.ubuntu.com,*.microsoft.com,*.windowsupdate.com"]
    }
  }


  network_rule_collection {
    name     = "aks_network_rules"
    priority = 201
    action   = "Allow"
    rule {
      name                  = "https"
      protocols             = ["TCP"]
      source_addresses      = ["10.1.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["443"]
    }
    rule {
      name                  = "dns"
      protocols             = ["UDP"]
      source_addresses      = ["10.1.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
    }
    rule {
      name                  = "time"
      protocols             = ["UDP"]
      source_addresses      = ["10.1.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["123"]
    }
    rule {
      name                  = "tunnel_udp"
      protocols             = ["UDP"]
      source_addresses      = ["10.1.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["1194"]
    }
    rule {
      name                  = "tunnel_tcp"
      protocols             = ["TCP"]
      source_addresses      = ["10.1.0.0/16"]
      destination_addresses = ["*"]
      destination_ports     = ["9000"]
    }
  }

}

variable "resource_group_name" {}

variable "location" {}



