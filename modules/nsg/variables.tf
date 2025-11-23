variable "rg_name" {}
variable "location" {}
variable "allowed_sources" {
  type = list(string)
}
variable "prefix" { default = "inf-assess-joshua" }