resource "azurerm_resource_group" "raph-rg" {
  name     = local.rg_name
  location = var.location

  tags = {
    project = var.project
    environment = var.env
  }
}

resource "azurerm_storage_account" "raph-sta" {
  name                     = local.sta_name
  resource_group_name      = azurerm_resource_group.raph-rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    project = var.project
    environment = var.env
  }
}

resource "azurerm_virtual_network" "raph-vnet" {
  name                = local.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.raph-rg.name

  tags = {
    project = var.project
    environment = var.env
  }
}