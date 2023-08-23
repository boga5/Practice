output "resource_group_name" {
  value = azurerm_resource_group.tfm_app.name
}

output "app_service_plan" {
  value = azurerm_service_plan.tfm_app.name
}

output "app_service" {
  value = azurerm_linux_web_app.tfm_app.name
}

output "app_url" {
  value = "https://${azurerm_linux_web_app.tfm_app.default_hostname}"
}
