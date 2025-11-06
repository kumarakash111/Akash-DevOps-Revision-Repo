terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "90ba3f99-29ea-4a71-8106-8a6775ca9f61"
}