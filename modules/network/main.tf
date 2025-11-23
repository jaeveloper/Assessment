# Create Hub VNet
resource "azurerm_virtual_network" "hub" {
  name                = "${var.prefix}-hub-vnet"
  address_space       = [var.hub_vnet_cidr]
  location            = var.location
  resource_group_name = var.rg_name
}

# Hub subnets
resource "azurerm_subnet" "hub_subnets" {
  for_each = var.hub_subnets
  name                 = each.value.name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [each.value.prefix]
}

# Spoke1 VNet
resource "azurerm_virtual_network" "spoke1" {
  name                = "${var.prefix}-spoke1-vnet"
  address_space       = [var.spoke1_vnet_cidr]
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "spoke1_subnets" {
  for_each = var.spoke1_subnets
  name                 = each.value.name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.spoke1.name
  address_prefixes     = [each.value.prefix]
}

# Spoke2 VNet
resource "azurerm_virtual_network" "spoke2" {
  name                = "${var.prefix}-spoke2-vnet"
  address_space       = [var.spoke2_vnet_cidr]
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "spoke2_subnets" {
  for_each = var.spoke2_subnets
  name                 = each.value.name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.spoke2.name
  address_prefixes     = [each.value.prefix]
}

# VNet Peerings: Hub <-> Spoke1
resource "azurerm_virtual_network_peering" "hub_to_spoke1" {
  name                      = "hub-to-spoke1"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  allow_gateway_transit = true
}

resource "azurerm_virtual_network_peering" "spoke1_to_hub" {
  name                      = "spoke1-to-hub"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.spoke1.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  use_remote_gateways = true
}

# Hub <-> Spoke2
resource "azurerm_virtual_network_peering" "hub_to_spoke2" {
  name                      = "hub-to-spoke2"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  allow_gateway_transit = true
}

resource "azurerm_virtual_network_peering" "spoke2_to_hub" {
  name                      = "spoke2-to-hub"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.spoke2.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  use_remote_gateways = true
}