resource "random_id" "random_id" {
    keepers = {
        resource_group = azurerm_resource_group.name
    }
    byte_length = 8
}

resource "azurerm_resource_group" "this_rg" {
    name = "rg-${random_id.random_id.hex}"
    location = "centralindia"
}

output "rg_name" {
    value = azurerm_resource_group.this_rg.name
}

output "rg_location" {
  value = azurerm_resource_group.this_rg.location
}

output "random_id" {
  value = random_id.random_id.hex
}