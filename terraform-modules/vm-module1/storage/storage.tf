resource "azurerm_storage_account" "this_storage" {
    name = var.storage_name
    location = var.storage_location
    resource_group_name = var.rg_name
    account_tier = "Standard"
    account_replication_type = "LRS"
    tags = var.tags
    // depends_on = [ module.rg.rg_name, module.rg.random_id ]
}

output "vm_diag_str" {
    value = azurerm_storage_account.this_storage
}