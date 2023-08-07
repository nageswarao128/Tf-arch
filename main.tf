resource "azurerm_resource_group" "rg" {
 name     = "rg-new"
 location = var.resource_group_location
}



module "network" {
 source             = "./modules/network"
 resource_group_name = azurerm_resource_group.rg.name
 
}

module "virtual_machine" {
 source             = "./modules/virtual_machine"
 resource_group_name = azurerm_resource_group.rg.name
 num_cpus            = var.num_cpus
 ram_memory_gb       = var.ram_memory_gb
 username            = var.username
 vm_name             = var.vm_name
 os_disk_size_gb     = var.os_disk_size_gb
 vm_sizes            = var.vm_sizes
 
 

}