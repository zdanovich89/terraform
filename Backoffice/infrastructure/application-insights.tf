resource "azurerm_application_insights" "backoffice-application-insights" {
  name                = "backoffice-application-insights"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}
