module "storage" {
  source = "github.com/dkooll/terraform-azurerm-storageaccount"
  storage_accounts = {
    sa1 = {
      location          = "westeurope"
      tier              = "Standard"
      type              = "GRS"
      kind              = "StorageV2"
      enable_protection = "true"
      containers = {
        sc1 = { name = "mystore250", access_type = "private" }
        sc2 = { name = "mystore251", access_type = "private" }
      }
    }

    sa2 = {
      location          = "eastus2"
      tier              = "Standard"
      type              = "GRS"
      kind              = "StorageV2"
      enable_protection = "false"
      shares = {
        fs1 = { name = "smbfileshare2", quota = 50 }
      }
    }
  }
}