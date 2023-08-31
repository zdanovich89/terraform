module "app_service" {
  source = "../../Modules/web_application"

  resource_group_name = "rg-communicationhub-dev-01"
  name                = "app-commhub-mainapi-dev-nsure-01"
  location            = "eastus"
  service_plan_id     = module.service_plan.service_plan_id
  https_only          = true

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY             = module.application_insights.application_insights_instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING      = module.application_insights.application_insights_connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION = "~3"
    ASPNETCORE_ENVIRONMENT                     = "Development"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE            = "true"
    WEBSITE_RUN_FROM_PACKAGE                   = "1"
    XDT_MicrosoftApplicationInsights_Mode      = "Recommended"
  }
}