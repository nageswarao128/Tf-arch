

resource "azurerm_virtual_network" "my_terraform_network" {
 name                = "Vnet-tf"
 address_space       = ["10.0.0.0/16"]
 location            = var.resource_group_location
 resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "my_terraform_subnet" {
 name                 = "mySubnet"
 resource_group_name = var.resource_group_name
 virtual_network_name = azurerm_virtual_network.my_terraform_network.name
 address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "my_terraform_public_ip" {
 name                = "myPublicIP"
 location            = var.resource_group_location
 resource_group_name = var.resource_group_name
 allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "my_terraform_nsg" {
 name                = "myNetworkSecurityGroup"
 location            = var.resource_group_location
 resource_group_name = var.resource_group_name

 security_rule {
   name                       = "SSH"
   priority                   = 1001
   direction                  = "Inbound"
   access                     = "Allow"
   protocol                   = "Tcp"
   source_port_range          = "*"
   destination_port_range     = "22"
   source_address_prefix      = "*"
   destination_address_prefix = "*"
 }
}

