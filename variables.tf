variable "rgname" {
  description = "Name of the resource group"
  type        = string
  default     = "RG-VIART-WE-001"
}

variable "location" {
  description = "Azure location for deployment"
  type        = string
  default     = "germanywestcentral"
}

variable "dbname" {
  description = "Name of the PostgresSQL database"
  type        = string
  default = "pgdb_app"
}

locals {
  saname = "dsviartwe001"
  scname = "content"
  aspname = "SP-VIART-WE-001"
  asname = "app-viart-we-001"

  docker_image = "nginx:latest"
  docker_registry_url = "https://index.docker.io"

  pgflex_name = "pg-viart-we-001"
  pgflex_version = "12"
  pgflex_admin_login = "psqladmin"
  pgflex_admin_password = "H@Sh1CoR3!"
  pgflex_zone = "1"
  pgflex_storage_mb= 32768
  pgflex_storage_tier = "P4"
  pgflex_public_network = false
}
