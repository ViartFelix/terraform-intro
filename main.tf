resource "azurerm_resource_group" "rg-viart-we-001" {
  name     = var.rgname
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

resource "azurerm_service_plan" "sp-viart-we-001" {
  name                = local.aspname
  location            = azurerm_resource_group.rg-viart-we-001.location
  resource_group_name = azurerm_resource_group.rg-viart-we-001.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "app-viart-we-001" {
  name                = local.asname
  location            = azurerm_resource_group.rg-viart-we-001.location
  resource_group_name = azurerm_resource_group.rg-viart-we-001.name
  service_plan_id     = azurerm_service_plan.sp-viart-we-001.id

  site_config {
    application_stack {
      docker_image_name   = local.docker_image
      docker_registry_url = local.docker_registry_url
    }
  }
}

resource "azurerm_postgresql_flexible_server" "pg-viart-we-001" {
  name                          = local.pgflex_name
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

resource "azurerm_postgresql_flexible_server_database" "db-viart-we-001" {
  name      = var.dbname
  server_id = azurerm_postgresql_flexible_server.pg-viart-we-001.id
}
