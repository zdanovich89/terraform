variable "resource_group_name" {
  type    = string
  default = "rg-crm-rad-01"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "tenant_id" {
  default = "8fc43c60-4563-43cf-ad1e-b9b67501268a"
}


variable "app_services_with_appi" {
  default = {
    "app-crm-nsureapi-rad-nsure-01" = {
      name       = "app-crm-nsureapi-rad-nsure-01"
      https_only = true
      appconfig_endpoint = "https://appconf-crm-rad-nsure-01.azconfig.io"
      appconfig_tenantid = "8fc43c60-4563-43cf-ad1e-b9b67501268a"
      aspnetcore_env = "RAD"
    },
    "app-crm-crmfileapi-rad-nsure-01" = {
      name       = "app-crm-crmfileapi-rad-nsure-01"
      https_only = true
      appconfig_endpoint = "https://appconf-crm-rad-nsure-01.azconfig.io"
      appconfig_tenantid = "8fc43c60-4563-43cf-ad1e-b9b67501268a"
      aspnetcore_env = "RAD"
    },
    "app-crm-messengermicroservice-rad-nsure-01" = {
      name       = "app-crm-messengermicroservice-rad-nsure-01"
      https_only = true
      appconfig_endpoint = "https://appconf-crm-rad-nsure-01.azconfig.io"
      appconfig_tenantid = "8fc43c60-4563-43cf-ad1e-b9b67501268a"
      aspnetcore_env = "RAD"
    },
    "app-crm-insurancemicroservice-rad-nsure-01" = {
      name       = "app-crm-insurancemicroservice-rad-nsure-01"
      https_only = true
      appconfig_endpoint = "https://appconf-crm-rad-nsure-01.azconfig.io"
      appconfig_tenantid = "8fc43c60-4563-43cf-ad1e-b9b67501268a"
      aspnetcore_env = "RAD"
    },
    "app-crm-crmmessengermicroservice-rad-nsure-01" = {
      name       = "app-crm-crmmessengermicroservice-rad-nsure-01"
      https_only = true
      appconfig_endpoint = "https://appconf-crm-rad-nsure-01.azconfig.io"
      appconfig_tenantid = "8fc43c60-4563-43cf-ad1e-b9b67501268a"
      aspnetcore_env = "RAD"
    }
  }

}

variable "app_services_without_appi" {
  default = {
    "app-crm-nsure-rad-nsure-01" = {
      name       = "app-crm-nsure-rad-nsure-01"
      https_only = true
      appconfig_endpoint = ""
      appconfig_tenantid = ""
      aspnetcore_env = ""
    },
    "app-crm-virtualentityapi-rad-nsure-01" = {
      name       = "app-crm-virtualentity-rad-nsure-01"
      https_only = true
      appconfig_endpoint = "https://appconf-crm-rad-nsure-01.azconfig.io"
      appconfig_tenantid = "8fc43c60-4563-43cf-ad1e-b9b67501268a"
      aspnetcore_env = "RAD"
    }
  }
}

variable "function_apps" {
  default = {
    "func-crm-background-rad-nsure-01" = {
      name                   = "func-crm-background-rad-nsure-01"
      https_only             = true
      enable_builtin_logging = false
      appconfig_endpoint = "https://appconf-crm-rad-nsure-01.azconfig.io"
      function_env = "Rad"
      webjobsstorage = "@Microsoft.KeyVault(SecretUri=https://kv-crm-rad-nsure-01.vault.azure.net/secrets/AzureWebJobsStorage/1197740567d04eb18bb7f254fb2117ce)"
      webjobsmarketingfunction = "1"
    },
    "func-crm-crm-rad-nsure-01" = {
      name                   = "func-crm-crm-rad-nsure-01"
      https_only             = true
      enable_builtin_logging = false
      appconfig_endpoint = "https://appconf-crm-rad-nsure-01.azconfig.io"
      function_env = "Rad"
      webjobsstorage = "@Microsoft.KeyVault(SecretUri=https://kv-crm-rad-nsure-01.vault.azure.net/secrets/AzureWebJobsStorage/1197740567d04eb18bb7f254fb2117ce)"
      webjobsmarketingfunction = "1"
    },
    "func-crm-quotation-rad-nsure-01" = {
      name                   = "func-crm-quotation-rad-nsure-01"
      https_only             = true
      enable_builtin_logging = false
      appconfig_endpoint = "https://appconf-crm-rad-nsure-01.azconfig.io"
      function_env = "Rad"
      webjobsstorage = "@Microsoft.KeyVault(SecretUri=https://kv-crm-rad-nsure-01.vault.azure.net/secrets/AzureWebJobsStorage/1197740567d04eb18bb7f254fb2117ce)"
      webjobsmarketingfunction = "1"
    },
    "func-crm-sendgrid-rad-nsure-01" = {
      name                   = "func-crm-sendgrid-rad-nsure-01"
      https_only             = true
      enable_builtin_logging = false
      appconfig_endpoint = ""
      function_env = ""
      webjobsstorage = ""
      webjobsmarketingfunction = ""
    }
  }
}


variable "sb_queues_with_auth_rule" {
  default = {
    "crmaddressupdatequeue" = {
      name                                 = "crmaddressupdatequeue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmcarriercrudqueue" = {
      name                                 = "crmcarriercrudqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmautoinsuranceupdatequeue" = {
      name                                 = "crmautoinsuranceupdatequeue"
      enable_partitioning                  = true
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmclientupdatequeue" = {
      name                                 = "crmclientupdatequeue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = true
    },
    "crmlendercrudqueue" = {
      name                                 = "crmlendercrudqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = true
    },
    "crmvehiclepolicydiscountsupdatequeue" = {
      name                                 = "crmvehiclepolicydiscountsupdatequeue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmmonolinecrudqueue" = {
      name                                 = "crmmonolinecrudqueue"
      enable_partitioning                  = true
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmexternalinsurancecrudqueue" = {
      name                                 = "crmexternalinsurancecrudqueue"
      enable_partitioning                  = true
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmservicescrudqueue" = {
      name                                 = "crmservicescrudqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmleadupdatequeue" = {
      name                                 = "crmleadupdatequeue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmstateconfigurationcrudqueue" = {
      name                                 = "crmstateconfigurationcrudqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmbusinesscentralqueue" = {
      name                                 = "crmbusinesscentralqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmpropertyupdatequeue" = {
      name                                 = "crmpropertyupdatequeue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "crmhomeinsuranceupdatequeue" = {
      name                                 = "crmhomeinsuranceupdatequeue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "emailqueue" = {
      name                                 = "emailqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    }
  }
}

variable "sb_queues_without_auth_rule" {
  default = {
    "automaticclientandhomequotecreationqueue" = {
      name                                 = "automaticclientandhomequotecreationqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "automaticclientandhomequotecreationfromnewfrontendqueue" = {
      name                                 = "automaticclientandhomequotecreationfromnewfrontendqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "smsqueue" = {
      name                                 = "smsqueue"
      enable_partitioning                  = true
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "homeownerquotationqueue" = {
      name                                 = "homeownerquotationqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "automatichomeinsurancecreationqueue" = {
      name                                 = "automatichomeinsurancecreationqueue"
      enable_partitioning                  = true
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "autoquotationqueue" = {
      name                                 = "autoquotationqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = true
    },
    "clickcollectorqueue" = {
      name                                 = "clickcollectorqueue"
      enable_partitioning                  = true
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "recalculateamountinvitationqueue" = {
      name                                 = "recalculateamountinvitationqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "delayinsendingsmsbyheymarketqueue" = {
      name                                 = "delayinsendingsmsbyheymarketqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "smsflowqueue" = {
      name                                 = "smsflowqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    },
    "automaticautoinsurancecreationqueue" = {
      name                                 = "automaticautoinsurancecreationqueue"
      enable_partitioning                  = false
      enable_express                       = false
      requires_duplicate_detection         = false
      requires_session                     = false
      dead_lettering_on_message_expiration = false
    }
  }
}