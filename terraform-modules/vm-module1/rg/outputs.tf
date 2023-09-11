output "rg_name" {
    value = azurerm_resource_group.this_rg.name
}

output "rg_location" {
  value = azurerm_resource_group.this_rg.location
}

output "random_id" {
  value = random_integer.ri.result
}