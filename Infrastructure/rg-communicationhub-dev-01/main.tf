terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
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

module "resource_group" {
  source = "../../Modules/resource-group"

  resource_group_name = "rg-communicationhub-dev-01"
  location            = "eastus"
}

module "service_plan" {
  source = "../../Modules/service-plan"

  depends_on          = [module.resource_group]
  resource_group_name = "rg-communicationhub-dev-01"
  name                = "plan-commhub-dev-nsure-01"
}

module "app_service" {
  source = "../../Modules/web-application"

  resource_group_name = "rg-communicationhub-dev-01"
  location            = "eastus"
  service_plan_id     = module.service_plan.service_plan_id
}
