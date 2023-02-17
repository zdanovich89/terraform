resource "azurerm_app_service" "nsure-dev" {
  name                = var.dev-nsure-frontendapi-name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.dev-nsure-service-plan.id
  client_affinity_enabled = true ## Enables session affinity cookies, which route client requests in the same session to the same instance
  https_only = true ## enables all HTTP traffic to be redirected to HTTPS

  site_config {
    cors {
      allowed_origins     = []
      support_credentials = false
    }
    always_on = true ## Prevents app from being idled out due to inactivity.
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.frontend-api-application-insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.frontend-api-application-insights.connection_string
  }
}