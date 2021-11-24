## Application Service Plan
resource "azurerm_app_service_plan" "nsure-dev-service-plan" {
  name                = "nsure-dev-service-plan"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  sku{
    tier = "Basic"
    size = "B2"
  }
}