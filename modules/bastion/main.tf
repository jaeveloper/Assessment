# Public IP for the Bastion (required for Standard SKU)
resource "azurerm_public_ip" "bastion_pip" {
  name                = "${var.prefix}-bastion-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Standard Bastion Host
resource "azurerm_bastion_host" "bastion" {
  name                = "${var.prefix}-bastion"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard"
  scale_units         = 2

  ip_configuration {
    name                 = "bastion-ipcfg"
    subnet_id            = var.bastion_subnet_id   # AzureBastionSubnet ID
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }

  # Optional features
  copy_paste_enabled        = true
  file_copy_enabled         = false
  session_recording_enabled = false
}
