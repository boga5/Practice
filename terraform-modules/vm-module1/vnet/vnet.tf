resource "azurerm_virtual_network" "this_vnet" {
    name        = var.vnet_name
    location    = var.vnet_location
    resource_group_name    = var.rg_name
    address_space = ["10.5.0.0/20"]
    // depends_on = [ module.rg.rg_name, module.rg.random_id ]
}

resource "azurerm_subnet" "this_snet" {
    name        = var.snet_name
    resource_group_name   = var.rg_name
    virtual_network_name = azurerm_virtual_network.this_vnet.name
    address_prefixes = ["10.5.1.0/26"]
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
    value = azurerm_virtual_network.this_vnet.name
}

output "vm_subnet_id" {
    value = azurerm_subnet.this_snet.id
}

output "snet_name" {
    value = azurerm_subnet.this_snet.name
}