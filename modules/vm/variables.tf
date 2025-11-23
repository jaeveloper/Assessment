variable "vm_name" {}
variable "rg_name" {}
variable "location" {}
variable "subnet_id" {}
variable "admin_username" { default = "azureuser" }
variable "ssh_public_key" {}
variable "vm_size" { default = "Standard_B1ms" }
variable "image_publisher" { default = "Canonical" }
variable "image_offer" { default = "UbuntuServer" }
variable "image_sku" { default = "20_04-lts" }

