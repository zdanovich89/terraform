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

variable "service_plan_id" {
  type = string
}

variable "https_only" {
  type    = string
  default = "true"
}

variable "app_settings" {
  type    = map(string)
  default = {}
}

variable "site_config" {
  type = object({
    default_documents  = list(string)
    http2_enabled      = bool
    websockets_enabled = bool
    always_on          = bool
    use_32_bit_worker  = bool
    current_stack      = string
    dotnet_version     = string
  })
}


