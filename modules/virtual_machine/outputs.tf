output "vm_size_found" {
 value = null_resource.validate_vm_size.triggers["vm_size_found"]
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}