resource "azurerm_resource_group" "raph-rg" {
    name = "terraform-raph"
    location = "germanywestcentral"
    tags = {
        test = "testTag"
    }
}

resource "azurerm_storage_account" "raph-storage-account" {
    name                     = "raphstorageaccount"
    resource_group_name      = azurerm_resource_group.raph-rg.name
    location                 = "germanywestcentral"
    account_tier             = "Standard"
    account_replication_type = "GRS"

    tags = {
        environment = "staging"
    }
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