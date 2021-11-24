## service bus


resource "azurerm_template_deployment" "servicebus"{
    name = "servicebus"
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
            "name": "servicebus",
            "location": "${var.resource_group_location}",
            "kind": "V1",
            "properties": {
                "displayName": "service-bus",
                "statuses": [
                    {
                        "status": "Connected"
                    }
                ],
                "customParameterValues": {},
                "nonSecretParameterValues": {},
                "createdTime": "2020-02-20T15:16:45.6506004Z",
                "changedTime": "2020-02-20T15:16:45.6506004Z",
                "api": {
                    "name": "servicebus",
                    "displayName": "Service Bus",
                    "description": "Connect to Azure Service Bus to send and receive messages. You can perform actions such as send to queue, send to topic, receive from queue, receive from subscription, etc.",
                    "iconUri": "https://connectoricons-prod.azureedge.net/releases/v1.0.1518/1.0.1518.2564/servicebus/icon.png",
                    "brandColor": "#c4d5ff",
                    "id": "/subscriptions/${var.subscription_id}/providers/Microsoft.Web/locations/${var.resource_group_location}/managedApis/servicebus",
                    "type": "Microsoft.Web/locations/managedApis"
                },
                "testLinks": []
            }
        }
    ]
}
    DEPLOY
}


