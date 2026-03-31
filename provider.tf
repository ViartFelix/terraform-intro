terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm",
            version = "4.50.0"
        }
    }
}

provider "azurerm" {
    subscription_id = "e5d7725b-892b-4f4f-99a1-eaad2477ddd4"
    features {}
}