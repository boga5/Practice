variable "vm_name" {
    type = string
    description = "Name of the VM"
}

variable "vm_location" {
    type = string
    description = "Location of the VM"
}

variable "rg_name" {
    type = string
    description = "RG of the VM"
}

variable "nic_id" {
    type = string
    description = "NIC ID"
}

variable "tags" {
    description = "Tags for resources"
}