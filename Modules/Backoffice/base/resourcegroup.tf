## Resource Group
resource "azurerm_resource_group" "dev-nsure-backoffice" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

