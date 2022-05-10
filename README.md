![example workflow](https://github.com/dkooll/terraform-azurerm-vnet/actions/workflows/validate.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Storage Account `[Microsoft.Storage/storageAccounts]`

Terraform module which creates storage account resources on Azure.

## Table of Contents

- [Storage Account](#storage-account)
  - [**Table of Contents**](#table-of-contents)
  - [Resources](#resources)
  - [Inputs](#inputs)
    - [Usage: `single storage account multiple containers`](#inputs-usage-single-storage-account-multiple-containers)
    - [Usage: `multiple storage accounts multiple tables`](#inputs-usage-multiple-storage-accounts-multiple-tables)
    - [Usage: `single storage account multiple queues`](#inputs-usage-single-storage-account-multiple-queues)
    - [Usage: `multiple storage accounts multiple fileshares`](#inputs-usage-multiple-storage-accounts-multiple-fileshares)
  - [Outputs](#outputs)

## Resources

| Name | Type |
| :-- | :-- |
| `azurerm_resource_group` | resource |
| `random_string` | resource |
| `azurerm_storage_account` | resource |
| `azurerm_storage_container` | resource |
| `azurerm_storage_queue` | resource |
| `azurerm_storage_share` | resource |
| `azurerm_storage_table` | resource |

## Inputs

| Name | Description | Type | Required |
| :-- | :-- | :-- | :-- |
| `storage_accounts` | describes storage related configuration | object | yes |

### Usage: `single storage account multiple containers`

```terraform
module "vnet" {
  source = "github.com/dkooll/terraform-azurerm-vnet"
  version = "1.0.0"
  vnets = {
    vnet1 = {
      cidr     = ["10.18.0.0/16"]
      dns      = ["8.8.8.8","7.7.7.7"]
      location = "westeurope"
      subnets = {
        sn1 = {cidr = ["10.18.1.0/24"]}
      }
    }
  }
}
```

### Usage: `multiple storage accounts multiple tables`

```terraform
module "vnet" {
  source = "github.com/dkooll/terraform-azurerm-vnet"
  version = "1.0.0"
  vnets = {
    vnet1 = {
      cidr     = ["10.18.0.0/16"]
      dns      = ["8.8.8.8"]
      location = "westeurope"
      subnets = {
        sn1 = {cidr = ["10.18.1.0/24"]}
        sn2 = {cidr = ["10.18.2.0/24"]}
      }
    }
  }
}
```

### Usage: `single storage account multiple queues`

```terraform
module "vnet" {
  source = "github.com/dkooll/terraform-azurerm-vnet"
  version = "1.0.0"
  vnets = {
    vnet1 = {
      cidr     = ["10.18.0.0/16"]
      dns      = ["8.8.8.8"]
      location = "westeurope"
      subnets = {
        sn1 = {
          cidr = ["10.18.1.0/24"]
          endpoints = [
            "Microsoft.Storage",
            "Microsoft.Sql"
          ]
        }
      }
    }

    vnet2 = {
      cidr     = ["10.19.0.0/16"]
      dns      = []
      location = "eastus2"
      subnets = {
        sn1 = {
          cidr = ["10.19.1.0/24"]
          endpoints = [
            "Microsoft.Web"
          ]
        }
      }
    }
  }
}
```

### Usage: `multiple storage accounts multiple fileshares`

```terraform
module "vnet" {
  source = "github.com/dkooll/terraform-azurerm-vnet"
  version = "1.0.0"
  vnets = {
    vnet1 = {
      cidr     = ["10.18.0.0/16"]
      dns      = ["8.8.8.8"]
      location = "westeurope"
      subnets = {
        sn1 = {
          cidr = ["10.18.1.0/24"]
          delegations = [
            "Microsoft.ContainerInstance/containerGroups",
            "Microsoft.Kusto/clusters",
            "Microsoft.Sql/managedInstances"
          ]
        }
      }
    }
  }
}
```

## Outputs

| Name | Description |
| :-- | :-- |
| `subnets` | contains all subnets |
| `vnets` | contains all vnets |
