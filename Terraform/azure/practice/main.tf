provider "azurerm" {
  features {}

  subscription_id = "6a6a9c10-f82a-4e15-bf31-cd5b20019403"
  tenant_id       = "b5c45fbc-1a54-4e8c-b402-48f9f2f03237"
}

resource "azurerm_resource_group" "main" {
    name = "example"
    location = "West Europe"
}