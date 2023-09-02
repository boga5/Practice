#using a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.vm_rg
  location = var.vm_location
}

#using a VNet
resource "azurerm_virtual_network" "myVNet" {
  name                = var.vm_vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/20"]
}

#creating a subnet for our machine
resource "azurerm_subnet" "mySNet" {
  name                 = var.vm_snet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myVNet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#creating a Public IP
resource "azurerm_public_ip" "myPIP" {
  name                = var.vm_public_ip
  location            = azurerm_resource_group.rg.location
  allocation_method   = var.ip_allocation_method
  resource_group_name = azurerm_resource_group.rg.name
}

#creating a NIC (Network Interface Card)
resource "azurerm_network_interface" "myNIC" {
  name                = var.vm_nic
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = var.vm_nic_config
    subnet_id                     = azurerm_subnet.mySNet.id
    private_ip_address_allocation = var.pvt_ip_allocation_method
    public_ip_address_id          = azurerm_public_ip.myPIP.id
  }
}

#Creating a NSG (Network Security Group)
resource "azurerm_network_security_group" "myNSG" {
  name                = var.vm_nsg
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {
    name                       = "RDP"
    priority                   = "500"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#Associating a NSG with NIC
resource "azurerm_network_interface_security_group_association" "myNSG_NIC" {
  network_interface_id      = azurerm_network_interface.myNIC.id
  network_security_group_id = azurerm_network_security_group.myNSG.id
}

#creating a random id for storage
resource "random_id" "random_id" {
  keepers = {
    resource_group = azurerm_resource_group.rg.name
  }
  byte_length = 8
}

#creating a storage account for boot diagnostics
resource "azurerm_storage_account" "myStorage" {
  name                     = "windiag${random_id.random_id.hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = var.storage_acc_tier
  account_replication_type = var.storage_acc_replica_type
}

#creating a Windows VM
resource "azurerm_windows_virtual_machine" "boga_win" {
  name                  = var.vm_name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = var.vm_size
  admin_username        = var.vm_username
  admin_password        = var.vm_password
  network_interface_ids = [azurerm_network_interface.myNIC.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vm_disk_storage_acc_type
  }
  #delete_os_disk_on_termination    = true
  #delete_data_disks_on_termination = true
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}