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
}

locals {
  common_tags = {
    createdBy    = "Boga"
    createdUsing = "Terraform"
    usage        = "Personal"
    source       = "Terraform-CLI"
  }
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "tfm_rg" {
  name     = "rg-${random_integer.ri.result}"
  location = "eastus"
  tags = local.common_tags
}

resource "azurerm_service_plan" "tfm_asp" {
  name                = "asp-${random_integer.ri.result}"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.tfm_rg.name
  os_type             = "Linux"
  sku_name            = "B1"
  tags = local.common_tags
}

resource "azurerm_linux_web_app" "tfm_app" {
  name                = "app-${random_integer.ri.result}"
  location            = azurerm_resource_group.tfm_rg.location
  resource_group_name = azurerm_resource_group.tfm_rg.name
  service_plan_id     = azurerm_service_plan.tfm_asp.id

  site_config {
    application_stack {
      node_version = "16-lts"
    }
  }
  tags = merge(local.common_tags, {tagCreated = "InsideResourceBlock"} )
}

resource "null_resource" "pass_variables" {
  provisioner "local-exec" {
    command = <<EOT
      Write-Host "##vso[task.setvariable variable=app_name isoutput=true;]${azurerm_linux_web_app.tfm_app.name}"
      EOT
    interpreter = [ "pwsh","-Command" ]
  }
}
