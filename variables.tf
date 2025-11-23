variable "rg_name" {}
variable "location" {}
variable "hub_vnet_cidr" {}
variable "spoke1_vnet_cidr" {}
variable "spoke2_vnet_cidr" {}
variable "hub_subnets" {}
variable "spoke1_subnets" {}
variable "spoke2_subnets" {}
variable "allowed_sources" {}
variable "admin_username" {}
variable "ssh_public_key" {}
variable "subscription_id" {
  type = string
}