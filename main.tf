resource "azurerm_resource_group" "resource_group" {
  name     = local.rg_name
  location = var.location

  tags = {
    project     = var.project
    environment = var.env
  }
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = local.asp_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.asp_sku_name

  tags = {
    project     = var.project
    environment = var.env
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = {
    project     = var.project
    environment = var.env
  }
}

resource "azurerm_subnet" "webapp" {
  name                 = local.subnet_name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes

  delegation {
    name = "webapp-delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action",
      ]
    }
  }
}

resource "azurerm_linux_web_app" "webapp" {
  name                     = local.webapp_name
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = var.location
  service_plan_id          = azurerm_service_plan.app_service_plan.id
  virtual_network_subnet_id = azurerm_subnet.webapp.id
  https_only               = true

  site_config {
    application_stack {
      php_version = var.php_version
    }
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }

  tags = {
    project     = var.project
    environment = var.env
  }
}