terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "rg" {
  source      = "./modules/resource_group"
  rg_name     = var.rg_name
  rg_location = var.location
}

module "network" {
  source = "./modules/network"

  rg_name  = module.rg.rg_name
  location = var.location

  hub_vnet_cidr    = var.hub_vnet_cidr
  spoke1_vnet_cidr = var.spoke1_vnet_cidr
  spoke2_vnet_cidr = var.spoke2_vnet_cidr

  hub_subnets    = var.hub_subnets
  spoke1_subnets = var.spoke1_subnets
  spoke2_subnets = var.spoke2_subnets
}

module "nsg" {
  source          = "./modules/nsg"
  rg_name         = module.rg.rg_name
  location        = var.location
  allowed_sources = var.allowed_sources
}

resource "azurerm_subnet_network_security_group_association" "spoke1" {
  subnet_id                 = module.network.spoke1_subnet_ids["vm-subnet"]
  network_security_group_id = module.nsg.nsg_id
}

resource "azurerm_subnet_network_security_group_association" "spoke2" {
  subnet_id                 = module.network.spoke2_subnet_ids["vm-subnet"]
  network_security_group_id = module.nsg.nsg_id
}

module "vng" {
  source            = "./modules/vpn_gateway"
  rg_name           = module.rg.rg_name
  location          = var.location
  vnet_id           = module.network.hub_vnet_id
  gateway_subnet_id = module.network.hub_subnet_ids["GatewaySubnet"]
  enable_p2s        = false
}

module "bastion" {
  source        = "./modules/bastion"
  rg_name       = var.rg_name
  location      = var.location
  bastion_subnet_id   = module.network.hub_subnet_ids["AzureBastionSubnet"] # if needed

  virtual_network_id = module.network.hub_vnet_id  # pass it as input
}

module "vm1" {
  source         = "./modules/vm"
  vm_name        = "vm1"
  rg_name        = module.rg.rg_name
  location       = var.location
  subnet_id      = module.network.spoke1_subnet_ids["vm-subnet"]
  admin_username = var.admin_username
  ssh_public_key = var.ssh_public_key
}

module "vm2" {
  source         = "./modules/vm"
  vm_name        = "vm2"
  rg_name        = module.rg.rg_name
  location       = var.location
  subnet_id      = module.network.spoke2_subnet_ids["vm-subnet"]
  admin_username = var.admin_username
  ssh_public_key = var.ssh_public_key
}

module "routes" {
  source           = "./modules/routes"
  rg_name          = var.rg_name
  location         = var.location
  spoke1_subnet_id = module.network.spoke1_subnet_ids["vm-subnet"]
  spoke2_subnet_id = module.network.spoke2_subnet_ids["vm-subnet"]
  vng_id           = module.vng.vng_id
  hub_cidr         = module.network.hub_vnet_cidr
}
