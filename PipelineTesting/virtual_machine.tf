provider "azurerm" {
    features {}
    alias           = "core_network"
    subscription_id = "00000000-0000-0000-0000-000000000000"
    client_id       = "00000000-0000-0000-0000-000000000000"
    client_secret   = "S3cR3t20!"
    tenant_id       = "00000000-0000-0000-0000-000000000000"
}
resource "azurerm_resource_group" "rg-terraform-dev-01" {
    name     = "rg-terraform-dev-01"
    location = "East US"
}
resource "azurerm_linux_virtual_machine" "example" {
    name                = "example-machine"
    resource_group_name = azurerm_resource_group.rg-terraform-dev-01.name
    location            = azurerm_resource_group.rg-terraform-dev-01.location
    size                = "Standard_F2"
    admin_username      = "adminuser"
    network_interface_ids = [
        azurerm_network_interface.example.id,
    ]

    admin_ssh_key {
        username   = "adminuser"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name = "vm-01"
        admin_username = "username"
        admin_password = "password"
    }
}  