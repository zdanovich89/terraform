## nsure-dev-quotation-function

resource "azurerm_template_deployment" "nsure-dev-quotation-function"{
  name = var.nsure-dev-quotation-function_name
  resource_group_name = var.resource_group_name
  deployment_mode = "Incremental"
  template_body = <<DEPLOY
  {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "sites_nsure_dev_quotation_function_name": {
            "defaultValue": "${var.nsure-dev-quotation-function_name}",
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
            "name": "[parameters('sites_nsure_dev_quotation_function_name')]",
            "location": "East US",
            "kind": "functionapp",
            "identity": {
                "type": "SystemAssigned"
            },
            "properties": {
                "enabled": true,
                "hostNameSslStates": [
                    {
                        "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '.azurewebsites.net')]",
                        "sslState": "Disabled",
                        "hostType": "Standard"
                    },
                    {
                        "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '.scm.azurewebsites.net')]",
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
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/ftp')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "allow": true
            }
        },
        {
            "type": "Microsoft.Web/sites/basicPublishingCredentialsPolicies",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/scm')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "allow": true
            }
        },
        {
            "type": "Microsoft.Web/sites/config",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/web')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
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
                "httpLoggingEnabled": false,
                "acrUseManagedIdentityCreds": false,
                "logsDirectorySizeLimit": 35,
                "detailedErrorLoggingEnabled": false,
                "publishingUsername": "$${var.nsure-dev-quotation-function_name}",
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
                "managedServiceIdentityId": 15193,
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
                "ftpsState": "FtpsOnly",
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
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/2921637055946833')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Przemysław Trochim",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"658b425b9ea1569276131278ea7f8c51651ac023\",\"buildId\":\"735\",\"releaseId\":\"292\",\"buildNumber\":\"735\",\"releaseName\":\"Release-38\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-16T09:45:48.1528776Z",
                "end_time": "2021-11-16T09:45:48.1528776Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/3021637076035168')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"63702ae64e2428b9754fb982a87050557c135abc\",\"buildId\":\"750\",\"releaseId\":\"302\",\"buildNumber\":\"750\",\"releaseName\":\"Release-39\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-16T15:20:37.7765121Z",
                "end_time": "2021-11-16T15:20:37.7765121Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/3131637150999497')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"619251554ce1c20a8474b67211da6fdd1a07169a\",\"buildId\":\"772\",\"releaseId\":\"313\",\"buildNumber\":\"772\",\"releaseName\":\"Release-40\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-17T12:10:03.5745524Z",
                "end_time": "2021-11-17T12:10:03.5745524Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/3191637154740397')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"2d711f9c2bc4472afa9c257f2e42ab63d5e0533f\",\"buildId\":\"783\",\"releaseId\":\"319\",\"buildNumber\":\"783\",\"releaseName\":\"Release-41\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-17T13:12:21.8436241Z",
                "end_time": "2021-11-17T13:12:21.8436241Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/3291637236898090')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"d5f00c10b1e08cf54b41feac48df109f8d43772e\",\"buildId\":\"828\",\"releaseId\":\"329\",\"buildNumber\":\"828\",\"releaseName\":\"Release-42\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-18T12:01:43.306702Z",
                "end_time": "2021-11-18T12:01:43.306702Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/3391637246892425')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"61c0fd63b25d32c90d96d07b3b9d636a5af95655\",\"buildId\":\"842\",\"releaseId\":\"339\",\"buildNumber\":\"842\",\"releaseName\":\"Release-43\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-18T14:48:14.9639254Z",
                "end_time": "2021-11-18T14:48:14.9639254Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/3471637250725713')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"3c732a9d58038563a8da0a83e060a79554d321e7\",\"buildId\":\"854\",\"releaseId\":\"347\",\"buildNumber\":\"854\",\"releaseName\":\"Release-44\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-18T15:52:07.3767311Z",
                "end_time": "2021-11-18T15:52:07.3767311Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/3521637307505128')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"221e9c85a671bf44b00704cc86bd40bba076f533\",\"buildId\":\"860\",\"releaseId\":\"352\",\"buildNumber\":\"860\",\"releaseName\":\"Release-45\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-19T07:38:26.7679438Z",
                "end_time": "2021-11-19T07:38:26.7679438Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/3601637567331967')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"523f4b525b004e2b38e6401bdf8ba37f163211c8\",\"buildId\":\"880\",\"releaseId\":\"360\",\"buildNumber\":\"880\",\"releaseName\":\"Release-46\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-22T07:48:52.5836128Z",
                "end_time": "2021-11-22T07:48:52.5836128Z",
                "active": false
            }
        },
        {
            "type": "Microsoft.Web/sites/deployments",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/3731637670033286')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "status": 4,
                "author": "Krzysztof Pruszyński",
                "deployer": "VSTS",
                "message": "{\"type\":\"Deployment\",\"commitId\":\"19e55dfae006f08620bdf4938c2882647f197fca\",\"buildId\":\"920\",\"releaseId\":\"373\",\"buildNumber\":\"920\",\"releaseName\":\"Release-47\",\"repoProvider\":\"TfsGit\",\"repoName\":\"Nsure\",\"collectionUrl\":\"https://dev.azure.com/NsureInc/\",\"teamProject\":\"b88f039a-2d00-4128-aac7-66786dcfd925\",\"buildProjectUrl\":\"https://dev.azure.com/NsureInc/b88f039a-2d00-4128-aac7-66786dcfd925\",\"repositoryUrl\":\"\",\"branch\":\"develop\",\"teamProjectName\":\"Nsure\",\"slotName\":\"production\"}",
                "start_time": "2021-11-23T12:20:34.6345404Z",
                "end_time": "2021-11-23T12:20:34.6345404Z",
                "active": true
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/AutoQuotationFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/AutoQuotationFunction/",
                "script_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Finturo.FunctionApps.dll",
                "config_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/AutoQuotationFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/AutoQuotationFunction.dat",
                "href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/functions/AutoQuotationFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/ClickCollectorFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/ClickCollectorFunction/",
                "script_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Finturo.FunctionApps.dll",
                "config_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/ClickCollectorFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/ClickCollectorFunction.dat",
                "href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/functions/ClickCollectorFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/HomeownerQuotationFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/HomeownerQuotationFunction/",
                "script_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Finturo.FunctionApps.dll",
                "config_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/HomeownerQuotationFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/HomeownerQuotationFunction.dat",
                "href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/functions/HomeownerQuotationFunction",
                "config": {},
                "test_data": "{\"body\":\"{\\\"body\\\":\\\"\\\"}\"}",
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/HomeRequotationFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/HomeRequotationFunction/",
                "script_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Finturo.FunctionApps.dll",
                "config_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/HomeRequotationFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/HomeRequotationFunction.dat",
                "href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/functions/HomeRequotationFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/functions",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/TextMessageSendingFunction')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "script_root_path_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/TextMessageSendingFunction/",
                "script_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/bin/Netwise.Finturo.FunctionApps.dll",
                "config_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/site/wwwroot/TextMessageSendingFunction/function.json",
                "test_data_href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/vfs/data/Functions/sampledata/TextMessageSendingFunction.dat",
                "href": "https://${var.nsure-dev-quotation-function_name}.azurewebsites.net/admin/functions/TextMessageSendingFunction",
                "config": {},
                "language": "DotNetAssembly",
                "isDisabled": false
            }
        },
        {
            "type": "Microsoft.Web/sites/hostNameBindings",
            "apiVersion": "2021-02-01",
            "name": "[concat(parameters('sites_nsure_dev_quotation_function_name'), '/', parameters('sites_nsure_dev_quotation_function_name'), '.azurewebsites.net')]",
            "location": "East US",
            "dependsOn": [
                "[resourceId('Microsoft.Web/sites', parameters('sites_nsure_dev_quotation_function_name'))]"
            ],
            "properties": {
                "siteName": "${var.nsure-dev-quotation-function_name}",
                "hostNameType": "Verified"
            }
        }
    ]
}
DEPLOY
}



