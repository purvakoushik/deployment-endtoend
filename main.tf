provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
  }
}

resource "azurerm_service_plan" "example" {
  name                = "example-app-service-plan"
  resource_group_name = var.resource_group_name
  location            = "east us"
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_storage_account" "example" {
  name                     = "githubactionstoaccount"
  resource_group_name      = var.resource_group_name
  location                 = "east us"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_linux_function_app" "example" {
  name                = "azure-github-deployment-pipeline-test"
  resource_group_name = var.resource_group_name
  location            = "east us"

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id

  site_config {}
}
