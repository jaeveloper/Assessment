output "hub_vnet_id" { value = azurerm_virtual_network.hub.id }
output "hub_subnet_ids" {
  value = { for k, s in azurerm_subnet.hub_subnets : k => s.id }
}
output "spoke1_vnet_id" { value = azurerm_virtual_network.spoke1.id }
output "spoke1_subnet_ids" { value = { for k, s in azurerm_subnet.spoke1_subnets : k => s.id } }
output "spoke2_vnet_id" { value = azurerm_virtual_network.spoke2.id }
output "spoke2_subnet_ids" { value = { for k, s in azurerm_subnet.spoke2_subnets : k => s.id } }

output "hub_vnet_cidr" {
  value = tolist(azurerm_virtual_network.hub.address_space)[0]
}