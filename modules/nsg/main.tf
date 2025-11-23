resource "azurerm_network_security_group" "this" {
  name                = "${var.prefix}-vm-subnet-nsg"
  location            = var.location
  resource_group_name = var.rg_name
}

# SSH inbound
resource "azurerm_network_security_rule" "ssh_in" {
  name                        = "SSH-ALLOW"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes = ["0.0.0.0/0"]
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.this.name
}

# RDP inbound
resource "azurerm_network_security_rule" "rdp_in" {
  name                        = "RDP-ALLOW"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefixes = ["0.0.0.0/0"]
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.this.name
}

# ICMP inbound
resource "azurerm_network_security_rule" "icmp_in" {
  name                        = "ICMP-ALLOW"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  
  # Allow ICMP from hub and spoke VNets
  source_address_prefixes      = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
  destination_address_prefixes = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]

  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.this.name
}

# Outbound: allow all (default)
resource "azurerm_network_security_rule" "out_allow_all" {
  name                        = "Allow-All-Out"
  priority                    = 1000
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.this.name
}