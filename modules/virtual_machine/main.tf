module "network"{
    source = "../network"
    resource_group_name = var.resource_group_name
    #resource_group_name = azurerm_resource_group.rg.name
  }
 

resource "azurerm_network_interface" "my_terraform_nic" {
 name                = "myNIC"
 location            = var.resource_group_location
 resource_group_name = var.resource_group_name

 ip_configuration {
   name                          = "my_nic_configuration"
   subnet_id                     = module.network.subnet_id
   private_ip_address_allocation = "Dynamic"
   public_ip_address_id          = module.network.public_ip_id
 }
}

locals {
 vm_size = lookup(var.vm_sizes, "${var.num_cpus}vCPUs_${var.ram_memory_gb}GB", null)
}

resource "null_resource" "validate_vm_size" {
 triggers = {
   vm_size_found = local.vm_size != null
 }

 provisioner "local-exec" {
   when      = create
   command   = "echo 'No matching VM size found for the specified number of CPUs and RAM memory.'"
   on_failure = continue
 }
}
 resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  name               = var.vm_name
  location           = var.resource_group_location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic.id]
  size               = local.vm_size  #  determined VM size here

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
 
  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = var.os_disk_size_gb  
  }
 
   
  computer_name  = "hostname"
  admin_username = var.username
  admin_password = "London@123"

  disable_password_authentication = var.disable_password_authentication
  
  }
 