
resource "azurerm_storage_account" "function_storage" {
  name                     = "${replace(var.project_name, "-", "")}funcstore"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "plan" {
  name                = "${var.project_name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_function_app" "fn" {
  name                       = "${var.project_name}-fn"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  version                    = "~4"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME   = "python"
    WEBSITE_RUN_FROM_PACKAGE   = "1"
    AzureWebJobsFeatureFlags   = "EnableWorkerIndexing"
    GITHUB_TOKEN               = var.github_token
    GITHUB_ORG                 = var.github_org
    AZURE_SUBSCRIPTION_ID      = var.subscription_id
    AZURE_TENANT_ID            = var.tenant_id
    RESOURCE_GROUP             = var.resource_group_name
    LOCATION                   = var.location
  }

  identity {
    type = "SystemAssigned"
  }
}
