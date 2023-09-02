variable "vm_rg" {
  type        = string
  description = "Resource group where VM should be placed"
}

variable "vm_location" {
  description = "Location of all the resources created uisng this Terraform script"
  type        = string
}

variable "vm_vnet_name" {
  description = "Name of Virtual Network used by this VM"
  type        = string
}

variable "vm_snet_name" {
  description = "Name of Subnet used by our VM"
  type        = string
}

variable "vm_public_ip" {
  description = "Name of our public IP"
  type        = string
}

variable "ip_allocation_method" {
  description = "Allocation method of IP. Dynamic/Static"
  type        = string
  default     = "Dynamic"
}

variable "vm_nsg" {
  description = "Name of our Network Security Group (NSG)"
  type        = string
}

variable "vm_nic" {
  description = "Name of the Network Interface Card"
  type        = string
}

variable "vm_nic_config" {
  description = "Name of the NIC Configuration"
  type        = string
}

variable "pvt_ip_allocation_method" {
  description = "Allocation Method of Provate IP. Dynamic/Static"
  type        = string
  default     = "Dynamic"
}

variable "storage_acc_tier" {
  description = "Storage Account Tier. Standard/Premium"
  type        = string
  default     = "Standard"
}

variable "storage_acc_replica_type" {
  description = "Replication Type of Storage. LRS/GRS/RA-GRS"
  type        = string
  default     = "LRS"
}

variable "vm_name" {
  description = "Name of VM"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
}

variable "os_disk_name" {
  description = "Name of the OS Disk"
  type        = string
}

variable "vm_disk_storage_acc_type" {
  description = "Storage Account type of disk. Standard_LRS"
  type        = string
  default     = "Standard_LRS"
}

variable "vm_username" {
  type        = string
  description = "Username to login to Linux VM"
}

variable "vm_password" {
  type        = string
  description = "Password for the VM to login"
}
