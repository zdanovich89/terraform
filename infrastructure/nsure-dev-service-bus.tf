## nsure-dev-service-bus 

resource "azurerm_servicebus_namespace" "nsure-dev-service-bus" {
  name                =  var.nsure-dev-service-bus_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  
}


resource "azurerm_servicebus_namespace_authorization_rule" "SendListen"{
  name                = "SendListen"
  namespace_name = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  resource_group_name = var.resource_group_name

  listen = true
  send = true
  manage = false
  
}


resource "azurerm_servicebus_queue" "automaticautoinsurancecreationqueue" {
  name                = "automaticautoinsurancecreationqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT5M"
  max_delivery_count = 3 
}


resource "azurerm_servicebus_queue" "automatichomeinsurancecreationqueue" {
  name                = "automatichomeinsurancecreationqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT5M"
  max_delivery_count = 3
  
}


resource "azurerm_servicebus_queue" "crmcarriercrudqueue" {
  name                = "crmcarriercrudqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT30S"
  max_delivery_count = 2
  
 
}


resource "azurerm_servicebus_queue" "homeownerquotationqueue" {
  name                = "homeownerquotationqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  lock_duration = "PT5M"
  enable_partitioning = true
  max_delivery_count = 3
 
}

resource "azurerm_servicebus_queue" "autoquotationqueue" {
  name = "autoquotationqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  lock_duration = "PT5M"
  default_message_ttl = "P14D"
  max_delivery_count = 5
  enable_partitioning = true


}


resource "azurerm_servicebus_queue" "clickcollectorqueue" {
  name = "clickcollectorqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 2
  enable_partitioning = false


}

resource "azurerm_servicebus_queue" "crmaddressupdatequeue" {
  name = "crmaddressupdatequeue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 5
  enable_partitioning = false

}


resource "azurerm_servicebus_queue" "crmautoinsuranceupdatequeue" {
  name = "crmautoinsuranceupdatequeue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 2
  enable_partitioning = true

}

resource "azurerm_servicebus_queue" "crmbusinesscentralqueue" {
  name = "crmbusinesscentralqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 3
  enable_partitioning = false

}

resource "azurerm_servicebus_queue" "crmclientupdatequeue" {
  name = "crmclientupdatequeue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 2
  enable_partitioning = true

}

resource "azurerm_servicebus_queue" "crmdocusigncrudqueue" {
  name = "crmdocusigncrudqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 2
  enable_partitioning = false

}

resource "azurerm_servicebus_queue" "crmhomeinsuranceupdatequeue" {
  name = "crmhomeinsuranceupdatequeue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 2
  enable_partitioning = true

}

resource "azurerm_servicebus_queue" "crmleadupdatequeue" {
  name = "crmleadupdatequeue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 3
  enable_partitioning = true

}

resource "azurerm_servicebus_queue" "crmpropertyupdatequeue" {
  name = "crmpropertyupdatequeue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name

  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 5
  enable_partitioning = false

}
resource "azurerm_servicebus_queue" "crmstateconfigurationcrudqueue" {
  name = "crmstateconfigurationcrudqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 2
  enable_partitioning = true

}
resource "azurerm_servicebus_queue" "crmvehiclepolicydiscountsupdatequeue" {
  name = "crmvehiclepolicydiscountsupdatequeue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 1
  enable_partitioning = false

}

resource "azurerm_servicebus_queue" "delayinsendingsmsbyheymarketqueue" {
  name = "delayinsendingsmsbyheymarketqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 2
  enable_partitioning = false

}

resource "azurerm_servicebus_queue" "devqueue" {
  name = "devqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 1
  enable_partitioning = false
}

resource "azurerm_servicebus_queue" "grzechuqueue" {
  name = "grzechuqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 10
  enable_partitioning = false
}

resource "azurerm_servicebus_queue" "smsqueue" {
  name = "smsqueue"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.nsure-dev-service-bus.name
  max_size_in_megabytes = 1024
  lock_duration = "PT30S"
  default_message_ttl = "P14D"
  max_delivery_count = 10
  enable_partitioning = false
}
