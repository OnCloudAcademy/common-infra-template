
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
}
