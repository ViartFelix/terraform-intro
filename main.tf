resource "azurerm_resource_group" "raph-rg-td-webapp" {
    name = "terraform-webapp-raph"
    location = "germanywestcentral"
    tags = {
        test = "testTag"
    }
}

resource "azurerm_storage_account" "raph-storage-account" {
    name                     = "raphstorageaccount"
    resource_group_name      = azurerm_resource_group.raph-rg-td-webapp.name
    location                 = "germanywestcentral"
    account_tier             = "Standard"
    account_replication_type = "GRS"

    tags = {
        environment = "staging"
    }
}

resource "azurerm_storage_container" "raph-storage-container" {
  name                  = "content"
  storage_account_id    = azurerm_storage_account.raph-storage-account.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "raph-storage-blob" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.raph-storage-account.name
  storage_container_name = azurerm_storage_container.raph-storage-container.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}

resource "azurerm_storage_share" "raph-storage-share" {
    name               = "sharename"
    storage_account_id = azurerm_storage_account.raph-storage-account.id
    quota              = 50
}

resource "azurerm_storage_share_file" "raph-storage-share-file" {
    storage_share_id = azurerm_storage_share.raph-storage-share.id
    name              = "my-awesome-content.zip"
    source            = "some-local-file.zip"
}

resource "azurerm_service_plan" "raph-service-plan" {
  name                = "raph-service-plan"
  resource_group_name = azurerm_resource_group.raph-rg-td-webapp.name
  location            = azurerm_resource_group.raph-rg-td-webapp.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "raph-windows-web-app" {
  name                = "raph-windows-web-app"
  resource_group_name = azurerm_resource_group.raph-rg-td-webapp.name
  location            = azurerm_service_plan.raph-service-plan.location
  service_plan_id     = azurerm_service_plan.raph-service-plan.id

  site_config {}
}