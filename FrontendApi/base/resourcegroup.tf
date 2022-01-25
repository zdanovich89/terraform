resource "azurerm_resource_group" "dev-nsure-frontend" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

