module "app_service" {
  source = "../../Modules/web-application"

  resource_group_name = "rg-communicationhub-dev-01"
  name                = "app-commhub-mainapi-dev-nsure-01"
  location            = "eastus"
  service_plan_id     = module.service_plan.service_plan_id
  https_only          = false

  site_config = {
    default_documents  = ["index.html", "Default.htm", "Default.html", "Default.asp", "index.htm", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"]
    http2_enabled      = true
    websockets_enabled = true
    always_on          = false
    use_32_bit_worker  = true
    current_stack      = ".NET"
    dotnet_version     = "v6.0"

  }
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
