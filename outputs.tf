output "resource_group_name"{
  value = azurerm_resource_group.rg.name
}


output "public_ip_address" {
  value = module.virtual_machine.public_ip_address
}

