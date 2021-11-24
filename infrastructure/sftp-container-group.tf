
## sftp container group 
resource "azurerm_container_group" "sftp-container-group" {
  name                = "sftp-container-group"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  ip_address_type     = "public"
  dns_name_label      = var.sftp-container-group-dns-name-label
  os_type             = "Linux"
  
  container {
    name   = "sftp-container"
    image  = "atmoz/sftp:latest"
    cpu    = "1"
    memory = "0.5"

    ports {
      port     = 22
      protocol = "TCP"
    }
    
    volume {
    name = "sftpvolume1"
    mount_path = "/home/everquote/upload"
    read_only = false
    storage_account_name = azurerm_storage_account.nsurestorage.name
    storage_account_key = azurerm_storage_account.nsurestorage.primary_access_key
    share_name =  azurerm_storage_share.everquotefileshare.name
  }
  }
}