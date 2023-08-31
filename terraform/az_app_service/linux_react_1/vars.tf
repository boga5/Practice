variable "rg_name" {
  type        = string
  description = "The name of the resource group"
  default     = "tfmboga-rg"
}

variable "location" {
  type        = string
  description = "The location of RG & all other resources"
  default     = "eastus"
}

variable "app_service_plan_name" {
  type        = string
  description = "The name of app service plan"
  default     = "boga-linux-ASP"
}

variable "app_service_name" {
  type        = string
  description = "The name of app service"
  default     = "tfm-sample-app-6309"
}
