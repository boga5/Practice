resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "this_rg" {
    name = "rg-${random_integer.ri.result}"
    location = "East US"
    // depends_on = [ random_id.random_id.hex ]
}