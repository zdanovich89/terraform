resource "azurerm_app_service" "nsure-dev-marketing" {
  name                = var.dev-nsure-marketing-name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.dev-nsure-marketing-service-plan.id
  client_affinity_enabled = true ## Enables session affinity cookies, which route client requests in the same session to the same instance
  https_only = true ## enables all HTTP traffic to be redirected to HTTPS
  
  logs {
    detailed_error_messages_enabled = true
    failed_request_tracing_enabled = true
    application_logs {
      file_system_level = "Error"
    }
  }
  site_config {
    cors {
      allowed_origins     = []
      support_credentials = false
    }
    always_on = true ## Prevents app from being idled out due to inactivity.
    
  }
  
  identity {
    type = "SystemAssigned" ## Specifies the identity type of the App Service, System Assigned generates a service principal for you
  }
  
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.dev-nsure-marketing-insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.dev-nsure-marketing-insights.connection_string
  }
}