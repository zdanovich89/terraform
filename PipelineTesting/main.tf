provider "azurerm" {
  features {}
  alias           = "core_network"
  subscription_id = "00000000-0000-0000-0000-000000000000"
  client_id       = "00000000-0000-0000-0000-000000000000"
  client_secret   = "S3cR3t20!"
  tenant_id       = "00000000-0000-0000-0000-000000000000"
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