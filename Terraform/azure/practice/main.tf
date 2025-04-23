resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "primary" {
  name                = "${var.resource_group_name}-network"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.address_space]

  depends_on = [azurerm_resource_group.main]
}


resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet-names)
  name                 = var.subnet-names[count.index]
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.primary.name
  address_prefixes     = [cidrsubnet(var.address_space, 8, count.index)]

  depends_on = [azurerm_virtual_network.primary]
}


resource "azurerm_network_security_group" "nsg" {
  name                = "${var.resource_group_name}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

}


resource "azurerm_network_security_rule" "nsg_rule" {
  count                       = length(var.nsg_rule)
  name                        = var.nsg_rule[count.index].name
  priority                    = var.nsg_rule[count.index].priority
  direction                   = var.nsg_rule[count.index].direction
  access                      = var.nsg_rule[count.index].access
  protocol                    = var.nsg_rule[count.index].protocol
  source_port_range           = var.nsg_rule[count.index].source_port_range
  destination_port_range      = var.nsg_rule[count.index].destination_port_range
  source_address_prefix       = var.nsg_rule[count.index].source_address_prefix
  destination_address_prefix  = var.nsg_rule[count.index].destination_address_prefix
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.nsg.name

  depends_on = [azurerm_network_security_group.nsg]
}