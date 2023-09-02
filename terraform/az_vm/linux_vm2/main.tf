#create a resource group using resource block
#using existing resource group using data block
data "azurerm_resource_group" "rg" {
  name = var.vm_rg
}

#create virtual network
data "azurerm_virtual_network" "boga_vnet" {
  name = var.vm_vnet_name
  #address_space       = ["10.0.0.0/20"] #can handle 32-24=2^12 = 4096 IPs (~4000 devices)
  #location            = var.vm_location
  resource_group_name = data.azurerm_resource_group.rg.name
}

#create subnets
resource "azurerm_subnet" "lin_snet" {
  name                 = var.vm_snet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.boga_vnet.name
  address_prefixes     = ["10.0.2.0/26"] #64 IPs
}

#create Public IP
resource "azurerm_public_ip" "lin_IP" {
  name                = var.vm_public_ip
  location            = var.vm_location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = var.ip_allocation_method
}

#create Network Security groups & security rule
resource "azurerm_network_security_group" "lin_nsg" {
  name                = var.vm_nsg
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.vm_location

  #opening 22 port for world to connect to VM using ssh-keys
  security_rule {
    name                       = "SSH"
    priority                   = "300"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#create NIC
resource "azurerm_network_interface" "lin_nic" {
  name                = var.vm_nic
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.vm_location

  #attaching our private and public IP to NIC
  ip_configuration {
    name                          = var.vm_nic_config
    subnet_id                     = azurerm_subnet.lin_snet.id
    private_ip_address_allocation = var.pvt_ip_allocation_method
    public_ip_address_id          = azurerm_public_ip.lin_IP.id
  }
}

#connect the security group to NIC
resource "azurerm_network_interface_security_group_association" "lin_nic_sg_assc" {
  network_interface_id      = azurerm_network_interface.lin_nic.id
  network_security_group_id = azurerm_network_security_group.lin_nsg.id
}

#generate a random ID for storage allocation
resource "random_id" "random_id" {
  keepers = {
    #generate a new ID only when new resource group is created
    resource_group = data.azurerm_resource_group.rg.name
  }
  byte_length = 8
}

#create storage account for boot dignostics 
resource "azurerm_storage_account" "boga_storage" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = var.vm_location
  resource_group_name      = data.azurerm_resource_group.rg.name
  account_tier             = var.storage_acc_tier
  account_replication_type = var.storage_acc_replica_type
}

#create virtual machine(s)
resource "azurerm_linux_virtual_machine" "lin_vm" {
  name                            = var.vm_name
  location                        = var.vm_location
  resource_group_name             = data.azurerm_resource_group.rg.name
  network_interface_ids           = [azurerm_network_interface.lin_nic.id]
  size                            = var.vm_size
  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  disable_password_authentication = false

  #disk attributes
  os_disk {
    name                 = var.os_disk_name
    caching              = "ReadWrite"
    storage_account_type = var.vm_disk_storage_acc_type
  }

  #source image (OS type)
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  #computer_name  = "hostname"

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.boga_storage.primary_blob_endpoint
  }

  depends_on = [
    azurerm_network_interface.lin_nic
  ]
}