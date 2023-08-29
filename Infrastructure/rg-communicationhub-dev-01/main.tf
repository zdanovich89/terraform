terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.3.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-sharedresources-dev-01"
    storage_account_name = "stsharedresdevnsure01"
    container_name       = "terraformstate"
    key                  = "rg-communicationhub-dev-01.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "app_service" {
  source = "../../Modules/web-application"

  resource_group_name = "rg-communicationhub-dev-01"
  name                = "app-commhub-mainapi-dev-nsure-01"
  location            = "eastus"
  service_plan_id     = module.service_plan.service_plan_id

#   app_settings = {
#     APPINSIGHTS_INSTRUMENTATIONKEY        = module.application_insights.application_insights_instrumentation_key
#     APPLICATIONINSIGHTS_CONNECTION_STRING = module.application_insights.application_insights_connection_string
#   }
# }
