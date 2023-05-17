provider "azurerm" {
  features {}
}

# Define the resource group
resource "azurerm_resource_group" "rg-terraform-dev-01" {
  name     = "rg-terraform-dev-01"
  location = "East US"
}
# resource "azurerm_management_lock" "resource-group-level" {
#   name       = "resource-group-level"
#   scope      = azurerm_resource_group.rg-terraform-dev-01.id
#   lock_level = "ReadOnly"
#   notes      = "This Resource Group is Read-Only"
# }