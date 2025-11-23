variable "rg_name" {}
variable "location" {}
variable "prefix" { default = "inf-assess-joshua" }
variable "hub_vnet_cidr" {}
variable "spoke1_vnet_cidr" {}
variable "spoke2_vnet_cidr" {}
variable "hub_subnets" { type = map(object({ name = string, prefix = string })) }
variable "spoke1_subnets" { type = map(object({ name = string, prefix = string })) }
variable "spoke2_subnets" { type = map(object({ name = string, prefix = string })) }