![example workflow](https://github.com/dkooll/terraform-azurerm-storageaccount/actions/workflows/validate.yml/badge.svg)

# Storage Account

Terraform module which creates storage account resources on Azure. A single object storageaccounts is referenced. It contains several nested keys, such as containers, tables, queues and shares.

To be able to use these resources more than once on each storage account, local variables are used in combination with the flatten function to produce lists of maps.

The code base is validated using [terratest](https://terratest.gruntwork.io/). These tests can be found [here](tests).

The [example](examples) directory contains any prerequirements and integrations to test the code and is set as the working directory.

The below examples shows the usage and available features when consuming the module.

## Usage: single storage account multiple containers

```hcl
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

## Usage: multiple storage accounts multiple tables

```hcl
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

## Usage: single storage account multiple queues

```hcl
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

## Usage: multiple storage accounts multiple fileshares

```hcl
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

## Resources

| Name | Type |
| :-- | :-- |
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |

## Inputs

| Name | Description | Type | Required |
| :-- | :-- | :-- | :-- |
| `storage_accounts` | describes storage related configuration | object | yes |

## Outputs

| Name | Description |
| :-- | :-- |
| `storageaccounts` | contains all storage accounts |
| `containers` | contains all containers |
| `tables` | contains all tables |
| `queues` | contains all queues |
| `shares` | contains all shares |