resource "azurerm_windows_virtual_machine" "this_vm" {
    name = "vm-${module.rg.random_id}"
    location = module.rg.rg_location
    resource_group_name = module.rg.rg_name
    size = "Standard_D2as_v4"
    admin_username = "boga-samp"
    admin_password = "boga@12345"
    network_interface_id = [module.nic.id]
    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2019-Datacenter"
        version = "latest"
    }
}

output "vm_name" {
    value = azurerm_windows_virtual_machine.this_vm.name
}