resource "azurerm_application_insights" "blazor-application-insights" {
  name                = "blazor-application-insights"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}
