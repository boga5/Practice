resource "azurerm_storage_account" "this_storage" {
    name = "diag${module.rg.random_id}"
    location = module.rg.rg_location
    resource_group_name = module.rg.rg_name
    account_tier = "Standard"
    account_replication_type = "LRS"
}

output "vm_diag_str" {
    value = azurerm_storage_account.this_storage
}