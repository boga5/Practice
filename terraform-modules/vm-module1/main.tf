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

module "resource_group" { source = "./rg" }

module "vnet" { source = "./vnet" }

module "nsg" {  source = "./nsg" }

module "nic" {  source = "./nic" }

module "public_ip" {  source = "./public_ip" }

module "storage" {  source = "./storage" }

module "vm" { source = "./vm" }