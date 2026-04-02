
resource "azurerm_resource_group" "example" {
  name     = local.rgname
  location = var.location
}

resource "azurerm_service_plan" "example" {
  name                = local.spnom
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "example" {
  name                = local.appname
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    application_stack {
       docker_image_name = "dotnet/aspire-dashboard"
       docker_registry_url = "https://mcr.microsoft.com"
    }    
  }
  storage_account {
    access_key = azurerm_storage_account.example.primary_access_key
    account_name = azurerm_storage_account.example.name
    name = azurerm_storage_account.example.name
    share_name = "sharename1"
    type = "AzureFiles"
  }
  
}

resource "azurerm_storage_account" "example" {
  name                     = var.storageaccountname
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_share" "example" {
  name               = "sharename1"
  storage_account_id = azurerm_storage_account.example.id
  quota              = 50

}

resource "azurerm_storage_share" "example2" {
  name               = "sharename2"
  storage_account_id = azurerm_storage_account.example.id
  quota              = 50

}

resource "azurerm_container_group" "example" {
  name                = "example-continst"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-label"
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }

    volume {
      name = "log"
      mount_path = "/mnt/log"
      storage_account_name = var.storageaccountname
      share_name = "sharename2"
    }
  }


  tags = {
    environment = "testing"
  }
}