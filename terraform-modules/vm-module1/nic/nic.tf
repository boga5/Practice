
resource "azurerm_network_interface" "this_nic" {
    name = var.nic_name
    location = var.nic_location
    resource_group_name = var.rg_name

    ip_configuration {
        name = "${var.nic_name}cfg"
        subnet_id = var.snet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = var.pip_id
    }
}

resource "azurerm_network_interface_security_group_association" "this_nic_nsg" {
    network_interface_id = azurerm_network_interface.this_nic.id
    network_security_group_id = var.nsg_id
}