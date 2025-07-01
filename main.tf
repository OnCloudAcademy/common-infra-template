
data "azurerm_subscription" "current" {}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.project_name
  location = var.location
}

module "durable_function" {
  source              = "./modules/durable_function"
  project_name        = var.project_name
  location            = var.location
  resource_group_name = module.resource_group.name
  github_token        = var.github_token
  github_org          = var.github_org
  subscription_id     = var.subscription_id
  tenant_id           = data.azurerm_subscription.current.tenant_id
}
