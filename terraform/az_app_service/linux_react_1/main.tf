terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  #subscription_id = "d5a9087f-7556-40c9-b9fd-80b4468b8ef8"
  #tenant_id         = "${env.ARM_TENANT_ID}"
  #client_id = "${env.ARM_CLIENT_ID}"
  #client_secret = "${env.ARM_CLIENT_SECRET}"
}

#resource "azurerm_resource_group" "tfm_app" {
#  name     = var.rg_name
#  location = var.location
#}

resource "azurerm_service_plan" "tfm_app" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = azurerm_resource_group.tfm_app.name
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "tfm_app" {
  name                = var.app_service_name
  location            = azurerm_resource_group.tfm_app.location
  resource_group_name = azurerm_resource_group.tfm_app.name
  service_plan_id     = azurerm_service_plan.tfm_app.id

  site_config {}
}
