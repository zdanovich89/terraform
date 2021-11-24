variable "resource_group_name" {
  type = string
  default = "nsure-dev-zmienne"
}

variable "resource_group_location" {
  type = string
  default = "eastus"
}

variable "subscription_id" {
  type = string
  default = "98134baf-b89e-45c5-9c70-1c40e593e6db"
}


## HAS TO BE GLOBALLY UNIQUE
## can only consist of lowercase letters, numbers and dashes, and must be between 3 and 24 characters long
variable "nsure-dev_name" {
    type = string
    default = "nsure-dev-variables"
}

## HAS TO BE GLOBALLY UNIQUE
## can only consist of lowercase letters, numbers and dashes, and must be between 3 and 24 characters long
variable "nsure-dev-virtualentity-api" {
  type = string
  default = "nsure-dev-virtualentity-api-var"
}


## HAS TO BE GLOBALLY UNIQUE
## can only consist of lowercase letters, numbers and dashes, and must be between 3 and 24 characters long
variable "nsure-dev-keyvault-name" {
    type = string
    default = "nsure-dev-keyvault-var"
}


## HAS TO BE GLOBALLY UNIQUE
## can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long
variable "nsuredevstorage-name"{
    type = string
    default = "nsuredevstoragevar"
}

## HAS TO BE GLOBALLY UNIQUE
variable "nsure-dev-db-sql-server-name"{
  type = string
  default = "nsure-dev-db-sql-server-var"
}


variable "nsure-dev-db-sql-server-login" {
    type = string
    default = "admintududu"
  
}

variable "nsure-dev-db-sql-server-password" {
    type = string
    default = "Bla123ASd@"
  
}

## HAS TO BE GLOBALLY UNIQUE

variable "nsure-dev-service-bus_name" {
  type = string
  default = "nsure-dev-service-bus-var"
}
## HAS TO BE GLOBALLY UNIQUE
variable "nsure-dev-crm-api_name"{
  type = string
  default = "nsure-dev-crm-api-var"
}

## HAS TO BE GLOBALLY UNIQUE
variable "nsure-dev-insurance-microservice_name"{
  type = string
  default = "nsure-dev-insurance-microservice-var"
}

## HAS TO BE GLOBALLY UNIQUE
variable "nsure-dev-crm-file-api" {
  type = string
  default = "nsure-dev-crm-file-api-var"
  
}

variable "sftp-container-group-dns-name-label" {
  type = string
  default = "nsure-sftp-dev-var"
  
}

variable "nsure-dev-datafactory_name" {
  type = string
  default = "nsure-dev-datafactory-var"
  
}

variable "nsure-dev-api_name" {
  type = string
  default = "nsure-dev-api-var"
  
}

variable "nsure-dev-cosmos-db_name" {
  type = string
  default = "nsure-dev-cosmos-db-var"
}

variable "nsure-dev-analytic-db_name" {
  type = string
  default = "nsure-dev-analytic-db-var"
}


variable "nsure-dev-notification-function_name" {
  type = string
  default = "nsure-dev-notification-function-var"
}

variable "nsure-dev-quotation-function_name" {
  type = string
  default = "nsure-dev-quotation-function-var"
}


variable "nsure-dev-crm-functions_name" {
  type = string
  default = "nsure-dev-crm-functions-var"
}