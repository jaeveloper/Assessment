output "vm1_private_ip" {
  value = module.vm1.private_ip
}
output "vm2_private_ip" {
  value = module.vm2.private_ip
}
output "bastion_host_id" {
  value = module.bastion.bastion_id
}