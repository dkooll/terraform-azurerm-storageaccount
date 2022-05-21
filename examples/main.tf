module "storage" {
  source = "../"
  storage_accounts = {
    sa1 = {
      location  = "westeurope"
      tier      = "Standard"
      repl_type = "GRS"
      kind      = "StorageV2"
      containers = {
        sc1 = { name = "mystore250", access_type = "private" }
        sc2 = { name = "mystore251", access_type = "private" }
      }
    }

    sa2 = {
      location  = "eastus2"
      tier      = "Standard"
      repl_type = "GRS"
      kind      = "StorageV2"
      shares = {
        fs1 = { name = "smbfileshare2", quota = 50 }
      }
    }
  }
}