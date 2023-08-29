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

# variable "app_settings" {
#   type    = map(string)
#   default = {}
# }
