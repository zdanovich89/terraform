variable "resource_group_name" {
  type = string
  default = "rg-finturonsure-tst-01"
}

variable "location" {
    type = string
    default = "eastus"
}

variable "app_service_plan_id_spfinturo_tst" {
  type = string
}

variable "tenant_id" {
  default="8fc43c60-4563-43cf-ad1e-b9b67501268a"
}


variable "app_services_with_appi" {
    default = {
      "app-finturo-nsureapi-tst-nsure-01" = {
        name = "app-finturo-nsureapi-tst-nsure-01"
        https_only = true
      },
      "app-finturo-crmfileapi-tst-nsure-01" = {
        name = "app-finturo-crmfileapi-tst-nsure-01"
        https_only = true
      },
      "app-finturo-messengermicroservice-tst-nsure-01" = {
        name = "app-finturo-messengermicroservice-tst-nsure-01"
        https_only = true
      },
      "app-finturo-insurancemicroservice-tst-nsure-01" = {
        name = "app-finturo-insurancemicroservice-tst-nsure-01"
        https_only = true
      }
    }
  
}

variable "app_services_without_appi" {
    default = {
      "app-finturo-nsure-tst-nsure-01" = {
        name = "app-finturo-nsure-tst-nsure-01"
        https_only = true
      },
      "app-finturo-virtualentityapi-tst-nsure-01" = {
        name = "app-finturo-virtualentity-tst-nsure-01"
        https_only = true
      }
    }
}

variable "function_apps" {
  default = {
   "func-finturo-background-tst-nsure-01" = {
      name="func-finturo-background-tst-nsure-01"
      https_only = true
      enable_builtin_logging = false
   },
   "func-finturo-crm-tst-nsure-01" = {
      name="func-finturo-crm-tst-nsure-01"
      https_only = true
      enable_builtin_logging = false
   },
   "func-finturo-quotation-tst-nsure-01" = {
      name="func-finturo-quotation-tst-nsure-01"
      https_only = true
      enable_builtin_logging = false
   },
   "func-finturo-sendgrid-tst-nsure-01" = {
      name="func-finturo-sendgrid-tst-nsure-01"
      https_only = true
      enable_builtin_logging = false
   },
    "func-finturo-notification-tst-nsure-01" = {
      name="func-finturo-notification-tst-nsure-01"
      https_only = true
      enable_builtin_logging = false
   }
  }
}

variable "sb_queues" {
    default = {
      "crmaddressupdatequeue" = {
         name = "crmaddressupdatequeue"      
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "automaticclientandhomequotecreationqueue" = {
         name = "automaticclientandhomequotecreationqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmcarriercrudqueue" = {
         name = "crmcarriercrudqueue"        
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmautoinsuranceupdatequeue" = {
         name = "crmautoinsuranceupdatequeue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "automaticclientandhomequotecreationfromnewfrontendqueue" = {
         name = "automaticclientandhomequotecreationfromnewfrontendqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmdocusigncrudqueue" = {
         name = "crmdocusigncrudqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "smsqueue" = {
         name = "smsqueue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmclientupdatequeue" = {
         name = "crmclientupdatequeue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = true
      },
      "homeownerquotationqueue" = {
         name = "homeownerquotationqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmlendercrudqueue" = {
         name = "crmlendercrudqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = true
      },
      "crmvehiclepolicydiscountsupdatequeue" ={
         name = "crmvehiclepolicydiscountsupdatequeue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmmonolinecrudqueue" = {
         name = "crmmonolinecrudqueue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "automatichomeinsurancecreationqueue" = {
         name = "automatichomeinsurancecreationqueue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "autoquotationqueue" = {
         name = "autoquotationqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = true
      },
      "crmexternalinsurancecrudqueue" = {
         name = "crmexternalinsurancecrudqueue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmservicescrudqueue" = {
         name = "crmservicescrudqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "clickcollectorqueue" = {
         name = "clickcollectorqueue"
         enable_partitioning =  true
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "recalculateamountinvitationqueue" = {
         name = "recalculateamountinvitationqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "delayinsendingsmsbyheymarketqueue" = {
         name = "delayinsendingsmsbyheymarketqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmleadupdatequeue" = {
         name = "crmleadupdatequeue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "smsflowqueue" = {
         name = "smsflowqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmstateconfigurationcrudqueue" = {
         name = "crmstateconfigurationcrudqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmbusinesscentralqueue" = {
         name = "crmbusinesscentralqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "automaticautoinsurancecreationqueue" = {
         name = "automaticautoinsurancecreationqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmpropertyupdatequeue" = {
         name = "crmpropertyupdatequeue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "crmhomeinsuranceupdatequeue" = {
         name = "crmhomeinsuranceupdatequeue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      },
      "emailqueue" = {
         name = "emailqueue"
         enable_partitioning =  false
         enable_express =  false
         requires_duplicate_detection =false
         requires_session =  false
         dead_lettering_on_message_expiration = false
      }
   }
}