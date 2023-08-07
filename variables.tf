variable "resource_group_name"{
  description = "rg-name"
  default ="rg-new"
}

variable "resource_group_location" {
 type    = string
 default = "eastus"
}

variable "num_cpus" {
 type        = number
 description = "Number of CPUs requested by the client."
}

variable "ram_memory_gb" {
 type        = number
 description = "RAM memory in GB requested by the client."
}

variable "vm_sizes" {
 type        = map(string)
 description = "Map to determine the VM size based on the number of CPUs and RAM memory."
 default = {
   "1vCPUs_2GB"  = "Standard_B1s"
   "2vCPUs_4GB"  = "Standard_B2s"
   "2vCPUs_8GB"  = "Standard_DS1_v2"
   "4vCPUs_16GB" = "Standard_DS2_v2"
   "8vCPUs_32GB" = "Standard_DS3_v2"
 }
}

variable "os_disk_size_gb" {
 type        = number
 description = "Size of the OS disk in GB."
}

variable "username" {
 type        = string
 description = "The username for the local account that will be created on the new VM."
 default     = "azureuser"
}

variable "vm_name" {
 type        = string
 description = "Name of the virtual machine."
}