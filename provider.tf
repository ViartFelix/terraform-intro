terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.50.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "2bdd3c78-184f-4638-a596-d141512561cb"
  features {}
}
