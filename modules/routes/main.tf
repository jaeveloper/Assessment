# Create a route table
resource "azurerm_route_table" "spoke_rt" {
  name                = "${var.rg_name}-spoke-rt"
  resource_group_name = var.rg_name
  location            = var.location
}

# Route to Spoke1 via Virtual Network Gateway
resource "azurerm_route" "to_spoke1" {
  name                 = "to-spoke1-via-vng"
  resource_group_name  = var.rg_name
  route_table_name     = azurerm_route_table.spoke_rt.name
  address_prefix       = "10.1.0.0/24"  # update if needed
  next_hop_type        = "VirtualNetworkGateway"
}

# Route to Spoke2 via Virtual Network Gateway
resource "azurerm_route" "to_spoke2" {
  name                 = "to-spoke2-via-vng"
  resource_group_name  = var.rg_name
  route_table_name     = azurerm_route_table.spoke_rt.name
  address_prefix       = "10.2.0.0/24"  # update if needed
  next_hop_type        = "VirtualNetworkGateway"
}

# Associate route table with Spoke1 subnet
resource "azurerm_subnet_route_table_association" "spoke1_assoc" {
  subnet_id      = var.spoke1_subnet_id
  route_table_id = azurerm_route_table.spoke_rt.id
}

# Associate route table with Spoke2 subnet
resource "azurerm_subnet_route_table_association" "spoke2_assoc" {
  subnet_id      = var.spoke2_subnet_id
  route_table_id = azurerm_route_table.spoke_rt.id
}