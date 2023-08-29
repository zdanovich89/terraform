resource "azurerm_windows_web_app" "windows_app" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    always_on = true
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY        = module.application_insights.application_insights_instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = module.application_insights.application_insights_connection_string
  }
}
