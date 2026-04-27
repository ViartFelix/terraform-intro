resource "azurerm_resource_group" "rg-viart-we-001" {
    name = var.rgname
    location = var.location
    tags = {
        test = "testTag"
    }
}

resource "azurerm_storage_account" "ds-viart-we-001" {
    name                     = local.saname
    resource_group_name      = azurerm_resource_group.rg-viart-we-001.name
    location                 = var.location
    account_tier             = "Standard"
    account_replication_type = "GRS"

    tags = {
        environment = "staging"
    }
}

resource "azurerm_storage_container" "ds-container-viart-we-001" {
  name                  = local.scname
  storage_account_id    = azurerm_storage_account.ds-viart-we-001.id
  container_access_type = "private"
}

resource "azurerm_app_service_plan" "sp-viart-we-001" {
  name                = local.aspname
  location            = azurerm_resource_group.rg-viart-we-001.location
  resource_group_name = azurerm_resource_group.rg-viart-we-001.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "raph-app-service" {
  name                = local.asname
  location            = azurerm_resource_group.rg-viart-we-001.location
  resource_group_name = azurerm_resource_group.rg-viart-we-001.name
  app_service_plan_id = azurerm_app_service_plan.sp-viart-we-001.id

  site_config {}
}

resource "azurerm_container_group" "app-viart-we-001" {
  name                = "nginx-viart-we-001"
  location            = azurerm_resource_group.rg-viart-we-001.location
  resource_group_name = azurerm_resource_group.rg-viart-we-001.name
  os_type             = "Linux"
  restart_policy      = "Always"

  container {
    name   = local.nginx_container
    image  = local.nginx_image
    cpu    = local.nginx_cpu
    memory = local.nginx_memory

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "staging"
  }
}


resource "azurerm_postgresql_flexible_server" "pg-viart-we-001" {
  name                          = "pg-viart-we-001-psqlflexibleserver"
  resource_group_name           = azurerm_resource_group.rg-viart-we-001.name
  location                      = azurerm_resource_group.rg-viart-we-001.location
  version                       = local.pgflex_version
  public_network_access_enabled = local.pgflex_public_network
  administrator_login           = local.pgflex_admin_login
  administrator_password        = local.pgflex_admin_password
  zone                          = local.pgflex_zone

  storage_mb   = local.pgflex_storage_mb
  storage_tier = local.pgflex_storage_tier
}

resource "azurerm_postgresql_server" "pg-viart-we-001" {
  name                = "pg-viart-we-001-psql-db"
  location            = azurerm_resource_group.rg-viart-we-001.location
  resource_group_name = azurerm_resource_group.rg-viart-we-001.name

  administrator_login          = local.pgdb_login
  administrator_login_password = local.pgdb_password

  sku_name   = local.pgdb_sku_name
  version    = local.pgdb_version
  storage_mb = local.pgdb_storage_mb

  backup_retention_days        = local.pgdb_backup_retention_days
  geo_redundant_backup_enabled = local.pgdb_geo_redundant_backup_enabled
  auto_grow_enabled            = local.pgdb_auto_grow_enabled

  public_network_access_enabled    = local.pgdb_public_network_access_enabled
  ssl_enforcement_enabled          = local.pgdb_ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = local.pgdb_ssl_minimal_tls_version_enforced
}