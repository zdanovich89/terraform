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
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/3111637150920089')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"619251554ce1c20a8474b67211da6fdd1a07169a\",\"buildId\":\"769\",\"releaseId\":\"311\",\"buildNumber\":\"769\",\"releaseName\":\"Release-29\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-17T12:08:41.3187873Z",
                "end_time": "2021-11-17T12:08:41.3187873Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/3221637155027414')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"2d711f9c2bc4472afa9c257f2e42ab63d5e0533f\",\"buildId\":\"787\",\"releaseId\":\"322\",\"buildNumber\":\"787\",\"releaseName\":\"Release-30\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-17T13:17:08.5349038Z",
                "end_time": "2021-11-17T13:17:08.5349038Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/3271637236766369')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"d5f00c10b1e08cf54b41feac48df109f8d43772e\",\"buildId\":\"824\",\"releaseId\":\"327\",\"buildNumber\":\"824\",\"releaseName\":\"Release-31\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-18T11:59:31.2003217Z",
                "end_time": "2021-11-18T11:59:31.2003217Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/3351637246666692')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"61c0fd63b25d32c90d96d07b3b9d636a5af95655\",\"buildId\":\"837\",\"releaseId\":\"335\",\"buildNumber\":\"837\",\"releaseName\":\"Release-32\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-18T14:44:28.1544298Z",
                "end_time": "2021-11-18T14:44:28.1544298Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/3421637250494367')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"3c732a9d58038563a8da0a83e060a79554d321e7\",\"buildId\":\"849\",\"releaseId\":\"342\",\"buildNumber\":\"849\",\"releaseName\":\"Release-33\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-18T15:48:15.4965942Z",
                "end_time": "2021-11-18T15:48:15.4965942Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/3571637307772631')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"221e9c85a671bf44b00704cc86bd40bba076f533\",\"buildId\":\"864\",\"releaseId\":\"357\",\"buildNumber\":\"864\",\"releaseName\":\"Release-34\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-19T07:42:53.7682198Z",
                "end_time": "2021-11-19T07:42:53.7682198Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/3621637567605921')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"523f4b525b004e2b38e6401bdf8ba37f163211c8\",\"buildId\":\"883\",\"releaseId\":\"362\",\"buildNumber\":\"883\",\"releaseName\":\"Release-35\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-22T07:53:26.6858848Z",
                "end_time": "2021-11-22T07:53:26.6858848Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/3781637670264037')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"19e55dfae006f08620bdf4938c2882647f197fca\",\"buildId\":\"924\",\"releaseId\":\"378\",\"buildNumber\":\"924\",\"releaseName\":\"Release-36\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-23T12:24:27.3168172Z",
                "end_time": "2021-11-23T12:24:27.3168172Z",
                "active": true
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/502e563b02894d7aa30410a281ffa607')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "status": 4,
                "author_email": "N/A",
                "author": "N/A",
                "deployer": "ZipDeploy",
                "message": "Created via a push deployment",
                "start_time": "2021-11-19T14:14:01.7926001Z",
                "end_time": "2021-11-19T14:14:02.0894941Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_crm_functions_name'), '/fd0b548b202c4f218b5643d7697971a5')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_crm_functions_name'))]"
            ],
            "properties": {
                "status": 4,
                "author_email": "N/A",
                "author": "N/A",
                "deployer": "ZipDeploy",
                "message": "Created via a push deployment",
                "start_time": "2021-11-19T15:17:37.1130372Z",
                "end_time": "2021-11-19T15:17:37.6286982Z",
                "active": false
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



