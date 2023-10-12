resource "azurerm_public_ip" "this_public_ip" {
    name = var.pip_name
    location = var.pip_location
    resource_group_name = var.rg_name
    allocation_method = "Dynamic"
    tags = var.tags
}

output "vm_public_ip" {
    value = azurerm_public_ip.this_public_ip
}

output "vm_public_ip_address" {
    value = azurerm_public_ip.this_public_ip.id
}