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
module "storage" {
  source = "github.com/dkooll/terraform-azurerm-storageaccount"
  version = "1.0.0"
  storage_accounts = {
    sa1 = {
      location  = "westeurope"
      tier      = "Standard"
      repl_type = "GRS"
      kind      = "StorageV2"
      containers = {
        sc1 = {name = "mystore250",access_type = "private"}
        sc2 = {name = "mystore251",access_type = "private"}
      }
    }
  }
}
```

### Usage: `multiple storage accounts multiple tables`

```terraform
module "storage" {
  source = "github.com/dkooll/terraform-azurerm-storageaccount"
  version = "1.0.0"
  storage_accounts = {
    sa1 = {
      location  = "eastus2"
      tier      = "Standard"
      repl_type = "GRS"
      kind      = "StorageV2"
      tables = {
        t1 = {name = "table1"}
        t2 = {name = "table2"}
      }

    sa2 = {
      location  = "southeastasia"
      tier      = "Standard"
      repl_type = "GRS"
      kind      = "StorageV2"
      tables = {
        t1 = {name = "table1"}
        t2 = {name = "table2"}
      }
    }
  }
}
```

### Usage: `single storage account multiple queues`

```terraform
module "storage" {
  source = "github.com/dkooll/terraform-azurerm-storageaccount"
  version = "1.0.0"
  storage_accounts = {
    sa1 = {
      location  = "eastus2"
      tier      = "Standard"
      repl_type = "GRS"
      kind      = "StorageV2"
      queues = {
        q1 = {name = "queue1"}
        q2 = {name = "queue2"}
      }
    }
  }
}
```

### Usage: `multiple storage accounts multiple fileshares`

```terraform
module "storage" {
  source = "github.com/dkooll/terraform-azurerm-storageaccount"
  version = "1.0.0"
  storage_accounts = {
    sa1 = {
      location  = "eastus2"
      tier      = "Standard"
      repl_type = "GRS"
      kind      = "StorageV2"
      shares = {
        fs1 = {name = "smbfileshare1",quota = 50}
        fs2 = {name = "smbfileshare2",quota = 10}
      }

    sa2 = {
      location  = "southeastasia"
      tier      = "Standard"
      repl_type = "GRS"
      kind      = "StorageV2"
      shares = {
        fs1 = {name = "smbfileshare1",quota = 5}
        fs2 = {name = "smbfileshare2",quota = 10}
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
