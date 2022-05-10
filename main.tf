provider "azurerm" {
  features {}
}

#----------------------------------------------------------------------------------------
# Resourcegroups
#----------------------------------------------------------------------------------------

resource "azurerm_resource_group" "rg" {
  name     = "rg-storage-${var.env}-001"
  location = "westeurope"
}

#----------------------------------------------------------------------------------------
# Generate random id
#----------------------------------------------------------------------------------------

resource "random_string" "random" {
  for_each = var.storage_accounts

  length    = 3
  min_lower = 3
  special   = false
  number    = false
  upper     = false
}

#----------------------------------------------------------------------------------------
# Storage accounts
#----------------------------------------------------------------------------------------

resource "azurerm_storage_account" "sa" {
  for_each = var.storage_accounts

  name                     = "sa${var.env}${each.key}${random_string.random[each.key].result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = each.value.location
  account_tier             = each.value.tier
  account_replication_type = each.value.repl_type
  account_kind             = each.value.kind

  identity {
    type = "SystemAssigned"
  }
}

#----------------------------------------------------------------------------------------
# Containers
#----------------------------------------------------------------------------------------

resource "azurerm_storage_container" "sc" {
  for_each = {
    for sc in local.containers : "${sc.sa_key}.${sc.sc_key}" => sc
  }

  name                  = each.value.name
  storage_account_name  = each.value.storage_account_name
  container_access_type = each.value.container_access_type
}

#----------------------------------------------------------------------------------------
# Queues
#----------------------------------------------------------------------------------------

resource "azurerm_storage_queue" "example" {
  for_each = {
    for sq in local.queues : "${sq.sa_key}.${sq.sq_key}" => sq
  }

  name                 = each.value.name
  storage_account_name = each.value.storage_account_name
}

#----------------------------------------------------------------------------------------
# shares
#----------------------------------------------------------------------------------------

resource "azurerm_storage_share" "example" {
  for_each = {
    for fs in local.shares : "${fs.sa_key}.${fs.fs_key}" => fs
  }

  name                 = each.value.name
  storage_account_name = each.value.storage_account_name
  quota                = 50
}

#----------------------------------------------------------------------------------------
# tables
#----------------------------------------------------------------------------------------

resource "azurerm_storage_table" "example" {
  for_each = {
    for st in local.tables : "${st.sa_key}.${st.st_key}" => st
  }

  name                 = each.value.name
  storage_account_name = each.value.storage_account_name
}