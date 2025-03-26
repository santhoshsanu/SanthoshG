provider "azurerm" {
  features {}

  subscription_id = ""
}

resource "azurerm_resource_group" "main" {
    name = "example-tf"
    location = "East US"
}

resource "azurerm_virtual_network" "primary" {
  name = "primary-network"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space = ["10.0.0.0/16"]

  depends_on = [ azurerm_resource_group.main ]
}


resource "azurerm_subnet" "web" {
  name = "web-subnet"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.primary.name
  address_prefixes = ["10.0.1.0/24"]

  depends_on = [ azurerm_virtual_network.primary ]
}

resource "azurerm_subnet" "data" {
  name = "data-subnet"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.primary.name
  address_prefixes = ["10.0.2.0/24"]

  depends_on = [ azurerm_virtual_network.primary ]
}
