variable "nsg_name" {
    type = string
    description = "Name of the NSG"
}

variable "nsg_location" {
    type = string
    description = "Location of the NSG"
}

variable "rg_name" {
    type = string
    description = "RG of the NSG"
}

variable "tags" {
    description = "Tags for resources"
}