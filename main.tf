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
  app_service_plan_id = azurerm_app_service_plan.raph-app-service-plan.id

  site_config {}
}

resource "azurerm_container_group" "raph-c-group" {
  name                = "raph-nginx-group"
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
  version                       = "12"
  public_network_access_enabled = false
  administrator_login           = "psqladmin"
  administrator_password        = "H@Sh1CoR3!"
  zone                          = "1"

  storage_mb   = 32768
  storage_tier = "P4"
}

resource "azurerm_postgresql_server" "pg-viart-we-001" {
  name                = "john"
  location            = azurerm_resource_group.rg-viart-we-001.location
  resource_group_name = azurerm_resource_group.rg-viart-we-001.name

  administrator_login          = "psqladmin"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}