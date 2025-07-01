
resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
}

variable "name" {
  type = string
}

variable "location" {
  type = string
}

output "name" {
  value = azurerm_resource_group.rg.name
}
