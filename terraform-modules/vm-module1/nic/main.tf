resource "azurerm_network_interface" "this_nic" {
    name = "nic${module.rg.random_id}"
    location = module.rg.rg_location
    resource_group_name = module.rg.rg_name

    ip_configuration {
        name = "nic-config${module.rg.random_id}"
        subnet_id = module.vnet.vm_subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = module.public_ip.vm_public_ip.id
    }
}

resource "azurerm_network_interface_security_group_association" "this_nic_nsg" {
    network_interface_id = azurerm_network_interface.this_nic.id
    network_security_group_id = module.nsg.vm_nsg.id
}