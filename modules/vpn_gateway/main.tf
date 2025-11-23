# Create Public IP for VNG (required)
resource "azurerm_public_ip" "vng_pip" {
  name = "${var.rg_name}-vng-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Virtual Network Gateway
resource "azurerm_virtual_network_gateway" "vng" {
  name = "${var.rg_name}-vng-pip"
  location            = var.location
  resource_group_name = var.rg_name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = var.gateway_sku

  ip_configuration {
    name                          = "vng-ipcfg"
    public_ip_address_id          = azurerm_public_ip.vng_pip.id
    subnet_id                     = var.gateway_subnet_id
  }

  # P2S disabled: no vpn_client_configuration set when enable_p2s = false
}