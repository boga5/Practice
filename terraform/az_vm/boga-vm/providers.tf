terraform {
  required_version = ">=0.14"
  required_providers {
    /*azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    } */
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    /* random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    } */
  }
  //storing the state file in Azure storage (bogatfmstates)
  backend "azurerm" {
    resource_group_name  = "boga-rg"
    storage_account_name = "bogatfmstates"
    container_name       = "terraform-cli"
    key                  = "bogavm.tfstate" //name of the state file for this setup
  }

  // state file storage in terraform cloud
  /*  cloud {
    organization = "boga5"
    workspaces {
      name = "boga-vm"
    }
  } */
}

provider "azurerm" {
  features {}
}