resource "azurerm_application_insights" "dev-nsure-marketing-insights" {
  name                = "dev-nsure-marketing-insights"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}
