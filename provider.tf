terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm",
            version = "4.50.0"
        }
    }
}

provider "azurerm" {
    subscription_id = "2c33b7e6-a46e-40c2-a1df-5f474e8279ea"
    features {}
}