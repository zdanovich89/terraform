## Resource Group
resource "azurerm_resource_group" "nsure-dev" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

