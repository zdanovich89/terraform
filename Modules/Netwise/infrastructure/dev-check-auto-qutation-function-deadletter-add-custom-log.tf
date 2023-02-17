
## dev-check-auto-quotation-function-dedletter-add-custom-log

resource "azurerm_template_deployment" "dev-check-auto-quotation-function-deadletter-add-custom-log"{
    name = "devcheckautoquotationfunction-deadletter-add-custom-log"
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
            "type": "Microsoft.Logic/workflows",
            "apiVersion": "2017-07-01",
            "name": "dev-check-auto-quotation-function-deadletter-add-custom-log",
            "location": "${var.resource_group_location}",
            "properties": {
                "state": "Disabled",
                "definition": {
                    "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
                    "contentVersion": "1.0.0.0",
                    "parameters": {
                        "$connections": {
                            "defaultValue": {},
                            "type": "Object"
                        }
                    },
                    "triggers": {
                        "When_a_message_is_received_in_a_queue_(auto-complete)": {
                            "recurrence": {
                                "frequency": "Hour",
                                "interval": 4
                            },
                            "type": "ApiConnection",
                            "inputs": {
                                "host": {
                                    "connection": {
                                        "name": "@parameters('$connections')['servicebus']['connectionId']"
                                    }
                                },
                                "method": "get",
                                "path": "/@{encodeURIComponent(encodeURIComponent('autoquotationqueue'))}/messages/head",
                                "queries": {
                                    "queueType": "DeadLetter"
                                }
                            }
                        }
                    },
                    "actions": {
                        "Create_Custom_Nsure_Log": {
                            "runAfter": {
                                "Parse_Queue_Message": [
                                    "Succeeded"
                                ]
                            },
                            "type": "ApiConnection",
                            "inputs": {
                                "body": {
                                    "_ntw_autoquote_value": "@body('Parse_Queue_Message')?['QuoteId']",
                                    "ntw_name": "[TR] [Quotation] Fail",
                                    "ntw_type": 1
                                },
                                "host": {
                                    "connection": {
                                        "name": "@parameters('$connections')['commondataservice']['connectionId']"
                                    }
                                },
                                "method": "post",
                                "path": "/v2/datasets/@{encodeURIComponent(encodeURIComponent('org1cc5b349.crm'))}/tables/@{encodeURIComponent(encodeURIComponent('ntw_customnsurelogs'))}/items"
                            }
                        },
                        "Parse_Queue_Message": {
                            "runAfter": {},
                            "type": "ParseJson",
                            "inputs": {
                                "content": "@base64ToString(triggerBody()?['ContentData'])",
                                "schema": {
                                    "properties": {
                                        "QuoteId": {
                                            "type": "string"
                                        },
                                        "UserId": {
                                            "type": "string"
                                        }
                                    },
                                    "type": "object"
                                }
                            }
                        }
                    },
                    "outputs": {}
                },
                "parameters": {
                    "$connections": {
                        "value": {
                            "commondataservice": {
                                "connectionId": "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Web/connections/commondataservice",
                                "connectionName": "commondataservice",
                                "id": "/subscriptions/${var.subscription_id}/providers/Microsoft.Web/locations/${var.resource_group_location}/managedApis/commondataservice"
                            },
                            "servicebus": {
                                "connectionId": "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Web/connections/servicebus",
                                "connectionName": "servicebus",
                                "id": "/subscriptions/${var.subscription_id}/providers/Microsoft.Web/locations/${var.resource_group_location}/managedApis/servicebus"
                            }
                        }
                    }
                }
            }
        }
    ]
}
    DEPLOY
}
