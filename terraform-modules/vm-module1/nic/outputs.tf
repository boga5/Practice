output "vm_nic" {
    value = azurerm_network_interface.this_nic
    description = "NIC Details"
}