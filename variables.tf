
variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}