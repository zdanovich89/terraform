## nsure-dev-notification-function

resource "azurerm_template_deployment" "nsure-dev-notification-function"{
  name = var.nsure-dev-notification-function_name
  resource_group_name = var.resource_group_name
  deployment_mode = "Incremental"
  template_body = <<DEPLOY
  {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {},
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Web/sites",
            "apiVersion": "2021-02-01",
            "name": "${var.nsure-dev-notification-function_name}",
            "location": "East US",
            "kind": "functionapp",
            "identity": {
                "type": "SystemAssigned"
            },
            "properties": {
                "enabled": true,
                "hostNameSslStates": [
                    {
                        "name": "${var.nsure-dev-notification-function_name}.azurewebsites.net",
                        "sslState": "Disabled",
                        "hostType": "Standard"
                    },
                    {
                        "name": "${var.nsure-dev-notification-function_name}.scm.azurewebsites.net",
                        "sslState": "Disabled",
                        "hostType": "Repository"
                    }
                ],
                "serverFarmId": "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Web/serverfarms/${azurerm_app_service_plan.nsure-dev-service-plan.name}",
                "reserved": false,
                "isXenon": false,
                "hyperV": false,
                "siteConfig": {
                    "numberOfWorkers": 1,
                    "acrUseManagedIdentityCreds": false,
                    "alwaysOn": true,
                    "http20Enabled": false,
                    "functionAppScaleLimit": 0,
                    "minimumElasticInstanceCount": 1
                },
                "scmSiteAlsoStopped": false,
                "clientAffinityEnabled": false,
                "clientCertEnabled": false,
                "clientCertMode": "Required",
                "hostNamesDisabled": false,
                "customDomainVerificationId": "913E046AF45B38A2AC10A076FB4717540F62C7575DC7A8AE9FD9590D6AF11A4F",
                "containerSize": 1536,
                "dailyMemoryTimeQuota": 0,
                "httpsOnly": true,
                "redundancyMode": "None",
                "storageAccountRequired": false,
                "keyVaultReferenceIdentity": "SystemAssigned"
            }
        },
        {
            "type": "Microsoft.Web/sites/basicPublishingCredentialsPolicies",
            "apiVersion": "2021-02-01",
            "name": "${var.nsure-dev-notification-function_name}/ftp",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', '${var.nsure-dev-notification-function_name}')]"
            ],
            "properties": {
                "allow": true
            }
        },
        {
            "type": "Microsoft.Web/sites/basicPublishingCredentialsPolicies",
            "apiVersion": "2021-02-01",
            "name": "${var.nsure-dev-notification-function_name}/scm",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', '${var.nsure-dev-notification-function_name}')]"
            ],
            "properties": {
                "allow": true
            }
        },
        {
            "type": "Microsoft.Web/sites/config",
            "apiVersion": "2021-02-01",
            "name": "${var.nsure-dev-notification-function_name}/web",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', '${var.nsure-dev-notification-function_name}')]"
            ],
            "properties": {
                "numberOfWorkers": 1,
                "defaultDocuments": [
                    "Default.htm",
                    "Default.html",
                    "Default.asp",
                    "index.htm",
                    "index.html",
                    "iisstart.htm",
                    "default.aspx",
                    "index.php"
                ],
                "netFrameworkVersion": "v4.0",
                "phpVersion": "5.6",
                "requestTracingEnabled": false,
                "remoteDebuggingEnabled": false,
                "remoteDebuggingVersion": "VS2017",
                "httpLoggingEnabled": false,
                "acrUseManagedIdentityCreds": false,
                "logsDirectorySizeLimit": 35,
                "detailedErrorLoggingEnabled": false,
                "publishingUsername": "${var.nsure-dev-notification-function_name}",
                "scmType": "None",
                "use32BitWorkerProcess": true,
                "webSocketsEnabled": false,
                "alwaysOn": true,
                "managedPipelineMode": "Integrated",
                "virtualApplications": [
                    {
                        "virtualPath": "/",
                        "physicalPath": "site\\wwwroot",
                        "preloadEnabled": true
                    }
                ],
                "loadBalancing": "LeastRequests",
                "experiments": {
                    "rampUpRules": []
                },
                "autoHealEnabled": false,
                "vnetRouteAllEnabled": false,
                "vnetPrivatePortsCount": 0,
                "cors": {
                    "allowedOrigins": [
                        "https://functions.azure.com",
                        "https://functions-staging.azure.com",
                        "https://functions-next.azure.com"
                    ],
                    "supportCredentials": false
                },
                "localMySqlEnabled": false,
                "managedServiceIdentityId": 24209,
                "ipSecurityRestrictions": [
                    {
                        "ipAddress": "Any",
                        "action": "Allow",
                        "priority": 1,
                        "name": "Allow all",
                        "description": "Allow all access"
                    }
                ],
                "scmIpSecurityRestrictions": [
                    {
                        "ipAddress": "Any",
                        "action": "Allow",
                        "priority": 1,
                        "name": "Allow all",
                        "description": "Allow all access"
                    }
                ],
                "scmIpSecurityRestrictionsUseMain": false,
                "http20Enabled": false,
                "minTlsVersion": "1.2",
                "scmMinTlsVersion": "1.0",
                "ftpsState": "AllAllowed",
                "preWarmedInstanceCount": 0,
                "functionAppScaleLimit": 0,
                "functionsRuntimeScaleMonitoringEnabled": false,
                "minimumElasticInstanceCount": 1,
                "azureStorageAccounts": {}
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "${var.nsure-dev-notification-function_name}/SmsCosmosDbFunction",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', '${var.nsure-dev-notification-function_name}')]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-notification-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/SmsCosmosDbFunction/",
                "script_href": "https://${var.nsure-dev-notification-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.NotificationFuction.dll",
                "config_href": "https://${var.nsure-dev-notification-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/SmsCosmosDbFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-notification-function_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/SmsCosmosDbFunction.dat",
                "href": "https://${var.nsure-dev-notification-function_name}.azurewebsites.net/admin/functions/SmsCosmosDbFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/hostNameBindings",
            "apiVersion": "2021-02-01",
            "name": "${var.nsure-dev-notification-function_name}/${var.nsure-dev-notification-function_name}.azurewebsites.net",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', '${var.nsure-dev-notification-function_name}')]"
            ],
            "properties": {
                "siteName": "${var.nsure-dev-notification-function_name}",
                "hostNameType": "Verified"
            }
        }
    ]
}
DEPLOY
}



