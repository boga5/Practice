terraform {
  required_version = ">=0.14"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "rg" {
  source = "./rg"
}

module "vnet" {
  source        = "./vnet"
  vnet_name     = "vnet${module.rg.random_id}"
  vnet_location = module.rg.rg_location
  rg_name       = module.rg.rg_name
  snet_name     = "snet${module.rg.random_id}"
}

module "nsg" {
  source       = "./nsg"
  nsg_name     = "nsg${module.rg.random_id}"
  nsg_location = module.rg.rg_location
  rg_name      = module.rg.rg_name
}

module "nic" {
  source       = "./nic"
  nic_name     = "nic${module.rg.random_id}"
  nic_location = module.rg.rg_location
  rg_name      = module.rg.rg_name
  snet_id      = module.vnet.vm_subnet_id
  pip_id       = module.public_ip.vm_public_ip_address

  nsg_id = module.nsg.vm_nsg.id

  //nic_config_name = "nic-config${module.rg.random_id}"
}

module "public_ip" {
  source       = "./public_ip"
  pip_name     = "publicip${module.rg.random_id}"
  pip_location = module.rg.rg_location
  rg_name      = module.rg.rg_name
}

module "storage" {
  source           = "./storage"
  storage_name     = "diagstr${module.rg.random_id}"
  storage_location = module.rg.rg_location
  rg_name          = module.rg.rg_name
}

module "vm" {
  source      = "./vm"
  vm_name     = "vm-${module.rg.random_id}"
  vm_location = module.rg.rg_location
  rg_name     = module.rg.rg_name
  nic_id      = module.nic.vm_nic.id
}