resource "azurerm_app_service_plan" "dev-nsure-service-plan" {
  name                = "dev-nsure-service-plan"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  sku{
    tier = "Basic"
    size = "B2"
  }
}