resource "azurerm_application_insights" "app_insights" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}
