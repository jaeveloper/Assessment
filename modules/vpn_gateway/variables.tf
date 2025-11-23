variable "rg_name" {}
variable "location" {}
variable "vnet_id" {}
variable "gateway_subnet_id" {}
variable "gateway_sku" { default = "VpnGw1" }
variable "enable_p2s" { default = false }