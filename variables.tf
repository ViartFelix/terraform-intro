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

locals {
  shname = "sharename"
  scname = "content"
  saname = "raphstorageaccount"
  aspname = "raph-app-service-plan"
  asname = "raph-app-service"

  nginx_container = "nginx"
  nginx_image = "nginx:latest"
  nginx_cpu = "0.5"
  nginx_memory = "1.0"
}