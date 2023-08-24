resource "azurerm_app_service_plan" "prod-nsure-service-plan" {
  name                = "prod-nsure-service-plan"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  sku{
    tier = "Basic"
    size = "B2"
  }
}