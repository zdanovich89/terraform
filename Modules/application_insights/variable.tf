variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "application_type" {
  type    = string
  default = "ASP.NET web application"
}

variable "APPINSIGHTS_INSTRUMENTATIONKEY" {
  type = string
}

variable "APPLICATIONINSIGHTS_CONNECTION_STRING" {
  type = string
}
