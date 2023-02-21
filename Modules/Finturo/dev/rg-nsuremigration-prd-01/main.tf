resource "azurerm_resource_group" "rg-nsuremigration-prd-01" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_public_ip" "vm-nsure-migration-1-ip" {
  name                = "vm-nsure-migration-1-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"

  depends_on = [
    azurerm_resource_group.rg-nsuremigration-prd-01
  ]
}

resource "azurerm_subnet" "nsure-migration-prd-1__default" {
  name                 = "default"
  virtual_network_name = "nsure-migration-prd-1-vnet"
  resource_group_name  = var.resource_group_name
  address_prefixes       = ["10.0.0.0/24"]

  depends_on = [
    azurerm_resource_group.rg-nsuremigration-prd-01,
    azurerm_virtual_network.nsure-migration-prd-1-vnet
  ]
}

resource "azurerm_virtual_machine" "nsure-migration-prd-1__vm-nsure-migration-1" {
  name                = "vm-nsure-migration-1"
  location            = var.location
  resource_group_name = var.resource_group_name
  license_type        = "Windows_Client"
  vm_size             = "Standard_D2as_v4"
  network_interface_ids = [
  azurerm_network_interface.vm-nsure-migratio949_z1.id, ]
  delete_data_disks_on_termination = "false"
  delete_os_disk_on_termination    = "false"
  os_profile {
    computer_name  = "vm-nsure-migrat"
    admin_username = "nsure"
  }
  storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-21h2-pro-g2"
    version   = "latest"
  }
  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }
  storage_os_disk {
    name          = "vm-nsure-migration-1_OsDisk_1_5394a1a6ec964bd69a141f173b93c4ad"
    caching       = "ReadWrite"
    create_option = "FromImage"
    os_type       = "Windows"
  }
  zones = [
    "1"
  ]

  depends_on = [
    azurerm_resource_group.rg-nsuremigration-prd-01,
    azurerm_network_interface.vm-nsure-migratio949_z1,
    azurerm_managed_disk.vm-nsure-migration-1_OsDisk_1_5394a1a6ec964bd69a141f173b93c4ad

  ]
}


resource "azurerm_virtual_machine_extension" "AzureNetworkWatcherExtension" {
  name                       = "AzureNetworkWatcherExtension"
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type_handler_version       = "1.4"
  virtual_machine_id         = "/subscriptions/42b712fa-047c-4530-b774-6444cc123ae7/resourceGroups/nsure-migration-prd-1/providers/Microsoft.Compute/virtualMachines/vm-nsure-migration-1"
  type                       = "NetworkWatcherAgentWindows"
  auto_upgrade_minor_version = true

  depends_on = [
    azurerm_resource_group.rg-nsuremigration-prd-01,
    azurerm_virtual_machine.nsure-migration-prd-1__vm-nsure-migration-1
  ]
}


resource "azurerm_managed_disk" "vm-nsure-migration-1_OsDisk_1_5394a1a6ec964bd69a141f173b93c4ad" {
  name                 = "vm-nsure-migration-1_OsDisk_1_5394a1a6ec964bd69a141f173b93c4ad"
  location             = var.location
  resource_group_name  = var.resource_group_name
  os_type              = "Windows"
  create_option        = "FromImage"
  image_reference_id   = "/Subscriptions/42b712fa-047c-4530-b774-6444cc123ae7/Providers/Microsoft.Compute/Locations/eastus/Publishers/MicrosoftWindowsDesktop/ArtifactTypes/VMImage/Offers/Windows-10/Skus/win10-21h2-pro-g2/Versions/19044.1826.220706"
  storage_account_type = "StandardSSD_LRS"
  disk_size_gb         = "127"
  zone = "1"

  depends_on = [
    azurerm_resource_group.rg-nsuremigration-prd-01
  ]
}
resource "azurerm_network_security_group" "vm-nsure-migration-1-nsg" {
  name                = "vm-nsure-migration-1-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "RDP"
    access                     = "Allow"
    priority                   = "300"
    protocol                   = "Tcp"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "3389"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_resource_group.rg-nsuremigration-prd-01
  ]
}

resource "azurerm_network_interface" "vm-nsure-migratio949_z1" {
  name                          = "vm-nsure-migratio949_z1"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enable_ip_forwarding          = false
  enable_accelerated_networking = true
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.nsure-migration-prd-1__default.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm-nsure-migration-1-ip.id
    primary                       = true
  }

  depends_on = [
    azurerm_resource_group.rg-nsuremigration-prd-01,
    azurerm_subnet.nsure-migration-prd-1__default,
    azurerm_public_ip.vm-nsure-migration-1-ip
  ]
}

resource "azurerm_virtual_network" "nsure-migration-prd-1-vnet" {
  name                = "nsure-migration-prd-1-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16", ]
  subnet {
    name           = "default"
    address_prefix = "10.0.0.0/24"
  }

  depends_on = [
    azurerm_resource_group.rg-nsuremigration-prd-01
  ]
}

