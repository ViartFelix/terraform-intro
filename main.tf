resource "azurerm_resource_group" "raph-rg-td-webapp" {
    name = var.rgname
    location = var.location
    tags = {
        test = "testTag"
    }
}

resource "azurerm_storage_account" "raph-storage-account" {
    name                     = local.saname
    resource_group_name      = azurerm_resource_group.raph-rg-td-webapp.name
    location                 = var.location
    account_tier             = "Standard"
    account_replication_type = "GRS"

    tags = {
        environment = "staging"
    }
}

resource "azurerm_storage_container" "raph-storage-container" {
  name                  = local.scname
  storage_account_id    = azurerm_storage_account.raph-storage-account.id
  container_access_type = "private"
}

resource "azurerm_storage_share" "raph-storage-share" {
    name               = local.shname
    storage_account_id = azurerm_storage_account.raph-storage-account.id
    quota              = 50
}

resource "azurerm_app_service_plan" "raph-app-service-plan" {
  name                = local.aspname
  location            = azurerm_resource_group.raph-rg-td-webapp.location
  resource_group_name = azurerm_resource_group.raph-rg-td-webapp.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "raph-app-service" {
  name                = local.asname
  location            = azurerm_resource_group.raph-rg-td-webapp.location
  resource_group_name = azurerm_resource_group.raph-rg-td-webapp.name
  app_service_plan_id = azurerm_app_service_plan.raph-app-service-plan.id

  site_config {}
}

resource "azurerm_container_group" "raph-windows-c-group" {
  name                = "raph-nginx-group"
  location            = azurerm_resource_group.raph-rg-td-webapp.location
  resource_group_name = azurerm_resource_group.raph-rg-td-webapp.name
  os_type             = "Linux"
  restart_policy      = "Always"

  container {
    name   = var.nginx_container
    image  = "nginx:latest"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "staging"
  }
}