variable "subscription_id" {
  type        = string
  description = "(Required) Azure subscription ID"
}

variable "client_id" {
  type        = string
  description = "(Required) Azure client ID"
}

variable "client_secret" {
  type        = string
  description = "(Required) Azure client secret"
}

variable "tenant_id" {
  type        = string
  description = "(Required) Azure tenant ID"
}

variable "environment" {
  type        = string
  description = "(Required) Environment name"
}

variable "project" {
  type        = string
  description = "(Required) Name of your project"
}

variable "resource_group_location" {
  type        = string
  description = "(Required) Location for the resources"
}

variable "tags" {
  type        = map(string)
  description = "(Required) Map of tags to attach to resources."
  default     = {}
}

variable "containers" {
  type        = list(string)
  description = "List of containers to create in storage"
  default     = ["bronze", "silver", "gold"]
}

variable "vnet_address_space" {
  type        = string
  description = "The address space for the spoke Virtual Network"
  default     = "10.0.0.0/16"
}

variable "private_subnet_address_prefixes" {
  type        = list(string)
  description = "Address space for private Databricks subnet"
  default     = ["10.0.2.0/24"]
}

variable "public_subnet_address_prefixes" {
  type        = list(string)
  description = "Address space for public Databricks subnet"
  default     = ["10.0.1.0/24"]
}
