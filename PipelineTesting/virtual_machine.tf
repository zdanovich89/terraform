resource "azurerm_linux_virtual_machine" "example" {
    name                = "example-machine"
    resource_group_name = azurerm_resource_group.example.name
    location            = azurerm_resource_group.example.location
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