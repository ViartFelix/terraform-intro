variable "rgname" {
  description = "Name of the resource group"
  type        = string
  default     = "raph-rg-td-webapp"
}

variable "location" {
  description = "Azure location for deployment"
  type        = string
  default     = "germanywestcentral"
}

variable "nginx_container" {
  description = "Name of the storage container"
  type        = string
  default     = "nginx"
}

locals {
  shname = "sharename"
  scname = "content"
  saname = "raphstorageaccount"
  aspname = "raph-app-service-plan"
  asname = "raph-app-service"
}