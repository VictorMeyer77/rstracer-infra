locals {
  databricks_workspace_name = "${var.environment}${var.project}dtbk"
}

resource "azurerm_databricks_workspace" "this" {
  name                = local.databricks_workspace_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "standard"
  tags                = var.tags
}