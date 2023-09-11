resource "azurerm_network_security_group" "this_nsg" {
    name    = var.nsg_name
    location = var.nsg_location
    resource_group_name = var.rg_name

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