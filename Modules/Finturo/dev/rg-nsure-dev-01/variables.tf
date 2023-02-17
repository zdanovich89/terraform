variable "resource_group_name" {
  type = string
  default = "rg-finturonsure-dev-01"
}

variable "location" {
    type = string
    default = "eastus"
}

variable "tenant_id" {
  default="8fc43c60-4563-43cf-ad1e-b9b67501268a"
}


variable "app_services_with_appi" {
    default = {
      "app-finturo-devapi-dev-nsure-01" = {
        name = "app-finturo-devapi-dev-nsure-01"
        https_only = true
      },
      "app-finturo-crmfileapi-dev-nsure-01" = {
        name = "app-finturo-crmfileapi-dev-nsure-01"
        https_only = true
      },
      "app-finturo-virtualentityapi-dev-nsure-01" = {
        name = "app-finturo-virtualentity-dev-nsure-01"
        https_only = true
      },
      "app-finturo-insurancemicroservice-dev-nsure-01" = {
        name = "app-finturo-insurancemicroservice-dev-nsure-01"
        https_only = true
      }
    }
  
}

variable "app_services_without_appi" {
    default = {
      "app-finturo-nsuredev-dev-nsure-01" = {
        name = "app-finturo-nsuredev-dev-nsure-01"
        https_only = true
      },
      "app-finturo-messengermicroservice-dev-nsure-01" = {
        name = "app-finturo-devapi-dev-nsure-01"
        https_only = true
    }
    }
}

variable "function_apps" {
  default = {
   "func-finturo-background-dev-nsure-01" = {
      name="func-finturo-background-dev-nsure-01"
      https_only = true
      enable_builtin_logging = false
   },
   "func-finturo-crm-dev-nsure-01" = {
      name="func-finturo-crm-dev-nsure-01"
      https_only = true
      enable_builtin_logging = false
   },
   "func-finturo-quotation-dev-nsure-01" = {
      name="func-finturo-quotation-dev-nsure-01"
      https_only = true
      enable_builtin_logging = false
   },
   "func-finturo-sendgrid-dev-nsure-01" = {
      name="func-finturo-sendgrid-dev-nsure-01"
      https_only = true
      enable_builtin_logging = false
   }
  }
}

variable "sb_queues" {
    default = {
      "nsure-dev__smsqueue" = {
         name = "smsqueue"      
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__twiliowebcallbackqueue" = {
         name = "twiliowebcallbackqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmpropertyupdatequeue" = {
         name = "crmpropertyupdatequeue"        
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmclientupdatequeue" = {
         name = "crmclientupdatequeue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__delayinsendingsmsbyheymarketqueue" = {
         name = "delayinsendingsmsbyheymarketqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__devqueue" = {
         name = "devqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__autoquotationqueue" = {
         name = "autoquotationqueue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__smsflowqueue" = {
         name = "smsflowqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = true
      },
      "nsure-dev__grzechuqueue" = {
         name = "grzechuqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__automaticclientandhomequotecreationqueue" = {
         name = "automaticclientandhomequotecreationqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = true
      },
      "nsure-dev__automaticautoinsurancecreationqueue" ={
         name = "automaticautoinsurancecreationqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__homeownerquotationqueue" = {
         name = "homeownerquotationqueue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmhomeinsuranceupdatequeue" = {
         name = "crmhomeinsuranceupdatequeue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__recalculateamountinvitationqueue" = {
         name = "recalculateamountinvitationqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = true
      },
      "nsure-dev__crmstateconfigurationcrudqueue" = {
         name = "crmstateconfigurationcrudqueue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmlendercrudqueue" = {
         name = "crmlendercrudqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmleadupdatequeue" = {
         name = "crmleadupdatequeue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmservicescrudqueue" = {
         name = "crmservicescrudqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__automatichomeinsurancecreationqueue" = {
         name = "automatichomeinsurancecreationqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmdocusigncrudqueue" = {
         name = "crmdocusigncrudqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmvehiclepolicydiscountsupdatequeue" = {
         name = "crmvehiclepolicydiscountsupdatequeue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmcarriercrudqueue" = {
         name = "crmcarriercrudqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmmonolinecrudqueue" = {
         name = "crmmonolinecrudqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__emailqueue" = {
         name = "emailqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmexternalinsurancecrudqueue" = {
         name = "crmexternalinsurancecrudqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__automaticclientandhomequotecreationfromnewfrontendqueue" = {
         name = "automaticclientandhomequotecreationfromnewfrontendqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmautoinsuranceupdatequeue" = {
         name = "crmautoinsuranceupdatequeue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmbusinesscentralqueue" = {
         name = "crmbusinesscentralqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__crmaddressupdatequeue" = {
         name = "crmaddressupdatequeue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "nsure-dev__clickcollectorqueue" = {
         name = "clickcollectorqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      }
    }
  
}
