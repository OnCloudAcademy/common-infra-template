
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

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

variable "github_org" {
  description = "GitHub Organization Name"
  type        = string
}