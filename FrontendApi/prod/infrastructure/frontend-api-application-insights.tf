resource "azurerm_application_insights" "frontend-api-application-insights" {
  name                = "frontend-api-application-insights"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}
