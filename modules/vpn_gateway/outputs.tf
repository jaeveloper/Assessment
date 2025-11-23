output "vng_id" { value = azurerm_virtual_network_gateway.vng.id }
output "vng_public_ip" { value = azurerm_public_ip.vng_pip.ip_address }

