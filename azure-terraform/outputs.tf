output "rg_name" {
  value       = azurerm_resource_group.this.name
  description = "Name of the resource group"
}

output "rg_id" {
  value       = azurerm_resource_group.this.id
  description = "ID of the resource group"
}

output "workspace_name" {
  value       = azurerm_databricks_workspace.this.name
  description = "Name of the Databricks workspace"
}

output "workspace_id" {
  value       = azurerm_databricks_workspace.this.workspace_id
  description = "ID of the Databricks workspace"
}

output "workspace_resource_id" {
  value       = azurerm_databricks_workspace.this.id
  description = "ID of the Databricks workspace resource"
}

output "workspace_url" {
  value       = "https://${azurerm_databricks_workspace.this.workspace_url}"
  description = "URL of the Databricks workspace"
}