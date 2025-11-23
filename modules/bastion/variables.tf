variable "rg_name" {}
variable "location" {}
variable "bastion_subnet_id" {}
variable "prefix" { default = "inf-assess-joshua" }

variable "virtual_network_id" {
  description = "ID of the hub virtual network"
  type        = string
}