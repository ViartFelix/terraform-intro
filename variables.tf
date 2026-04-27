variable "rgname" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-viart-we-001"
}

variable "location" {
  description = "Azure location for deployment"
  type        = string
  default     = "germanywestcentral"
}

locals {
  shname = "sharename"
  scname = "content"
  saname = "viartstorageaccount"
  aspname = "viart-app-service-plan"
  asname = "viart-app-service"

  nginx_container = "nginx"
  nginx_image = "nginx:latest"
  nginx_cpu = "0.5"
  nginx_memory = "1.0"
}