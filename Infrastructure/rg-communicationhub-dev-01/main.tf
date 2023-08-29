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
