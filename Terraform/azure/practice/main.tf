provider "azurerm" {
  features {}

  subscription_id = ""
  tenant_id       = ""
}

resource "azurerm_resource_group" "main" {
    name = "example"
    location = "West Europe"
}