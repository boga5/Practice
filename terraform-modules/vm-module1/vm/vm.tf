resource "azurerm_windows_virtual_machine" "this_vm" {
    name = var.vm_name
    location = var.vm_location
    resource_group_name = var.rg_name
    size = "Standard_D2as_v4"
    admin_username = "boga-samp"
    admin_password = "boga@12345"
    network_interface_ids = [var.nic_id]
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
    // depends_on = [ module.rg, module.nic ]
}

output "vm_name" {
    value = azurerm_windows_virtual_machine.this_vm.name
}