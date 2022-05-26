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
  }
}