resource "azurerm_public_ip" "this_public_ip" {
    name = "publicip${module.rg.random_id}"
    location = module.rg.rg_location
    resource_group_name = module.rg.rg_name
    allocation_method = "Dynamic"
}

output "vm_public_ip" {
    value = azurerm_public_ip.this_public_ip
}

output "vm_public_ip_address" {
    value = azurerm_public_ip.this_public_ip.id
}