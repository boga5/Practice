/*
#creating a random id for using it everywhere
resource "random_id" "random_id" {
    keepers = {
        resource_group = ""
    }
    byte_length = 8
}

resource "azurerm_resource_group" "this_rg" {
    name = "rg-${random_id.random_id.hex}"
    location = "centralindia"
}
*/

resource "azurerm_virtual_network" "this_vnet" {
    name        = "vnet${module.rg.random_id}"
    location    = module.rg.rg_location
    resource_group_name    = module.rg.rg_name
    address_space = ["10.5.0.0/20"]
}

resource "azurerm_subnet" "this_snet" {
    name        = "snet${module.rg.random_id}"
    resource_group_name   = module.rg.rg_name
    virtual_network_name = azurerm_virtual_network.this_vnet.name
    subnet_prefixes = ["10.0.2.0/26"]
}

/*
output "random_id" {
    value = random_id.random_id.hex
}

output "resource_group" {
    value = azurerm_resource_group.this_rg.name
}

output "rg_location" {
    value = azurerm_resource_group.this_rg.location
}
*/

output "vm_vnet" {
    value = azurerm_virtual_network.this_vnet
}

output "vm_subnet" {
    value = azurerm_subnet.this_snet
}

output "snet_name" {
    value = azurerm_subnet.this_snet.name
}