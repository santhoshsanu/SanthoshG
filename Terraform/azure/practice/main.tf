provider "azurerm" {
  features {}

  subscription_id = ""
  tenant_id       = ""
}

resource "azurerm_resource_group" "main" {
    name = "example"
    location = "East US"
}

resource "azurerm_virtual_network" "primary" {
  name = "primary-network"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space = ["10.0.0.0/16"]
}


resource "azurerm_subnet" "web" {
  name = "web-subnet"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.primary.name
  address_prefixes = ["10.0.0.1/24"]
}
