provider "azurerm" {
  features {}
}

# Define the resource group
resource "azurerm_resource_group" "rg-terraform-dev-01" {
  name     = "rg-terraform-dev-01"
  location = "East US"
}