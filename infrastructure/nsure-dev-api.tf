## Nsure Dev Api

resource "azurerm_app_service" "nsure-dev-api" {
  name                = var.nsure-dev-api_name
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
    scm_type = "VSTSRM"
    php_version = "5.6"
    use_32_bit_worker_process = true ## Configures app service to run in 32 bit mode
    ftps_state = "FtpsOnly" ## Configures Ftp based deployment to use FTPS 
    websockets_enabled = true ## Enables websocket support
    always_on = true ## Prevents app from being idled out due to inactivity. 
    default_documents = [ "Default.htm", "Default.html", "Default.asp", "index.htm", "index.html" ,"iisstart.htm", "default.aspx", "index.php", "hostingstart.html"] ## Sets the ordering of default documents to load, if an address isn't specified.
  }
  identity {
    type = "SystemAssigned" ## Specifies the identity type of the App Service, System Assigned generates a service principal for you
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.dev-application-insights.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "disabled"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.dev-application-insights.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    "ASPNETCORE_DETAILEDERRORS" = "True"
    "ASPNETCORE_ENVIRONMENT" = "Development"
    "AttachmentsCDSToBlobEmails" = "przemyslaw.trochim@netwise.pl;krzysztof.pruszynski@netwise.pl;kamil.klosiewicz@netwise.pl"
    "AutoRenewalAndLYLMails" = "przemyslaw.trochim@netwise.pl;krzysztof.pruszynski@netwise.pl;kamil.klosiewicz@netwise.pl"
    "AzureActiveDirectory:AuthUri" = "https://login.microsoftonline.com/nsure.com/oauth2/authorize"
    "AzureActiveDirectory:Domain" = "nsure.com"
    "AzureActiveDirectory:Instance" = "https://login.microsoftonline.com"
    "AzureActiveDirectory:WebApiUri" = "https://nsure-dev.crm.dynamics.com/api/data/v9.1"
    "ConnectionStrings:AzureWebJobsStorage" = "" ## KEYVAULT AzureWebJobsStorage Connection string
    "CosmosDb:Uri" = "https://nsure-dev-db.documents.azure.com:443/"
    "CrmApiUrl" = "https://${azurerm_app_service.nsure-dev-crm-api.name}.azurewebsites.net/api/"
    "DataProtectionBlobStorage:BlobContainer" = "persist-key-blob-container"
    "DataProtectionBlobStorage:BlobName" = "blob-data-protection-key.xml"
    "DiagnosticServices_EXTENSION_VERSION" = "~3"
    "DocuSign:ApiPath" = "https://demo.docusign.net/restapi"
    "DocuSign:AuthServer" = "account-d.docusign.com"
    "DocuSign:ConsoleStartingView" = "envelope"
    "DocuSign:DocumentSignedSuccessfullyPath" = "https://${azurerm_app_service.nsure-dev.name}.azurewebsites.net/docusign-signed-successfully"
    "Estated:Url" = "https://apis.estated.com/v4/property"
    "EZLynx:EndpointUrl" = "https://services.uatezlynx.com"
    "EZLynx:TimeOutMilliSec" = "30000"
    "Heymarket:ApiUrl" = "https://api.heymarket.com/v1/"
    "Heymarket:CreatorId" = "48146"
    "Heymarket:InboxId" = "22948"
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "JWT:CrmAudience" = "https://${azurerm_app_service.nsure-dev-crm-api.name}.azurewebsites.net"
    "JWT:CrmIssuer" = "https://${azurerm_app_service.nsure-dev.name}.azurewebsites.net"
    "JWT:Issuer" = "https://${azurerm_app_service.nsure-dev.name}.azurewebsites.net"
    "KeyVault:Url" = "https://${azurerm_app_service.nsure-dev.name}-keyvault.vault.azure.net"
    "Mail:Username" = "contact-user@nsure.com"
    "MSDEPLOY_RENAME_LOCKED_FILES" = "1"
    "NationalFloodData:Mocks:All" = "False"
    "Polly:MaxRetryAttempts" = "3"
    "Polly:PauseBetweenFailures" = "0.00:00:00.042"
    "Quotation:Mocks:All" = "false"
    "Quotation:Mocks:AutoQuotation" = "false"
    "Quotation:Mocks:HomeownersQuotation" = "false"
    "ServiceBusQueue:AutomaticAutoInsuranceCreationQueue:DelaySendingMinute" = "5"
    "ServiceBusQueue:AutomaticHomeInsuranceCreationQueue:DelaySendingMinute" = "5"
    "ServiceBusQueue:HomeownerQueueName" = "homeownerquotationqueue"
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "TestProp" = "Test Value"
    "Turborater:Mocks:AutoByYearMakeModelDetails" = "False"
    "Turborater:Mocks:FindCounties" = "False"
    "Turborater:Mocks:FindVehiclesAndDrivers" = "False"
    "Turborater:Mocks:PropertyValuationForLookup" = "False"
    "Turborater:Mocks:VINDetails" = "False"
    "VaultUri" = "${azurerm_key_vault.nsure-dev-keyvault.vault_uri}"
    "WebJobs:MovePhoneCallsEmailsFromCrmToSql:EmailDeleteEnabled" = "true"
    "WebJobs:MovePhoneCallsEmailsFromCrmToSql:EmailEnabled" = "true"
    "WebJobs:MovePhoneCallsEmailsFromCrmToSql:NumberOfDaysBackForEmails" = "180"
    "WebJobs:MovePhoneCallsEmailsFromCrmToSql:NumberOfDaysBackForPhoneCalls" = "90"
    "WebJobs:MovePhoneCallsEmailsFromCrmToSql:PhoneCallDeleteEnabled" = "true"
    "WebJobs:MovePhoneCallsEmailsFromCrmToSql:PhoneCallEnabled" = "true"
    "WEBJOBS_RESTART_TIME" = "60"
    "WEBSITE_HEALTHCHECK_MAXPINGFAILURES" = "2"
    "WebsiteUrl:Domain" = "https://${azurerm_app_service.nsure-dev.name}.azurewebsites.net/"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk" = "1"
    
  }
}


resource "azurerm_template_deployment" "nsure-dev-api-corestack" {
  name                = "nsure-dev-api-corestack"
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
    "siteName"         = azurerm_app_service.nsure-dev-api.name
  }
  deployment_mode = "Incremental"
  depends_on      = [azurerm_app_service.nsure-dev-api]
}


resource "azurerm_template_deployment" "nsure-dev-api-logging-extension"{
  name = "nsure-dev-api-logging-extension"
  resource_group_name = var.resource_group_name
  deployment_mode = "Incremental"
  template_body = <<DEPLOY
    {
   "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
   "contentVersion": "1.0.0.0",
   "parameters": {
       "siteName": {
           "type": "string",
           "metadata": {
               "description": "The Azure App Service Name"
           }
       },
       "extensionName": {
           "type": "string",
           "metadata": {
               "description": "The Site Extension Name."
           }
       },
       "extensionVersion": {
           "type": "string",
           "metadata": {
               "description": "The Extension Version"
           }
       }
   },
   "resources": [
       {
           "type": "Microsoft.Web/sites/siteextensions",
           "name": "[concat(parameters('siteName'), '/', parameters('extensionName'))]",
           "apiVersion": "2015-04-01",
           "location": "[resourceGroup().location]",
           "properties": {
               "version": "[parameters('extensionVersion')]"
           }
       }
   ]
}
    DEPLOY


  parameters =  {
    "siteName"          = "${azurerm_app_service.nsure-dev-api.name}"
    "extensionName"     = "Microsoft.AspNetCore.AzureAppServices.SiteExtension"
    "extensionVersion"  = "6.0.0"
  }
}
