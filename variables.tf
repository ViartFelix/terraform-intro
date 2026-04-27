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
  scname = "content"
  saname = "viartstorageaccount"
  aspname = "viart-app-service-plan"
  asname = "viart-app-service"

  nginx_container = "nginx"
  nginx_image = "nginx:latest"
  nginx_cpu = "0.5"
  nginx_memory = "1.0"

  pgflex_version = "12"
  pgflex_admin_login = "psqladmin"
  pgflex_admin_password = "H@Sh1CoR3!"
  pgflex_zone = "1"
  pgflex_storage_mb = 32768
  pgflex_storage_tier = "P4"
  pgflex_public_network = false

  pgdb_login = "psqladmin"
  pgdb_password = "H@Sh1CoR3!"
  pgdb_sku_name = "GP_Gen5_4"
  pgdb_version = "11"
  pgdb_storage_mb = 640000

  pgdb_backup_retention_days = 7
  pgdb_geo_redundant_backup_enabled = true
  pgdb_auto_grow_enabled = true

  pgdb_public_network_access_enabled = false
  pgdb_ssl_enforcement_enabled = true
  pgdb_ssl_minimal_tls_version_enforced = "TLS1_2"
}