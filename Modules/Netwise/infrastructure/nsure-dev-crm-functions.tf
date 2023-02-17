## nsure-dev-crm functions

resource "azurerm_template_deployment" "nsure-dev-crm-functions"{
  name = var.nsure-dev-crm-functions_name
  resource_group_name = var.resource_group_name
  deployment_mode = "Incremental"
  template_body = <<DEPLOY
  {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "sites_nsure_dev_crm_functions_name": {
            "defaultValue": "${var.nsure-dev-crm-functions_name}",
            "type": "String"
        },
        "serverfarms_nsure_dev_service_plan_externalid": {
            "defaultValue": "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Web/serverfarms/${azurerm_app_service_plan.nsure-dev-service-plan.name}",
            "type": "String"
        }
    },
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Web/sites",
            "apiVersion": "2021-02-01",
            "name": "[parameters('sites_nsure_dev_crm_functions_name')]",
            "location": "East US",
            "kind": "functionapp",
            "identity": {
                "type": "SystemAssigned"
            },
            "properties": {
                "enabled": true,
                "hostNameSslStates": [
                    {
                        "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '.azurewebsites.net')]",
                        "sslState": "Disabled",
                        "hostType": "Standard"
                    },
                    {
                        "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '.scm.azurewebsites.net')]",
                        "sslState": "Disabled",
                        "hostType": "Repository"
                    }
                ],
                "serverFarmId": "[parameters('serverfarms_nsure_dev_service_plan_externalid')]",
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
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/ftp')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "allow": true
            }
        },
        {
            "type": "Microsoft.Web/sites/basicPublishingCredentialsPolicies",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/scm')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "allow": true
            }
        },
        {
            "type": "Microsoft.Web/sites/config",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/web')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
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
                "publishingUsername": "$${var.nsure-dev-crm-functions_name}",
                "scmType": "VSTSRM",
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
                "managedServiceIdentityId": 22996,
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
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmAddressUpdateFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmAddressUpdateFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmAddressUpdateFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmAddressUpdateFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmAddressUpdateFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmAutoInsuranceUpdateFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmAutoInsuranceUpdateFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmAutoInsuranceUpdateFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmAutoInsuranceUpdateFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmAutoInsuranceUpdateFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmBusinessCentralFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmBusinessCentralFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmBusinessCentralFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmBusinessCentralFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmBusinessCentralFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmCarrierCrudFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmCarrierCrudFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmCarrierCrudFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmCarrierCrudFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmCarrierCrudFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmClientUpdateFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmClientUpdateFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmClientUpdateFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmClientUpdateFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmClientUpdateFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmDocuSignCrudFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmDocuSignCrudFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmDocuSignCrudFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmDocuSignCrudFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmDocuSignCrudFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmHomeInsuranceUpdateFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmHomeInsuranceUpdateFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmHomeInsuranceUpdateFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmHomeInsuranceUpdateFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmHomeInsuranceUpdateFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmLeadUpdateFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmLeadUpdateFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmLeadUpdateFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmLeadUpdateFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmLeadUpdateFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmPropertyUpdateFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmPropertyUpdateFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmPropertyUpdateFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmPropertyUpdateFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmPropertyUpdateFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmStateConfigurationCrudFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmStateConfigurationCrudFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmStateConfigurationCrudFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmStateConfigurationCrudFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmStateConfigurationCrudFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/CrmVehiclePolicyDiscountsUpdateFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmVehiclePolicyDiscountsUpdateFunction/",
                "script_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Nsure.CRM.Functions.dll",
                "config_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/site/wwwroot/CrmVehiclePolicyDiscountsUpdateFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/CrmVehiclePolicyDiscountsUpdateFunction.dat",
                "href": "https://${var.nsure-dev-crm-functions_name}.azurewebsites.net/admin/functions/CrmVehiclePolicyDiscountsUpdateFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/hostNameBindings",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/', parameters('sites_nsure_dev_crm_functions_name'), '.azurewebsites.net')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "siteName": "${var.nsure-dev-crm-functions_name}",
                "hostNameType": "Verified"
            }
        }
    ]
}
DEPLOY
}



