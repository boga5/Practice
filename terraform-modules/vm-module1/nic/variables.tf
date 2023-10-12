variable nic_name {
    description = "Name of the NIC"
    type = string
}

variable nic_location {
    description = "Name of the NIC"
    type = string
}

variable rg_name {
    description = "Name of the NIC"
    type = string
}

variable snet_id {
    description = "Subnet ID"
    type = string
}

variable "pip_id" {
    type = string
    description = "Public IP ID"
}

variable "nsg_id" {
    type = string
    description = "NSG ID"
}

variable "tags" {
    description = "Tags for resources"
}