## common data service

resource "azurerm_template_deployment" "commondataservice"{
    name = "commondataservice"
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
            "type": "Microsoft.Web/connections",
            "apiVersion": "2016-06-01",
            "name": "commondataservice",
            "location": "${var.resource_group_location}",
            "kind": "V1",
            "properties": {
                "displayName": "netwise@nsure.com",
                "statuses": [
                    {
                        "status": "Connected"
                    }
                ],
                "customParameterValues": {},
                "nonSecretParameterValues": {
                    "token:grantType": "code"
                },
                "createdTime": "2020-03-09T14:03:03.666026Z",
                "changedTime": "2021-10-21T12:19:40.6675719Z",
                "api": {
                    "name": "commondataservice",
                    "displayName": "Microsoft Dataverse (legacy)",
                    "description": "Provides access to the environment database in Microsoft Dataverse.",
                    "iconUri": "https://connectoricons-prod.azureedge.net/releases/v1.0.1527/1.0.1527.2580/commondataservice/icon.png",
                    "brandColor": "#637080",
                    "id":   "/subscriptions/${var.subscription_id}/providers/Microsoft.Web/locations/${var.resource_group_location}/managedApis/commondataservice",
                    "type": "Microsoft.Web/locations/managedApis"
                },
                "testLinks": []
            }
        }
    ]
}
    DEPLOY


}
