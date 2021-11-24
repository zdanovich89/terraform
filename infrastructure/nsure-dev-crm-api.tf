## Nsure Dev Crm Api 

resource "azurerm_app_service" "nsure-dev-crm-api" {
  name                = var.nsure-dev-crm-api_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.nsure-dev-service-plan.id
  client_affinity_enabled = true ## Enables session affinity cookies, which route client requests in the same session to the same instance
  https_only = true ## enables all HTTP traffic to be redirected to HTTPS
  
  site_config {
    cors {
      allowed_origins = []
      support_credentials = false
    }
    always_on = true ## Prevents app from being idled out due to inactivity.
    remote_debugging_version = "VS2017"
    scm_type = "VSTSRM"
    use_32_bit_worker_process = true ## Configures app service to run in 32 bit mode
    default_documents = [ "Default.htm", "Deafult.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"] ## Sets the ordering of default documents to load, if an address isn't specified.
  }
  
  identity {
    type = "SystemAssigned" ## Specifies the identity type of the App Service, System Assigned generates a service principal for you
  }
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.dev-application-insights.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "disabled"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    "ASPNETCORE_ENVIRONMENT" = "Development"
    "DiagnosticServices_EXTENSION_VERSION" = "~3"
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "MSDEPLOY_RENAME_LOCKED_FILES" = "1"
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"

  }

}



resource "azurerm_template_deployment" "nsure-dev-crm-api-microservice-corestack" {
  name                = "nsure-dev-crm-api-corestack"
  resource_group_name = var.resource_group_name
  template_body       = <<DEPLOY
  {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "siteName": {
            "type": "string",
            "metadata": {
                "description": "The Azure App Service Name"
            }
        }
    },
    "resources": [
        {
            "apiVersion": "2018-02-01",
            "name": "[parameters('siteName')]",
            "type": "Microsoft.Web/sites",
            "location": "[resourceGroup().location]",
            "properties": {
                "name": "[parameters('siteName')]",
                "siteConfig": {
                    "metadata": [
                        {
                            "name": "CURRENT_STACK",
                            "value": "dotnetcore"
                        }
                    ]
                }
            }
        }
    ]
}
  DEPLOY
  parameters = {
    "siteName"         = azurerm_app_service.nsure-dev-crm-api.name
  }
  deployment_mode = "Incremental"
  depends_on      = [azurerm_app_service.nsure-dev-crm-api]
}
