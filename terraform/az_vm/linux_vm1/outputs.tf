output "resource_group_name" { value = data.azurerm_resource_group.rg.name }
output "VNet-name" { value = azurerm_virtual_network.boga_vnet.name }
output "Subnet-name" { value = azurerm_subnet.lin_snet.name }
output "public-ip" { value = azurerm_linux_virtual_machine.lin_vm.public_ip_address }
output "NSG-name" { value = azurerm_network_security_group.lin_nsg.name }
output "NIC-name" { value = azurerm_network_interface.lin_nic.name }
output "vm-name" { value = azurerm_linux_virtual_machine.lin_vm.name }
output "vm-size" { value = azurerm_linux_virtual_machine.lin_vm.size }
output "Boot-Diagnostics-Storage-name" { value = azurerm_storage_account.boga_storage.name }