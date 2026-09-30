terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "4.80.0"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_linux_web_app" "res-0" {
  ftp_publish_basic_authentication_enabled       = false
  https_only                                     = true
  key_vault_reference_identity_id                = "SystemAssigned"
  location                                       = "germanywestcentral"
  name                                           = "epf-rag-squaDZ"
  resource_group_name                            = "rg-epf-rag"
  service_plan_id                                = "/subscriptions/4c1b7d40-1d03-4a65-b5ea-a2b3af088566/resourceGroups/rg-epf-rag/providers/Microsoft.Web/serverFarms/plan-epf-rag"
  webdeploy_publish_basic_authentication_enabled = false
  site_config {
    always_on                         = false
    default_documents                 = ["Default.htm", "Default.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"]
    ftps_state                        = "FtpsOnly"
    ip_restriction_default_action     = ""
    scm_ip_restriction_default_action = ""
    worker_count                      = 1
    application_stack {
    }
  }
}
