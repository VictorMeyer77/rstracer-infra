resource "azurerm_virtual_network" "this" {
  name                = "${var.environment}${var.project}vnet"
  location            = local.rg_location
  resource_group_name = local.rg_name
  address_space       = [var.vnet_address_space]
  tags                = var.tags

  depends_on = [
    azurerm_resource_group.this
  ]
}

resource "azurerm_network_security_group" "this" {
  name                = "${var.environment}${var.project}nsg"
  location            = local.rg_location
  resource_group_name = local.rg_name
  tags                = var.tags

  depends_on = [
    azurerm_resource_group.this
  ]

}


resource "azurerm_route_table" "this" {
  name                = "${var.environment}${var.project}rtb"
  location            = local.rg_location
  resource_group_name = local.rg_name
  tags                = var.tags

  depends_on = [
    azurerm_resource_group.this
  ]
}

locals {
  service_delegation_actions = [
    "Microsoft.Network/virtualNetworks/subnets/join/action",
    "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
    "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
  ]
}

resource "azurerm_subnet" "private" {
  name                 = "private-subnet-${local.databricks_workspace_name}"
  resource_group_name  = local.rg_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = var.private_subnet_address_prefixes

  delegation {
    name = "databricks-private-subnet-delegation"

    service_delegation {
      name    = "Microsoft.Databricks/workspaces"
      actions = local.service_delegation_actions
    }
  }
}

resource "azurerm_subnet" "public" {
  name                 = "public-subnet-${local.databricks_workspace_name}"
  resource_group_name  = local.rg_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = var.public_subnet_address_prefixes

  delegation {
    name = "databricks-public-subnet-delegation"

    service_delegation {
      name    = "Microsoft.Databricks/workspaces"
      actions = local.service_delegation_actions
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_subnet_route_table_association" "private" {
  subnet_id      = azurerm_subnet.private.id
  route_table_id = azurerm_route_table.this.id
}

resource "azurerm_subnet_route_table_association" "public" {
  subnet_id      = azurerm_subnet.public.id
  route_table_id = azurerm_route_table.this.id
}