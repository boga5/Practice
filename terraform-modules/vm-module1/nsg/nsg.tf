resource "azurerm_network_security_group" "this_nsg" {
    name    = "nsg${module.vnet.random_id}"
    location = module.rg.rg_location
    resource_group_name = module.vnet.rg_name

    security_rule {
        name = "RDP"
        priority = "300"
        direction = "Inbound"
        protocol = "Tcp"
        access = "Allow"
        source_address_prefix = "*"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "1433"
    }
}

output "vm_nsg" {
    value = azurerm_network_security_group.this_nsg
}